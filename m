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
	by dcvr.yhbt.net (Postfix) with ESMTP id D06371F404
	for <e@80x24.org>; Wed, 29 Aug 2018 19:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeH2Xfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 19:35:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33503 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2Xfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 19:35:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id h9-v6so4800392edr.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=y4/zlZz9vUWz3SSe//4lRrPZm6YRI7uPulq9ORaajpk=;
        b=Kkk0MVIbSGEySo82f/8EDiPcgAEUYISX8vTkgTIoUWH1fElA5svXaVB+zafftar/6f
         kKrnLIYne2bJP8PRLNTtC32kU9xVRBlQVFmnas6uYFAwOovzfQsogHaCo6knWSdQMnqu
         8zZqRUzCWPuRSLnEWSuBjD2amKx47hSKuGFaABMlzbH0WS2zNH78AMd5v6r3LP8g7xyt
         QD5MNaL3yNBO1857hagH/Dcm9FuS6ry8qNcCKqN5Ca473iMCe/6NVDVrlPv8EiURhu88
         ozz9zuxDsKeWwdJmkcHztr0dus4etCIK5S+0hVY/RsI2dOaDriap7wkVVzIjL3Y9IlTC
         sVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=y4/zlZz9vUWz3SSe//4lRrPZm6YRI7uPulq9ORaajpk=;
        b=cB04gDrRZQBpqwWwMMGkk3F1o8+KHf0RLi7+ssg89eEuseQvzHvFrCD2KvXVYt3dg8
         IipcW2Vfb+FTYzZWXuooTm7937oKrPa/h3/+8e/RNFT3lmtdEDlF33XoqANxrxDz2lz1
         1or7X6vxzC4HxiaYAT1dtnFO1xuyeyfRJ6qfrYUI+9jsylvj1bzToba4T/hbrgfJI0RE
         wkAPmVD83wNoYsFWEksW+zy9UlxEHYh1/0uf5ufwSFgxG64JHx/GF+ZQ5C1SUIIM87Yg
         T0wHpzEVpDK+zOyeR6KvZeustkmSfyh7PSFQTHXcCPGcpJ0wQP+bFuEH3JUpV6gZQuIR
         fSGg==
X-Gm-Message-State: APzg51Ctb1yPSdfn2p7CDriHCaUL/a41qtHQhe5nZOGjqMX6Xopz+nEe
        HGKmrLNvdrde0V47D/+ZYsfpeHceo0Y=
X-Google-Smtp-Source: ANB0VdZ4U1GnKt67BMu7IH1iCKVu2DyZagxcVUgG0Grnb4vRiFo3D1rWT0suZSxJC3oBizK5nMCyBA==
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr8937013eda.33.1535571448749;
        Wed, 29 Aug 2018 12:37:28 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x48-v6sm2639881edm.18.2018.08.29.12.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 12:37:27 -0700 (PDT)
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
        <87zhx5c8wo.fsf@evledraar.gmail.com>
        <20180829191232.GC7547@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180829191232.GC7547@aiede.svl.corp.google.com>
Date:   Wed, 29 Aug 2018 21:37:26 +0200
Message-ID: <87y3cpc6bt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 29 2018, Jonathan Nieder wrote:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Aug 29 2018, Jonathan Nieder wrote:
>
>>> what objects would you expect the following to refer to?
>>>
>>>   abcdabcd^{sha1}
>>>   abcdabcd^{sha256}
>>>   ef01ef01^{sha1}
>>>   ef01ef01^{sha256}
>>
>> I still can't really make any sense of why anyone would even want #2 as
>> described above, but for this third case I think we should do this:
>>
>>     abcdabcd^{sha1}   = abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
>>     abcdabcd^{sha256} = ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>>     ef01ef01^{sha1}   = ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>>     ef01ef01^{sha256} = abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd...
>>
>> I.e. a really useful thing about this peel syntax is that it's
>> forgiving, and will try to optimistically look up what you want.
>
> Sorry, I'm still not understanding.
>
> I am not attached to any particular syntax, but what I really want is
> the following:
>
> 	Someone who only uses SHA-256 sent me the commit id
> 	abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd... out of band.
> 	Show me that commit.

This is reasonable.

> 	I don't care what object id you show me when you show that
> 	commit.  If I pass --output-format=sha1, then that means I
> 	care, and show me the SHA-1.
>
> In other words, I want the input format and output format completely
> decoupled.  If I pass ^{sha1}, I am indicating the input format.  To
> specify the output format, I'd use --output-format instead.

This is also a reasonable thing to want, but I don't see how it can be
sensibly squared with the existing peel syntax.

The peel syntax <thing>^{commit} doesn't mean <thing> is a commit, it
means that thing might be some thing (commit, tag), and it should be
(recursively if needed) *resolved* as the thing on the RHS.

So to be consistent <thing>^{sha1} shouldn't mean <thing> is SHA-1, but
that I want a SHA-1 out of <thing>.

> That lets me mix both hash functions in my input:
>
> 	git --output-format=sha256 diff abcdabcd^{sha1} abcdabcd^{sha256}

Presumably you mean something like:

     git diff-tree --raw -r -p bcdabcd^{sha1} abcdabcd^{sha256}

I.e. we don't show any sort of SHAs in diff output, so what would this
--output-format=sha256 mean?

> I learned about these two commits out of band from different users,
> one who only uses SHA-1 and the other who only uses SHA-256.

I think for those cases we would just support:

     git diff-tree --raw -r -p bcdabcd abcdabcd

I.e. there's no need to specify the hash type, unless the two happen to
be ambiguous, but yeah, if that's the case we'd need to peel them (or
supply more hexdigits).

> In other words:
>
> [...]
>> Similarly, I think it would be very useful if we just make this work:
>>
>>     git rev-parse $some_hash^{sha256}^{commit}
>>
>> And not care whether $some_hash is SHA-1 or SHA-256, if it's the former
>> we'd consult the SHA-1 <-> SHA-256 lookup table and go from there, and
>> always return a useful value.
>
> The opposite of this. :)

Can you elaborate on that? What do you think that should do? Return an
error if $some_hash is SHA-1, even though we have a $some_hash =
$some_hash_256 mapping?

I.e. if I'm using this in a script I'd need:

    if x = git rev-parse $some_hash^{sha256}^{commit}
        hash = x
    elsif x = git rev-parse $some_hash^{sha1}^{commit}
        hash = x
    endif

As opposed to the thing I'm saying is the redeeming quality of the peel
syntax:

    hash = git rev-parse $some_hash^{sha256}^{commit}
