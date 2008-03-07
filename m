From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Something wrong with next in main git repository?
Date: Fri, 7 Mar 2008 11:42:12 +0000
Message-ID: <57518fd10803070342u7e1a5527u52d5cec8f65847a1@mail.gmail.com>
References: <200803071129.21551.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXaya-0002pj-8i
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbYCGLmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbYCGLmP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:42:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:17991 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbYCGLmN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:42:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so229459rvb.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=FKy6rm+98Jfaz4/8vVdRAmF0FJiNJQzQKNEj6u5KXXk=;
        b=ga4Y0A5DmbJJ9MhUCW+EDWHYWsZMoPuQzr/UZLKMZT9fHvc0OiW+WuqVuRQZUCG3cVBNvBk6vYFBJPyGldbe0ODpI7LEBsy3zjlGwUCemzCfoKdQsz6yylFIQQsL0ilOjzUhM54abqwm78MRpuWNBPLd+WcC2qAGOSJqJRIgo1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=B+XGM+QQk+2T8+aIMCQ3+Di98vLHPReBcWkSfptJJ/b/2kRMwwoZqfUoXnGh3Tee0bHwpyjqJoVmOMFNq1KAORYE5idTwwGnB5ZL7XlzUnl0+o7NQdVB1xAztu9dTXs5fo366l/Q4i/9t6ZQ8L8rxBbowdr2cZBSCeEefryp0SI=
Received: by 10.141.107.13 with SMTP id j13mr319298rvm.276.1204890132432;
        Fri, 07 Mar 2008 03:42:12 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Fri, 7 Mar 2008 03:42:12 -0800 (PST)
In-Reply-To: <200803071129.21551.andyparkins@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: fc730d39b5064e2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76478>

On Fri, Mar 7, 2008 at 11:29 AM, Andy Parkins <andyparkins@gmail.com> wrote:
> Hello,
>
>  I've been keeping up with development only intermittently lately, and just got
>  a warning from git fetch (in my git directory) that the update to my 'next'
>  tracking branch was rejected as not being a fast forward.
>
>  I renamed my current up/next to up/oldnext and fetched the latest next, so I
>  had up/oldnext and up/next to compare.  I'm probably concerned over nothing,
>  but I can't find any mention of a rewind of next in the mailing list.
>
>  As far as I can tell a whole series of merges has just vanished.  For
>  information:
>
>   $ git rev-parse up/next up/oldnext
>   0bdd7328c801101d752d0dfc9976a50651738897
>   38fd5a1b23780381c3b6987c730f5ea3d8e1fc7f
>
>   $ git merge-base up/next up/oldnext
>   ef5b9d6e2286630bf8afb5bdf1c6e3356f3d50c7
>
>  Apart from all the merges that have vanished, some revisions have vanished too
>  (vanished in the sense, they aren't on the branch any more).  i.e.
>
>   $ git log --no-merges --pretty=oneline up/next..up/oldnext
>   33369889 Revert "Support builtin aliases"
>   3a569a00 Revert "parse_commit_buffer: don't parse invalid commits"
>   1b1b2346 parse_commit_buffer: don't parse invalid commits
>   f0a31f58 Avoid redundant declaration of missing_target()
>   ... etc ...
>   0edad442 adjust_shared_perm: chmod() only when needed.
>   69a47520 Revert "pack-objects: use of version 3 delta is now optional."
>   394737eb pack-objects: use of version 3 delta is now optional.
>
>  Have all these commits gone missing?  I'm certain that someone other than me
>  would have noticed this sort of loss, so is it something I've done wrong or
>  misunderstood?
>

'next' now gets rewound after each feature release, to try and give a
clean slate to base new work off of.  Is that perhaps what you're
seeing?
