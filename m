Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2C520A04
	for <e@80x24.org>; Fri, 26 May 2017 09:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762227AbdEZJtG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 05:49:06 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33403 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759839AbdEZJtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 05:49:04 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so7201497pfh.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=l7Ct7/XVaqVEY+Lg0jGbH/NeR6kYLtQGApLWQV0l4dc=;
        b=JfXRSYGckYnEpic6GMuCbUhkjoJaOQrAeS8LrBw08/jtu4jEyz+D8noKj1H9wZNfPT
         EUJSQndZ2xA2l1hb/ko3Fgqj5LGyihbwfMB/Ir17Plnqp/iqV155B+uOnYwazdywaFox
         OIsUO774eDGjjYv5uqFbuPMf/mtWP5pDSuKbaZdl+/y3aFXV9Ijix+e6S45EUpo61DZs
         W5bKw4N070Im9a5MJ3PwOaQynrwP6BrN4EuHA23uiuzxrim92OIP/git+ONEm/lmJ4dR
         +WuqpmR2AiUswbkVtJd1soJH0NLo/pVpWG6WxOpVS3NGxwqR3Qxh4B8aN6n/xtv4Emc8
         AA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=l7Ct7/XVaqVEY+Lg0jGbH/NeR6kYLtQGApLWQV0l4dc=;
        b=Uek/ew6uN9nDZk9/oz3CrHgFuXGkJw0aBvjJcDkvZ5X+KKgEW8pSjcNxqG7GcoPz2E
         nD5snTciPD8JOQpX0Kv0bdLEh2Dl6YwOZmHj/OAodgdN9Ia7eD10Y3ocYLxzdHPdt+Hu
         Scx0gic2rJ/tWCM/sfncTHcxWOZH3IaPrjTiM2ZDscctZS2YLmDYsWB0GBOq8a2NH72i
         Y/waNjJ5nj6ejDc8R/fgPPKcPEawvKQOve03LuND/FVB+g/Fv0CSn0HQRLh6mK/8h8Rf
         TFQ4BRQ2VmaeLGKAan2KY8+H7//kW+9DNcHl4EIR2FlOb3TfC+g8nctgHeeplwJs3otL
         wTBQ==
X-Gm-Message-State: AODbwcB5rfLpvGCVAJ3HFSvrh9yJuMIX7XCNKB50Q4j9TmBmxRkqm/Pk
        4nKIjGmBBkNEVg==
X-Received: by 10.84.140.164 with SMTP id 33mr56418307plt.142.1495792143391;
        Fri, 26 May 2017 02:49:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id h84sm864351pfh.45.2017.05.26.02.49.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 02:49:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 1/7] grep: don't redundantly compile throwaway patterns under threading
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-2-avarab@gmail.com>
        <xmqqvaoqhnlw.fsf@gitster.mtv.corp.google.com>
        <CACBZZX51hmq-jCkwyDt6QWfLJ+qxziUV-Bef+yVDoViLNhC4dw@mail.gmail.com>
        <xmqqlgpkcu2v.fsf@gitster.mtv.corp.google.com>
        <CACBZZX7i2RqyjXmF8wxYvs0d1nijiopVQ2EUM5rmpztEbe6tKg@mail.gmail.com>
Date:   Fri, 26 May 2017 18:49:01 +0900
In-Reply-To: <CACBZZX7i2RqyjXmF8wxYvs0d1nijiopVQ2EUM5rmpztEbe6tKg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 26 May
 2017 10:06:01
        +0200")
Message-ID: <xmqqmva0aqya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> To be clear the point of my mail was not to say "I can't think of a
> way to support both of these things, help!", obviously we can continue
> to maintain two codepaths. The point was to raise the idea that we
> could simply remove the more complex & doomed to forever be slow
> codepath.

To be clear, the point of my response was that these features must
remain.  As long as they are more convenient than sifting through
output produced by pattern matching engine that is less powerful
(which forces the user to give wider pattern than desired, to avoid
false negatives) with eyeball, having to match each pattern one by
one, instead of being able to use a combined and more efficient
single pattern, is still more efficient for the end user, which is
the point of using a computer.
