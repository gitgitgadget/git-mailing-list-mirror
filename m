Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D8C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 20:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBEUaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 15:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUaO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 15:30:14 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E771554A
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 12:30:10 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id n2so4330031pgb.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 12:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uecagHS8p1q6svI4Brz6HJ2eJX+C+gJevlYCA90MVBQ=;
        b=I9dsJjdA74xKSFVIa2DfLPAN2cCpq5BDNGmLX1Sw/ol0GVZZ6GMJNePZwpPOU71E/7
         UKNOlQywzCDB8w+DBq3A6UzKsZbj5HynLStA3uArSm4L6KfaTpeif0aQ0NFOosT2f4SC
         V+Ca71w9DH5cR2aKw7ITQE18FKme9SWK8ZOmH4PjeMHt5YYgZkC5mTWjZtTpN2jTSmbP
         hvk0smV18YPxhT//yA6Gt/Rh7ucn5KHpNocTHHQ//LjgHuyTZJ461y0iiyEWJFP803qW
         D3QB2KEySxwPDRZMy8/8Yc9V+50z55eLS+zD2J27OcEX3D7nXJBQkjTlyYXM+TojNfzw
         MgEw==
X-Gm-Message-State: AO0yUKVr3UY8ABv+/eWIcNvL6B68FW9XXhR+5zHXyQtImOKJ398gWVzn
        zCUhF1HzMLwjwJwOmEIRFVzBjUvMfkKmMCOdoTE=
X-Google-Smtp-Source: AK7set9m2GvDOhjX7Dx1DF7uqziuLqLBE2TtMS8IQzNQSrvQ8PGw6jx7GglIcOV88NSdbVJOfKI3kZ9YNmSW9QDS9Fw=
X-Received: by 2002:a05:6a00:4208:b0:58e:2111:9c42 with SMTP id
 cd8-20020a056a00420800b0058e21119c42mr3863812pfb.22.1675629010333; Sun, 05
 Feb 2023 12:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20230202171821.10508-1-cheskaqiqi@gmail.com> <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230205145245.11078-4-cheskaqiqi@gmail.com>
In-Reply-To: <20230205145245.11078-4-cheskaqiqi@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Feb 2023 15:29:58 -0500
Message-ID: <CAPig+cTH_5Bu48fO1Eub25CLZmRCmz4EjYz9O++H12HGTVXU0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] t4113: indent with space
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2023 at 9:56 AM Shuqi Liang <cheskaqiqi@gmail.com> wrote:
> t4113: indent with space

This probably ought to say "indent with tab" since that's what this
patch is doing.

> As Documentation/CodingGuidelines says, the shell scripts
> are to use tabs for indentation, but this script
> uses 4-column indent with space. Fix it in use tabs for indentation.

s/in use/to use/

> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
> diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
> index e0a52a12c4..ab5ecaab7f 100755
> --- a/t/t4113-apply-ending.sh
> +++ b/t/t4113-apply-ending.sh
> @@ -22,11 +22,11 @@ test_expect_success setup '
>         echo 'a' >file
>         echo 'b' >>file
>         echo 'c' >>file
> -    git update-index --add file
> +       git update-index --add file
>  '

As a GSoC microproject, v3 is probably "good enough", so there may not
be a compelling reason to re-roll.

If you do find a reason to re-roll, though, I might suggest swapping
patches 2 and 3 since the current organization leaves a mix of tab and
space indentation in the tests, which makes reviewers do extra work
since they have to look ahead in the patch series to see if you fix
the inconsistent indentation in a later patch.
