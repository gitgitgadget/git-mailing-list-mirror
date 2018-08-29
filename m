Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3201F404
	for <e@80x24.org>; Wed, 29 Aug 2018 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeH2Wj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 18:39:58 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39596 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeH2Wj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 18:39:58 -0400
Received: by mail-ed1-f54.google.com with SMTP id h4-v6so4675843edi.6
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9hb72SAGb7LcpDEpU8RmWU0C8iN5joiylbEvfsUcxVs=;
        b=CuAdczlEY++XLH20TJQrCT0JuVj2CxvxfXW4hwjuFN0esYxgOb4vfU3+fCKOmrks2a
         H8Wzb625Hdqe1wLmTitQd/FRl4ejqCoejJJa3pwqJcOIIrqIFrsOAGrB9ZLiOpTRZCFA
         wWcLnkVzuLL5WBpwUFNPkX8clu+jbF6dHUp2PuI6qzHZuxVaMClcEy9yG4axcIsdwuw2
         RNIhxx84XYkta0KiAwH1JTblKqNPW6P0GL1hnrC5UDmGDL7wNdBzRAH4KFbMuH3U22YI
         XT0e3f2F7qzFjYYup6rZa4P7agdVa85EQlqa20uCICY7jNR7yuaqbMRn1+AdKdere818
         2eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9hb72SAGb7LcpDEpU8RmWU0C8iN5joiylbEvfsUcxVs=;
        b=BdF5mVpBfrMQ85fwjYLC1qw0kRrchUAXIE/8dfiSomz8DjcAK7q+y2SD/JbnPyjHGE
         d3DIVHzG1I/L3jxgP2Hbdnmf0AsqJeiwFKkSGVypd9vMB+BssYTI8qSI4WJgyMOVcQyi
         MaXUcq5Agok/sfhRct0lyQkH7++rvJkDgOTUADnJmTKX0neGkZmXHXEZtSqEL4FdbYCv
         nkIgFoSOaPWYMQRiCCkDB/IvVALdktP5mx1cMlhxHJtUsFYh0xqbIcFtIbEs3+MrlB4f
         etvlSPFQHEi2//BksS4At02lZSahz4c6VVlPtpVTIvcMJ/lhSxrmYgnhg7A8f6hRUiIn
         FcTg==
X-Gm-Message-State: APzg51A7JMjUUTZymmJqfQmQ+BujB3Jdne9+LuWoHx/Gwv3doSku7HI5
        hLTw53BiqQyAuojC5sT9NJmjvSLBYWA=
X-Google-Smtp-Source: ANB0VdZsbCJUJkaT6jAOpC2SSROFNMnWSN2iCr1CQmWQ5Mrq3TVPHvDXC9dhXb2r4ONNCDHEJ+JEhw==
X-Received: by 2002:a50:a305:: with SMTP id 5-v6mr9353343edn.57.1535568105513;
        Wed, 29 Aug 2018 11:41:45 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1943274edo.39.2018.08.29.11.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 11:41:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
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
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180829175950.GB7547@aiede.svl.corp.google.com>
Date:   Wed, 29 Aug 2018 20:41:43 +0200
Message-ID: <87zhx5c8wo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 29 2018, Jonathan Nieder wrote:

> Stefan Beller wrote:
>
>>                  And with that model, <hexdigits>^{sha256}^{tree}
>> could mean to obtain the sha256 value of <hexvalue> and then derive
>> the tree from that object,
>
> What does "the sha256 value of <hexvalue>" mean?
>
> For example, in a repository with two objects:
>
>  1. an object with sha1-name abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
>     and sha256-name ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>
>  2. an object with sha1-name ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>     and sha256-name abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd...

I'm not saying this makes sense, or that it doesn't honestly my head's
still spinning a bit from this mail exchange (these are the patches I
need to re-submit):
https://public-inbox.org/git/878t8txfyf.fsf@evledraar.gmail.com/#t

But paraphrasing my understanding of what Junio & Jeff are saying in
that thread, basically what the peel syntax means is different in the
two completely different scenarios it's used:

 1. When it's being used as <object>^{<thing>}[...^{<thing2>}] AND
    <object> is an unambiguous SHA1 it's fairly straightforward, i.e. if
    <object> is a commit and you say ^{tree} it lists the tree SHA-1,
    but if <object> is e.g. a tree and you say ^{blob} it produces an
    error, since there's no one blob.

 2. When it's used in the same way, but <object> is an ambiguous SHA1 we
    fall back on a completely different sort of behavior.

    Now it's, or well, supposed to be, I haven't worked through the
    feedback and rewritten the patches, this weird sort of filter syntax
    where <ambiguous_object>^{<type>} will return SHA1s of starting with
    a prefix of <ambiguous_object> IF the types of such SHA1s could be
    contained within that type of object.

    So e.g. abcabc^{tree} is supposed to list all tree and blob objects
    starting with a prefix of abcabc, even though some of the blobs
    could not be reachable from those trees.

    It doesn't make sense to me, but there it is.

Now, because of this SHA1 v.s. SHA256 thing we have a third case.

> what objects would you expect the following to refer to?
>
>   abcdabcd^{sha1}
>   abcdabcd^{sha256}
>   ef01ef01^{sha1}
>   ef01ef01^{sha256}

I still can't really make any sense of why anyone would even want #2 as
described above, but for this third case I think we should do this:

    abcdabcd^{sha1}   = abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
    abcdabcd^{sha256} = ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
    ef01ef01^{sha1}   = ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
    ef01ef01^{sha256} = abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd...

I.e. a really useful thing about this peel syntax is that it's
forgiving, and will try to optimistically look up what you want.

So e.g. <hash>^{commit} is not an error if <hash> is already a commit,
it could be (why are you trying to peel something already peeled!),
because it's useful to be able to feed it a set of things, some of which
are commits, some of which are tags, and have it always resolve things
without error handling on the caller side.

Similarly, I think it would be very useful if we just make this work:

    git rev-parse $some_hash^{sha256}^{commit}

And not care whether $some_hash is SHA-1 or SHA-256, if it's the former
we'd consult the SHA-1 <-> SHA-256 lookup table and go from there, and
always return a useful value.
