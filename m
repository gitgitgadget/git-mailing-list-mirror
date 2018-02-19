Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F171F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeBSSrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:47:18 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38776 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeBSSrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:47:17 -0500
Received: by mail-qk0-f195.google.com with SMTP id s198so13445427qke.5
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5z+XWzqjhofv12BmjyAwu7kOpcPyocpYXK9gHgZYZnM=;
        b=k3jAU55FU63vwo/Xe/7ui7rFJ6BaSVsTc7WEuGpuwfOY6avY8u0xYz0QQqsUOj1fdg
         +a+nU0u8mJhE8zT2SfZ2Ta8sRcTxwsbI3VR5iY7HM+++h7HmxQBw0GjNKxavqde0NSQt
         R6n8W3CEz+5TB8yTYpcri66iYvIdWU8lsWoDDSuc8TfDK6kLoUgXufFmH+nxx40vpV+V
         IoxWhyLA7nfLqtj6sXDZCHlKOdYZxvr7aGhw5bgjn1OB9GUV5ZfJfBn6uJVYVObKUNG8
         i/Yo7QdmfNZ9a3I8nzg2kBsC9DBope0fYyK4Trv4DHZmAK4hZcgtDvh8TuJM2yH9g/qL
         wZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5z+XWzqjhofv12BmjyAwu7kOpcPyocpYXK9gHgZYZnM=;
        b=Cy5Y8U/Lj3T6r5EeUySw/S9ukzKOfG+IoPQBZiYe52cGUvq+fb4pcwkrHJ4ISqBZ4d
         Vcs7bYkupOhdDsPo62gHdiSncYKf6bC1s4Gqx5mW32bAMmW7UZEZ9jGz861Ghi2gTn69
         2LEDKpULfi+ncnTboJpGmrBQkzkKq6WX499CxHoSyVTsNmpBwrQBcyKs3JUgV7ZxSYvz
         sAi+p1I9YkcujKT4CL//rkTm5ZJUexlCIn+ytsNNu2RzIMW/BJrvrf9o2WFVXMnxpCAL
         ofrl8Tl1pkNXliFc2JvTEwHo1enkZ9u+SnEpN1j4ZLuB2LeNY0yYbRb9SvwVfM0r0NdU
         hzFQ==
X-Gm-Message-State: APf1xPCkb0TYI+pZ7VNN3ovOdnU0gFnFd1HA1CxIBYQ8HOQsp2ml2M3L
        37MtxLAVWmTNgTvijYz4X5WgwM5nRCbf3SfVT3M=
X-Google-Smtp-Source: AH8x227JwtLmQpGlnvzhyAg4FsPHC2A16KJfCCVWvd5FDR3MT9Wlk52kXAhYs+M/Pv05K6AiQv3/QNjapDms5zdza9g=
X-Received: by 10.55.49.74 with SMTP id x71mr25743708qkx.133.1519066036483;
 Mon, 19 Feb 2018 10:47:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.26 with HTTP; Mon, 19 Feb 2018 10:47:16 -0800 (PST)
In-Reply-To: <20180219112910.24471-4-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net> <20180219112910.24471-4-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Feb 2018 13:47:16 -0500
X-Google-Sender-Auth: HGpUNl_b2nRJwHMImcQDNkXCl1o
Message-ID: <CAPig+cRWCd6pYxc8NrOM_ntodgkwwfMpD_tWQXYXOukVWgQfCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] t3701: use test_write_lines and write_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 6:29 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Simplify things slightly by using the above helpers.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> @@ -87,13 +87,8 @@ test_expect_success 'setup expected' '
> @@ -110,13 +105,12 @@ test_expect_success 'setup patch' '
>  test_expect_success 'setup fake editor' '
> -       echo "#!$SHELL_PATH" >fake_editor.sh &&
> -       cat >>fake_editor.sh <<-\EOF &&
> +       FAKE_EDITOR="$(pwd)/fake-editor.sh" &&
> +       write_script "$FAKE_EDITOR" <<-\EOF &&
>         mv -f "$1" oldpatch &&
>         mv -f patch "$1"
>         EOF
> -       chmod a+x fake_editor.sh &&
> -       test_set_editor "$(pwd)/fake_editor.sh"
> +       test_set_editor "$FAKE_EDITOR"
>  '

The very first thing that test_set_editor() does is set FAKE_EDITOR to
the value of $1, so it is confusing to see it getting setting it here
first; the reader has to spend extra brain cycles wondering if
something non-obvious is going on that requires this manual
assignment. Perhaps drop the assignment altogether and just write
literal "fake_editor.sh" in the couple places it's needed (as was done
in the original code)?
