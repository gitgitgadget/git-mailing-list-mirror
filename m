Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E721F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfAHSwW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:52:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34733 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHSwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:52:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so5171251wrw.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WWoULSs/Lz4plSj0PRLKwVhtec7niA5LUeFfdx0ccks=;
        b=uquEvS7zA9divUdkR12a1Q3/kvNw489GddC60MQp9RFMGEx4BK4cGX/zw2d4bets24
         GJxwNeU2CmfcQ3s2mqKB7K1dDMV7ONrtFFDnLWzi4S7PBdMfIa7JNN383VeWNcb3jFCM
         FhGselm3tDQsYMk75IcP7K0sChnXe/jEdU6JvF3tARdtKvmeRgsCJT0qmL0PSdGU6lLI
         OcSXnYuq/vXCOiZHIoukBiX+oY8mLNHAEQ7ovN5AhZ443m/5jbD1n85xwZ5MLZC3u9wR
         ZxJqklG48KB+zN1JmOQDwM0I74JlZjqwIh9hXwUqbNlr8xp4TiSIFWXW7f+RavJckMtH
         /yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WWoULSs/Lz4plSj0PRLKwVhtec7niA5LUeFfdx0ccks=;
        b=cTaKNRT2IDuKbB7CEFdK3jtpcbg6Qv1rSGCTmAYYWwidQNaC89x/Wmyr6t2Hj363Uf
         fW4W9R8fzSytvF3j65IM2d/UEWl8rfyoZXNe7NUwt6BgsDufdOXbnKA23EpQ155H70lx
         dosjf+Lsbl9cnzFDua2d5Znvm4fNEQjmNacrIdoiu6yBhSq4Ja4xymsf3OWsX/TXQYyC
         pvfoh7i+PQIQxet4C0Wa9VerovQxkBJse9W26d1F/bdxj1DIckslGJ+WOIWNuZ/54dbX
         wGsg7zqA1SIVIim35SkJTDvrZdYrDPmtTIBQChbFRurQMrXjmq2oVaickKweyHW9ft4G
         dgHw==
X-Gm-Message-State: AJcUukdMIBdSM65T86nuZxaV+QM7fZVbo3xgK+WwNt8PBFUpRunRZ9Pz
        lgrZiTZxQ+0hDrMZV+W4Qek=
X-Google-Smtp-Source: ALg8bN7as/4DSHksvqkEhMgC79HyZhJanb7nTGIuKLn1+3g3tX+HRM/UT3rkjKEd+uenHG3GyZkd2w==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr2259925wrp.242.1546973540330;
        Tue, 08 Jan 2019 10:52:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm11700751wmb.39.2019.01.08.10.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:52:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
        <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
        <20190107083150.GC21362@sigill.intra.peff.net>
        <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
        <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
        <20190108180522.GA4610@sigill.intra.peff.net>
        <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 08 Jan 2019 10:52:19 -0800
In-Reply-To: <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 Jan 2019 10:07:29 -0800")
Message-ID: <xmqq8szv56e4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Yeah, they should. I think one of them will need René's patch, which
>> changes the body of quick_has_loose(). I can roll it as a separate topic
>> if that's easier (or just wait a week or so until René's cleanups
>> graduate).
>
> Nah, what I got is already good to work with.  Both series are
> straight-forward and I do not expect them needing long fermentation.

Yikes, the conflicts with sb/more-repo-in-api is quite irritating.
I think I'll postpone the later parts of this series and ask this to
be sent after sb/more-repo-in-api matures a bit mroe.

