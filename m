Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3873A1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 08:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932301AbeFZIox (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 04:44:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33561 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeFZIos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 04:44:48 -0400
Received: by mail-vk0-f68.google.com with SMTP id f200-v6so2199814vke.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=43iDEkR20MIiIR9dFBGVeVYZxvATOp9oCeP21nZA7sA=;
        b=ICAU5cSTMJ1ouerjJZlPY+i1Q/+/WIkgDhs4L+ZpC9cPU3VPeYrX1cuqbR00FGqYEF
         CqFEWJdO+oNDQ+tbajOqRi8cZcG5TiQBO/jpvRxBNJ2fmHL0fo6OkC/3jlB/Uein4X1k
         eI0HTNpBvWCKbcdG7y0H4+eruz49y2EjWDHQhzFuzz3Df1DUkEAA9rMYVCuEW/tBkvXf
         I+c40bWJ25eEmEzNbFlqR8scEMZ5S5JxIAtFGg1QXe127wDJ9iCGynqsYGtErTFbn3wP
         A1K+zospf5huvC2sIJ9+wGePWiq/JI7BE8QvRwlR153tk4jRc4wlSSVPqhW0dH//YUFP
         iesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=43iDEkR20MIiIR9dFBGVeVYZxvATOp9oCeP21nZA7sA=;
        b=CLa7kf9APtMM40c77Yee2nnjs0Xc3ZseK+ziSRqRS2nRwzBrd4CAF1gHhfW3Vdge9O
         3lsy8OdfFCD8WKeoYg1BV5uiHFnD38F9xCfrEA6MBa6a4yvK3tArh53I8SYWVpuveioT
         4sa0h+/JvijGk0GfhV9qos8ssObBxfcglISftLjOEA6epHIM9ObHaIlTc3JdE+Bwcw7r
         4F96as3wMfx75QnWpFZzrb0CxOwnbl6MWcRcqzIYWapi2FRs5aKNzYbID1tAP6MDvMXm
         XdtPYjgKZR+NjlueWDeQTrGmMw6kM1tYxW3JtsodDlrPAo51PJBtPnKa0TnOqCR1uPw5
         zSDA==
X-Gm-Message-State: APt69E0fkS27Otxd6YY51ruYRnudTvCb/RGGM0m8JjThwfjAuiITAlBK
        2Acir8LKHnKWxX8uv5lqVAjSs14CrXlfiXTzQUk=
X-Google-Smtp-Source: AAOMgpf10K5V8qogFWpJp6zobPgz3IfXIRG145Zn3RiRFyf6PMpa8SnEpAqIosoMhRscIFN1nEnbJrXfvpZwfxG4Pek=
X-Received: by 2002:a1f:41d4:: with SMTP id o203-v6mr317196vka.149.1530002687311;
 Tue, 26 Jun 2018 01:44:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 01:44:46
 -0700 (PDT)
In-Reply-To: <20180626073001.6555-7-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com> <20180626073001.6555-7-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 01:44:46 -0700
Message-ID: <CABPp-BG2LJMQs6=hvyhKOdQE=dSwADsCKrkf16_stEVnUZr_vA@mail.gmail.com>
Subject: Re: [PATCH 06/29] t6036: fix broken "merge fails but has appropriate
 contents" tests
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> These tests reference non-existent object "c" when they really mean to
> be referencing "C", however, this error went unnoticed due to a broken
> &&-chain later in the test. Fix these errors, as well as the broken
> &&-chains behind which they hid.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t6036-recursive-corner-cases.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index b5621303d6..b32ff8e1db 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -506,10 +506,10 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
>                 test_line_count = 2 out &&
>
>                 git rev-parse >expect    \
> -                       B:a   E2:a/file  c:a/file   A:ignore-me &&
> +                       B:a   E2:a/file  C:a/file   A:ignore-me &&
>                 git rev-parse   >actual   \
>                         :2:a  :3:a/file  :1:a/file  :0:ignore-me &&
> -               test_cmp expect actual
> +               test_cmp expect actual &&
>
>                 test_path_is_file a~HEAD
>         )
> @@ -533,10 +533,10 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
>                 test_line_count = 2 out &&
>
>                 git rev-parse >expect    \
> -                       B:a   E2:a/file  c:a/file   A:ignore-me &&
> +                       B:a   E2:a/file  C:a/file   A:ignore-me &&
>                 git rev-parse   >actual   \
>                         :3:a  :2:a/file  :1:a/file  :0:ignore-me &&
> -               test_cmp expect actual
> +               test_cmp expect actual &&
>
>                 test_path_is_file a~D^0
>         )

Eek, how did that become c:a/file when it was originally C:a/file?
Thanks for spotting the regression and fixing.

Reviewed-by: Elijah Newren <newren@gmail.com>
