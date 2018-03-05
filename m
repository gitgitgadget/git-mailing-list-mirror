Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1EE1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbeCEVd3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:33:29 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33782 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933065AbeCEVdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:33:16 -0500
Received: by mail-wm0-f42.google.com with SMTP id s206so15099047wme.0
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x4es0eKlrnAizDHh9ZmGCLdl7tdKu53c5egQ3IBOX7E=;
        b=qLCVPY36+sjXxMqs/nVy4DswyayeyyceepLsmDZMPsz76s4M4YLUavW+okeuS0N4Ci
         GBASwYzgcKu5lP14agui2i1fLwjk46wx02SNwMeOUwbc3AXQrWXSZlwh/zy1I+/QdGSr
         dKf9j6SkgdcjGeVCVjvBwDBXbFhstBpEAwbDGKo8ofEXqxKWrOWTL3hR6YAZFZ3p46oa
         T/9CpNtxlqgcK2fgWhmhajAXsrwv8qq+YXieUBmR92rMSIcfavGFLENQrBCE8g0XDShd
         jhWwBb08XdlH45aUHL4A8SJlDbid1rIkisvY2E4JPySGd41TDI13EdFu3qtDVEMxRnur
         u0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x4es0eKlrnAizDHh9ZmGCLdl7tdKu53c5egQ3IBOX7E=;
        b=nBFCCSD9CZ3DrOpX/2ahlxPoQCARKhqJn1EIofeLbmkZsGa3MANlgPd7yf8bAtzwX1
         gxHJVNH/zfd3VdY1pZJM7FoGXfUPWBWugd+RhT65NsS4WU3NTQldV5nVaQtXsECcuXP/
         kFWz7DjZ9deh9RtMPs30dTbpd2wPiHWNJyYTm15VjzBWlTPQF0VJU6nKOxbTp/yobUsQ
         VL0Rp+e+j+QAow9VXpb+50xptTX2iRfgHSZ4CO2HvIqxSAF1U7toMjv/1vduB5Qqt7no
         n5nTL/elWnz38W6gWSgkxBvaUvJ3rPU9zmprHdgD2wIrcmxNAeo4PUfl7+Ln90DwAM1U
         LuXg==
X-Gm-Message-State: APf1xPDmzx8joeiDwgBFNjHgKGX7sYLW6GJUb7EiPKGg9PvzcZr1Xf2O
        zugypP0J6zTIozsWAUFfwmQ=
X-Google-Smtp-Source: AG47ELtCqbHm2fKKa1STtIkSB2haemScCutJOsYgJOVE2HbMqk7C5goLMINdZeTypQrxQqErbqZwhA==
X-Received: by 10.80.153.76 with SMTP id l12mr20323398edb.148.1520285595661;
        Mon, 05 Mar 2018 13:33:15 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o9sm1863092edh.59.2018.03.05.13.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:33:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] add--interactive: detect bogus diffFilter output
References: <20180303055715.GH27689@sigill.intra.peff.net> <20180303055849.GB15952@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180303055849.GB15952@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 22:33:13 +0100
Message-ID: <878tb6nr6u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 03 2018, Jeff King jotted:

> +	if (@colored && @colored != @diff) {

nit: should just be:

    if (@colored != @diff) {

It's not possible for @arrays in scalar context to be undefined.
