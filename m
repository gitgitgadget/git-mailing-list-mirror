Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE051F404
	for <e@80x24.org>; Wed, 24 Jan 2018 00:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeAXAdZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 19:33:25 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36798 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeAXAdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 19:33:24 -0500
Received: by mail-oi0-f41.google.com with SMTP id w135so1709030oie.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 16:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/dam1QzzlhajedMuYy+PQeU8NlQrVG0AQuqqkWAcOsQ=;
        b=vVRj4QXxLFYru7WzYdmkYb/WfNQTQNSSqTLz2LCe4/N3mgdVITb2XBHEtr7dVGnsNC
         1S6GwXlDBCIYpZg735Hyh1Kx5pGl3tIEM85pzOOenjKx93HGGxIxA/QHOOb6C7w44ABu
         6FoDqgQGgbIHLnIf4zMnVpUCqsFybR/yGu69XtjekAB93ePQhbqZ1BHtOJoOgn1svxb6
         o6FOfE0F/Lr8kt3/Bt3SFQATLsjsMR0BUGrb+tNFFouD1F8wiey+yfp7/hraMA9SgCAb
         Cxx2dgA3sBCxP0nzaAi9mvWXdXarck7YKCIYD2uPfjBAKCfurxzIsHDDPybUE1TZV/Wa
         PZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/dam1QzzlhajedMuYy+PQeU8NlQrVG0AQuqqkWAcOsQ=;
        b=RlIl1QFTQZuay1ESQT/I5bnPviK8/Hx/oiJWdIJLw09Laez/7azUTjLkEnkx2DDyHP
         l4JiWZhv+bVCDvvwfYDkqJGbSYmx3afNxBTN35p1tZWPUMrBSUYcQA1yjo6RL6lRwxl/
         KJnKvAqdL/YO96tNfRECParyh+y+QFL1gaDEnnpmC0sM6v/AbXQ+ZZ/QezPTdY8nZbkf
         eOF8xqi3vLw2TUrCAwZQGeEe4jdDusgW3hzD2iGAxYmxII4rlh1laZaRDR2ciRJKbW0z
         gg+QXcGIutb3n+toIKFVDsL2/S4LxpHPj2I4BWPKs9+ZGytzocVr1ekSvkXmZBRH1WRo
         zAQA==
X-Gm-Message-State: AKwxytfb2Z4yYIkjpStbT1Mjo6JcK1q+EHCdu1xJPr6t9rXY1dRfRfmV
        IboHQPWXniQAp3b9ForcF/QluDKlO4hpd2CSoB8=
X-Google-Smtp-Source: AH8x226izqS8MLRIOpBF05cUSPl/xY8n1eWcbLJHWGouloCWa79MPvx0qfnka64bi7bFJewdSLX34XsEbcyoEKWLpks=
X-Received: by 10.202.60.134 with SMTP id j128mr8291900oia.268.1516754004387;
 Tue, 23 Jan 2018 16:33:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Tue, 23 Jan 2018 16:32:53 -0800 (PST)
In-Reply-To: <20180123164605.GH13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com> <20180122133220.18587-6-szeder.dev@gmail.com>
 <20180123164605.GH13068@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Jan 2018 07:32:53 +0700
Message-ID: <CACsJy8AuY4_2i28Z4P3Y7P+N8vb+NhJLGBa=Gzi=rMxToAPrww@mail.gmail.com>
Subject: Re: [PATCH 5/5] travis-ci: don't fail if user already exists on 32
 bit Linux build job
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 11:46 PM, Jeff King <peff@peff.net> wrote:
>> The build job on Travis CI always starts with a fresh Docker
>> container, so this change doesn't make a difference there.
>
> I wonder if that is fixable. Installing dependencies into the container
> takes quite a lot of time, and is just wasted effort.

I agree (because apt-get install phase took forever on my laptop).
I've seen people just include a Dockerfile that builds everything in
(except things like creating user matching host). First try to fetch
it from docker hub (or a local registry but I don't think it applies
to us). If not found, rebuild the image with Dockerfile and run a new
container with it. Every time somebody changes dockerfile, they are
supposed to step the image version up.

Of course this is still wasted effort unless somebody pushes images to
docker registry and the script has to rebuild the image every single
time [1]. Somebody could do that manually. I see docker hub has some
automated rebuild feature, perhaps that'll work for us.

[1] It still benefits users who run ci scripts manually because the
created image will stay in their local machine.
-- 
Duy
