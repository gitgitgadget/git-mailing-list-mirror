Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA77A1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 19:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbeG0VI6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 17:08:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35389 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389162AbeG0VI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 17:08:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so6711398wmc.0
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IUgqZopgGe6UgQ5uPVxfH1HvcQMADHXE6Nd15SNJsl4=;
        b=DSkyNFx9DitlxZ4gFj5UCa8zu9hg5L0wV3O5yWUC3iTja04IPgl2H979+5dsEj80zt
         D0VWHf0mwy2IvEjWOFgoj7/aGRn5TR69ZHhnJvdHu1q0BLEcgZntZzYRgMsOv2DBOrev
         3DG8OZiiGvCA4hfqgnup76XFM2x2PAuRM7xosAjXk/A/StVYre2ABRzUDKSgebz+J33U
         Xj05UbdPn11kFmGtIVxSA1UHaaj2d3L7+ak/WpGbv8xP4tMBh4w6+JW3G+HsZLJaD5u7
         VK8m6k58kanSB7i6CkjEDmxC3+LuxgMzK9UuZM5cF7QESX4gEqSjLjyXodohw1+CANPD
         UghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=IUgqZopgGe6UgQ5uPVxfH1HvcQMADHXE6Nd15SNJsl4=;
        b=pXKfApOd3BnDuU0LlNCjK+PR3teiF//LvA/ojmi8HTlKiPN3cqbawM46M0zOnSQf6d
         //YIDt4vYpG80oH67hr3RQ0MRZFUFiM+parB4WsZKJ2Lgb/VO1nunDJugs71kK8bV2Ob
         H1XFVMzgRr79GEBoWY39tWAVK6Ip7vJObrUgTxWEgIr7+JJtQXnq35+cnoJ257ujFFrZ
         rqYNDJN//d/G7ntC0kmnpwMpHA8lC2Pwn7n+p5Ua+5kc9dCGN7zADkO/NWLYK7mqzAZN
         /clyzxztCeixTAjuKVH8jMY+FwsQpfEfaAKYT5mHqQUNrUwVn6hpUQhFqrxUWOxN4FrW
         rmdA==
X-Gm-Message-State: AOUpUlGdETj5ZftsG3c/0vsJebLo5hQwsCtmf+I3NhhnHBmYBv0aPCr0
        W1A5+2Iv4Pe0jtl8B4Z3yN0vlbR+XmY=
X-Google-Smtp-Source: AAOMgpdKE1kjrdMg8miE8UzPIh8Jxb9W6lw/ZKjq8URVuKiI4ZYSxOeoC8p/U+ThxilTmfBZZq5w9g==
X-Received: by 2002:a1c:1c52:: with SMTP id c79-v6mr5246155wmc.147.1532720734718;
        Fri, 27 Jul 2018 12:45:34 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id u185-v6sm5855460wmg.25.2018.07.27.12.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:45:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 01/10] receive.fsck.<msg-id> tests: remove dead code
References: <20180525192811.25680-1-avarab@gmail.com> <20180727143720.14948-2-avarab@gmail.com> <xmqqva90mr2l.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqva90mr2l.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 27 Jul 2018 21:45:33 +0200
Message-ID: <87d0v85uoy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 27 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Remove the setting of a receive.fsck.badDate config variable to
>> "ignore". This was added in efaba7cc77 ("fsck: optionally ignore
>> specific fsck issues completely", 2015-06-22) but never did anything,
>> presumably it was part of some work-in-progress code that never made
>> it into git.git.
>>
>> None of these tests will emit the "invalid author/committer line - bad
>> date" warning. The dates on the commit objects we're setting up are
>> not invalid.
>
> It is a timestamp somewhere mid February of 2009.  Perhaps the code
> is playing defensive against the lack of email address on the
> deliberately broken author line, i.e.
>
>     author Bugs Bunny 1234567890 +0000
>     committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000

This is covered by the "missingEmail" part of the test, but there's
nothing wrong with the timestamp itself.

I doubt Johannes remembers why he did this almost a decade ago, but it
looks to me like he was working on some test where the date was also
bad, and never finished it. There's no point in having that "badDate"
now.

> in case the parser punted and failed to parse that timestamp
> correctly?  IOW, the above _could_ be a commit written by "Bugs
> Bunny 1234567890" with missing e-mail and missing timestamp.
>
> So I dunno.  It won't break the test with today's system if we
> removed this config, but with an updated parser from the next year,
> it may start to break.

I still think it makes sense to remove this particular thing. Let's add
exhaustive tests for all this fsck.* stuff in another series, but no
point in testing for arbitrary fsck errors that aren't going to be
triggered in unrelated tests.

>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  t/t5504-fetch-receive-strict.sh | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
>> index 49d3621a92..e1f8768094 100755
>> --- a/t/t5504-fetch-receive-strict.sh
>> +++ b/t/t5504-fetch-receive-strict.sh
>> @@ -149,8 +149,6 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
>>  	git --git-dir=dst/.git branch -D bogus &&
>>  	git --git-dir=dst/.git config --add \
>>  		receive.fsck.missingEmail ignore &&
>> -	git --git-dir=dst/.git config --add \
>> -		receive.fsck.badDate warn &&
>>  	git push --porcelain dst bogus >act 2>&1 &&
>>  	! grep "missingEmail" act
>>  '
