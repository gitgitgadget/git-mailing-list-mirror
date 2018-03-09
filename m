Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985841F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeCITLQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:11:16 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55908 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932587AbeCITLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:11:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id q83so5783842wme.5
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=F/jQUg+bfHqjQLUTK8nk62ptu0NXzr6zX8ULHyHcU5o=;
        b=dxwp2P68awh64twxcUD232XJiI1+jAeZfDjWbw9LoNvXeIFxNn84P63Uzg2kfDy1qD
         FJiTosGqv2FT+YveqvtXo8uQcS4/HK8mjVyPCpof8s1uwIAry847f7dgD+i3CUPopduM
         43N1rdqdkFw77eWBjhxnlybYu6IKQL+zFrFjQrNJ/e5UbG+fXTTEJV/zKpH/ewVXBDpZ
         sVxyn/DsbOXvvAHrYQRgMl6qhrvvLVDFiJLAQrq9+iZJ7JKN49tmbFuwpyTaaSsiPYGl
         fpLslDai35xdd+LXHdqdOZpChzqvALTNzf9Tf4B+4NCKxW8VOC2FjxSi/i8vYmwP88W8
         cblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=F/jQUg+bfHqjQLUTK8nk62ptu0NXzr6zX8ULHyHcU5o=;
        b=VS/xRqJUpWj0kd1i3GYw3xJGJP0oKkt11LAEey/TXH5L2rnSd42seb6ck6k+SPcwHn
         0fqPJM8yHu05uJFQKq0hTnJVUyx/GAc++wel0AYvyl6rMHeZYE7WMwplyGK1M/MqMB+2
         mVPrtWldYq74zs4VnVB8UeHgFCDzYF8qH/EZGWW04VLx8Y+W3sggSOabSvU5b7iCCmpZ
         ixTb5XgvfcIOU4WO79pByTPYxty4P9l2q9Hu7pkHPszggzWV5P34S8kpAG62ZEV6lgHE
         7IJKS1fSWTE/GdlOktHIh8hNBWbbalYwVJdpNj5f4c4XjuW5I2R+ei4IGb8b3sD0jmmr
         GrSA==
X-Gm-Message-State: AElRT7H8TtKjciqjYbbUpkn3l4BA0qiNR4pCT/G3MSbq/OfvtdmKVaAk
        7pgbsC79mrd6YZ00722F2Oo=
X-Google-Smtp-Source: AG47ELvDtfrtnljzQBuaaQL+lGTv8pIwtUqeHLet6n5SkilGlxJmN2ZzxjfYUzK7betb0Vs/XnMrdg==
X-Received: by 10.28.241.15 with SMTP id p15mr2781991wmh.42.1520622672418;
        Fri, 09 Mar 2018 11:11:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j137sm1672068wmd.17.2018.03.09.11.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:11:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 08/10] convert: advise canonical UTF encoding names
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
        <20180309173536.62012-9-lars.schneider@autodesk.com>
Date:   Fri, 09 Mar 2018 11:11:11 -0800
Message-ID: <xmqqefkt5ak0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The canonical name of an UTF encoding has the format UTF, dash, number,
> and an optionally byte order in upper case (e.g. UTF-8 or UTF-16BE).
> Some iconv versions support alternative names without a dash or with
> lower case characters.
>
> To avoid problems between different iconv version always suggest the
> canonical UTF names in advise messages.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

I think it is probably better to squash this to earlier step,
i.e. jumping straight to the endgame solution.

> diff --git a/convert.c b/convert.c
> index b80d666a6b..9a3ae7cce1 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -279,12 +279,20 @@ static int validate_encoding(const char *path, const char *enc,
>  				"BOM is prohibited in '%s' if encoded as %s");
>  			/*
>  			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
> +			 * We cut off the last two characters of the encoding name
> +			 # to generate the encoding name suitable for BOMs.
>  			 */

I somehow thought that I saw "s/#/*/" in somebody's response during
the previous round?

>  			const char *advise_msg = _(
>  				"The file '%s' contains a byte order "
> -				"mark (BOM). Please use %.6s as "
> +				"mark (BOM). Please use UTF-%s as "
>  				"working-tree-encoding.");
> -			advise(advise_msg, path, enc);
> +			const char *stripped = "";
> +			char *upper = xstrdup_toupper(enc);
> +			upper[strlen(upper)-2] = '\0';
> +			if (!skip_prefix(upper, "UTF-", &stripped))
> +				skip_prefix(stripped, "UTF", &stripped);
> +			advise(advise_msg, path, stripped);
> +			free(upper);

If this codepath is ever entered with "enc" that does not begin with
"UTF" (e.g. "Shift_JIS", which is impossible in the current code,
but I'll talk about future-proofing here), then neither of these
skip_prefix will trigger, and then you'd end up suggesting to use
"UTF-" that is nonsense.  Perhaps initialize stripped to NULL and
force advise to segv to catch such a programmer error?
