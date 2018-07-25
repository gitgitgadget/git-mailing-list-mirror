Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF031F597
	for <e@80x24.org>; Wed, 25 Jul 2018 16:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeGYR6Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 13:58:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbeGYR6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 13:58:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8072227wrp.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VwIkAo5N9nfRq6v/fxraWbnP4tI8fKryGpM8Pvq1k/Y=;
        b=WIARXAbue53D3GpcdsHNVjiDnV3xlRrSoy+rNVuDt07x+QPT0LOp3otNCbC13/DXLk
         SprDtKBbhGkxWqIxuRSsiA3cQQx69BWiYWB2Qpe1aIc+7IQ6qPlnmhDkeIPi1I1Pm4p1
         vRPakS5ro9VhPm9gqOI1ai9hTrq5PsRACyKJulmkbXKIAI2ElztFig1Dc9B3Va461OaS
         duHE3jVQfwOb2D4gPuqwuee/JDCG8fUyDQuk/DedyBPyxT1VO/UA+0O+fmM9QmvNzFpi
         Fg+P6CowfiZPKZBbZW4gOYwJHQyaGnSdeD/HM/gp7LpCA33TVRDQe+lBKXT0ZLIrUMMQ
         1m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VwIkAo5N9nfRq6v/fxraWbnP4tI8fKryGpM8Pvq1k/Y=;
        b=PBc5Dbu1sp3N+VjPVlGQO2TOLoZfseeuNunAwnTyMtjgzxffxZDsbM46pXeL1vyyPb
         tajg+bWnDLrtsU6Mk4pRmpirGryc6lgjrAWFWPAaf6t123VPt44472OlD4YTIijlHXxa
         JsG2pqL+QBuweEaLkvTavl67QaTRrv7NWw27O0N1x06AnwStLTQHigBV+03nPiZcgrya
         lwoyppjXdmLz6PxeBP8Qo/oFiEN4jBXqcNcqSeoqJq60UWhG9hbmyl+g89PjOs+k8/1M
         uXxai84E3soplblN2GAW8ZCpkDLBOwkwT6gbuTH5HeSMHLvb9nQOrUj+VNWpth2oA1wY
         f4eQ==
X-Gm-Message-State: AOUpUlG7C09WZbP6cKkHo0V7M8BkM13I0kvpe6UOx8xifg/SvJvCh5eu
        +pfRRH5/ngYznkr2LcPuCPo=
X-Google-Smtp-Source: AAOMgpdTTcnnPo2PB8Nq8xABzn8m1nQYsCWXlOzvPWpNueIDnuNY4E4FKAkAKjzkPDlSb8+vhO4XCA==
X-Received: by 2002:a5d:5043:: with SMTP id h3-v6mr14439438wrt.186.1532537154443;
        Wed, 25 Jul 2018 09:45:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e12-v6sm9228056wru.89.2018.07.25.09.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:45:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH 2/2] doc hash-function-transition: pick SHA-256 as NewHash
References: <20180725083024.16131-1-avarab@gmail.com>
        <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
        <20180725083024.16131-3-avarab@gmail.com>
Date:   Wed, 25 Jul 2018 09:45:52 -0700
In-Reply-To: <20180725083024.16131-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 25 Jul 2018 08:30:24 +0000")
Message-ID: <xmqq4lgnw9fj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> @@ -125,19 +122,19 @@ Detailed Design
>  ---------------
>  Repository format extension
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -A NewHash repository uses repository format version `1` (see
> +A SHA-256 repository uses repository format version `1` (see
>  Documentation/technical/repository-version.txt) with extensions
>  `objectFormat` and `compatObjectFormat`:
>  
>  	[core]
>  		repositoryFormatVersion = 1
>  	[extensions]
> -		objectFormat = newhash
> +		objectFormat = sha256
>  		compatObjectFormat = sha1

Whenever we said SHA1, somebody came and told us that the name of
the hash is SHA-1 (with dash).  Would we be nitpicker-prone in the
same way with "sha256" here?

> @@ -155,36 +152,36 @@ repository extensions.
>  Object names
>  ~~~~~~~~~~~~
>  Objects can be named by their 40 hexadecimal digit sha1-name or 64
> -hexadecimal digit newhash-name, plus names derived from those (see
> +hexadecimal digit sha256-name, plus names derived from those (see
>  gitrevisions(7)).

Seeing this hunk makes me respond to the above question with another
question: "having to write sha-256-name, sha-1-name, gpgsig-sha-256,
and sha-256-content is sort of ugly, no?"

I guess names with two dashes are not _too_ bad, so I dunno.

>  Selection of a New Hash
>  -----------------------
> @@ -611,6 +608,10 @@ collisions in 2^69 operations. In August they published details.
>  Luckily, no practical demonstrations of a collision in full SHA-1 were
>  published until 10 years later, in 2017.
>  
> +It was decided that Git needed to transition to a new hash
> +function. Initially no decision was made as to what function this was,
> +the "NewHash" placeholder name was picked to describe it.
> +
>  The hash function NewHash to replace SHA-1 should be stronger than
>  SHA-1 was: we would like it to be trustworthy and useful in practice
>  for at least 10 years.

This sentence needs a bit of updating to match the new paragraph
inserted above.  "should be stronger" is something said by those
who are still looking for one and/or trying to decide.  Perhaps
something like this?

	...
	the "NewHash" placeholder name was used to describe it.

	We wanted to choose a hash function to replace SHA-1 that is
	stronger than SHA-1 was, and would like it to be trustworthy
	and useful in practice for at least 10 years.

	Some other relevant properties we wanted in NewHash are:

> @@ -630,14 +631,19 @@ Some other relevant properties:
>  4. As a tiebreaker, the hash should be fast to compute (fortunately
>     many contenders are faster than SHA-1).
>  
> -Some hashes under consideration are SHA-256, SHA-512/256, SHA-256x16,
> +Some hashes under consideration were SHA-256, SHA-512/256, SHA-256x16,
>  K12, and BLAKE2bp-256.
>  
> +Eventually in July 2018 SHA-256 was chosen to be the NewHash. See the
> +thread starting at <20180609224913.GC38834@genre.crustytoothpaste.net>
> +for the discussion
> +(https://public-inbox.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/)
> +

