Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421921F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 19:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeFBTn2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 15:43:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34552 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFBTn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 15:43:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so4336764wro.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nvu3vUls5hkppEeqX8w1QJOMM8h8idjHTx92ZbzljXc=;
        b=sNsgXTwwCV6H7IGxcFPxZXXpjf59PxRQz11fYKb3wv5D3sSpAFZD3Phl40swlu18b8
         p4gjgUIkhrt9IUvm6yQf4+BtQMyuYvnX5wYQTEJpzCaZCz7c3fPcyD4Hi9ThnTZuI7p4
         XRud8m46rGjOUKhOM76ga7ZVJKD8vcrm7j3INQpQqif6oI3LevEePhUPGXOND3my/YV5
         OTGm1H0QPVsZk0hb7p9De5tBD7ZkjPgpuDo+iKE/B+yso+8UEaTkbqMAtc9Syt9mxUIL
         Cs24oHZA1HnBdMpjAn2UoTFwlvRQjrdIciG/y1MixvPtLvP0mrbZnRgyJu8UUlm5HP1n
         TWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=nvu3vUls5hkppEeqX8w1QJOMM8h8idjHTx92ZbzljXc=;
        b=C8Qqf85G1laTH4d8pz3TyYW39f8GqpgVO8p9JTJ4yhuVx/my/ErXEM5fzcYjh/Gnsc
         ei49d0JMLsWVmIo5/VN9L846vyYWFnuy6w7ugyMRYkSVx0UlVolxaQIqrsHG7Dbx8vln
         VY6n8WNzHhWscSJjn400tpcwnyRZEBsO4SCmkuBxQR3uBYW0zPdbDR/U6KjgDzCOMVgt
         hEJ/HbtEcqzeGLDzdVTIWvtZc0Hw3uG87ojecHv0DZaf3qmxL0Z4yN726eigS6r+ofYu
         M8yO3+sUncymebRJj6GpGU4S2v8aZUc4xTB2JlzJ+gYoZXKd8rL+gOplpzyKHTl9uKPm
         DBLQ==
X-Gm-Message-State: ALKqPweMbtnohKWjd4M2nz9I+XOtaIiAzPNMUGYbgkAzA13K6a6FIReU
        S7UhYV+aSPfEp60irG8VrIU=
X-Google-Smtp-Source: ADUXVKI3zYLonWqxae8NuOkvQMF/GOs/OCJ5q72RNHNRJUpC12XUTZJ0SkDwG9qccil51GNpn85BFA==
X-Received: by 2002:adf:84c2:: with SMTP id 60-v6mr12560864wrg.167.1527968606500;
        Sat, 02 Jun 2018 12:43:26 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri112.neoplus.adsl.tpnet.pl. [83.8.102.112])
        by smtp.gmail.com with ESMTPSA id 184-v6sm5249862wmv.33.2018.06.02.12.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 12:43:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 02/20] commit-graph: fix GRAPH_MIN_SIZE
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-3-dstolee@microsoft.com>
        <868t861ci6.fsf@gmail.com>
        <20180526203036.GL652292@genre.crustytoothpaste.net>
Date:   Sat, 02 Jun 2018 21:43:22 +0200
In-Reply-To: <20180526203036.GL652292@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 26 May 2018 20:30:36 +0000")
Message-ID: <86lgbxq8it.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sat, May 26, 2018 at 08:46:09PM +0200, Jakub Narebski wrote:
>> One issue: in the future when Git moves to NewHash, it could encounter
>> then both commit-graph files using SHA-1 and using NewHash.  What about
>> GRPH_OID_LEN then: for one of those it would be incorrect.  Unless it is
>> about minimal length of checksum, that is we assume that NewHash would
>> be longer than SHA-1, but ten why name it GRAPH_OID_LEN?
>
> My proposal is that whatever we're using in the .git directory is
> consistent.  If we're using SHA-1 for objects, then everything is SHA-1.
> If we're using NewHash for objects, then all data is stored in NewHash
> (except translation tables and such).  Any conversions between SHA-1 and
> NewHash require a lookup through the standard techniques.
>
> I agree that here it would be more helpful if it were a reference to
> the_hash_algo, and I've applied a patch to my object-id-part14 series to
> make that conversion.

All right, I can agree that it would make most sense to always use SHA-1
for OID, or always use NewHash for objects.  This would make
commit-graph file with SHA-1 hash invalid for NewHash-using Git version.

It would be nice, however, to avoid having to redo all the hard work,
like calculating generation numbers (from old commit-graph file, or from
server that does not support NewHash yet -- the latter is not
implemented, but IIUC planned feature).  But we can do it with explicit
conversion step, e.g. 'git commit-graph convert' or 'upgrade'.

But all that is in the future.
--=20
Jakub Nar=C4=99bski
