Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071F61F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeIQUjY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 16:39:24 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53998 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbeIQUjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 16:39:23 -0400
Received: by mail-wm1-f41.google.com with SMTP id b19-v6so10078124wme.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=u8jmhptrqLn8U9HI9u4akFXRF0fmhQGMBIqduZp1xvQ=;
        b=bzWZvYobeJ5Coe2o/bKt1p6nIJUkLFMV4oic/zKtgLe9mL8Mr18J+Y71C0yb6/UA0f
         hYlhqx2mArVXgROKhmYwBKStZdh+z8tcL+rD/vr3scI3DMpzcUBfuW/kWgSW0vPcRHh7
         bsK6+2XEGJv0qVi78IIxKDs/oSeBw0V5/q1RaW8gIrqsGwDJxBkKtynJF1jUNZjYiddc
         P5s/WQPFviss+LEQ5OzmHJpBNfRpuOhYHoVm1d1db72ge3BnCiCnp9tjXPDU5jdkMamt
         mddX8TS/MSWyp7Ak45yHwS1wRFjn06uJd7OKb9Yz7Obz5pApdgVdoXadad1bPDz//LDH
         jYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=u8jmhptrqLn8U9HI9u4akFXRF0fmhQGMBIqduZp1xvQ=;
        b=kYfNUgJyhsgDbqQf2dfp4/6vEH6LUWhPwuatrClnSm50qaPgBkaizhMLO2n0bVj8oZ
         IsRHC1vbAXTaN+QdN8X67/bGE9c8pojDD5kyrNxI+ecTZCcGybQmhxTv4CaVNCK05K6N
         10gF21ETLemxkJ0/7tu3Ol+PPaCE3eqpaIbnF93MrH4fmxU1VsXr9ZN8wiHMvExWsA0C
         RDZlJbm7GyW8/jc2OPaMOWSeihWVu2nhKBGFtoD+/mAd2nOpQPZlwOH7w0Ws+owN8lAu
         7oT0ed6A4Uu1QMdMFOGnKMDpNqlHAYa3yoxhHYGmpPPtJGRyOQl6qw6zelMNQD47V/nN
         p2Sg==
X-Gm-Message-State: APzg51CxYwjysFhVl5GbTvCoxWm62+FXyuuIvGAypU3PHjjf2Z/uIzYp
        ZPWQVJ9h6H58sIuwoXpQnSmUOyPT
X-Google-Smtp-Source: ANB0VdZjm/rH+zzFR0w8jkgtuh/6QHMp2VN9I2Z+f3Ij1f+SKCBYbmJI5VHSkVC/L90Hc3n2h5Voiw==
X-Received: by 2002:a1c:7dc7:: with SMTP id y190-v6mr11192527wmc.62.1537197096287;
        Mon, 17 Sep 2018 08:11:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r66-v6sm21015734wmb.37.2018.09.17.08.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 08:11:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
        <20180915221743.a018386eb34f6ac792c6e694@ao2.it>
Date:   Mon, 17 Sep 2018 08:11:35 -0700
In-Reply-To: <20180915221743.a018386eb34f6ac792c6e694@ao2.it> (Antonio
        Ospite's message of "Sat, 15 Sep 2018 22:17:43 +0200")
Message-ID: <xmqqzhwg88go.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> I did send a v4 addressing this:
> https://public-inbox.org/git/20180824132951.8000-1-ao2@ao2.it/
>
> In case you missed it I might as well send a v5 with some minor
> cosmetic touches suggested by Ævar:
> https://public-inbox.org/git/87wosfesxl.fsf@evledraar.gmail.com/

Thanks, will take a look.
