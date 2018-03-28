Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD65C1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 16:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeC1Q65 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 12:58:57 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45568 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbeC1Q6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 12:58:54 -0400
Received: by mail-wr0-f173.google.com with SMTP id u11so2891526wri.12
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4ojoXF9jkj6kZM3MQq6IvtNCqQ0vClDVIfgArUbvw6U=;
        b=e6pOvC2jrxIc8FCL2GTGjvGoMNzqd1cXbWBuEssXRBojWDdZyLXm0HZzgdJk7Zvy9J
         63fG7/jAXhSCg41E6pOTGEr3bGPayh931zRzfyoJ6DKjmmgMjcYI8cmeXQgXi/0GzHYb
         eFxlzoHsXxWTuM/26zmBsaxuZkzXeMt8VbOgj1QseDTsxda4uD907bfXw7nIAQOWcby0
         O4F5r3Lzb677Ie9P2Z1+0YKoIjVKFhNaULCL3uk+RHQRCgtm0Mnptl6sy+n/rL3bFQ1l
         czrL6k3jE/Qh7tPT53M2pMc8ne34570M0kDVEGuM24vsORYbbFXnVubaAITqWqeUoq0n
         jioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4ojoXF9jkj6kZM3MQq6IvtNCqQ0vClDVIfgArUbvw6U=;
        b=hccqgQ+4+lPEDigHlAs76Ldp4MkCAvTER9t6aBVQM6+VogYi+mV8SUOWh6E+CnfgFm
         b5gaa2cLZhP76pPXVNxyv2/uqSnAmPP1B23VairYFzAfNwxHrCv+0yrrN1EJHoJZTs07
         PhSRLFJRJs1bqq8pRZtGpTw75Mtak+XLe+gcVCfON2/XmZym3o/Mm8Obft5mIWuJ5dgu
         8WYqW+hnz3a2d2yMaHvlvOmTiUadCkrUQ0KENDnfeIuLeSDRZcfivy0kRcz0jJOlW+PL
         eB1407hnKA5gNtuJfeFrC0QvqoM7nDNrtJU4KPDxXq9nxj0Scesd4Tdj61tNCc1B0PCn
         LMnw==
X-Gm-Message-State: AElRT7FsJC4Yje+rabwo94vqgHit9n0ZtcxTNOABg4kkdU2PGKNFE3zp
        J0RKTMb5hdz+FBYVmtXKwUs=
X-Google-Smtp-Source: AIpwx49zAIJ8bCVNh867azI9LLb2YsTPbZp5O6wSdh/Ni/LRNNTyuJxxs2Kf0YMwzjIWPNBxk+PKbg==
X-Received: by 10.223.160.195 with SMTP id n3mr3802337wrn.92.1522256332807;
        Wed, 28 Mar 2018 09:58:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m62sm5562764wmc.25.2018.03.28.09.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 09:58:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
        <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com>
        <xmqq8tafe92r.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803271630210.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 28 Mar 2018 09:58:51 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803271630210.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Mar 2018 16:40:47 +0200
        (DST)")
Message-ID: <xmqqh8p087ck.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Ideally, the existing one be annotated with prereq SHA1, and also
>> duplicated with a tweak to cause the same kind of (half-)collision
>> under the NewHash and be annotated with prereq NewHash.
>
> That's a good idea. I wonder whether we want to be a bit more specific,
> though, so that we have something grep'able for the future? Something like
> SHA1_SHORT_COLLISION or some such?

Sorry, you lost me.  

What I meant was that a test, for example, that expects the object
name for an empty blob begins with e69de29 is valid ONLY when Git is
using SHA-1 to name objects, so such a test should be run only when
Git is using SHA-1 and no other hash.  All tests in t1512 that
expects the sequence of events in it would yield blobs and trees
whose names have many leading "0"s are the same way.

I think it would do to have a single prerequisite to cover all such
tests: "Run this piece of test only when Git is using SHA-1 hash".
I do not think you need a set of prerequisites to say "Run this with
SHA-1 because we are testing X" where X may be "disambiguation",
"unique-abbrev", "loose-refs", or whatever.
