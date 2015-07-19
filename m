From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] worktree: fix incorrect references to file "locked"
Date: Sat, 18 Jul 2015 23:04:12 -0400
Message-ID: <CAPig+cS4CC8D9JKxw3KSKMZdb_3sWR0C91LL9qcKrF-+RAbfEQ@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
	<dfaad2ac35a59b93f1f650d3398c861abd84f289.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:04:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGetm-0002I0-HE
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbGSDEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:04:13 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33563 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbGSDEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:04:13 -0400
Received: by ykfw194 with SMTP id w194so36904868ykf.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=p9kFOiHC/EN9ZxqA1Yik2dF0o3wQ8eGepXbhZgZUFEI=;
        b=ngf5IyUBgTaQjqYaXNTfdcnsVS6WGlWOnNeWdygVEY/j85rR6ZbrAFCLlTl8R9AJh+
         cGqsmAmyzMn6z7UCFNCbf3aBDz9HsakGzasPIWgBWyCajGFCVgVULaViTWGtsdNbc/Tf
         nBVKb1PrwVITmVd+WgT/vpJeVQTTUNC+fJy5lXRn10PnNrPAK68DRYSzXsg9VLP4CZUN
         6D2qUn5ERXW7DMJMR788RKf0TEVkKUftfZs8KPXuwu15BQhVU282RUfqWnmD1ZnQMemO
         cs84ZWH7hPmE33LQ4owX4haXF+WLFGUjrmih1wrpIrLEK2bNsey9rJxYHf5InQXYhQcc
         ncUg==
X-Received: by 10.13.202.204 with SMTP id m195mr22080261ywd.48.1437275052539;
 Sat, 18 Jul 2015 20:04:12 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:04:12 -0700 (PDT)
In-Reply-To: <dfaad2ac35a59b93f1f650d3398c861abd84f289.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: 2yL9TQBro_-bUrgaYzFS4ao9lLs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274195>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The manpage referred to file "lock" in a couple of places. The file is
> actually called "locked".
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 707dfd0..6cb3877 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -39,7 +39,7 @@ repository so that they do not get automatically pruned.
>
>  If a linked working tree is stored on a portable device or network share
>  which is not always mounted, you can prevent its administrative files from
> -being pruned by creating a file named 'lock' alongside the other
> +being pruned by creating a file named 'locked' alongside the other

This change is good.

>  administrative files, optionally containing a plain text reason that
>  pruning should be suppressed. See section "DETAILS" for more information.
>
> @@ -167,7 +167,7 @@ performed manually, such as:
>    warn if the worktree is dirty)
>  - `mv` to move or rename a worktree and update its administrative files
>  - `list` to list linked working trees
> -- `lock` to prevent automatic pruning of administrative files (for instance,
> +- `locked` to prevent automatic pruning of administrative files (for instance,
>    for a worktree on a portable device)

This one is not. This 'lock' is referring to a proposed user-interface
command ("git worktree lock") for manipulating the underlying 'locked'
file so that the user doesn't have to have detailed implementation
knowledge or muck with the underlying mechanics manually.
