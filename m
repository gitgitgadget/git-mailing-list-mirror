Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390351F453
	for <e@80x24.org>; Sat,  3 Nov 2018 17:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeKDCjV (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 22:39:21 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43601 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKDCjU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 22:39:20 -0400
Received: by mail-wr1-f48.google.com with SMTP id y3-v6so4753253wrh.10
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=BwYdYOLKDhXVL+CAz5IAJZrFCuIwL/67zpjn/5Phm3c=;
        b=DnkXAmROJhgiXRoiK4nRse3b030ChvG+bCIdQJix8UgcFHiI0QJWuNS1ABFAWY2l5P
         K5u9LRUwQBs+lrzFHVY1sl/F9V4gY9nG8Fu9CY1aoC/SbtiXhMTvp7MoKy3YFnGepyHH
         2IPS2cWOT9fDLKZY+zUpfZFPpEjybytBjf4JqmWqPQwjji+lUdvVeO22sTMPMYnXZegb
         kS0je3PxmUIF25ZLGQymaK6wq8iox1ZiVvo+45XwO6TZUABRC2LJmOpCIs7TD3QjDlZZ
         tmbjbogGi5DF5alk4QjLbgb4ZHHtjV+kn+3QGG+4l11S4leK/2Ukji+tqJWd6B69J4WL
         jvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BwYdYOLKDhXVL+CAz5IAJZrFCuIwL/67zpjn/5Phm3c=;
        b=LnVngdWrrcAI9n1e1i0LN8AEvZGFu6pK8X+cHsgfmYOwM65nuRWO/3dKmS4TRD4uyW
         2qBu1Aj0Eckk7jXahIWVUVzAOEI6TVI0A5dP5uIkCXumuDX7Mrf2V9cQtBVJAyCTHqct
         KQS6FN/76Ws5fkpa6vJodWYUZ4sLZkuSVKVYR7tIaq53gcFP6dmKHv8aCqt6F9TLDY1O
         I5uLr/YACrQP3z8AECc2iMQTOTJZ4MSS2pOs82NEhjWZTQfsh6LrgBOwSy3I17n0KSwY
         +ujBGNE80LLl4RvTq7QD8KvkkU+JEnrrtBhqSR10a2FK6hUGc8qX7/XGgpbgqGntwT3O
         Iz6A==
X-Gm-Message-State: AGRZ1gLpb2lKaITohJr4OwQ2RmOcHQ6UYzhIEiY9vCItbQV/kyCm7rnD
        dZBkc876BEo3CEefVePFkxU=
X-Google-Smtp-Source: AJdET5e+43mONmF3cuRvmYYyfEVUsH2i2usZwbhF0KGu3lLiOsgpbB9Ry5dNpCcYsL4/iQd9WQh4HQ==
X-Received: by 2002:adf:a31c:: with SMTP id c28-v6mr14190575wrb.195.1541266046252;
        Sat, 03 Nov 2018 10:27:26 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egr209.neoplus.adsl.tpnet.pl. [83.21.81.209])
        by smtp.gmail.com with ESMTPSA id y13-v6sm55483wrq.13.2018.11.03.10.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 10:27:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
        <86tvl0zhos.fsf@gmail.com> <86ftwjzv1h.fsf@gmail.com>
Date:   Sat, 03 Nov 2018 18:27:22 +0100
Message-ID: <86r2g2ul51.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Stefan Beller <sbeller@google.com> writes:
> [...]
>>> How would this impact creation of a commit?
>>>
>>> The current generation numbers can be lazily updated or not
>>> updated at all. In my understanding of the maximum generation
>>> numbers, a new commit would make these maximum generation
>>> numbers invalid (i.e. they have to be recomputed).
> [...]
>>> For the V2 maximum generation numbers, would we need to
>>> rewrite the numbers for all commits once we recompute them?
>>> Assuming that is true, it sounds like the benchmark doesn't
>>> cover the whole costs associated with V2, which is why the
>>> exceptional performance can be explained.
>>
>> Let's check it using a simple example
>>
>> First, (minimum) parent-based generation numbers before and after
>> extending the commit graph:
>>
>>   1   2     3   4     5   6   7    new
>>   1   2     3   4     5   -   -    old
>>   .---.-----.---.-----.---*---*
>>        \
>>         \   3   4     5   6        new
>>          \  3   4     5   6        old
>>           \-.---.-----.---.
>>                  \
>>                   \   5            new
>>                    \  -            old
>>                     \-*
>
> Let me check yet another idea, using (minimum) parent-based V0 generation
> numbers (counting distance from the sink / root) as a starting number
> for source / heads commits.
[...]

> [...] but let's check another example
>
>    1   2     3   4   5   6     7   8   9       new
>    1   2     3   4   5   6     7   8   -       old
>    .---.-----.---.---.---.-----.---.---*
>         \                     /
>          \   3   4           / 5   6   7   8   new
>           \  5   6          /  -   -   -   -   old
>            \-.---.---------/---*---*---*---*

But let's do this correctly.


   1   2     3   4      5   6     7   8   9      new
   1   2     3   4      5   6     7   8   -      old
   .---.-----.---.------.---.-----.---.---*
        \                        /
         \   3   4              /                new
          \  5   6             /                 old
           \-.---.------------/
                  \
                   \    5   6     7   8          new
                    \   -   -     -   -          old
                     \--*---*-----*---*

Well, it looks as if I draw it incorrectly, but performed calculations
right.  You may need to modify / change some data, but it looks as if it
is not that much of a problem.

The new version of the maximum generation numbers looks like it gives
the same results as generation numbers for the "longest" path, and
update may affect only the side-branches that were added to.  All
branches merged into the trunk, and not added to should be safe with
respect to updating.

Can anyone here prove a thing about update of those modified maximum
generation numbers?  Thanks in advance.

Best,
--=20
Jakub Nar=C4=99bski
