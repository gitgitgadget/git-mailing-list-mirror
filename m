Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93CD1FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 17:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdILRdk (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:33:40 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:43194 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdILRdj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:33:39 -0400
Received: by mail-wm0-f49.google.com with SMTP id a137so1454038wma.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jkfyUHyyfrhhfaxUFQo+NdDpMG5i1VvsP4X0uH9SaYw=;
        b=Zlo3xjEAiXJhdBXcenCpr9u95lvsJblxnxNru8U/5xTDIpUeekCQ6ZjNKVRmcakafX
         FkR7XxKBO5DxrB+lF9D0MnpMDtCTmOgvFda4W++Rbo3cR1D9pW3yvYBBAAkhw74sjcQ5
         +oq60NGAKwAV/R6pQ0FZLdOgZyIrc0RDATNsqmHUzAp3Tyt/JLGIc1sXRTAbZWsOs+7a
         N9kUTi8jKcILC7Ax5zfJdlr9mRpQGd+NpiBVyN59WY5hvtt6GZsE0XC4v//EuBnE/Kmn
         jAbtTLd61JAwNqa252HFy3lPd1jLL3U1XvsJUZrEeGYjbxhQ7UFlEpoz1GZocGcaic5/
         0a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jkfyUHyyfrhhfaxUFQo+NdDpMG5i1VvsP4X0uH9SaYw=;
        b=JXLF9AuJ9nUWUij3Ze4Pgmbf0cNLFNrxGxlcjStTcVwGVPJq7dEAE7dKTacQj8gQzd
         E7KKjGI2AuV6PRIB/Ft/LRE+RvbPqio0yIovUES7hPoqo71A1jL5xLzsEd6k3aeaZVJY
         ++kUTgLUxpCbP9u9Kgw9LsydUT4lUc8/kMQqoKhcFNCgd61R2zGTikQrj6oThWV7watu
         T/SSykAaXci2kVDAPSLqdjgYxGbQqn2hxA2AJX0daj1eWVos5kYMxr7OH/3JiRwFUAYA
         z/nAeADmMHfjtXl9M5PfYkRtk1dlg5MzkgvESKYawTG5DuqQUw/sbmu1Vn4ognOstTZp
         0yuw==
X-Gm-Message-State: AHPjjUiFEMx64+mTKoLn8/BlogdOuFr12146seaFv0OOXGhWZvzj356A
        7ZRpAR2+cR9tIxey95QI/PAqrabRskx94+vZWjbTX25O
X-Google-Smtp-Source: AOwi7QBGg+xDh0AzuTR/FvfmApVd3s5aCjz958IGEpzBIYgwAN8H2DHOZl8J51mkkAnYXOq7pR42lTJRrdj9JLBLiYg=
X-Received: by 10.28.73.133 with SMTP id w127mr229397wma.55.1505237618514;
 Tue, 12 Sep 2017 10:33:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Tue, 12 Sep 2017 10:33:37 -0700 (PDT)
In-Reply-To: <20170911042737.4h5b2jygdeu7cpmf@tungsten.ozlabs.ibm.com>
References: <334a7be4f61c02db24008181eb1d6c80c95772f7.1503894009.git.sam.bobroff@au1.ibm.com>
 <xmqqingw8ppj.fsf@gitster.mtv.corp.google.com> <20170911042737.4h5b2jygdeu7cpmf@tungsten.ozlabs.ibm.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 12 Sep 2017 10:33:37 -0700
Message-ID: <CAGZ79kbcufMxbBdH=a9YzPWWet5nEdmUN6P+xmMEcGna-VL9=Q@mail.gmail.com>
Subject: Re: [PATCH] format-patch: use raw format for notes
To:     Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 9:27 PM, Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:

> (If only there were a way to set the coverletter text automatically as
> well...)
>

Checkout branch.<name>.description
