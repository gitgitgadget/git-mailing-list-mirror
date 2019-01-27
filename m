Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0181F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfA0AW0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:22:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34821 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfA0AW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:22:26 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so14750366itp.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUsYehfJo8fnf33sVgdnmt4jXzCCou0hM3qVnKyTM3A=;
        b=o77rA4WbGMySjizX/opJsLvzdqIFuVnjZSR6UVN9rW3/M7eIm6BtUrv1AOME1ecvLG
         fqYTcs0rrk+YBArG2Dqfy0xGF9W1aKrz9XZGRFQmmM7RZYcZH4EWWIQsuioinOMskdY4
         BaWxFm0Rw3D1RR7qzHUC1qv2rfgYVbJYgdl3YbVbXfvIrbp/u4r+yuq1z337Kmz7lzVS
         lNB2aAB2eBOFJKticTj0vXWeFDadM8eNl0D6PzijfTUpHuDMaWRHsRur4lcxAcceOEqx
         cCrr61AN3zSlKyMf40/vrwYNTae0amZWNt4injdhwkDItDR388vnrKTCF14Dduexq5vP
         e64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUsYehfJo8fnf33sVgdnmt4jXzCCou0hM3qVnKyTM3A=;
        b=J67VLPNSrng7DcJHF9WoVpuztZPNh805NuJ8FXfCqd4QSrVFjQKnKZ8EGkbPEJcOHL
         12XHv8Ox5tGXuQOnBQog1pnLKc9VmNcieHJ3BucX7iiuaLQZk1GCkFXFcKcTPPYKKCGv
         7M5UbwBp7Qi4ZdNURu+5AcySzAjciIRPwOx5BKFiq+kLEbpUWCSx/Q058gomjG6vJnvJ
         Rjcz3XsmjHR3g7VxXY0u5CzCCKg5+TnDkc4oqpccVXMMBTy/DQCMfZNi1gpLTbxRYKGg
         DE9nIo1BoLQVhfGqcmyXBwWKeoBO6DB6V4bPPXXcZUDAilLAkqpNyYWDBexhWojK1Ds1
         3XsA==
X-Gm-Message-State: AJcUukcMLxmWPLZLkB3Q3OOjGSlV1yeAtikkfeGU1ohmA8r/qbbJGbL4
        CSiEejyaMTAgTFElk0J5+WpBJ0LQbmgiAGpAH+4=
X-Google-Smtp-Source: ALg8bN6Vb+J9kwbE6VqO64RK1xh6ePSp2tZiUj2ocSLGwIyaYhTPCcHk5FU9JWeHgF4w+Ln4MRhPPV6Q8zhMw6F64tQ=
X-Received: by 2002:a02:183:: with SMTP id 3mr10512626jak.130.1548548545487;
 Sat, 26 Jan 2019 16:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20190126204951.42455-1-koraktor@gmail.com> <20190126204951.42455-2-koraktor@gmail.com>
In-Reply-To: <20190126204951.42455-2-koraktor@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 27 Jan 2019 07:21:59 +0700
Message-ID: <CACsJy8A+QsSDfL_RX2ctNsV35VpBaSp4M7hR00nSObmmULUmvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Setup working tree in describe
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wrote:
>
> This ensures the given working tree is used for --dirty.
>
> The implementation of --broken uses diff-index which calls
> setup_work_tree() itself.

It would be nice to have a test case covering --broken even if no fix
is needed (so that somebody else will not accidentally break it
later). I did a quick test and thought it was broken, but it turns out
I tested it wrong :P

> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  builtin/describe.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index cc118448ee..b5b7abdc8f 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>                         struct argv_array args = ARGV_ARRAY_INIT;
>                         int fd, result;
>
> +                       setup_work_tree();
>                         read_cache();
>                         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
>                                       NULL, NULL, NULL);
> --
> 2.20.1
>


-- 
Duy
