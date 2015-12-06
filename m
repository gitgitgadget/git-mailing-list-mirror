From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] git-worktree.txt: mention about the config file split
Date: Sun, 6 Dec 2015 03:02:27 -0500
Message-ID: <CAPig+cT3NrF+0uDi4krd9WoqqJvZUqxCfhVxekoKWaPZ7C_dKw@mail.gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
	<1449083626-20075-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 09:02:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5UHL-0000Q8-KV
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 09:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbbLFICc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2015 03:02:32 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35320 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbbLFIC2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 03:02:28 -0500
Received: by vkha189 with SMTP id a189so87146120vkh.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 00:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7lZhbWJoqprBHLlQtX8isIsxmvbhc6ucjIFbtYldvq8=;
        b=p9tpwCICr/R4Ut99xfnIDWVy8TjsxSuI9lxak0goOxfTlmF5sA8DVb3C5jIYuYzBPI
         HIaxrT7nLLhDv64Rf6DnKwgemK/vepPGw4/jNiEZNGCV0L/3ULGf7LbzSWLsEV2eiV9T
         An+6y4WVAkguV3uJWJ1pzZCXBmDkbYJPPrw7jPtOYlaj9Ub/XMyNjxPHuY4qUTBlXpRo
         8LR+1ddaAwi54OkpiYdGGwosIKG1Lj4e9by/YAODR7KhiHgeYroMna5yv6v41teDhNQP
         PiYS1o8jGManN7Uw/AyXv+5w0Bbf7UIRq6BjO+z0oFtwxYoeg2gxbMyMbOZZ2H0raV+t
         A68w==
X-Received: by 10.31.56.18 with SMTP id f18mr14456821vka.19.1449388947693;
 Sun, 06 Dec 2015 00:02:27 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 6 Dec 2015 00:02:27 -0800 (PST)
In-Reply-To: <1449083626-20075-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: mjaZ8DkCJCWxxvjhXpPXGBQYIuk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282045>

On Wed, Dec 2, 2015 at 2:13 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> @@ -147,6 +147,19 @@ to `/path/main/.git/worktrees/test-next` then a =
file named
>  `test-next` entry from being pruned.  See
>  linkgit:gitrepository-layout[5] for details.
>
> +Similar to the file system split in ".git", the repository config fi=
le
> +is also split. Certain variables, for example core.worktree, are
> +per-worktree while the majority of variables are still shared (see
> +linkgit:git-config[1] for details). Shared variables and per-working
> +tree ones that belong to the main working tree are in .git/config.
> +Per-working tree variables for working tree X are in
> +$GIT_COMMON_DIR/worktrees/X/config.worktree. Even though per-working

Existing examples in the DETAILS section call this "test-next" rather
than "X", so perhaps s/X/test-next/g ?

> +tree variables for the main working tree are in the default config
> +place, they are invisible from all linked working trees.  You can ma=
ke
> +more config variables per-working tree by adding them in
> +.git/info/config.worktree (see linkgit:gitrepository-layout[5] for
> +details).
> +
>  LIST OUTPUT FORMAT
>  ------------------
>  The worktree list command has two output formats.  The default forma=
t shows the
> --
> 2.2.0.513.g477eb31
