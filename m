Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28C31F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbcHISob (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:44:31 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34526 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283AbcHISoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:44:30 -0400
Received: by mail-io0-f178.google.com with SMTP id q83so20104480iod.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:44:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HivtbjuUToIlZPRqJWiv6/RP4MwtvptYuk4cDkCbxEQ=;
        b=QR4L05Raey6FIPORomBQXEMOWs3MuQxh5GxfzhK8doN8bo6iOkEw52KNXyW4VEfqXS
         I/WfmsQcqj7Rg3bGaLVOGgD/QM4rc1y6lKVgoHGQUEMkKl9Pfa+hiGuEQGDZ7I+zr+tY
         CZU09tQ2FtuTsLqcVkVJ1HKaV8kpFDtsPwxy4OLViCWdTx7DedtXj8bxylSsY4TDgD/K
         Ui2SAfy1/rtIkhkaHWb5yj3kXFQg90FOYKhziqYpVwHelPXCfUs22dA+a9SQLDgwGLxd
         3u1Pa1epJs7ev7BeLNngfLHUR3O0+pgz24/1Gt8vBOs+t1E9QoLnp6ERu/9KCUpvSjD3
         +Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HivtbjuUToIlZPRqJWiv6/RP4MwtvptYuk4cDkCbxEQ=;
        b=aWxRNPQEOUjTj3PxOT/8tbfqjo29xLvRlo/157VSbN1nzvGG7RNZl7Lk/0Z+VgZdBE
         DDHne/Mx1zty6JYhnfQVp1wGX1I2LyfopCHjlVnDDSnSBq2qKT0+xSmyrLNDz8IWhiQK
         aoCRsZx3QgHqeq8v1wiDtVp4NeLOKU2oe57PZ/u7aLHSlBDeH+a1b/a33pbmHH4A90fF
         GzVXaQdR/f978Mf1cM3nplrKN+3QFfUXKvp6XjLrwZYorFi61l3JacA3TdYraMwLq5Xa
         bOPTGaeFDxaDu87MvOai7suHip854lfGw9nbSI9K9xblFMR+Ujhnluf177hxVlt57KHE
         0NAQ==
X-Gm-Message-State: AEkoousP+QwUKx0PEMoWDlRhL0uDLL3yuVJKoe1EZ8Thb9UpH14et0uakunMKg1/xPKHM1hWTAA3fI2MQPaRIA==
X-Received: by 10.107.2.78 with SMTP id 75mr638016ioc.128.1470768269932; Tue,
 09 Aug 2016 11:44:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Tue, 9 Aug 2016 11:43:59 -0700 (PDT)
In-Reply-To: <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com> <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 9 Aug 2016 20:43:59 +0200
Message-ID: <CACsJy8ARtg5KUceogNaeB+Fgh-u-TxfkAWdOk68_sEA-c0y6vg@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 1:37 PM, Jeff King <peff@peff.net> wrote:
>    That's (relatively) easy for me to script via mutt (grab
>    these patches, apply them).

Could you share your mutt set up pleaaase? I've been wanting this for
a long time, but never used mutt long enough to bother with a proper
setup like this (I blame gmail).
-- 
Duy
