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
	by dcvr.yhbt.net (Postfix) with ESMTP id 304201F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbeHWSuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:50:14 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33710 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbeHWSuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:50:14 -0400
Received: by mail-ed1-f49.google.com with SMTP id h9-v6so3876477edr.0
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rWcJru1hwG4LU58oLvp0yPnBhVQnVje71QK9oHbkfJM=;
        b=JCK5EXIfnQ2qupoKqx87vuPksRQ9W3Zau+PnkRIyiqONFcsMJXOJwrfJ75Qjq8wjby
         4DOm0OWsmQhcJ/5voG/FFY0RP/F4Tj2QpnejlXG+X02U97oyibRjSjgqqtb6m4rE2/Yn
         C6u/vEigHkulxKkYruu8XjslyUs1x/QyIGaXsuSXVQJkroIvI1OQwpAbSVDUHoOP3VUk
         Ipu3CYeliMmXDqjjRVa5yeA5ok8sh/Mhdm5k6XtEJOYNZrHe/bC08CgP4GAo96xQB5GJ
         p/mccUDPx0PIqJbfNksG/xLoWaUkc3f7EGQGaQ7bWPTa+sR2jJEcmNiutQi7XzDgB8s3
         a69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rWcJru1hwG4LU58oLvp0yPnBhVQnVje71QK9oHbkfJM=;
        b=tSLjNO1HS/HfYNUOaHty0+9goHQ6pIhFocNw1oaPpfPCH7B5NYYJIpS79aGqQDtmkC
         IFnPdat5lnNDezKQuQgGdGmz3El1xPdQN2GExGdFQKJcpbLqV7rQXmKLu7JiRbYVTUyC
         d9h81RQCvYzIxmBUo9AjWqbA5eabSGDO1oZC4zjNeL/op8QyourXRuMQ3yv+M05lq3tm
         QyiEEHImi47P72Kbmx6gkB8+YBY60XljMo6fqjYz8/FRLYvXh2Vn9tjddVdWDx1AjcIz
         gpsdAGbdXLKH+a5f4NXkbvnpQByJIePcOPJ2LyUP0C0FsdI9OL66eRV24LdvbZMmS50y
         H99w==
X-Gm-Message-State: AOUpUlF2ndSQYjphS9dLwn6t7irMt6zUIgqJ+X0Qg5lVEM+cv0NZXp4m
        jVQjoMvLLD73pqwSD+eiKEo=
X-Google-Smtp-Source: AA+uWPz/BKyj+kkrIT9s7oA+SH4PtmVtiuls01kc95wx9YAmcNSRKCqpdsSuAdCDwxg1/Y4RbA0hAA==
X-Received: by 2002:a50:f69b:: with SMTP id d27-v6mr27096307edn.103.1535037606120;
        Thu, 23 Aug 2018 08:20:06 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id q24-v6sm2273678edd.73.2018.08.23.08.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 08:20:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
References: <878t4xfaes.fsf@evledraar.gmail.com> <xmqqy3cxjgz1.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqy3cxjgz1.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 23 Aug 2018 17:20:04 +0200
Message-ID: <876001f6u3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 23 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> - The trailer consists of the following:
>>>   - A copy of the 20-byte SHA-256 checksum at the end of the
>>>     corresponding packfile.
>>>
>>>   - 20-byte SHA-256 checksum of all of the above.
>>
>> We need to update both of these to 32 byte, right? Or are we planning to
>> truncate the checksums?
>
> https://public-inbox.org/git/CA+55aFwc7UQ61EbNJ36pFU_aBCXGya4JuT-TvpPJ21hKhRengQ@mail.gmail.com/

Thanks.

Yeah for this checksum purpose even 10 or 5 characters would do, but
since we'll need a new pack format anyway for SHA-256 why not just use
the full length of the SHA-256 here? We're using the full length of the
SHA-1.

I don't see it mattering for security / corruption detection purposes,
but just to avoid confusion. We'll have this one place left where
something looks like a SHA-1, but is actually a trunctated SHA-256.
