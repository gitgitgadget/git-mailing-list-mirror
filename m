Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EF11FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbcH2Pjo (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 11:39:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33911 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbcH2Pjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 11:39:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so10070434wma.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r+GfnE6DqMle3khGleJg8QOxNkNgpHXduhpyRa2GSwE=;
        b=D9TXnAwLYOhIm+9Msp3gTvyEj3m55ssOSEUvso7QKHspWkaFhmhcL608CIF/M4YX9o
         wCoPFloMqBRYNLFU65lvR1dmokYejsGRnka1sbLOGn1qJW0eXBKGAkZ8q3aUUt4KPpbF
         e4ssHAp95dapWnQxmfygXqc2Zr9O3dZORU1xmlhsWw4B5cmTuNW4KqLnF6ZtdzZ94csK
         iLPXLGYYfW71zyN6F/WK5TUimXttXAjq1VawXv1/jrMBvi6803ArZQ5aDKM4kSzdVmaG
         SsGP0KkTB568RyoL1SarXpcgGgq+s5xa0e9ymRJNHie0GioYXny8hFdM+MCc/T+8hi/z
         ELBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r+GfnE6DqMle3khGleJg8QOxNkNgpHXduhpyRa2GSwE=;
        b=dsh7hAd019A/dgwGfYOxpsjweuJDlj6jvdLzcTVk7soNuhU3/G/KelelLPMfrwCCyk
         UVQUCim/5XOq/XCpr4DSDQEK+KA7t43LbUQ+r14Su2/4TI6MSl2IdaVDbqJdg+58LwUt
         pRwztlLUqMLYaI8oXvfn4o+oWvqxyhi59sSbyoW0m7ZetXJC5NU2otecsJoO+apHP902
         fKc/GrUjh1Le6+zf6SAUWg7/yhwziudbCyNv73KL80/Ny7KJA2wTxQj2hNUtFWpRyGj3
         /R3Dc7JM3KmRD7rdbquSV/6v8Xfu4lBDQR0gJ+RMFBkKQ30QQSonw+ZGeusCV9he4fPd
         JJ6w==
X-Gm-Message-State: AE9vXwOj1wv7q9/7ngWD83XblJKwHiJUkG6hYjHmAiHZysRE68fRYEEXRZQS9VfI8akY4Q==
X-Received: by 10.194.172.165 with SMTP id bd5mr10976131wjc.33.1472485175370;
        Mon, 29 Aug 2016 08:39:35 -0700 (PDT)
Received: from [10.32.248.244] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id q23sm14104129wme.17.2016.08.29.08.39.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 08:39:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 00/13] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
Date:   Mon, 29 Aug 2016 17:39:31 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D7C1480E-8FF4-4EA5-BA77-7A4672853614@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Aug 2016, at 13:07, larsxschneider@gmail.com wrote:
> 
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The goal of this series is to avoid launching a new clean/smudge filter
> process for each file that is filtered.
> 
> A short summary about v1 to v5 can be found here:
> https://git.github.io/rev_news/2016/08/17/edition-18/
> 
> This series is also published on web:
> https://github.com/larsxschneider/git/pull/10

Hi Junio,

I am working on v7 of this patch series and I noticed that is does
not merge clean anymore (not even with git/git master). Should
I rebase my patch series? If yes, what would be the most
convenient base for you?

Thanks,
Lars

