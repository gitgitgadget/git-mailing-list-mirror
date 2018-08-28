Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A531F404
	for <e@80x24.org>; Tue, 28 Aug 2018 15:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH1TiA (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 15:38:00 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38142 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeH1Th7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 15:37:59 -0400
Received: by mail-wr1-f48.google.com with SMTP id w11-v6so2036633wrc.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NetsV5bl7ZCtl3MShB8GfCDU6w92Nyp3Oj53nm+58C8=;
        b=leya0w/kL1JZNftZ01Tx+bLIO9kTjmkx4EgIe2ct4QPoiMAL2q4ndY6ZfAciMTFNiV
         fCrKANdrvfJMfUsN7/goen9Up1yU4tzHJNS6yBLEkryer/dHK8PVM88da0ikn0z77M2S
         9VPm+oPa/7JUvo4AKxRivTVZg+R3E6twBWgncAdEDaP7Gx7yKa5+jStuUap5nGlk2PyR
         Qijub9R+cf9Fdz0pOx9yDYu2P966MrFT5zO+lxxCt7cL0qcEVg2UjFrEO2SNGbXXv00H
         UPAWo53+Xy/ajFjhViQ9l2PPAtU7xW4U1Sfpz5OP/0ifA0YTDguzFhjdm0y0F0f1/lkJ
         8ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NetsV5bl7ZCtl3MShB8GfCDU6w92Nyp3Oj53nm+58C8=;
        b=DI4i2S/zfB1mA5ZVFOd3U/+ZCG8+MDIDm1SOAqGwNkauB8OUVJS7lt8xckym1k1pe+
         xLa8FnLlMq65ZRHiSRb7RqHNSgK/0r3OY1IldDg8xHCgAlt0PlgqElP3dkkl+6CTKCDg
         8tu7ilOviBgWVdJZ7DZY5ITu3Nd5fbIjZYuCpc5+bADrGGlLyfK8C+R6QexBHNYuvzF0
         ZpFWrdgHVegdRb1YU/RfgDxswLeTCimrLOjP2oHVj5iRi1dPgvuj2PQYXzKkcE0DX8bA
         Vwarjz9gS1yP2Gp7KMu2C/CPqBbx2aHl8aGSsCsO7dxEVZiE7r0Ztu/+40C8K19gafda
         y39A==
X-Gm-Message-State: APzg51A3Ge1VbObr1UbEZrqH9QRG/yQPpYqVn6v2h+Z8it2cIKrKFOn9
        HKq7jIlzaCCttf4siyK6mZg=
X-Google-Smtp-Source: ANB0VdYNOUtknHZ2Yr/vKPE2faw3gmdBwQLc/Q6SE5R9CA8bHdedgH/vzuJWTDATwtrFIVmPSllxew==
X-Received: by 2002:adf:b357:: with SMTP id k23-v6mr1623404wrd.207.1535471143546;
        Tue, 28 Aug 2018 08:45:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2767181wmf.34.2018.08.28.08.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 08:45:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
References: <878t4xfaes.fsf@evledraar.gmail.com>
        <87h8jeeh2e.fsf@evledraar.gmail.com>
        <CA+WKDT1k1SpHQmUKunV+vC+VLBfTBjZBgw+n4NeTE=oKxWL-Sg@mail.gmail.com>
Date:   Tue, 28 Aug 2018 08:45:42 -0700
In-Reply-To: <CA+WKDT1k1SpHQmUKunV+vC+VLBfTBjZBgw+n4NeTE=oKxWL-Sg@mail.gmail.com>
        (Edward Thomson's message of "Tue, 28 Aug 2018 15:15:35 +0100")
Message-ID: <xmqqzhx6h4ux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edward Thomson <ethomson@edwardthomson.com> writes:

> If I'm understanding you correctly, then on the libgit2 side, I'm very much
> opposed to this proposal.  We never execute commands, nor do I want to start
> thinking that we can do so arbitrarily.  We run in environments where that's
> a non-starter
>
> At present, in libgit2, users can provide their own mechanism for running
> clean/smudge filters.  But hash transformation / compatibility is going to
> be a crucial compatibility component.  So this is not something that we
> could simply opt out of or require users to implement themselves.

While I suspect the "apparent flexibility" does not equal to "we
must be able to run arbitrary external programs" in the proposal, I
do agree that hash transformation MUST NOT be configurable like
this.  We do not want to add random source of incompatible mappings
when there is no need to introduce confusion.

If old object names under old hash users find in log messages and
other places need to be easily looked up in a repository that has
been converted, then:

 (1) get_sha1() equivalent in the new world should learn to fall
     back to use old hash when there is no object with that name
     under new hash;

 (2) in addition to the above fallback, there should be a syntax to
     explicitly tell that function that it is using the old hash;

 (3) get_commit_buffer() should learn to optionally allow converting
     old hash in log messages to new ones, in a way similar to how
     textconv filter can be specified by the end-users to make
     binary blob easier to grok by text-based tools (the important
     part is that such a filter does not have to be limited to
     "upgrade hash algorithm"---it can be more general "correct
     misspelt words automatically" filter).

With 1+2, you can say "git log $sha1" and also "git log sha1:$sha1"
to disambiguate.  3 would be icing on the cake.
