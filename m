From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 08:06:22 -0700 (PDT)
Message-ID: <e81763ce-b933-40ca-b624-adfb26653ac9@s18g2000prg.googlegroups.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net> <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org> <20110322111844.GA32446@sigill.intra.peff.net>
 <20110322132820.GA14559@sigill.intra.peff.net> <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
 <20110322134358.GA19064@sigill.intra.peff.net> <AANLkTin_qX2S+orrj25=GjB6kf8B6GRSE+HVFUAkDGSb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 16:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q23Ac-000312-4u
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 16:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1CVPGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 11:06:49 -0400
Received: from mail-gy0-f184.google.com ([209.85.160.184]:54346 "EHLO
	mail-gy0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1CVPGs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 11:06:48 -0400
Received: by gyg10 with SMTP id 10so5086481gyg.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 08:06:47 -0700 (PDT)
Received: by 10.91.186.11 with SMTP id n11mr809986agp.14.1300806382911; Tue,
 22 Mar 2011 08:06:22 -0700 (PDT)
Received: by s18g2000prg.googlegroups.com with HTTP; Tue, 22 Mar 2011 08:06:22
 -0700 (PDT)
In-Reply-To: <AANLkTin_qX2S+orrj25=GjB6kf8B6GRSE+HVFUAkDGSb@mail.gmail.com>
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US;
 rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169744>

Thanks a lot for the explanations, I was really wondering about that.

Incidentally, I had a real reason to prefer using the `!echo...`
syntax over the `!sh -c 'echo...'` one;  I need my users to define the
following alias:

    git checkout $1 && git submodule foreach 'git checkout $sha1'

Due to the necessity of single-quoting the `foreach` expression, I
couldn't define it with the `!sh -c` syntax. And because of the
problems discussed in this thread, I still don't know how to have my
users define this alias.

Thanks, D.

P.S. Incidentally, this alias is addressing a pitfall in the use of
submodules that I think should not exist in the first place:

If a repo has a submodule, and head 'foo' of the repo has the
submodule's HEAD pointing to head 'foo' of its origin, while head
'bar' of the repo has the submodule HEAD pointing to head 'bar' of its
origin, checking out bar/foo on the repository leaves the submodule in
an outdated state (and `submodule update` doesn't help).
