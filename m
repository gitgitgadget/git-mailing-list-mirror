From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v4 0/3] git-remote-fd & git-remote-ext
Date: Mon, 4 Oct 2010 15:06:43 +0300
Message-ID: <20101004120643.GA12948@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20101004113043.GE4738@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 14:01:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2jjF-0006Tk-Vg
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 14:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab0JDMBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 08:01:07 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:46935 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0JDMBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 08:01:06 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 396898C797;
	Mon,  4 Oct 2010 15:01:05 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A05CBF35F57; Mon, 04 Oct 2010 15:01:05 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 14D642BD45;
	Mon,  4 Oct 2010 15:01:03 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20101004113043.GE4738@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158036>

On Mon, Oct 04, 2010 at 06:30:43AM -0500, Jonathan Nieder wrote:
> Ilari Liusvaara wrote:
> 
> > This adds two new remote helpers.
> 
> Looks good to me.  I assume you've checked it still works. :)

Yeah, it does:

[Ilari@<...>:~/repositories/git(remote-fd)]$ git push -f hostmirror remote-fd 
Counting objects: 27, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (20/20), done.
Writing objects: 100% (20/20), 6.80 KiB, done.
Total 20 (delta 14), reused 0 (delta 0)
To ext::socat - ABSTRACT-CONNECT:/tmp/gits %G/Ilari/git-mirror
 + 63ac78b...ae35921 remote-fd -> remote-fd (forced update)

[Ilari@<...>:~/repositories/git(remote-fd)]$ git push fd::3,4 master 4>/tmp/fin 3</tmp/fout
Counting objects: 101805, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (29579/29579), done.
Writing objects: 100% (101805/101805), 24.74 MiB | 22.43 MiB/s, done.
Total 101805 (delta 74164), reused 98023 (delta 70709)
To fd::3,4
 * [new branch]      master -> master

[Ilari@<...>:~/repositories/git(remote-fd)]$ git ls-remote 'ext::git-ssl localhost Ilari/git-mirror' refs/heads/*
depth=1 <...>
verify return:1
depth=0 <...>
verify return:1
3b4609d029e2db42b5154f019facecee49196bf0        refs/heads/html
2f76919517e98bb5e979d6c8c7bbc3478a066a21        refs/heads/maint
b43f48fc1c841a29db0817c726e3d3beb17d4ba0        refs/heads/man
9855b08d35edf8a8a441f24ff7b00e220a29f261        refs/heads/master
92b87a9bab1a84261d2381e813e58577967bdc79        refs/heads/next
cfe4082cb3c8db8eb0fe2fd67221a1076d0ace9b        refs/heads/pu
ae35921b925cce12a57f237cb627b4673e7c1032        refs/heads/remote-fd
9551e394549d4526054f8b8d3e05f9bf1cd818ce        refs/heads/todo


-Ilari
