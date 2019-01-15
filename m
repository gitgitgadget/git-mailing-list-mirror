Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA29E1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbfAOTZ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:25:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33601 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:25:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so3538821eds.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vujg0Se18OrPMOI2Kv1a+pVhv4C1HC1TU9KUiBfrVmc=;
        b=VNsVO/Alab/ptlgbM/kvs/rrrWAuD/2HgAO/HxCoqsDo9Sn/LKY52FgasK19tRVAs6
         TlGC2XmaR6LAdHDnCRi97VWTZhWxr6wLqSwDjijCwW4b09DpQrjYObXMZlBe9c2Nrjki
         68Kvda6ekCJ1nyqdIAJKSaPCcN2LW4/p3Jft8xf8l0NJw61ctkxUMtaCJW6325XI2g87
         swhgAGJmkfaRxdrHc6FBV3GJ5h4GRZ6rKq6mu8uYOBgD/11ZlAjechMd7XziMF9ggNnS
         Q5Jm8j1jbcMtq0HTM56hKbOsGSy8+94N4VlinKNqUvEFbbUzGS6KgsRAB647MY5yjS6p
         lXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vujg0Se18OrPMOI2Kv1a+pVhv4C1HC1TU9KUiBfrVmc=;
        b=q8UnU2PQnGjMAqHLfiF2U9uTPDXxNm7xp+VNi5NP/WAzoO3QuOsQ+vDfA4UuXc3/uW
         FUyDJh+3dxMFSPtH1Tn6+Lr1LxqfEcmumRBa1aqGT5R9OiizPayAZDnlEe+Z+4K+H34A
         651zOtckJtfJkW884zEeD6znI3IFE8CP+BV/zplCCUV15BoErJUp3G7nz44pOh5Tv9kr
         o2PmDODvPVzGIv5MbYzjvbbvkWq3BQzIvx3/wBQ3jiBWksHCJDZ3e1mh2hiqNIlW73fn
         P5MQdrUOIbLx0DLpAfBMekOzBHJg2tft3/Z2/rjvOiwLcfq5P3XBVLpI3gqmApUod+kd
         QWlQ==
X-Gm-Message-State: AJcUukcHcL4oSLwzLM+t70EyYfeENvgipGrY8+2DuHpGFWnE33iM/h00
        JCfX1twWFZpbcAX8tTWZldlI6Egjov67w5cJ2N9HgA==
X-Google-Smtp-Source: ALg8bN44ftrjW8Mk2/peWk52YwtKtUMp0TR5cFIDPjsOKBBfAUE0YxsCRYNF6af+oz4ehX7zK0bSbx4MbJ+Jc2hFFh0=
X-Received: by 2002:a17:906:681a:: with SMTP id k26-v6mr4156385ejr.62.1547580356460;
 Tue, 15 Jan 2019 11:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20190111221414.GA31335@sigill.intra.peff.net> <20190111221539.GB10188@sigill.intra.peff.net>
 <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com> <20190112102635.GA16633@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1901151502130.41@tvgsbejvaqbjf.bet> <20190115191714.GD4886@sigill.intra.peff.net>
In-Reply-To: <20190115191714.GD4886@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Jan 2019 11:25:45 -0800
Message-ID: <CAGZ79kYMiy=j8z2Y3XA03OD07jeUEXs3frNpjvyAFguVxeoBow@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Stefan was routinely running coverity, though I haven't seen results in
> a while. I think we should make sure that continues, as it did turn up
> some useful results (and a lot of cruft, too, but on the whole I have
> found it useful).

coverity had some outage (end of last year?-ish) and then changed the
way it dealt with automated uploads IIRC.
I have not looked into redoing the automation again since then.

Since 7th of Jan, they seem to have issues with hosting (for everyone
or just the open source projects?)
https://community.synopsys.com/s/article/Coverity-Scan-Update

For reference, the script that used to work is at
https://github.com/stefanbeller/git/commit/039be8078bb0379db271135e0c0d7315c34fe243
(which is on the `coverity` branch of that repo)
