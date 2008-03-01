From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 21:29:04 +0700
Message-ID: <fcaeb9bf0803010629v4894ad92ief4d5ef4257723e@mail.gmail.com>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
	 <m3tzjrkie4.fsf@localhost.localdomain>
	 <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "eric miao" <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 15:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVSih-0003Yc-Nl
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 15:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYCAO3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 09:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYCAO3L
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 09:29:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:31477 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYCAO3K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 09:29:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so877238ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aPXKxOy+jgiWxleWeF26z+AJWprbrBkyVGQ8P7OHjp4=;
        b=LYqnQzVTUy3IZPm0OsgsxfAwIPS+2FC38JUtxYTqymh53vfYcQSw1d9r6ggJMrtKc3g5eAoQemehGRSVOcCFHs45xpmjm+YL18gE8YCWCp/2JNqSrD3JQP4La3GZOiKpbBiApzq9f8b8lrTHIDcfKRZTf41HpBd9H+D9f6kjk5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENi6KSlfIwbwX4Z/HfpqJM4lsqTaGjK4ZXch+8OF2uLheRZ+Zzhfs8CrjFKQHvyxKVgk+ByxP/Bhaim/cJi2RKDxUOZ8Iu6obHmjmtdWNIuFeD+xE/j72u1f3wTOGXoPrvBh29vlvMk8LZVpW+MjWmw+BCp3eAxEtq7GTLOmyT4=
Received: by 10.141.36.10 with SMTP id o10mr7102232rvj.176.1204381745174;
        Sat, 01 Mar 2008 06:29:05 -0800 (PST)
Received: by 10.141.204.12 with HTTP; Sat, 1 Mar 2008 06:29:04 -0800 (PST)
In-Reply-To: <f17812d70803010610o39cdf327x995c9e2e75a9edba@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75678>

On Sat, Mar 1, 2008 at 9:10 PM, eric miao <eric.y.miao@gmail.com> wrote:
> On Fri, Feb 29, 2008 at 9:21 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>  > "eric miao" <eric.y.miao@gmail.com> writes:
>  >
>  >  > I kept a mirror of
>  >  >
>  >  > http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>  >  >
>  >  > by a crontab task fetching the updated commits at midnight everyday.
>  >  >
>  >  > Yet I found the repository now grows to be 1.2G without checking out
>  >  > anything. The checked out working tree of this is about 1.5G.
>  >
>  >  Did you (re)packed this repository, running "git gc", or "git repack"?
>  >  Currently git either downloads small packs, or loose objects; it needs
>  >  to repack to make repository size smaller.
>  >
>  >  BTW. the largest git repository is 1.6G OpenOffice.org conversion,
>  >  with > 2G checkout, and some large binary files under version
>  >  control. Mozilla and GCC, other large repos, got under 0.5G IIRC.
>  >  So kernel should be quite smaller.
>  >
>  >
>  >  > I tried "git prune" and "git repack" but it still remains so large. The
>  >  > trend of the kernel is still going to be enlarged. Thus I'm thinking
>  >  > of the possibility of a baseline feature. One can totally forget about
>  >  > the history before that baseline, and start the development there
>  >  > after.
>  >
>  >  There is so called "shallow clone" feature, which allows to clone only
>  >  part of history. Currently it dupports only --depth, i.e. number of
>  >  commits from tips; it could I guess support providing tag as
>  >  delimiter. (You are welcome to implement it ;-).
>  >
>
>  I haven't ever used the shallow clone, but it looks still a bit different
>  from what I thought originally, say, if I download linux-2.6.24.tar.bz2
>  from kernel.org, that's about 40MB and should be a fair amount.
>  I then unpack and "git init", I expect it to recognize it's a v2.6.24,
>  and I can thereafter use "git fetch" to fetch those commits after
>  v2.6.24 from git.kernel.org. Is this possible?

I tried shallow clone (depth 1) with a fairly old linux-2.6 repo and
the pack was 68MB. A bit bigger than 40MB but still acceptable IMO.
The tarball+git-init way, I don't think it work. Maybe kernel.org
could release shallow git bundles in addition to tarballs so  users
like you can download a bundle, make a repo from it and keep up with
"git fetch".

-- 
Duy
