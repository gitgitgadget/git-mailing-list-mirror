Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765FC1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbdFPVjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:39:04 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36134 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdFPVjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:39:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id m125so36159736wmm.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JIL5Y+r40RyqvUN+KbNLb8bK3JOyWDekxgRfk/Tx5Po=;
        b=jEHtdVEP1tkhvKalIfxhVgl5dSVWsEFZ0XwexLY5pHLQA6b/LEc8MK85iNHYN1SmVq
         M2sHWQNbI+kFcNJuwVDRz1LuqetITd4dWN2LHuHsh4TEpO31ozDMg0F/u9937vBQdsXt
         pRNfi21Qzi2O1WJNQa+h1FXCa93ekdeXJtPCT3spOyjENlnMTbaUoesXBXwzkZZKf3Sz
         /TnIiHt/1MnugKGrlxdIiEYdzgW07U5kzkBgJNgM6SCSJir1qeMm04jwGHPpo+Erj1kl
         ygYXe0a2ls0Tv7EpzDDPoslbt85yV4PBOS+QQ2r7bEDTDTFJ9HauEOdA973CIvquwQdu
         V78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JIL5Y+r40RyqvUN+KbNLb8bK3JOyWDekxgRfk/Tx5Po=;
        b=rCw8f91d/cQ4vWgBQvH3HsA9ABFPOa/tpk2kFQ8XHa/sDWXHkrIEAJJWYbTg0828iY
         GAl42CxRUdTD7Ezi7Be/RyqrO7B7IaLhs6r75ABtPo4QY6y+rEyXauBLEfMH6HkRlqbQ
         cAKe9J0+iZF1C0cX/t6royRU8kguY5Umus3mSMf1S+kZIw5bviUsSqidYeeYNXY0LOa6
         w1Y76SOsSAciUKgpugwq980Q0QIj7XhmScv9/T2qPKVUlUEpHnGqdBJpWP9TNJ49yfmn
         ZAIj1CzfCpcGhg+4kF6JQQtGM2fawTV8gxbF9VM/roIIU7FVqCeYqQPkTG9BSAW+NUgy
         pApg==
X-Gm-Message-State: AKS2vOwNmBSNKnlLrVqJLbnvkeHl5AMDgjMEDy0wV8LT/AgD3KrnJTbx
        ldZb1HgKswe4jA==
X-Received: by 10.80.146.47 with SMTP id i44mr8591239eda.48.1497649142083;
        Fri, 16 Jun 2017 14:39:02 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id p20sm1932123eda.67.2017.06.16.14.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 14:39:00 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dLyxI-0002UJ-4G; Fri, 16 Jun 2017 23:39:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash function transition plan
References: <alpine.DEB.2.21.1.1706152123060.4200@virtualbox> <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com> <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net> <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com> <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net> <87y3ss8n4h.fsf@gmail.com> <alpine.DEB.2.21.1.1706161438470.4200@virtualbox> <CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com> <xmqq37azy7ru.fsf@gitster.mtv.corp.google.com> <xmqqr2yjwsb6.fsf@gitster.mtv.corp.google.com> <20170616212414.GC133952@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170616212414.GC133952@aiede.mtv.corp.google.com>
Date:   Fri, 16 Jun 2017 23:39:00 +0200
Message-ID: <87tw3f8vez.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 16 2017, Jonathan Nieder jotted:
> Part of the reason I suggested previously that it would be helpful to
> try to benchmark Git with various hash functions (which didn't go over
> well, for some reason) is that it makes these comparisons more
> concrete.  Without measuring, it is hard to get a sense of the
> distribution of input sizes and how much practical effect the
> differences we are talking about have.

It would be great to have such benchmarks (I probably missed the "didn't
go over well" part), but FWIW you can get pretty close to this right now
in git by running various t/perf benchmarks with
BLKSHA1/OPENSSL/SHA1DC.

Between the three of those (particularly SHA1DC being slower than
OpenSSL) you get a similar performance difference as some SHA-1
v.s. SHA-256 benchmarks I've seen, so to the extent that we have
existing performance tests it's revealing to see what's slower & faster.

It makes a particularly big difference for e.g. p3400-rebase.sh.
