Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA3F1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeH3Awl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:52:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39463 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeH3Awl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:52:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so6869181wmq.4
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jWM5L9hSpWvr27amfGKKGnhKQOgeT3kLO8s/dP6V+kc=;
        b=cR9s5qKzIwGGSqo9zOf3JiV0cmoA8Gbi/1RQUOmnk1db4S8Hdt1ZbRXXSsV4Wopc+9
         F73ZHIxZ8/Tje7gDjxgjjNthlWJ4I3XejamX+T7VFGzcpZnzsiquLnER5q4/TdNN3PcK
         eY5VN9bQVLRmdn5K75rQnsS+LZ6UimqHF/wvzDSfo2bz4UtiDJOZ1Nd0iPSdvDjW6e2t
         vunswL5uqmCVOVyVaPxVgom3cVieNCCNK3kdM2NlWmjbG2A1rF6MZ6obBlg3TqOpP6Qf
         0Ikg7k9xi//JCOjgErX5IvE3PVYOui7gb+Gw3fRDj8RSpHMKT2809zAH3Qnq9Jh4my1D
         yucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jWM5L9hSpWvr27amfGKKGnhKQOgeT3kLO8s/dP6V+kc=;
        b=rJF7lnYCHclYewVa/O89QTil31VNUy4PKB2SOK4htKp0YwJocwi46JxINQOqnGVwlZ
         HKUI3FJZyslefREl0g4Wtuif1NgzGJPmFnMBxxMdD/64+wEoJVYlsYDVbv7op8LOi7uF
         xaq+2lSNFPR4hv+TBHN0Y4/fvf9S+oaAEhz+Q/fSNh02NV7bagRbPHcqY4itUVHoSu7r
         gFEZ8wvn+uOKRrNO+tXdh+fZ58z28HK6+9WGplUq22mN9pg6sMhiRuj6nxDsTy/ne6Qv
         D5MYTpmvLBGTveGcrk1Mx4PSYqgJGvaKzCoz5KeYOr1sE1l/aOEfPut3H0Gxk7D1XhLG
         iZLA==
X-Gm-Message-State: APzg51AgBnc77y3PFq1KQjmhSuaDfW5w+hQhVS3cm1A+qGYIOG/tLMVs
        eFeQAHE9SduoKfLAkXYE2og=
X-Google-Smtp-Source: ANB0VdbvHtm51vbXxWi3q+djA47lwXP7J35HRIDuw9I6Z2krTbMgkFBvTcKPdlGEC+/gmAt5qxATHg==
X-Received: by 2002:a1c:480a:: with SMTP id v10-v6mr5108042wma.161.1535576041087;
        Wed, 29 Aug 2018 13:54:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm4967778wre.15.2018.08.29.13.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 13:54:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
References: <878t4xfaes.fsf@evledraar.gmail.com>
        <20180824014703.GE99542@aiede.svl.corp.google.com>
        <877ek9edsa.fsf@evledraar.gmail.com>
        <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
        <20180829175950.GB7547@aiede.svl.corp.google.com>
        <87zhx5c8wo.fsf@evledraar.gmail.com>
        <20180829191232.GC7547@aiede.svl.corp.google.com>
Date:   Wed, 29 Aug 2018 13:53:59 -0700
In-Reply-To: <20180829191232.GC7547@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 29 Aug 2018 12:12:32 -0700")
Message-ID: <xmqq36uwc2s8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, I want the input format and output format completely
> decoupled.

I thought that the original suggestion was to use "hashname:" as a
prefix to specify input format.  In other words

	sha1:abababab
	sha256:abababab

And an unadorned abababab is first looked up in sha256 space for
uniqueness, and if and only if there is only one object whose sha256
name begins with abababab and there is *no* object whose sha1 name
begins with that hexstring (or vice versa), that string will be
resolved to an object name.

I do not think ^{hashname} mixes well with ^{objecttype} syntax at
all as an output specifier, either.  It would make sense to be more
explicit, I would think, e.g.

	git rev-parse --output=sha1 sha256:abababab

(or would that be the job for name-rev?)
