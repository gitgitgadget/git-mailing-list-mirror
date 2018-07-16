Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA6A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeGPVfj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:35:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33242 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeGPVfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:35:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so10947023wma.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YVbCdtwnHnl3eV2UJO1InsxB1jr/aSXQBC+CJj8JxmQ=;
        b=c94SLzVNhWbJM/Wbafy8ZFh2WoNGWVKXM0aIqz3RB+2yDU+zZBDKwW+syC49cmo6y2
         kOFG1ZxN9Qv9q42GvhJ3BgWVaKGYAP41ZkUhYrjWmWSy0lwOc+uwXCg2WQDbv9r+NZ/b
         7i1LlP/srpLw7/VJBkdQ3u7OBBtN3y9nvuLYiR6mgGTVovRrz+5xmmsOcjJXcbLHVYYQ
         ES4+6utxWYsP3EEkxb6TdcSxW2UQzeDRVbXui2bT8hoIVVFBqejII0O6QOuLptr/BP0r
         8Y4wgqQRcULCzGvrGqZq7XqvtTtEjv1SmotNyfWfsirPY6DS8uTcZI791qLQBOyHM8Rr
         vGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YVbCdtwnHnl3eV2UJO1InsxB1jr/aSXQBC+CJj8JxmQ=;
        b=X+6mgs4j/C01VX9T/gAWJkpUaK+UkR39OFE9BJ/YSQSse7VYNsVor3KtoyPhrDWAeC
         ayuik4wwQ6qnQZRie41FqTfhM3qG5GoRlpR7gHrYdkU6ww86NB/7UWn8xeAAAfqe+ax4
         26hZzdVKX22oCXuoNz5DijXI7angPnuChdyY2RDbYLApAXFFq3sNcqqn650jSR18N3tF
         IXC4fCIEvk8yMFuSpj5xxDRXMK6bbzuTUb3Stvpm7ReitfFDtxWXcuGvPallf5W6NNWC
         RfrMIQyokv1FT3/CfxbQkaVrmThlsxfcN8rppOWe0iq94mA5rekMEB9y0kNRDDk4UQxD
         E8ig==
X-Gm-Message-State: AOUpUlGGiw6GG5PmeilppjFIFlLXvxXy3mMq/8TViJh3PTj0A0gSt2OM
        2LSDdJweBz8aaWQDnAzokmwGeU0S
X-Google-Smtp-Source: AAOMgpd9eWUzkuSnNNSRS7khukPbbaOHDQ4H1BD2fdqyoKlBO7pp3WSu1zmEPOXkj5aOQ8B1a27/oQ==
X-Received: by 2002:a1c:69d2:: with SMTP id z79-v6mr11142212wmh.92.1531775187337;
        Mon, 16 Jul 2018 14:06:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d14-v6sm8452938wrr.12.2018.07.16.14.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:06:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        sandals@crustytoothpaste.net,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.us>
Subject: Re: [PATCH 00/17] object_id part 14
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
        <CA+P7+xq9SeoZjYYWhM14-u4kGgwmNVPs6c+wFR2EbwK+_hVetg@mail.gmail.com>
        <1438bdfd-cb13-8da4-2dd2-16362b242ff3@gmail.com>
        <CAMy9T_HuO1a1_R+avedw-dmV4uWjOU9f0Hkrfo=gk8HTXcA7AQ@mail.gmail.com>
Date:   Mon, 16 Jul 2018 14:06:25 -0700
In-Reply-To: <CAMy9T_HuO1a1_R+avedw-dmV4uWjOU9f0Hkrfo=gk8HTXcA7AQ@mail.gmail.com>
        (Michael Haggerty's message of "Sat, 14 Jul 2018 16:38:54 -0700")
Message-ID: <xmqqmuuqsxf2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The magic 100 blames back to our chief magician, Junio:
>
>     8ac65937d0 Make sure we do not write bogus reflog entries. (2007-01-26)

Yup, guilty as charged.

cf. <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>

    "%s %s %s\n" with old and new commit object name and the message
    will be "2 * len(hash_in_hex) + 4" bytes long (counting the three
    whitespaces and the terminating NUL), and Shawn's original in
    6de08ae6 ("Log ref updates to logs/refs/<ref>", 2006-05-17) actually
    computed this one as "strlen(...) + 2*40+4".

    100 was merely me being sloppier than Shawn at 8ac65937 ("Make sure
    we do not write bogus reflog entries.", 2007-01-26), preferring
    being sufficient over not wasting even a single byte.
