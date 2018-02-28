Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C139E1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933484AbeB1Rme (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:42:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52574 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933649AbeB1Rma (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:42:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id t3so6601731wmc.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pZm4yD1W+nyHiMwmf1rBJkruJ3yxBzjeAn1TTNyR3tw=;
        b=j0Nlr/HVMriVPyGlqEI/CIaTXHfHMnOpBmXC7XpCWnE4HEglfqPomT9mJs5/70DyKl
         OGwX44QTBGAacFpIlCjpwF+pYIL6oEPHsDwZ+OY4IGpB0lkFanFMqkDpZ9/kZRjZ7JvV
         HgKSbZtkl23yiijiaFmNQz7Lt+35IqHvLdQvzm1XHwgaOwums8aiCw7Zhx0lXpQM+66m
         A/FM8bnazb6gceUp2Fm32p/fqjTExteSwua6z6VGzvuS77w8Ycw9LlKGqYROrop8uhqC
         C45PvDc+xbOpVShH2PudR8/9tLirob4d+m7T6wHrAYDqvwms1PgjCvDPkEQ/AFbH2jow
         wd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pZm4yD1W+nyHiMwmf1rBJkruJ3yxBzjeAn1TTNyR3tw=;
        b=ghDTsZaZDmsMHXRPW3+Kl1keefbof7IxbX1HEG8OtrYOcq5v2WCPyxjjHmyBiphs5f
         CPo4LX+SftWyhZezFGIDCxCo344Rz92eWcIYN1ki+8FWltfdMnZWfOfH8C+LtaUkA7ld
         llIFpHe98H1jWPm6Yyy/jL2ywSyhPE8SCbfcK13TtLEjBmxwzGpk0yfuYPPU3lKLze1f
         jc2+pRBkJQvK6UrQWFz4rCBm6+jEc/b40fHnI8mQxMT1VWCMXH3f/qJdL8onPAtlP0DR
         3LEgAU0i1/Eg0QyWQYtKylbQX13UoXiYC9/u0HUSZea8NEAvaiXKU7KS5szpmpj2v+Gm
         d92A==
X-Gm-Message-State: APf1xPAVXdE/0UozPU0YviP6I7wzJBQbJqiGLfZ0DcFK6G2lo42Daq9q
        HCWBWubf+IdLmIPF8E1IFHxe6290
X-Google-Smtp-Source: AG47ELsywA0nQmv7VUtSizxqdW02AuNZNicJ2L/fsk+zZGL5D0r4qAFfQTnBz827oEKsXFJApCHLGQ==
X-Received: by 10.28.111.145 with SMTP id c17mr11337078wmi.74.1519839748701;
        Wed, 28 Feb 2018 09:42:28 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i49sm2390426wra.44.2018.02.28.09.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 09:42:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
        <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
        <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
        <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
        <20180226014445.GB8677@sigill.intra.peff.net>
        <20180226173533.GA7877@tor.lan>
        <20180226204635.GB12598@sigill.intra.peff.net>
        <20180227210517.GA17555@tor.lan>
        <20180227212537.GA6899@sigill.intra.peff.net>
        <20180228082005.GA16857@tor.lan>
        <20180228132116.GA32272@sigill.intra.peff.net>
Date:   Wed, 28 Feb 2018 09:42:27 -0800
In-Reply-To: <20180228132116.GA32272@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 28 Feb 2018 08:21:16 -0500")
Message-ID: <xmqqfu5lm2nw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> The binary patch is still supported, but that detail may need some more explanation
>> in the commit message. Please see  t4066-diff-encoding.sh
>
> Yeah, but if you don't have binary-patches enabled we'd generate a bogus
> patch. Which, granted, without that you wouldn't be able to apply the
> patch either. But somehow it feels funny to me to generate something
> that _looks_ like a patch but you can't actually apply.

True.  And at least you _could_ apply a properly formatted binary
patch to the original.

> I also think we'd want a plan for this to be used consistently in other
> diff-like tools. E.g., "git blame" uses textconv for the starting file
> content, and it would be nice for this to kick in then, too. Ditto for
> things like grep, pickaxe, etc.

You probably do not want to limit your thinking to the generation
side.  It is entirely plausible to have "we deal with diff in this
encoding X" in addition to "the in-repo encoding for this project is
this encoding Y" and "the working tree encoding for this path is Z"
and allow them to interact in "git diff | git apply" pipeline.

"diff/format-patch --stdout/etc." on the upstream would first iconv
Y to X and feed the contents in X to xdiff machinery, which is sent
down the pipe and received by apply, which reads the preimage from
the disk or from the repository.  If doing "apply" without
"--cached/--index", the preimage data from the disk would go through
iconv Z to X.  If doing "apply --cached/--index", the preimage data
from the repo would go through iconv Y to X.  The incoming patch is
in X, so we apply, and the resulting postimage will be re-encoded in
Z in the working tree and Y in the repository.

