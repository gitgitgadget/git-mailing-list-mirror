Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8C01F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeI0DzP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:55:15 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50702 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeI0DzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:55:15 -0400
Received: by mail-wm1-f48.google.com with SMTP id s12-v6so3787223wmc.0
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VSIqJwlxZh2921foczNd5DgoqfZNMc6HWtXmvW2oeVI=;
        b=fwU+7GGcuPQgvudp1vOWjOr8lXl98srOp631lhxST2t6V4b0nyUghIEKBjgOIo4Fn/
         9kvPstc2fPimnt28/cCO4Q9P/6aRM02ZUVPdL9DGaLSgo+tuMd8NfpgGWIxOZcs8yKXh
         F0wPgiqL3XQbTJJXrz7wMtOZ++9W5CfBU9UWaedlxGaWJfKgrVy8wwegCvSgmSXjYtwA
         GI2HrF7ho63AYZlNSv+qnItV7nGXRxgZ7dKOImQHJQoyzb7WjtECwta4Q+IU9GC3ClAb
         C86tNCHbyixW6+Fw8TMdq20g5NbXjQ344f7KjLG4/3N2RowEGqPPK6wOYmVKQy8Rj0Ah
         nLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VSIqJwlxZh2921foczNd5DgoqfZNMc6HWtXmvW2oeVI=;
        b=hWMVk2F+JiNcmQzfKeLzwDpUcrfZDrXmZ4NtCpjr9YKve00ouy/yA+zPfVM+D22qnk
         z/gfexvObXUDcw+8mM1T/emwLmeouM+uKGC6tsyr+BeWyPRUZocxlcy8tg+JDPpyBhws
         0O1bxWMfh7upI7Xsb93zCGrQAhh56YolotNLU94Z+3mppirAdrjopNDS2sgdY/8bjAmw
         rnqed41Wg5hhgkaUnygdqKidkbxCQqqGAs/Px6kFixxSuG/Xnj2EZsow3oyb0MIbVqT+
         w7xmbwu/fwFSj6SU4AQl03lAaqzYGQBPVBkUC/XG11ZUNyJcXzyv7g5DS1aN22tO6uAK
         hGFA==
X-Gm-Message-State: ABuFfojUmPAE2gqy2fpBDE97aJEy23O//KT9JmH/BTthX00yFAaoSBla
        j7DC626x8o5BffWiSRVT+xw=
X-Google-Smtp-Source: ACcGV63epDbLsqnAYSGKnTi6nN8yLziU+T4hYHPCdVofdDUP+JPpzzUjSveZRGSBaCnpZb2wn84H2g==
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr6104585wmd.39.1537998015126;
        Wed, 26 Sep 2018 14:40:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b124-v6sm318578wmg.47.2018.09.26.14.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:40:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
        <87a7o4je0t.fsf@evledraar.gmail.com>
        <20180926185812.GD30680@sigill.intra.peff.net>
        <878t3oj8em.fsf@evledraar.gmail.com>
Date:   Wed, 26 Sep 2018 14:40:14 -0700
In-Reply-To: <878t3oj8em.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 26 Sep 2018 22:44:33 +0200")
Message-ID: <xmqqefdgj5tt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> So in terms of implementation I'm a big fan of the perl.git approach of
> having these docs as comments before the function implementation in the
> *.c file.
>
> It means you can't avoid seeing it or updating it when source
> spelunking, and it leaves header files short, which is useful when you'd
> like to get a general API overview without all the docs. Our documented
> headers are quite fat, e.g. strbuf.h is 60% of the size of strbuf.c, but
> less than 20% when you strip the docs.

Just like you I do not care too much where the authoritative source
lives, and I do agree with Peff that separate text file is much more
likely to go stale wrt the code, and that it is an acceptable trade
off to write docs in comment and live with slightly less freedom
than writing in plain text in order to keep the docs and source
closer together.  I do not think between Peff and me, neither of us
were contrasting in-header vs in-code comments.

And I tend to agree that it makes it even harder to let doc and code
drift apart to have the doc near the implementation (as opposed to
in the header).  It probably makes the result less useful, unless
the project invests in making the result accessible like "man
perlapi" does, than having them in the header for people who view
headers as guide to users of API, though.

> We just don't have some central index of those, and they're not a
> default target which means the likes of our own https://git-scm.com
> don't build them, so they're harder to find.
>
> Every perl installation also ships perlapi and a MB or so of obscure
> internal docs to everyone, which makes it easier to find via Google et
> al, which I find useful. So I guess I'm more on the side fence of
> dropping a hypothetical gitapi-oid-array into /usr/share/man than you
> are.

Regardless of where we place docs (between .c/.h or .txt), making
them indexable and investing in make target to actually produce
these docs with ToC is different matter.  I do not think people who
actually spent time on our docs had enough inclination to do so
themselves, but that should not prevent you or other like-minded
people from leading by example.

