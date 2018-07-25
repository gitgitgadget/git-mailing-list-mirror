Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D4E1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 17:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeGYSiX (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:38:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39629 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbeGYSiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:38:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id a11-v6so1019107pgw.6
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gRsijP/zdPgWdagTyVUfXjTMGvt/dMPhMoH71hdkCpU=;
        b=ntYG0L23HENQK90nWMTUERxkrOGiCX/oKzTePNRACh+4Efdu+XS7DCJgNyv3ukpthY
         6tKIIRyCxR5FFi4xgcnG00guRxngNypYnnSLw5vFLoSXgajng294+XNlnOcDpJhSOQ74
         z+Ge8jLsgi8pU0Snc38Fk260yzFuM5mUcV/08zA9CxzDphDM3rNuUmsTu40f4UhnjyVE
         +Vwb9pLAXL0W1c0XV+7IRCPlkys9vn7rAaZIpEXolQ9nb+euEwCnXoL+iqFK1CwcHPzN
         vLU6/gY6tPwWdhrpxq4LYR/Fq1e9YS1lQBW31U/cuvQkmFxshACUuxe62kyONBlH3pzZ
         atqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gRsijP/zdPgWdagTyVUfXjTMGvt/dMPhMoH71hdkCpU=;
        b=qqRH2803edn6pDc3+S9vTlclGND7jUO1I5qFkbK3GkuxxNpw8pDWL3QJCPsAn0FKzh
         GhOBohr28Q2X+YvG0spJT3BEZGemsDLStG9vIbc9fFBCceltvvc6ZphLFwDgBj9/Gpqr
         BgBsHMMJpICRHq7i22a84ICd8RytN2BB/d+cjAGalXmH9zUaQrqdc+P9N5ibhYXep3gO
         zpzVtDmXlBL8ulwTlkHScjmgG2mV3VOsZazAb0tF8bTRwJjefrppypNWV/R8LxVymvL2
         VBkNWj6T341G61/YKiDfTTO46Am96K9dGxtlRezdtNgC6uw+0AvxLudBc3ADnxJ6IiFk
         xvkw==
X-Gm-Message-State: AOUpUlE4rz99qN6Z4mIanqAs4MbetNnMFT8Kulq1bRyN31b2wu6Lcxkt
        Bp/03xTCHkm4HYj23yFao9A=
X-Google-Smtp-Source: AAOMgpfXdB2Gji1y6Wwwvk21LDMVVgw14C54Y5HBcIfQe93sLM/N3IxbqQXIKqONACHIDWHQMqtc3A==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr20541650pgp.283.1532539544551;
        Wed, 25 Jul 2018 10:25:44 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l79-v6sm39803413pfj.179.2018.07.25.10.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:25:43 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:25:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH 2/2] doc hash-function-transition: pick SHA-256 as NewHash
Message-ID: <20180725172537.GA176329@aiede.svl.corp.google.com>
References: <20180725083024.16131-1-avarab@gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
 <20180725083024.16131-3-avarab@gmail.com>
 <xmqq4lgnw9fj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4lgnw9fj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>> The consensus on the mailing list seems to be that SHA-256 should be
>> picked as our NewHash, see the "Hash algorithm analysis" thread as of
>> [1]. Linus has come around to this choice and suggested Junio make the
>> final pick, and he's endorsed SHA-256 [3].

I think this commit message focuses too much on the development
process, in a way that makes it not necessary useful to the target
audience that would be finding it with "git blame" or "git log".  It's
also not self-contained, which makes it less useful in the same way.

In other words, the commit message should be speaking for the project,
not speaking about the project.  I would be tempted to say something as
simple as

 hash-function-transition: pick SHA-256 as NewHash

 The project has decided.

 Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

and let any Acked-bys on the message speak for themselves.
Alternatively, the commit message could include a summary of the
discussion:

 From a security perspective, it seems that SHA-256, BLAKE2, SHA3-256,
 K12, and so on are all believed to have similar security properties.
 All are good options from a security point of view.

 SHA-256 has a number of advantages:

 * It has been around for a while, is widely used, and is supported by
   just about every single crypto library (OpenSSL, mbedTLS, CryptoNG,
   SecureTransport, etc).

 * When you compare against SHA1DC, most vectorized SHA-256
   implementations are indeed faster, even without acceleration.

 * If we're doing signatures with OpenPGP (or even, I suppose, CMS),
   we're going to be using SHA-2, so it doesn't make sense to have our
   security depend on two separate algorithms when either one of them
   alone could break the security when we could just depend on one.

 So SHA-256 it is.

[...]
>> @@ -125,19 +122,19 @@ Detailed Design
>>  ---------------
>>  Repository format extension
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> -A NewHash repository uses repository format version `1` (see
>> +A SHA-256 repository uses repository format version `1` (see
>>  Documentation/technical/repository-version.txt) with extensions
>>  `objectFormat` and `compatObjectFormat`:
>>  
>>  	[core]
>>  		repositoryFormatVersion = 1
>>  	[extensions]
>> -		objectFormat = newhash
>> +		objectFormat = sha256
>>  		compatObjectFormat = sha1
>
> Whenever we said SHA1, somebody came and told us that the name of
> the hash is SHA-1 (with dash).  Would we be nitpicker-prone in the
> same way with "sha256" here?

Regardless of how we spell it in prose, I think `sha256` as an
identifier in configuration is the spelling people will expect.  For
example, gpg ("gpg --version") calls it SHA256.

[...]
>>  Selection of a New Hash
>>  -----------------------
>> @@ -611,6 +608,10 @@ collisions in 2^69 operations. In August they published details.
>>  Luckily, no practical demonstrations of a collision in full SHA-1 were
>>  published until 10 years later, in 2017.
>>  
>> +It was decided that Git needed to transition to a new hash
>> +function. Initially no decision was made as to what function this was,
>> +the "NewHash" placeholder name was picked to describe it.
>> +
>>  The hash function NewHash to replace SHA-1 should be stronger than
>>  SHA-1 was: we would like it to be trustworthy and useful in practice
>>  for at least 10 years.
>
> This sentence needs a bit of updating to match the new paragraph
> inserted above.  "should be stronger" is something said by those
> who are still looking for one and/or trying to decide.

For what it's worth, I would be in favor of modifying the section
more heavily.  For example:

 Choice of Hash
 --------------
 In early 2005, around the time that Git was written,  Xiaoyun Wang,
 Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
 collisions in 2^69 operations. In August they published details.
 Luckily, no practical demonstrations of a collision in full SHA-1 were
 published until 10 years later, in 2017.

 Git v2.13.0 and later subsequently moved to a hardened SHA-1
 implementation by default that mitigates the SHAttered attack, but
 SHA-1 is still believed to be weak.

 The hash to replace this hardened SHA-1 should be stronger than SHA-1
 was: we would like it to be trustworthy and useful in practice
 for at least 10 years.

 Some other relevant properties:

 1. A 256-bit hash (long enough to match common security practice; not
    excessively long to hurt performance and disk usage).

 2. High quality implementations should be widely available (e.g., in
    OpenSSL and Apple CommonCrypto).

 3. The hash function's properties should match Git's needs (e.g. Git
    requires collision and 2nd preimage resistance and does not require
    length extension resistance).

 4. As a tiebreaker, the hash should be fast to compute (fortunately
    many contenders are faster than SHA-1).

 We choose SHA-256.

Changes:

- retitled since the hash function has already been selected
- added some notes about sha1dc
- when discussing wide implementation availability, mentioned
  CommonCrypto too, as an example of a non-OpenSSL library that the
  libgit2 authors care about
- named which function is chosen

We could put the runners up in the "alternatives considered" section,
but I don't think there's much to say about them here so I wouldn't.

Thanks and hope that helps,
Jonathan
