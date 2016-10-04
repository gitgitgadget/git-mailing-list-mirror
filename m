Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637A6207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbcJDFvh (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:51:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34506 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcJDFvg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:51:36 -0400
Received: by mail-yw0-f193.google.com with SMTP id u124so1824641ywg.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R6VylSzjwaiO4KLdP8EKIgqG43CVh8DuDETCjPmkAvY=;
        b=xMDphHQhn1GvKeaMqUE9nYQscDtjh6lbHHVo0rPIL0QBizYzlWtxvyt/mdpLo/HyhG
         1+uvF71Yk1M4NVfaR92CYtWqr6wIOLrT/CmNmPy1UR7Yt5rmNx8HfRK+OUGmsRJRnESF
         PL6DqZCr7uXGY9+TJYpDOiwwaHzcfwqAYk8qR3pbCR82unRu45iEdFHmjTljqyZt9I1n
         zAbqc/HZb18n8xDTc7+ygjFTVQKOiTkDw9IlHS7WnPZTKFrNFdbpXvOgpeoI6QKrRq+G
         AroTbwDoRwHxDXzY8xWgpe1AJThATUJJX1r/HcbtHC6e4K1+CiEY7jTzox9JM2bURnRE
         eQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R6VylSzjwaiO4KLdP8EKIgqG43CVh8DuDETCjPmkAvY=;
        b=MVxLgVuSVREdyqVmNfCguC79H3NOOISB4frcNCswfWm0mPRvpatk9FlH6UvpBUH/eS
         jT67LwmTtjy7Knuw4s3wIijoFn/vFwdWsRISEl6VCJQlo+O0BP+efi7IFZvzKGMIyat7
         arEp2KdkN9u8nO6uchk+LGdljaWeuyydy4UYg4H9UYbX8T0tk0lwd7vrlGeToiaFeWVV
         /1fvNtyS2Xm4WC2b95sfdBGcIQ3OE9tHLzraSfTDvzlgT9Snx3dm60pMPPzM9aJ22WnK
         gN2Aznxw6GKsuyboNhdNoXI0erLyhytFCRtUIMxs5A7Q/Kb6M0/JdbBwRympWQOtFCpI
         WNSA==
X-Gm-Message-State: AA6/9RnHGObCYe7IR2BULtF08pOPZC+2qTZXzhqhmisU3LNCpgdGSYDvUHRQH6cYKfvJijvS4YX7JywC7Tlgwg==
X-Received: by 10.129.102.85 with SMTP id a82mr1311445ywc.160.1475560295983;
 Mon, 03 Oct 2016 22:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:51:15 -0700 (PDT)
In-Reply-To: <20161003203401.d4awnljukgqbku2n@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203401.d4awnljukgqbku2n@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:51:15 -0700
Message-ID: <CA+P7+xqnSt5qe4OLi2kDO9+y_keyFtVK2=qx4Q5skusBWXD31Q@mail.gmail.com>
Subject: Re: [PATCH 03/18] t5613: use test_must_fail
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> Besides being our normal style, this correctly checks for an
> error exit() versus signal death.
>

Another very simple but obvious improvement.

Regards,
Jake

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5613-info-alternate.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index 4548fb0..65074dd 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -46,10 +46,9 @@ git clone -l -s F G &&
>  git clone --bare -l -s G H'
>
>  test_expect_success 'invalidity of deepest repository' \
> -'cd H && {
> -       git fsck
> -       test $? -ne 0
> -}'
> +'cd H &&
> +test_must_fail git fsck
> +'
>
>  cd "$base_dir"
>
> @@ -75,7 +74,8 @@ cd "$base_dir"
>  test_expect_success 'that info/alternates is necessary' \
>  'cd C &&
>  rm -f .git/objects/info/alternates &&
> -! (git fsck)'
> +test_must_fail git fsck
> +'
>
>  cd "$base_dir"
>
> @@ -89,7 +89,7 @@ cd "$base_dir"
>  test_expect_success \
>      'that relative alternate is only possible for current dir' '
>      cd D &&
> -    ! (git fsck)
> +    test_must_fail git fsck
>  '
>
>  cd "$base_dir"
> --
> 2.10.0.618.g82cc264
>
