Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6741F406
	for <e@80x24.org>; Tue, 26 Dec 2017 02:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbdLZCxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 21:53:48 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:44116 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZCxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 21:53:46 -0500
Received: by mail-oi0-f42.google.com with SMTP id g6so7141213oib.11
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 18:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qkmB6SzLF7Lw6wGg0sv8SRvUq9ibzskvKVNsbi6vIAU=;
        b=UqdedW7g7qqOo+O4KtM/x1P2jny8muRmbcziVhlNns2H+ulhvf8ix1tmb6bjgZRMJ/
         iaCHevVTyVs2shmRRlkeCTZfE24zWTEt+MRPi8o+oEhbZg/uRa9H+0/6gPDfZLcyNJjE
         prfsxu9fyBOPs6uZsEcENGCyndImY7VFJyfq4sR5bNz1lY4cdreByIFcyzT78DBQfswF
         SbhaU/01sMj4xY/eMVFd5iFEBKwWgQGLDgPoxMDAmVl2EZZly5sNy/FxcNa5kjowo8Jg
         bI9QKjQJL5M4PoCu+/lhn+pYMfRFjC+mrM9+LqXKI19ccn5nr4cpHrncK/SIzkh/jJCo
         bquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qkmB6SzLF7Lw6wGg0sv8SRvUq9ibzskvKVNsbi6vIAU=;
        b=a7wWThX8t5Vdt3tE7VWz/WCreRWi73RYeSDMwmOrk1J5mDQ5qOyA8RhlcvSOapEIFo
         0dqWb/TgBw2rjx5Mvok9MZjpyB6YOEMZaLvNhaYw5lThfuE4ulUmyNMDCPCUeqgjuAwI
         UdGJ6MORNX6B5xaLDYxjTNyY7sZcyzVQY1/cVguD3veDrcquyV3MmO5/BM5lL2bWVQQm
         Ri5fOlqfDgePCOy/zNmlHl7Cppr6noBmx6y11Wnb9ShVQ4/KZyRlUj7HVkERoI9iSXRW
         sBYRsHta6oYielBBkGpeoHQ5jHjPXQWloDkgvY+UG6SHuP7wprKgA+AiLLVD9QaKYvbB
         k4Ng==
X-Gm-Message-State: AKGB3mJJDuzig8ZqacGq0p+QYkP0o+3mxLdcJ1ChIiwwghUS1odL8lOJ
        UCHkZ+mtnIovkA67wyiEgPIfDUyzDluguMjtiH0=
X-Google-Smtp-Source: ACJfBosHCj8+/zyQoeT1xYQue7JthwtfpdT2Cpr6q2f9E/vG7x3H0AwweJbJmR/j2OXe+p1eZixHTt2J27FT+KiOrDI=
X-Received: by 10.202.82.196 with SMTP id g187mr10750017oib.183.1514256825087;
 Mon, 25 Dec 2017 18:53:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 25 Dec 2017 18:53:14 -0800 (PST)
In-Reply-To: <20171226021150.GA10059@duynguyen.vn.dektech.internal>
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com> <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
 <20171226021150.GA10059@duynguyen.vn.dektech.internal>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Dec 2017 09:53:14 +0700
Message-ID: <CACsJy8CN58ivOeAr83X86NZcBy+yrJd0SbFhej99Pjb8x8_gBA@mail.gmail.com>
Subject: Re: [PATCH] status: handle worktree renames
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 9:11 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Dec 25, 2017 at 07:26:27PM +0100, Igor Djordjevic wrote:
>> But I`ve noticed that "--porcelain=v2" output might still be buggy -
>> this is what having both files staged shows:
>>
>>     $ git status --porcelain=v2
>>     2 R. N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 new-file    original-file
>>
>> ..., where having old/deleted file unstaged, and new/created file
>> staged with `git add -N` shows this:
>>
>>     $ git status --porcelain=v2
>>     1 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 new-file
>>
>> So even though unstaged value is correctly recognized as "R" (renamed),
>> first number is "1" (instead of "2" to signal rename/copy), and both
>> rename score and original file name are missing.
>>
>> Not sure if this is a bug, but it seems so, as `git status` "Porcelain
>> Format Version 2"[1] says the last path is "pathname in the commit at
>> HEAD" (in case of copy/rename), which is missing here.
>
> Yeah v2 looks problematic. The way the document is written, it's not
> prepared to deal with a rename pair coming from comparing the index
> (with intent-to-add entries) with worktree, only from comparing with
> HEAD. So either we could ajust v2 semantics slightly like this
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 81cab9aefb..3da10020aa 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -309,13 +309,13 @@ Renamed or copied entries have the following format:
>                 of similarity between the source and target of the
>                 move or copy). For example "R100" or "C75".
>      <path>      The pathname.  In a renamed/copied entry, this
> -               is the path in the index and in the working tree.
> +               is the path in the index.
>      <sep>       When the `-z` option is used, the 2 pathnames are separated
>                 with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
>                 byte separates them.
> -    <origPath>  The pathname in the commit at HEAD.  This is only
> -               present in a renamed/copied entry, and tells
> -               where the renamed/copied contents came from.
> +    <origPath>  The pathname in the commit at HEAD or in the worktree.
> +               This is only present in a renamed/copied entry, and
> +               tells where the renamed/copied contents came from.
>      --------------------------------------------------------
>
>  Unmerged entries have the following format; the first character is
>
> The problem is, you cannot know if it's a rename from HEAD or from
> worktree with this updated v2 (or perhaps you could because HEAD name
> should be all zero?).

I'm wrong about this. the "<XY>" code for HEAD rename would be "R."
while worktree rename is ".R" so I think we're good.
-- 
Duy
