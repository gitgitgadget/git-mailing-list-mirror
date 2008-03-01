From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 22:10:31 +0800
Message-ID: <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
	 <m3tzjrkie4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 15:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVSQf-0006Ep-JV
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 15:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbYCAOKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 09:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755723AbYCAOKd
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 09:10:33 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:24846 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYCAOKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 09:10:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5448038wah.23
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 06:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iy9xpx225eETADO8ArXxtVH4h/NwkN9DtuHocL5iQbE=;
        b=kWJ6/7pKw6kUEuoXebyttwBGl7mxsJma9KqZsGtVgPITJEgBkcSDFmQFMJxXXP5OtVA2rSMLPRs2sYlx608Pg9c3IulEB+cJ+95Nfgc+HblP+PRKwID8DnivbUkX9Imgsx9iyFJJLD5Q6Mx5BI2Jaqtuxrp2O994Uq96fqWCSeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SbrIrOREPILj+OUI6/u/EpGDrI+0KlBRvfuJ+griwMFDe3V+CYwg5+vYJFJrqDrvL9x3Fr8oHZRscI6j3764Fz9VIfqCoaDx3kGYrWQRhDsryA6BCuAqJLkPuoXBDkOg5+0ILfFu1ByzPFTkqP9yAtkQi7T7S6qpOw2OigHOigw=
Received: by 10.115.17.11 with SMTP id u11mr2356910wai.149.1204380631416;
        Sat, 01 Mar 2008 06:10:31 -0800 (PST)
Received: by 10.115.75.13 with HTTP; Sat, 1 Mar 2008 06:10:31 -0800 (PST)
In-Reply-To: <m3tzjrkie4.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75677>

On Fri, Feb 29, 2008 at 9:21 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "eric miao" <eric.y.miao@gmail.com> writes:
>
>  > I kept a mirror of
>  >
>  > http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>  >
>  > by a crontab task fetching the updated commits at midnight everyday.
>  >
>  > Yet I found the repository now grows to be 1.2G without checking out
>  > anything. The checked out working tree of this is about 1.5G.
>
>  Did you (re)packed this repository, running "git gc", or "git repack"?
>  Currently git either downloads small packs, or loose objects; it needs
>  to repack to make repository size smaller.
>
>  BTW. the largest git repository is 1.6G OpenOffice.org conversion,
>  with > 2G checkout, and some large binary files under version
>  control. Mozilla and GCC, other large repos, got under 0.5G IIRC.
>  So kernel should be quite smaller.
>
>
>  > I tried "git prune" and "git repack" but it still remains so large. The
>  > trend of the kernel is still going to be enlarged. Thus I'm thinking
>  > of the possibility of a baseline feature. One can totally forget about
>  > the history before that baseline, and start the development there
>  > after.
>
>  There is so called "shallow clone" feature, which allows to clone only
>  part of history. Currently it dupports only --depth, i.e. number of
>  commits from tips; it could I guess support providing tag as
>  delimiter. (You are welcome to implement it ;-).
>

I haven't ever used the shallow clone, but it looks still a bit different
from what I thought originally, say, if I download linux-2.6.24.tar.bz2
from kernel.org, that's about 40MB and should be a fair amount.
I then unpack and "git init", I expect it to recognize it's a v2.6.24,
and I can thereafter use "git fetch" to fetch those commits after
v2.6.24 from git.kernel.org. Is this possible?

>  --
>  Jakub Narebski
>  Poland
>  ShadeHawk on #git
>



-- 
Cheers
- eric
