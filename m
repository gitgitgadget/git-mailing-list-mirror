Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80ECC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C867761179
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbhHFUCB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 6 Aug 2021 16:02:01 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:33715 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhHFUCA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:02:00 -0400
Received: by mail-ej1-f49.google.com with SMTP id hs10so16990040ejc.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 13:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ae9NaJQ392I9uo+lBo0dDJQ7Gbt3t0sy4nWdgapqcps=;
        b=nNheUzjY6S1vopAU9UDswi8ud8Vqcf8xA5sQG8Mx6M1ELhe20KeFP9kAKybqcQGjZN
         t0i1Oqu2Tauu0NNxIeSlWH9mtAQX2zhuzWMSF7sGgOdaHDL0gT5naoNubCXizCmIZoG1
         YWFw6jSzQsZGy9c9z7sfIyx0F50B0dlWZ5CHZb1bAVRATLT2hIMYlM0+86FL1qFsUa7I
         Uq6HSlc+yHOSVQH/mMedA82cWhuiA4mBJKtNZLUF55SoqeOP6S4e7+Yhh8kiiMUnZE/e
         ljThwfcs/W0j1xmSfRrMdDP2+muS2zZl9cGb+AtSVlg9CMHtXudgosZ4g4YDf1P7WM5c
         DiCw==
X-Gm-Message-State: AOAM532e18WR8ky0n0jh3sBlS3sSR/DYHEQ8GszIsRYSP8Qi6222ub3y
        7EBAonyro9wLspRRJy0bLDscYCjt+lqQNs2sp/Q=
X-Google-Smtp-Source: ABdhPJy47ThKFbrugbR09IUTgcSWTvJbuGYWoOvAgacq0vdwLlAFdVamt3Bd9GoaHHCCUkZ6gg4XoqE0EPYZYuDhnJ0=
X-Received: by 2002:a17:906:eb4c:: with SMTP id mc12mr11154192ejb.311.1628280103042;
 Fri, 06 Aug 2021 13:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210805230321.532218-1-mathstuf@gmail.com> <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
 <RFC-patch-v3-3.4-02613d0f30-20210806T191231Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-v3-3.4-02613d0f30-20210806T191231Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Aug 2021 16:01:32 -0400
Message-ID: <CAPig+cR_GGjnP-h-tNnyd5nFXr1=S-BUWAYc4VgpUBHvxiZW=g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] advice: remove use of global advice_add_embedded_repo
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 6, 2021 at 3:13 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> The external use of this variable was added in 532139940c9 (add: warn
> when adding an embedded repository, 2017-06-14), for the use-case it's

s/, for/. For/

> more straightforward to track whether we've adviced in

s/adviced/advised/
...or better...
s/we've adviced/we've shown advice/

> check_embedded_repo() than setting the global variable.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
