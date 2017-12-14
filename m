Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611E81F404
	for <e@80x24.org>; Thu, 14 Dec 2017 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdLNTlt (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 14:41:49 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:42259 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdLNTls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 14:41:48 -0500
Received: by mail-wm0-f41.google.com with SMTP id b199so13595758wme.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 11:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OACN8tiDQIgV6eRQ3ihuujn9EAN3BjOmM9vSUP5fWrI=;
        b=l1pZyISeDJz0x8n28HDQKIYZ33vfC3NoyjZS05QxU0dXE7YZey52JTeesLeOvyqNQ5
         pKMt7nCluW61dIOWvT9owcyQizRjh9bHHqmyPFaDoM/tuY78ZsUHfdHwlt+59iYMpnTf
         6irNJaAWgYh80hGQWJAPdt4WmpCpKhz42HkDckCxyotvuZMdSCwp3vBNeNmyuSDN1N+h
         990puhIfa3HwVH8zbJXBR5TRj0WI2m78rE9Szq3V3J9Ve1q1Q74zgZu/XvCHCtJ8d3/k
         3N8WzQ5LRv0EUAlKds5G0c2pNBzyhD33ei2wS/VgC/jpf+QkgpHRSAUis5xyKZSgdfme
         A5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OACN8tiDQIgV6eRQ3ihuujn9EAN3BjOmM9vSUP5fWrI=;
        b=nUQZN34DJAyUE9N3ar2G3dVY+Lb5Gha5DOFfaxwCz+3ukA9UMlQlorxGomz8z62Ily
         3OP0XuvG0/4Y4oKo2i1p27JQ1IiJu6LWA35u/9ONRlffNAvkpH0qXkqCGATl6JPMaTIU
         5CEOXs+I2Gadla5Qk+UlLXVaTX2Smf3QHP69xFarY6ckoeY3iIOW6bgX4uZlw2K2Vtrd
         tIH/s9ezxkfA0K7WUDyYnYKHC6so+0GMakHCBuvD2uew3T6HxfU7fk7xTSSPnotnOP7I
         SJyKAD3GSDdsTg0RJ3ZGm0qTh69kMSgEYO8mvEckZpGIRNfBXVKBrdOPffuIgoxJJf5h
         yaGA==
X-Gm-Message-State: AKGB3mIYQ16gxwB4tL21eDYRLFkcUpWfGV4jAe0L1vefDOjDPm9BrgID
        +Uumx4njAdTlmkD4YskahEo=
X-Google-Smtp-Source: ACJfBot8ARaqlvGVPQOurnbON815e7Fcfxa1NErtNu7+mEoYOSer5iiFsLweHkO4OHfGZqAMo4E/xg==
X-Received: by 10.28.15.11 with SMTP id 11mr3114077wmp.0.1513280507416;
        Thu, 14 Dec 2017 11:41:47 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 187sm8857817wmu.19.2017.12.14.11.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 11:41:46 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1ePZO4-00082o-Eq; Thu, 14 Dec 2017 20:41:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "David A. Wheeler" <dwheeler@dwheeler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com> <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com> <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com> <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com> <CAGZ79kZeMVLesunBzW5hhN-snL8fBXdjPgy=Tt8JCDmhDePDZA@mail.gmail.com> <xmqqk1xpta93.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqk1xpta93.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 20:41:44 +0100
Message-ID: <87tvwtayh3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 14 2017, Junio C. Hamano jotted:

> Stefan Beller <sbeller@google.com> writes:
>
>> Anyway I think spending list band width on good documentation is
>> not bandwidth wasted.
>
> I agree with that.  I do not consider the proposed change "good".

The case you're talking about upthread is something which we could
describe in the docs as "the starting point of the staging area is that
it's equivalent to the current commit, and is thus used as an
index/cache by various commands", if that ever comes up.

I think in the vast majority of other cases talking about it as the
staging area would be an improvement, since that's the function that has
the closest correspondence to what the UI is actually doing, that we're
using it as a cache / index is usually (always?) an implementation
detail.

Even the merge case you mentioned is something where staging area makes
more sense: "We tried to merge, but had a conflict, we've staged some of
your changes leaving the rest for you to sort out".
