Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1231F424
	for <e@80x24.org>; Sat, 20 Jan 2018 20:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756667AbeATUeU (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 15:34:20 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33472 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756615AbeATUeS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 15:34:18 -0500
Received: by mail-wm0-f41.google.com with SMTP id x4so12016336wmc.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=raIRCmCxyEhw+zD4TdKPpxNzJcti9PazI1wntMEaEXc=;
        b=p2GYhOp7y+/A8x9D11nfD+IAI+kE6jdVKG1OwEW/vmgYcPTfL1FDLl4889IR1/cNrQ
         /EwLMKW5mZZ4StNk1m3z+jUgshRCuOzzW350kZQKsMFzoo6EqzC63b/cUwKVZjZSvG/c
         hjx4uTCKAtHbspFi2dhEADxv0j/sIJPW6/eC99SIRNZLjdjARzdhF8myvYjszKOT2nrY
         dOam52luGTeitbwUR9cV5iOUP67Hc/ot7FnHrxIzbzmc4hjZ/1NjUiCqH6TooqQLeZ9P
         +wr4D8XVxKIFNT5h91KyuOXNJWgo2fvogby/rWlwFLdTBqAu9T9osrmjRDU0v4qT2XIY
         dNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=raIRCmCxyEhw+zD4TdKPpxNzJcti9PazI1wntMEaEXc=;
        b=hvr3jdNYVsJidbmr+coji4WJTpoaGMkoP4nxz2/hXAnK+xqihxMVLZ6EJ7RQbeleUZ
         qMp0hrePihgJukjFYVfGOGmIA8LV2sq1CMDCshMEFu93WBrDWuMZu+9D6RChU1FvttAD
         dUyBzR5Q6vttHmyBIz8T2hkMRGDtMa6m86nxWqUeLE+KifyaAUTCPL4p3fibDynrn0p3
         2R/QtbBMqvEhsDDHVE/Pfqaq8fSPbWjOp+I1dtX36njsC4/QhPtXmUvmYa0//a8vuqaX
         YOV9wqDtx9TbS1IklCapPoMcuCUQV5AmmHGCklq7XDTXSa7Q4AdLurFukeQDSkxP0U83
         tKGg==
X-Gm-Message-State: AKwxytfdlSTdecxnQ2S4y7RWmPYxmmb7HT383KXMGefP5wyRcDheOb01
        J8xkhU/RQcxMT/SiWB5RTMs=
X-Google-Smtp-Source: AH8x226k1FBi4vGIFuUkXGfml5OmPOo9jDVUXxTPNwWDTWp/f7HujU3EJegFR0M87ByNTJHIG6qpxQ==
X-Received: by 10.80.186.55 with SMTP id g52mr5253108edc.25.1516480457653;
        Sat, 20 Jan 2018 12:34:17 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p6sm7620803edh.68.2018.01.20.12.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Jan 2018 12:34:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'Ren=C3=A9?= Scharfe' <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Add tar extract install options override in installation processing.
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-4-randall.s.becker@rogers.com> <1153e1c0-c7d5-3e0d-ce41-ffb1230164f7@web.de> <019601d391f4$dd367de0$97a379a0$@nexbridge.com> <9b7bf754-90bd-c25c-f5ae-124dcd97d281@web.de> <019901d39204$4ed19980$ec74cc80$@nexbridge.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <019901d39204$4ed19980$ec74cc80$@nexbridge.com>
Date:   Sat, 20 Jan 2018 21:34:14 +0100
Message-ID: <877esci81l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 20 2018, Randall S. Becker jotted:

> I will reissue this particular patch shortly.

It makes sense to base that submission on the next branch instead of
master. I have a patch queued up there which adds two new tar
invocations.

Also re your commit message see the formatting guide in
Documentation/SubmittingPatches, in particular: instead of:

 - Add a brief subject line

 - Just make the body be a normal paragraph instead of a bullet-point
   list with one item.
