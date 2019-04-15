Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D638E20374
	for <e@80x24.org>; Mon, 15 Apr 2019 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfDOKa6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 06:30:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56013 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOKa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 06:30:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so19945449wmf.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2aiR1FkEbtHCiAB/8piW7pfOnpLG3H2cy+6b+tYd1kE=;
        b=VjdUlKA9+wJpXgGKgZduowzJWkJcaQnVXBRbw/YCV9nRWyILvEHiYwGqKKfNFowJWt
         DTg2FP3pj5hjYyerrkQVZWYfzsMsQeGMomdOnJFJL3nquLjzOqNmhzdVw876z1w6zYcz
         vuIm00Uw93d+2pgIw3GnmL7CCpIJH5Ff18PBe5x+L/r8gMgaJrT8jULkhJ4btOX0xga+
         Up//ySbR9+4LiolWKojEHYlchl88xpjkPzEGFrI7eb13F2E+eI/b2ZOukjdjNm06q21R
         k1NcPARHFIsyzUMYrCcp2OFQ6EPCQENmtqx1wCr1uprucNqZS7XGCq3a+AwoeR/0IgUK
         bHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2aiR1FkEbtHCiAB/8piW7pfOnpLG3H2cy+6b+tYd1kE=;
        b=M/9cU0Rvp+yVwsijYUeCq8toCKehphPxeIPJeXkOB6plKS3V84vqvcBDOjDzMfxs1r
         6KLwTdS5DoMvrjleB2POvB/ymHX6QukzgWvcvE4Q4jebVhbgK0GesC/b0EjRf1Y2bbFk
         TsGIvh1A1N/nBXpwnhgT9M4K7DnQcm5/q8VBxveANj32OK5f5m7WXa/SDAOCUeeuwqxe
         h/p8dUTz1W06xHO/P/QW0oPBi9LdB7azS5j7wIZvmx9os/QrEnqNcJ9QWEhAD6KFQGc6
         mDwhKLgJ9saPLGMeCetfo0p/UTfGARPlzyrYFN08pzC52gQswzZi0nVHCc/vDF2yYBfG
         iGqQ==
X-Gm-Message-State: APjAAAW+x+EX4vy8jTcKdYhkNwXAlr81yo0iP/HVkI8+IWaraY6toUg8
        yKtLkfIVpwiXSTWqQP+tpXI=
X-Google-Smtp-Source: APXvYqwUvRDPgU2ZiFqQHKXoh4Kq5p2IkQnUg7mk9hlh3fliFXh2Y0815NfgCr5Fp6MynwBxT5axhA==
X-Received: by 2002:a1c:2d45:: with SMTP id t66mr21903579wmt.106.1555324256292;
        Mon, 15 Apr 2019 03:30:56 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w11sm141181793wre.15.2019.04.15.03.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 03:30:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/16] Many promisor remotes
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
        <xmqqmukrr52m.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 15 Apr 2019 19:30:54 +0900
In-Reply-To: <xmqqmukrr52m.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 15 Apr 2019 18:27:45 +0900")
Message-ID: <xmqqimvfr25d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> This patch series is based on:
>>
>> 763fb763b8 (Merge branch 'jt/batch-fetch-blobs-in-diff' into jch, 2019-04-08)
>>
>> to avoid issues with jt/batch-fetch-blobs-in-diff.
> ...
> If you really need to depend on another topic or two, please base
> your work on a merge between 'master' (or some well known ancestor
> of it) and the tips of the topics instead.

Well, I've done this myself by first queuing these on 763fb763b8 and
then made a merge between jt/batch-fetch-blobs-in-diff and master
and applied these pathes on top of the result.  You should be able
to see the resulting topic replacing the old one in 'pu' in todays
pushout.

Now I can lose the semantic conflict resolution the rebuilding
machinery was keeping, which makes things a bit simpler ;-)

