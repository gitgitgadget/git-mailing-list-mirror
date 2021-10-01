Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2DCC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489E56137A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 19:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356031AbhJATMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 15:12:13 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37596 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356007AbhJATMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 15:12:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id ba1so38315715edb.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 12:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zcd8vgtfVNoU0j0iZ0pPnL9Z6f3b/lUT+/FpIhPH9M=;
        b=5xjzPOsBeGdTu0Jk2CWXlbdDZi4gy8VfMb0r6lpdpnudk2qhLloO77DONa+JsnC4Tq
         ALir1rtGcR/NM0IfsH1D53QYiOz59PXGHeueym2uRNyKkHlfzc7AK7/VoQLhtglQ9tzv
         dgzCGDPKLhgF4pnpPZzRbAgy2KFtwIQf2KGbsmzCTCu+HGL03sxfEgtIuG0otxbHTUYs
         cxfbK4D308yF7eA0o9w1R2A35dDrWPywOufEVetZp51fFJqXjgOm0zXRNoflCfBEzmI8
         AGeDjUfQLjr4Xe1m5YV1iGjL9ROr0h6t9siRMc2VN65ggPIlP+ZyH0Z3Qctby23FFBvy
         9Qww==
X-Gm-Message-State: AOAM532OKGnJNUXId4F75tXPHG0Pnu24lJBjLesRhybVsPakxRkNgkIS
        JKfsxMKyFrHOCLBIUN9VlVktAVg8dT31tF9al9w=
X-Google-Smtp-Source: ABdhPJxgK+C4OJRs7cHbViH0RTa9SYXKuKqOtzhmcfZoHeE4NABry9YdBfWd37SHhZSj4IPDpZC+1W/4WZvMR4kFS+U=
X-Received: by 2002:a17:906:480a:: with SMTP id w10mr4738091ejq.262.1633115425324;
 Fri, 01 Oct 2021 12:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211001113725.13354-1-bagasdotme@gmail.com> <20211001113725.13354-3-bagasdotme@gmail.com>
In-Reply-To: <20211001113725.13354-3-bagasdotme@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Oct 2021 15:10:14 -0400
Message-ID: <CAPig+cSWutBRQK+Qy=nkaDZRvy4trVNPuo+cF-quC2rBwNe2fw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] blame: document --color-* options
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 7:38 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
> 2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
> lines, 2018-04-23) introduce --color-lines and --color-by-age options to
> git blame, respectively. While both options are mentioned in usage help,
> they aren't documented in git-blame(1). Document them.
>
> Co-authored-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
> Signed-off-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> @@ -136,5 +136,17 @@ take effect.
> +--color-lines::
> +       Color lines differently, if they come from the same commit as the preceding line.

Drop the comma: s/differently,/differently/

> +       This facilitates distinguishing code blocks introduced by different commits.

Taking non-native English speakers into account, perhaps:
s/facilitates distinguishing/makes it easier to distinguish/

> +       The color defaults to cyan and be adjusted using the `color.blame.repeatedLines`

s/and be/and can be/

> +       config option. Only the line annotation (see "The Default Format" section)
> +       is colored.

You can drop the last sentence entirely if you start the blurb like this:

    Color line annotations differently, if...

> +--color-by-age::
> +       Color lines depending on the age of the line. The `color.blame.highlightRecent`
> +       config option controls what color is used for which range of age. Only the
> +       line annotation (see "The Default Format" section) is colored.

Ditto about dropping the last sentence.

    Color line annotations depending upon the age of the line.

> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> @@ -9,8 +9,8 @@ color.advice.hint::
>  color.blame.highlightRecent::
> -       This can be used to color the metadata of a blame line depending
> -       on age of the line.
> +       Used to color line annotations differently depending on the age of the commit
> +       (`git blame --color-by-age`).

This can be tightened up:

    Specify the line annotation color depending upon the age
    of the commit (`git blame...`).

> @@ -20,15 +20,15 @@ before the given timestamp, overwriting older timestamped colors.
>  color.blame.repeatedLines::
> -       Use the customized color for the part of git-blame output that
> -       is repeated meta information per line (such as commit id,
> -       author name, date and timezone). Defaults to cyan.
> +       Use the specified color to colorize line annotations, if they come from the
> +       same commit as the preceding line (`git blame --color-lines`). Defaults to
> +       cyan.

Likewise:

    Specify the line annotation color for lines which
    originate with the same commit (`git blame...`).
