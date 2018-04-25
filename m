Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C281B1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755989AbeDYSHL (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:07:11 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:41790 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755846AbeDYSHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:07:05 -0400
Received: by mail-qk0-f170.google.com with SMTP id d125so7339053qkb.8
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=n7cT0ikqcx7mIyahgwrlhIW99uvvKsI2IE7EH388+fs=;
        b=JZilrit6yf90UQe81WqDfSnMPtyy3guDRimKf9pkNLmo2Zp9BVi+hHhMTv/IekDa6O
         9kIVfsNZkVWOUboqxyPlQjpvQEUhqBOuAz9tSj3o+cmDV3PZ/EYuGgCMEV0KZBVOJaLU
         WJiTnKbyyh5Bmg50deH12GG0IzojnX0abkv7WE2Vdunv+GCU20Zn6HyO/Jxq9BIN5jvi
         Hbu+2tw9VrkOFiGhzdCXgtBWxu4R/m+Z4MXU+HO0vDWkFEYCfgtX7N5Z2BFC/YaTe2j3
         w3kNqmfAeY1I8F84Vw/hBQDzGWEhNCHX89Vn77cCNjcxmus+Nuyyg3KuwGzfbKWqDen8
         8oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=n7cT0ikqcx7mIyahgwrlhIW99uvvKsI2IE7EH388+fs=;
        b=NkxjxGbEzNZMYRE83J/46UUAqSMfXLliUWu8WmRDIpY54/g2PZK5bHtOJNJrfaiW2Y
         l5cCL/mPBqYcdZNAaAPOxWxQtPOS+hmc/vdR29hCdrZ3ZGpqaqostgqqEXlken/P6JYN
         DL3M1VV/rFElVgZemM5hhAsjv+xNA0pqxLVbpr1AiSre8UYz02xytFK2hSbcf8Dlo+8Y
         fQhzgbcEdO1N6unEIHvLgo+ONksb3uNGMGbef3ev3daiAOUG7yS+KpJ8SzBB0vpXM8sS
         PqSdKcg90DRDposx4P6nGMfQwwDd91p1fb4o1f0y3EmKxqVLDI0WbDLbw1lwayB5e+sK
         eJiQ==
X-Gm-Message-State: ALQs6tAdmuyMqY1MVsQkaPkRaIC2GwjFCubOp9RnBp0EObc9YJmxVRzQ
        Q4enW3Lvo2tzmhZdCd7mXrE3mCHDHqBobAVO+hs=
X-Google-Smtp-Source: AB8JxZpHOPqsvg+O3YttJjMPxl8KDIfTFKqEUKIEZkr0j+TLT3KQ/+eSN9R6EiBsuBlTyhSPLKQ56adnFaaOZ+Tb1qA=
X-Received: by 10.55.79.9 with SMTP id d9mr31007471qkb.2.1524679624200; Wed,
 25 Apr 2018 11:07:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Wed, 25 Apr 2018 11:07:03 -0700 (PDT)
In-Reply-To: <20180425163107.10399-3-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180425163107.10399-1-pclouds@gmail.com>
 <20180425163107.10399-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Apr 2018 14:07:03 -0400
X-Google-Sender-Auth: q7NuMssovLVqkOFGQxteq22z-B0
Message-ID: <CAPig+cQ-ZfvHD6B-mK6tOBMdKiVzwz15M4rsOdBMBcgu0OmuxA@mail.gmail.com>
Subject: Re: [PATCH v4/wip 02/12] generate-cmds.sh: export all commands to command-list.h
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 12:30 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> The current generate-cmds.sh generates just enough to print "git help"
> output. That is, it only extracts help text for common commands.
>
> The script is now updated to extract help text for all commands and
> keep command classification a new file, command-list.h. This will be
> useful later:
> [...]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> @@ -12,14 +34,51 @@ get_synopsis () {
> +define_categories() {
> +       echo
> +       echo "/* Command categories */"
> +       bit=3D0
> +       category_list "$1" |
> +       while read cat
> +       do
> +               echo "#define CAT_$cat (1UL << $bit)"
> +               bit=3D$(($bit+1))
> +       done
> +       test "$bit" -gt 32 && die "Urgh.. too many categories?"

Should this be '-ge' rather than '-gt'?

> +}
