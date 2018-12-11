Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D4820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeLKBty (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:49:54 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35648 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeLKBty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:49:54 -0500
Received: by mail-wm1-f50.google.com with SMTP id c126so552147wmh.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TzeRcbirZVjlaNrdIMksZh1pljTC4o4eiv/QA3ck2gA=;
        b=ig+ZclPQu2u54eP0DSMBZPhpKPCti0RJLeeTi9N8x2KVv7KW5Fu7hqcko+v8gujZEU
         GpuiQAVCPNHS67CoAAsB1Fw6rpMLThh9fdAIP5t9pqEG3tYxehTX79X3YfCdBq/6Vx1m
         BMYe9ag2mOpUFZ+iGMXtyxqupvKLgz3nONWBGOPzUlPm9HTund7B5umnhaprU/DxoG5r
         Nk+bUgBSGMdFMjpagvLSsM7Kh7aC+2e35oLXLv1glpVdl03bGJsY1onzdmzAhcQaV86d
         Q/kf9C58aV/GQ9JRGZJ2+Vs51WSNDbEo83Qn6iVuJu3dKEl4t9COR4Po2DUfgyJ/cdub
         8qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TzeRcbirZVjlaNrdIMksZh1pljTC4o4eiv/QA3ck2gA=;
        b=hYYCdSwWRqyGE2m4yL0T6BdxMVHtOrClT1ufE8aQXn1NuzxyqvDIfZ3Wd7jl4IvoFi
         ww4zjsHkCqcoxRU8Mup2+AmoRDPIQQz/AxUNP91sVEyG8tqbS5OdTTBcT0iz5N2irlpE
         ga4K3O89Kh0c7OlXIMaQ8F7Act0z1m9ghsat00rb0j2YZnz+itSGYnQNO2nokzoKHpOT
         1xxj6FOj9X1FXZrPonY1cm3xpX/aAHBU60gnWDMzg0LZpExnofItwnouv/pqYVS/NmR4
         0lGVZxSUiJXbNzIPTOT8wo+zfPj76pj8lRcQ2m7d+Gi5tt618nW4moy6nQeNQqbxDGJu
         VQpQ==
X-Gm-Message-State: AA+aEWac8EY5doc+IYVDnfniEJL5v9sFcaBa0zCCoYHuazHULDxaCz2D
        LLItUnX3Ax4y0JvK1s3kYZgW32a5ioo=
X-Google-Smtp-Source: AFSGD/VVO+amq7QQujtFIDj8TzdbPPUnQd/VmqbFub2YShT+U52mN+1lP4GM4rb/AXpAOdFwWvNIhA==
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr520265wmf.56.1544492992400;
        Mon, 10 Dec 2018 17:49:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c9sm643888wmh.27.2018.12.10.17.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 17:49:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGVHnaZLg4fuptVmNa=jRHg0cMDTWjv1NdLQJXPe=+ahw@mail.gmail.com>
        <875zw1aw68.fsf@evledraar.gmail.com>
Date:   Tue, 11 Dec 2018 10:49:50 +0900
In-Reply-To: <875zw1aw68.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 10 Dec 2018 22:50:23 +0100")
Message-ID: <xmqqo99sn875.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Related; Junio: I've submitted a few things in the last 2-3 weeks which
> I knew weren't making it into 2.20, but I just wanted to kick out the
> door as I had them ready. Things which are not noted in this "What's
> Cooking".
>
> I'm fine with re-submitting those once 2.21 picks up, but don't want to
> needlessly spam if your plan is to circle around and pick up those
> things you were (rightly) ignoring during the RC period.

Please consider it a time to get things reviewed by each other and a
chance to polish them before they even hit 'pu'.
