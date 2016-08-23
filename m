Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512EB1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755917AbcHWW1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:27:19 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36841 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755314AbcHWW1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:27:19 -0400
Received: by mail-yw0-f194.google.com with SMTP id u134so5761261ywg.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tugZrnPmDJPQ13yp/DoKP2luwkVLI7FjDXgfnSzB2hQ=;
        b=odtohzXEAK4uS3HdWvLKlVKtoii7dmtxyKc5M3mqa4KQ942+rmWhnASjP23Pb/lTnX
         Q50aNMc9xsXIoHOx8xFUEPRXYJN/950LMzGDcduSjfGCUmjBsxFlWLl3RRJajHDJL3Lf
         HZm5PeAZvFb2KIl1Xr2aUdbhknS82/0mM32Do3EA+bxEiUdTlf2aQzfmjYDQsYHNzbfM
         N7uzHDK1NKoXn3JwvvBaHqiQRawKR+plnbo6S8OyLi/oD/i+1nE/gXEAJ3MPzlhR+1OQ
         Vk0Y13+ynfGUydcXEYV9L6BB7PSn1uUE5qZquncTgRr3ITf/IVCQU6gsnHgZZd8Ti6G5
         v69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tugZrnPmDJPQ13yp/DoKP2luwkVLI7FjDXgfnSzB2hQ=;
        b=lTZYDz5bn3d+1fyWkLidNILkO4huJbm6MP/GRDwJdv3qcVit2EutPgB4WBXTJYrsFQ
         ZhytB5bsqXcgsNEeiJ7day70SEVsy6vjqUju8jWJWdy5dPMPS1QZM2J4gE7/huSBvlmK
         SRIY8U0rhP9JT2TB5dnOBgWbccf0bDH7qnOAMupcz3Cc2hrpVaN/PXXgjGkUDP7rQGdZ
         sVa1B9kNObeOHe0+eQ3MJjV6TIjuwmiA9wYG1x4M92EwxtqoCspIMh5/3PgChZfUDJYr
         bmWcPCYL7sFhBSBmKmrQZ3d2EyA9xVoJUqa+8g2CkgaI4k6IAgz6vgaXMjTpdjrdn4M5
         BIuw==
X-Gm-Message-State: AEkoousvYJF8WUbx1FZ2qSeSo/tMI7+87HN9oKQsehElHcBV7qz3SFQpIp5ZhuYbufQC9+9SOD74lTRrRFeRdg==
X-Received: by 10.129.135.2 with SMTP id x2mr23757849ywf.310.1471990243986;
 Tue, 23 Aug 2016 15:10:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:10:23 -0700 (PDT)
In-Reply-To: <20160815215327.15682-3-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-3-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:10:23 -0700
Message-ID: <CA+P7+xrmsNBxmoR6+2C9ZVvXcVH7D+O3iYqKhVrbAsaNUXzF_A@mail.gmail.com>
Subject: Re: [PATCHv5 2/8] t7408: merge short tests, factor out testing method
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> Tests consisting of one line each can be consolidated to have fewer tests
> to run as well as fewer lines of code.
>
> When having just a few git commands, do not create a new shell but
> use the -C flag in Git to execute in the correct directory.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Looks good. The resulting test file is easier to read, and you created
a common function to perform checking if we used alternates instead of
duplicating that part multiple times.

>  t/t7408-submodule-reference.sh | 48 ++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index b84c6748..dff47af 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -8,6 +8,15 @@ test_description='test clone --reference'
>
>  base_dir=$(pwd)
>
> +test_alternate_is_used () {
> +       alternates_file="$1" &&
> +       working_dir="$2" &&
> +       test_line_count = 1 "$alternates_file" &&
> +       echo "0 objects, 0 kilobytes" >expect &&
> +       git -C "$working_dir" count-objects >actual &&
> +       test_cmp expect actual
> +}
> +

This change wasn't mentioned in the description. You updated the tests
to use a stronger check for when alternates is in use. This is good. I
might have mentioned it in the description but it's not worth a
re-roll.

> -test_expect_success 'that reference gets used with update' '
> -       cd super-clone/sub &&
> -       echo "0 objects, 0 kilobytes" >expected &&
> -       git count-objects >current &&
> -       diff expected current

The stronger variant was used once here, but you use it in several
locations. It's good to have extracted this as the new tests are more
readable.

Thanks,
Jake
