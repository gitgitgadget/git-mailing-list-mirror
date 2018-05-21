Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEA21F42D
	for <e@80x24.org>; Mon, 21 May 2018 06:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750920AbeEUGqg (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 02:46:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34939 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUGqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 02:46:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id o78-v6so24728376wmg.0
        for <git@vger.kernel.org>; Sun, 20 May 2018 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xr/4zutRfN7q9PqIHx1VzocpRg25oRHMc1ETMQi4VcU=;
        b=A5lY4KUf7BeJ+nbDb6noa7ta2fgP50ZVkDqoUjGy5spN1Zdswx6nnm/Gh0oTyRVLge
         5qzBEcGq60MOAj0egUspTZ4yIop4tcPbjkxSjezbdsbjAMakq3lUoxqPyjQ0tb5+axXB
         4yqX4S/CCwMo39TAU/mPHQRvBMEknDV1pMGneHyNk1bIAKtbk1qED1d4Nyj/XUkf6f4o
         orT7n2b+m2+EqeZJT3Fe+q7LDxCYeGPIiS7d0XXnHbpQ1NjKbhzHalv9I4Al7DqGD+Lg
         msPB/OhQtBKfibSjYMgo/nQEq4B0UjCp6UKA6HeMQe49sDtNZBnt1u3v/IeoGA1PNBfd
         dR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xr/4zutRfN7q9PqIHx1VzocpRg25oRHMc1ETMQi4VcU=;
        b=B5K0KGzDPeb8H6wOPcEbJtmoTAIogQvXvaRmsuv38pH+1hR1M5TCWj6h+B1ROLAh8x
         +akB8cjGYaO9xXb/Zv9XzNptq2qMthzFOtXUDaGqkg0NdC9X+yRbZp/IRe7u9rkRRDdc
         RJewFyLKQJ61vFiCEqfG/pcAANRCoEGNmm/8uOGI8dYNzy6tUvUzsnrb6FShHtMHE8JD
         rzmghukF+vAJUEJ+d2p+BOrXNIUEMEq3XtCwWYj8AmgCRXmJbxRkOb4Jorxp/PnqPWSq
         IATRfc5JM1KImWh+gDQt2hVnKlDJ/KEeV5dt0p7tuxwuFAAd+wmx9bgi9kxalSyjQYhH
         OwCg==
X-Gm-Message-State: ALKqPwf+KNW4ZhQUQVZMLHZET6y9tLpOhS3ft3zfpUM5d3ga6UBz51I1
        bPUgvOLtP2A4gJ/ne9TbP5A=
X-Google-Smtp-Source: AB8JxZr1MMshQTl+MHRubV337b81LprqPL1cl0xfgyCCeECewpsxfbsNvFtOzqfpIa9qHz0Cg8vQ4Q==
X-Received: by 2002:a1c:7309:: with SMTP id d9-v6mr1185045wmb.60.1526885193836;
        Sun, 20 May 2018 23:46:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 67-v6sm18489705wmw.32.2018.05.20.23.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 23:46:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v2] travis-ci: run gcc-8 on linux-gcc jobs
References: <20180513091752.14003-1-pclouds@gmail.com>
        <20180519043234.9260-1-pclouds@gmail.com>
Date:   Mon, 21 May 2018 15:46:32 +0900
In-Reply-To: <20180519043234.9260-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 19 May 2018 06:32:34 +0200")
Message-ID: <xmqqmuwt1p6f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  v2 switches from gcc-7 to gcc-8. I initially ignored gcc 8 because it
>  was too new. But it built 'pu' ok and 8.1 was already out so the
>  first wave of bugs should have been gone by now.

I also liked the choice to ignore v8 for the same reason, but if it
is already mature (or maturing enough), let's use it.
