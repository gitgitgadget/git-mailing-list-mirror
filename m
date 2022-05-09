Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8AAC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 12:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiEIMu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiEIMuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 08:50:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A72983B6
        for <git@vger.kernel.org>; Mon,  9 May 2022 05:46:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g6so26598974ejw.1
        for <git@vger.kernel.org>; Mon, 09 May 2022 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7f1WMka3gW8T+SmmivIYkSoexI5hR+A4LFL90j7NfQ=;
        b=QginCqe/y6nZZE1dEDSi0RKSSjxhM+L+Cxp46JhN5IKYn8sl5yyXqcyln+QlrOJBP0
         dJgiVYuoQ+MFzjFPcOnSnTiRya6s3BoxXwkh1SK37Rg76adl0iYZ6b1/CdxvhOtT3oEr
         WL2AeChKMm8Cgvf9mjTOJQO3ZohhlfjldKOtWtvO5PFOOi5y2GWC7kYSLdvoKPdOzYek
         HQKgQLIWF0u6AHzkA1+6M0Dk4gsxzJ10Rd6LykH7agwbZzcocUUtDQLulLYBVy5uL7gn
         iyiQwVBjI/OBShzor604sN4uAbemeZ+fMurgE1goVKOJ4DJ+Rhrg/8HrpahFSSUh6ajB
         0vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7f1WMka3gW8T+SmmivIYkSoexI5hR+A4LFL90j7NfQ=;
        b=UGeUmVyzxx+MaXG2K4uZiTQgxFvSoy5QuuuZW/828u8oV0jMRFmb6qTZFiAITvMFTN
         s/2qd7PvfKX8fAfj+S13DL20yleNxO6iLjsphqXewK38oBD1TRxNjeMSPkTsP6n2Ewgh
         7nsQvrYzGWnEmD6tukv02EegPWSCRRzbUOK0NQxlc3JEqRB+U7101b/JXbJORoC2zq0E
         7Lp0ysqY9Jgqipsr/e1u1YeQuFvANVnSZ/kTZfHKU5Vfc/2HfA3jySpVI6l9I8LMpzcz
         j3pzSyZSp++7x4TR1FAN68K8eBkasSFE2/iMYCgruTtycVg7P0x/5oRADKoDBClNIyfM
         Ttxw==
X-Gm-Message-State: AOAM530f3oR2VmTuRkaBBCWdlMTydLtF54Jo/Svq57IvP8ZyfZLg/pQx
        rdtH8Uv00TvGoIK154gRE6M2c1PZk14jKyWuFKs=
X-Google-Smtp-Source: ABdhPJyRmEuBM5vTECAcbnIch+XKipw5Dmvn2dJvFms5jCHZPudct9twUR0YXTOejyFJzxy9fYnCwOCmw+WeA4ATdKg=
X-Received: by 2002:a17:907:8686:b0:6f4:b92c:8ef7 with SMTP id
 qa6-20020a170907868600b006f4b92c8ef7mr14322136ejc.651.1652100416646; Mon, 09
 May 2022 05:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
 <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <xmqqzgjuocjk.fsf@gitster.g>
In-Reply-To: <xmqqzgjuocjk.fsf@gitster.g>
From:   Halil SEN <halilsen@gmail.com>
Date:   Mon, 9 May 2022 14:46:45 +0200
Message-ID: <CAOeUTuufDgsyp7FgJj4T+h=JOMaWYVBkMx8S6fNRQ3cdVo6tOw@mail.gmail.com>
Subject: Re: Resizing panels in the gitk window
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?Q?Christian_Gr=C3=BCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, <gitster@pobox.com> wrote:
> I didn't look at it back then primarily because
> the patches were made against a wrong history

I remember looking for Paul's repository but I
failed to find it so created the patch against
the main git repo. Maybe I should have
mentioned this in my message since I knew
the documentation included that note.

I am happy to rebase my patch if someone
could point me in the right direction.
