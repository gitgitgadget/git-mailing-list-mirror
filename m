From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] worktree: remove references to "git checkout --to"
 from the manpage
Date: Sat, 18 Jul 2015 22:56:03 -0400
Message-ID: <CAPig+cSmRDNCY-k-1cVj7QzSJPP0NiKO+s2i2gLsacQBH8OxuA@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
	<58c91f8907d5f3ef91607e85a96adcf0b1278e14.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGelv-0007sk-4Q
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbGSC4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:56:06 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33339 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbbGSC4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 22:56:04 -0400
Received: by ykfw194 with SMTP id w194so36837700ykf.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K/c0i9ZudFYIDWMXXN2p6q9OCdjlZl1Pr1dMj/Lgrpc=;
        b=IigtZ9Iwp45iIaztvpZgakIuHfijKY5QWCPjdo60pb1b16dY1mDjRfoaUvXOMWGb9a
         P6eQ20rIWfM+7ZFTMlGq33mEt7iWcQDdQXIjvFPhHAsKRt8DyiOsYvsd01A4NM1DaCxc
         2Ok1rAtS1SrYyXXfdu9wVcXE4Yq4XBy0GthnLidDyT5MejHjUI2vS5kIWv37n+gBJNRi
         WFRXxbD4JaDMiAhlsUuYmWCi8bJD69CquAxs///n+OUYl6692JOgcAMUbZu4VxxyYx4w
         keLyVgmipG0DsbadcCE9z1qk0uPeYObJ3V26AS+sKAvCHwoxtyNx4T11CaqvXwy40wrw
         6S7A==
X-Received: by 10.129.70.69 with SMTP id t66mr22196557ywa.4.1437274563527;
 Sat, 18 Jul 2015 19:56:03 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 19:56:03 -0700 (PDT)
In-Reply-To: <58c91f8907d5f3ef91607e85a96adcf0b1278e14.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: khNgA1_bzFYB9n0AMAxwp4Jpr0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274194>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index c8dd0e5..707dfd0 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -18,7 +18,7 @@ DESCRIPTION
>  Manage multiple worktrees attached to the same repository.
>
>  A git repository can support multiple working trees, allowing you to check
> -out more than one branch at a time.  With `git checkout --to` a new working
> +out more than one branch at a time.  With `git worktree add`, a new working
>  tree is associated with the repository.  This new working tree is called a
>  "linked working tree" as opposed to the "main working tree" prepared by "git
>  init" or "git clone".  A repository has one main working tree (if it's not a
> @@ -99,7 +99,7 @@ Each linked working tree has a private sub-directory in the repository's
>  $GIT_DIR/worktrees directory.  The private sub-directory's name is usually
>  the base name of the linked working tree's path, possibly appended with a
>  number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
> -command `git checkout --to /path/other/test-next next` creates the linked
> +command `git worktree add /path/other/test-next next` creates the linked
>  working tree in `/path/other/test-next` and also creates a
>  `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
>  if `test-next` is already taken).

These fixes are already in 'master': 4d5a3c5
(Documentation/git-worktree: fix stale "git checkout --to" references,
2015-07-16)
