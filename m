Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5803B1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 08:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbeFKIJI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 04:09:08 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45999 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932512AbeFKIJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 04:09:06 -0400
Received: by mail-yb0-f194.google.com with SMTP id x6-v6so6390779ybl.12
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WUFYSNfNri+CyG1mdQVJ013lMfr5iL5nNUqWPQooQIc=;
        b=QXiBIS3udXoV0MNy+KbVbNw60ig7A/2l91YObjd7LRjrumKjB7x8ZFR21WzZn06fH6
         F+Jg5lUFfvsXHh+0Xjy/nBg/Lbb3X9Te1BwZ0NQSQXcHo/2oVyhjifcUnzswCpGlUAiz
         2xCVezSzJ2M9VrROoWyF3ysJfcDZInSvdxHOD1KSukA44ZVb0q5pY7un0owcdJZT11u/
         27ephohTZEthTn8g7umPImH0kzqKORsrXtA0GHArowrYFt2ljQVGLNsHs2VrJXKky1Ak
         KyFEW06V7HcvOXA1z4SMeVQKqsqLWriOMCtV2gCLWvY3IwJaRTBvNXDUiDZn4nqxDQKf
         TwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WUFYSNfNri+CyG1mdQVJ013lMfr5iL5nNUqWPQooQIc=;
        b=mfXTrK22AOkb/7IuHZ1zxfQ3mfO955lyqdb4pSyR+arexCJifCA0NdETiWihPWL+XH
         k38ZypWQt1j7MdduGpW4a6BaTdgB0IjgRfq75ur3aj7CPEFs/ZYf9p7ir/+5GBLccNbJ
         2dh80qVtzRKj2dm6uaM0X4Fi0nFXjt6TJ9ZLlYAUpQCztNk+l3TolFZWs91d351mfXAR
         hw0w/7nPy9oQngKuN5Gp/kuDeOKbAuPZN+17pGtzwJhZ+C2MpjN1/Pjwt/K+AqxnYKgy
         HEWJzxRVUQ6odgcBe1fxL1wWILoe+IxjlGS+htSycTuRFYFagw2dBkQMkXkHd5ycpUiu
         jqAA==
X-Gm-Message-State: APt69E1Fr67neyvjOIQWNrxsI7RFie/cZYO88PPlk5X2NYiVIOOvWMo9
        hm5v9JSkS/nrxuVu4+IpDfIC/Q38fa8IrwETO5c=
X-Google-Smtp-Source: ADUXVKIdQQM0sDYPgfTKtmopdw0cv4GHH4EtUBrQinQQUdI1rEKMUPK0Ni5vLHm3IAU2bOn/L3t0zv/I+EQTUxjF0Jw=
X-Received: by 2002:a25:a268:: with SMTP id b95-v6mr3541924ybi.295.1528704545832;
 Mon, 11 Jun 2018 01:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:09:05
 -0700 (PDT)
In-Reply-To: <20180604235229.279814-6-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net> <20180604235229.279814-6-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Jun 2018 04:09:05 -0400
X-Google-Sender-Auth: TLA7-h41yzA6YQNZADQLTkizCMg
Message-ID: <CAPig+cTm4BYZjsFSV8AZ-jMjVPtze5H_7XUG1wBhmuFghJbc=g@mail.gmail.com>
Subject: Re: [PATCH 05/10] t0064: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 7:52 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Compute test values of the appropriate size instead of hard-coding
> 40-character values.  Rename the echo20 function to echoid, since the
> values may be of varying sizes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
> @@ -3,30 +3,30 @@
> -echo20 () {
> +echoid () {
>         prefix="${1:+$1 }"
>         shift
>         while test $# -gt 0
>         do
> -               echo "$prefix$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"
> +               echo "$prefix$ZERO_OID" | sed -e "s/00/$1/g"
>                 shift
>         done
>  }
>
>
>  test_expect_success 'lookup with almost duplicate values' '
> +       # n-1 5s
> +       root=$(test_translate 555555555555555555555555555555555555555 \
> +               555555555555555555555555555555555555555555555555555555555555555) &&

This is rather unwieldy and ugly. How about simply re-using echoid()
to compute the value, like this:

    root=$(echoid "" 55) &&
    root=${root%5} &&

That is, use echoid() to generate the all-5's OID of correct length
and then chop the last '5' off the end.

>         {
> -               echo "append 5555555555555555555555555555555555555555" &&
> -               echo "append 555555555555555555555555555555555555555f" &&
> -               echo20 lookup 55
> +               id1="${root}5" &&
> +               id2="${root}f" &&
> +               echo "append $id1" &&
> +               echo "append $id2" &&
> +               echoid lookup 55
