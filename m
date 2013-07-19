From: Sebastian Staudt <koraktor@gmail.com>
Subject: Re: [RFC] checkout --rebase
Date: Fri, 19 Jul 2013 12:48:22 +0200
Message-ID: <CA+xP2SbHD+MU4K0JBbZdA6bWQFQerBi5mWA+7G9=tBksjp+LXw@mail.gmail.com>
References: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 12:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V08FN-0003YP-GG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 12:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760255Ab3GSKtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 06:49:05 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:52136 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760238Ab3GSKtD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 06:49:03 -0400
Received: by mail-we0-f170.google.com with SMTP id w57so3921169wes.15
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tIBTB87Arm74HZkIsdwqCpV2VZb35fhHzxO3vh3pFE0=;
        b=G+vHezt5nkhGDT78ipm5kl4fe2vSHrPpF8TsYDUKW6KH24pU8iB57PDvlsWJgEr8Wy
         3NPG9wEkwbTySEeHINjGd0aTLr9MmEBjSNG1zlmQ46A+O71W8XitXPKwTRJ2CBDLWQD3
         tH5xLAf1y5JAec2dBzqA4i4U3EJftCiYO/69cbXFISdrfMpefOaD0BrSoeagWFsnjkZE
         pwmnZsMGE2WYfPRHdKpyW7SES2P7BIG7S8A5RvXID1nX5OLSjl0P4Q/MhSkMFT+hF+uQ
         8lIUVvoScZzCdELeZwXBxmKU5q9EE9CERjXcOL4x1XizD0rT1pPywcgWBPwxcbnwAq+k
         Y4xg==
X-Received: by 10.180.9.212 with SMTP id c20mr22139476wib.65.1374230942134;
 Fri, 19 Jul 2013 03:49:02 -0700 (PDT)
Received: by 10.216.40.12 with HTTP; Fri, 19 Jul 2013 03:48:22 -0700 (PDT)
In-Reply-To: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230790>

Isn't this what you want?

 $ git rebase master um-build


2013/7/19 Ramkumar Ramachandra <artagnon@gmail.com>:
> Hi,
>
> I'm often work on small topic branches, and find myself doing this quite often:
>
>   # on branch master
>   $ git checkout um-build
>   $ git rebase master
>
> This is horribly inefficient; the first operation takes a _really_
> long time to complete, since master updates itself very often and I
> have to check out an old worktree.  So, I work around this issue by
> doing:
>
>   # on branch master
>   $ git checkout -b um-build-2
>   $ git cherry-pick ..um-build
>   $ git branch -M um-build
>
> ... and I scripted it.  Perhaps we should get this functionality in
> core, as `git checkout --rebase` (or something)?
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
