Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12381F42D
	for <e@80x24.org>; Wed, 23 May 2018 16:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbeEWQDP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 12:03:15 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:46361 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752655AbeEWQDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 12:03:14 -0400
Received: by mail-ot0-f173.google.com with SMTP id t1-v6so25770496ott.13
        for <git@vger.kernel.org>; Wed, 23 May 2018 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ruIRJpKkHx86sKqhczprE7hI1nn8U1x7LKPUhQXFcg=;
        b=ORSNmIpHyOc4y/aSzAq/ZQpeBPukBXxjrI21YpzcbI0Iz9fooRAF2zFt3sI6y3Zijd
         VaRTOuXpt/ELGkg27foTyE7nv23Sxe6nLC88wtVKqG9UVBYjJBZnW6SDVERJ/oUEJ6pr
         6EbHGddFEgb/IQSA9yT+6giDXp+QLZE9gaYqxnJJpydVYct2277JESySIZym2lmtTLwt
         z0WnQyZH1RbA/ZC9+lM9HhslrAkI5cIreGntSCkzuMI/IjiVxdpxy3BcyarKPQ6QKe2p
         IGigApxuVLznczUuFz28kTja2Nc92vqCKdZmYfgk1p0bOZWq6fyKrLrzLRKsCOGPPdmn
         /bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ruIRJpKkHx86sKqhczprE7hI1nn8U1x7LKPUhQXFcg=;
        b=jCIPgEdSxFg30Fp9tpKEkdKVsHubM8Oih5taOfrzpcaNR0xVurMM9KE0JEHBfayc/D
         aiqvj+N2f07IZoUMiCsciq3E57yaDcB2mumPtWBqhnL+w7hse20CSDiYYDSGwCGM3bT4
         a5KeQvw0ZALJZe0TBga5l3y8keho2e7y8ZDdiyc7qlVDnl3iSMKDz/+wKvNhWFYbdNZx
         JkfCn0LInGiv6lB6PtXEnBLLnqEWHAg26C/iBhV7zRWhzQcuUmQuK39zMRs5zYETZu5k
         yR4ImVaMXMwneEBGVajPnlBv27cDzgfj1FkTxunrlSD4JuajNCqh2pYEwSzcHcYJmn2p
         1HBQ==
X-Gm-Message-State: ALKqPwdQUNNQUmHHysnZ196L3GI4cqD7LP0lzbK6T6yxaagUR/LveytV
        3Hjiw51iz+HipLsA4vk3oHdRKkDv43DVeoLPBaU=
X-Google-Smtp-Source: AB8JxZpckRyAmz1azvlJnBTvK1tXIlQDcBZazI7xHgEm6efM0pPWhhYP5KHvqwr3usU/03dePLmjUYr9EYfrgO63AvU=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr2278284otb.152.1527091394221;
 Wed, 23 May 2018 09:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Wed, 23 May 2018 09:02:43
 -0700 (PDT)
In-Reply-To: <20180522194854.GA29564@inner.h.apk.li>
References: <20180522194854.GA29564@inner.h.apk.li>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 23 May 2018 18:02:43 +0200
Message-ID: <CACsJy8ChpbNM8sLzdptmzVp5XXF-rmQqxP+9CX5uJRa4e1kJvA@mail.gmail.com>
Subject: Re: bug: --shallow-since misbehaves on old branch heads
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I probably can't look into this until the weekend. Just wanted to let
you know that I've seen this mail and, being the one who introduced
--shallow-since, I will look into it soon (unless someone beats me to
it of course).
-- 
Duy
