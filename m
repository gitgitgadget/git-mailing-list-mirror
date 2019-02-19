Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64341F453
	for <e@80x24.org>; Tue, 19 Feb 2019 10:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBSKBl (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 05:01:41 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35545 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSKBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 05:01:41 -0500
Received: by mail-wr1-f44.google.com with SMTP id t18so21528257wrx.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ICiv9cDE9XPIBrGusDboh6en7gq86LnG4INCcBFtyJE=;
        b=YwPi5lxkO7C+JCQTKUlcYrosGiHTYSws+jPMHhhdsR2hWmzohGraAwFrNpgKNfCcja
         5WgxR4J0wntObJOUFkNEU4eSivm/YOAQu0IueHBrcAd1vO3q44zkGO8gfxJLaTMszu5c
         pJhX7APyVgXImZRmS5TSfnvDEYAjMtBD5vtR1LvAW8h4q81fMJKiTADYEh2G+sle6aSi
         1FsqTVH9Vbgln/AsQc7ueNHuKhf/kintO15lI0KG1jJslMd8m3tpKr41K97zgJtedyfr
         ZMGPSxEsxoVbf/7EIwyFSJ3ieFmIFrsSyXBP6lvLvNVLFMtW26VitbKx8f3Ok8lN4okz
         6oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ICiv9cDE9XPIBrGusDboh6en7gq86LnG4INCcBFtyJE=;
        b=seloxlUweFnlv241s1H3ze751mg1JRo4JX2yVZjG6nuR4pJBmiNTHYND8iUjFSZDhP
         mTcStxWKL27k30gD72w7+I43YQwklhtjrOyOKsRI8W7cY0JfaMsEPTtThrgcL0jiTney
         +NBj3pczGLs3+oTJp9cW4edzaUj3i6Zo/NIgKjQ8tqdcp/I/IyryfNWQvcmBmKD6l/AO
         60+Zp37ZGMWhjkh6FDGDoIosoMKHPc8YuKj1vVrvnrcEWJdHM4Ie9Ts5vmO5j5GJjWf6
         d8rg7xgC/4i0YrHJoziuMiHwe6yHXcRCU/Rj5y5eanYjoN0q16X/3IMBRRvtru9YI7e3
         YQIw==
X-Gm-Message-State: AHQUAuZCtXRMB8iYg1K9EFCSsp30SaOVsv4kySIK8iu4xpvUJ6JnqEL1
        dYOc8k7+qXmLI//GXQZqznY=
X-Google-Smtp-Source: AHgI3Iab1vc4ufDwmmt+e7Cp1P03nn9ZBBtSnbVuLckb+D8riH11OgBzH7ghwFE8U3eY7FBM3bzs9g==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr19894308wrv.95.1550570499338;
        Tue, 19 Feb 2019 02:01:39 -0800 (PST)
Received: from szeder.dev (x4d0c1b1a.dyn.telefonica.de. [77.12.27.26])
        by smtp.gmail.com with ESMTPSA id e23sm2226753wme.15.2019.02.19.02.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:01:38 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:01:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Senol Yazici <sypsilon@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, Johannes.Schindelin@gmx.de, jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
Message-ID: <20190219100136.GO1622@szeder.dev>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
 <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
 <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 09:02:43AM +0100, Senol Yazici wrote:
> 1. Dictator
> Concern: "Bad" connotation.

"Benevolent dictator" is a well-established term in open source
projects, and it has an inherently good connotation.
 
> Further, "googling" dictator does not give Linus as a result in (at
> least my) search (bubble).

https://en.wikipedia.org/wiki/Benevolent_dictator_for_life

> Suggestion for substitution: Principal or principal integrator.

These are poor substitutions.

