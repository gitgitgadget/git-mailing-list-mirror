Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D8C1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbcHZUJc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:09:32 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36933 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcHZUJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:09:31 -0400
Received: by mail-wm0-f50.google.com with SMTP id i5so7374175wmg.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=57923m/5Xu8R3E4uCeQmkeTDDnj1/z2t977NSde/8Hs=;
        b=WcXcOV3eCk9VRhEaM2XWM1wOWhsp1aigvPolZf9+lmKkv/pWOoV00av077IWtWluLx
         17VsqizFh9Utbd3COA8+6L9qrT6S7jcM0JLO+EEG+IbLi3H6vDI5n5mmYhCk+AXiUqK3
         66Y0kT471n/57XdVO53Mw32CcLKh+KfDtFIQeBfmQIC7oNCwrzGcZ8JB96lUKQRgXRlk
         /SWvkbuBFgvj98u29pmi5Sr5r0bWuU8n02Bsp2kgsTOaWcLj8+FItvWbhKPkLzJeKzuO
         LXcHXcXAh0zJujrVSGHIhIh5ySuzEVXcxjly3D4QY0QVd6pZXCquchIgigLN39JBBTcv
         Zufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=57923m/5Xu8R3E4uCeQmkeTDDnj1/z2t977NSde/8Hs=;
        b=H9SI4J8pqtCa9jyfG4q3T01vZrrpdVdTifU8aWOK21nb+anZ6ar5plzKspbdp3hR5S
         OPNuazC2v5vuB0QUpGnDjX2HI+S+sV09KJScA5SlqolutxfndDaJRHBfVj1BWXjbUV5z
         H9MIdILUTfCE5pyB/bW/m0hKOaT5TlwNPhT60hGZcDUgY+U12hkpWY7ybqNw/gXn0dkF
         CV/gkHjdGC8ZkjvyNKz30tdS1b4acpBxtRVFIpcdXW/aS3bqgiSwml4GiF3Fiyv21VGx
         ispBFdateT1+sG9++mgOFxNifCiyXIgtRNAwGSg1lSDzCQ8EsQQ7h6pSsVubDnYFDpAL
         Tm5g==
X-Gm-Message-State: AE9vXwPHiwKOj1Hu4UIwxNqWuRHaQBnpqFkDXG/c8oWPptodTxbIFvihTUbhT38v0qFJljcUKr3Y5PaF+nnuDg==
X-Received: by 10.28.107.144 with SMTP id a16mr446087wmi.75.1472241826633;
 Fri, 26 Aug 2016 13:03:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Fri, 26 Aug 2016 13:03:46 -0700 (PDT)
In-Reply-To: <xmqqwpj3fhaz.fsf@gitster.mtv.corp.google.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com> <20160826175836.14073-1-ralf.thielow@gmail.com>
 <20160826175836.14073-3-ralf.thielow@gmail.com> <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
 <xmqqwpj3fhaz.fsf@gitster.mtv.corp.google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 26 Aug 2016 22:03:46 +0200
Message-ID: <CAN0XMOJC2uqodOUDocf7o2Fi=aCvmaf_cWGYrbp1FbkjEji3cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] help: introduce option --exclude-guides
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-26 21:42 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>
> Taking all of these together, I'll queue this as a proposed fix-up
> directly on top of yours.
>

Thanks!
