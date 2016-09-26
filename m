Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA0E207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422691AbcIZQNk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:13:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36180 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422688AbcIZQNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:13:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so14865044wma.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dB4k9zJR7zUmxCcXiBETvbJM6wdA+XwvJn3UKTWckec=;
        b=s7BuEfXfjQ1rRTrHc66H/c9mQpKh54vsKEDUXC9eUDK9ni6sfzevnvJLPXgi/0ELED
         0CBOmMGDpx/qIffwOU3J1uovZKr97+wBN9mZGgOYr+xrWP37p5pvUCgXWzfPb/omyDqE
         79c0IfwRTUrSGGoWzFvV8wooResX9StxAV5Rf2h1PqtOd9LhjNY26oJIEmvJGvPQPEp1
         gFJG2Pm4os53IhuJS7GQmEF7n3cA01H/QZS2at6Mnx1KObBeTZZKNEUojQtrB7HApqva
         yd0oQ8H+zi08uYQ08d8zOfKeWmeJhRXcM/FmoGeDUXdaP2ag56wfTEWFBb6tfyIL7Pvc
         FG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dB4k9zJR7zUmxCcXiBETvbJM6wdA+XwvJn3UKTWckec=;
        b=JQRLVseTQdB3M93maGIvxtT/2t6vA4vQf9vbKKUfNK0w69omCjwTfQeSnReZhTZrZb
         WnKgFrJ78qUfMq8zsDP1hGux0S8bA+x/nt5ls0OyDHybYm7Qo7225ZjZFQTrfNuQONiW
         g/LBYRDRgKbzfjYPsYVTAEuZ3f4cvkovM9BDoDNtHL82O34cv7RO+KNl/boW/0pYwwOm
         ltZnHQ+lf1Yiu/oS4Etq+b9ffnYktaK1WBe7i1EaGa3XozhcJ5VrlpRMcXndiVlONa4y
         XVyQ4NHcZij2VxHWGGHHOim9y8IWw3aJx90QEHmOf+26l+bdivm64zoqCzd/SOb1ep44
         UaWQ==
X-Gm-Message-State: AA6/9RklpoBgFNL0JcQ2sDTianedHBUA1hAXeocN0U/3vLVSfB+wXsFo0BHUF10vEeMOcA==
X-Received: by 10.28.163.6 with SMTP id m6mr15856537wme.110.1474906416650;
        Mon, 26 Sep 2016 09:13:36 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id s9sm1668495wjh.16.2016.09.26.09.13.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 09:13:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 03/11] run-command: move check_pipe() from write_or_die to run_command
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <854ff387-57a4-4c27-4c27-b834f7797694@gmail.com>
Date:   Mon, 26 Sep 2016 18:13:35 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B4255C0-4C0C-45F0-B37D-0C78C2AAFAE9@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-4-larsxschneider@gmail.com> <854ff387-57a4-4c27-4c27-b834f7797694@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Sep 2016, at 00:12, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Move check_pipe() to run_command and make it public. This is =
necessary
>> to call the function from pkt-line in a subsequent patch.
>=20
> All right.

Does this mean I can add your "Acked-by: Jakub Narebski =
<jnareb@gmail.com>" ?

Thanks,
Lars=
