From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a' when 
	no changes were added)
Date: Sat, 24 Apr 2010 12:35:38 -0700
Message-ID: <r2y8c9a061004241235n77ca3925q8fde8fc3b01e4e80@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain> 
	<AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com> <20100424164247.GM3563@machine.or.cz> 
	<alpine.LFD.2.00.1004241430300.7232@xanadu.home> <20100424185433.GN3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Apr 24 21:36:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5l91-0002Rd-NW
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 21:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab0DXTf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 15:35:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58661 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab0DXTf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 15:35:58 -0400
Received: by pvc21 with SMTP id 21so33523pvc.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=MWuCuQD+PDdi+ApGRvsJpJtAq8YdCxNwFMS6cpZH00A=;
        b=p0BF1FnB5+BYYIFvNO5BTnL2bX+tZG4JTWnjkquvSoJyNskDBlD6DLC2laaAVRgIMI
         5pCpoQc3lLENZUjLxfCxTLXKxV8FIgm1g8Mvo1kEWK1W48fm71Cf0Zd0LwJESOCIXYi/
         34az6b8RKq5pg1kG+gFEO8YgCK0N7S+8C3N74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eb4qaVyu2dINz2/CLp1Zj9Vgeull5cZimmF/BdqGHHY1ByNnRH7fl2WZwpnKbr7U7W
         S3xWuLy2fgPObqow94geh4ZJrPwhyPkcVvdZanwg2oJi6CKYnr7g7RWQu4G9eRuxB9ln
         m1s6h5UvoBTwmpvMW/pPjOpz52YtTATKKlqgM=
Received: by 10.142.8.13 with SMTP id 13mr894824wfh.210.1272137758074; Sat, 24 
	Apr 2010 12:35:58 -0700 (PDT)
Received: by 10.142.141.12 with HTTP; Sat, 24 Apr 2010 12:35:38 -0700 (PDT)
In-Reply-To: <20100424185433.GN3563@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145699>

On Sat, Apr 24, 2010 at 11:54, Petr Baudis <pasky@suse.cz> wrote:
> Are there valid user scenarios where you customize your index, then want
> to override that using -a without thinking twice?
>

Depends on what you consider "customizing your index".  I add files to
the index all the time as I'm working on things, then commit -a at the
end "without thinking twice".

For example:
1) Hack on something.
2) git add $thing
3) Run full test-suite.
4) Fix a failing module.
5) git add $fixed-module-and-tests
6) Repeat 3-5 until there's only one module failing.
7) Fix last failing module.
8) git commit -a

I doubt I'm the only one that stages things as a way of marking them
as "done", and using git commit -a to "check-off" the last "todo"
item.
