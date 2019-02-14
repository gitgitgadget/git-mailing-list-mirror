Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D8E1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436468AbfBNVP5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:15:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38522 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392645AbfBNVP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:15:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so7529895wmh.3
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tXFI2k29MLsWHcJcEcfccXwQgnNAVzlV+RTjnKArcvU=;
        b=cRBSGEIc2uEheMEDpYWEEzGnxBbR+863L7uruV07IL4kPEZPagKntKhSCwW85mRiBs
         25BUfa/NgkHW8BPioRYdyLuY4yxkET/hskBMbOKHju8ulNzQopwCksHtPFccfAUh+UDU
         Pl6hSNnZ6GVqCwH8mRMkkuqZKaIv200BWaLb63jjkB7on1o8yygsexwBmQCwKY47Qc25
         VEulB9PedYMNLkljndUVQmWRKK9jUd9JotPevygIOpgW2ve3neLfOu0BdDHNq6w3WUsE
         59OIpqU5FHLsshqWXl9HxFS0/jJ8UvGPoKtNuwFEbbZk1uHFuM39/rXaegP342dy3o6M
         eOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tXFI2k29MLsWHcJcEcfccXwQgnNAVzlV+RTjnKArcvU=;
        b=IVQX6laU2bZoXZ66pCVYeLoUFuKhFgUb34OqTO7PxBLHR6UFlXFpHNccKnQj04DFAm
         obKYNn1Rv9rRdUvRXh8j8VdiTufQBIIU/HEbeC932FXS4w2O/5ksCQVz3wBA4cn2/BF0
         JbU2weRwakhKhaEFFN4329fxwsx5w8uqPMh4u8NEObO+jTANzKoNWC2qw8qsrgD6pxdW
         0oQsX3rBAH9KdsJIY6OCevW+tNTzT+hvxJhSrzcYBATp0/wtkXc1aPX+SAzzcG1SWGkp
         EznU7lHskwIDKWCM0a1h/9qV+NhwPHJribDmK6uuH56eAip/79FGTaORD+sbRjTg7f8Z
         5Mpg==
X-Gm-Message-State: AHQUAua19bz8XYsp//kGMtgJersTrMZ8WvXhXXtsYtfjQQg47l3lM+bb
        6C7bMMUike8zKZX8xqPykurVGGW9
X-Google-Smtp-Source: AHgI3IYa5CCoWO0tMqi7V+4ATJuEzt47/TIvjp5O3Zt7tjOEy1OJFZC8eCTLe+so6mU4PGBFM8658A==
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr4283564wme.82.1550178954301;
        Thu, 14 Feb 2019 13:15:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u15sm6244167wmu.17.2019.02.14.13.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 13:15:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'Duy Nguyen'" <pclouds@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
Subject: Re: Re* [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
        <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
        <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
        <20190212002705.GD13301@sigill.intra.peff.net>
        <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
        <005001d4c4a4$6af097a0$40d1c6e0$@nexbridge.com>
Date:   Thu, 14 Feb 2019 13:15:51 -0800
In-Reply-To: <005001d4c4a4$6af097a0$40d1c6e0$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 14 Feb 2019 15:32:29 -0500")
Message-ID: <xmqqva1m6ph4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On February 14, 2019 15:16, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Mon, Feb 11, 2019 at 01:07:15PM -0800, Junio C Hamano wrote:
>> >
>> >> >> test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File
>> >> >> exists" err
>> >> >
>> >> > The message does not match, does it? Here we grep for "File exists"
>> >> > but the message you showed says "File already exists".
>> >>
>> >> Hmph, this is from strerror(), right?
>> >>
>> >> The question is if we should be using grep to match on strerror()
>> >> result in the C locale.
>> >
>> > Yeah, I agree that's questionable. And I'm mildly surprised it hasn't
>> > been a problem before now.
>> >
>> >> Do we really care that the reason of the failure is due to EEXIST for
>> >> this particular test?
>> >
>> > Hmm. We care to _some_ degree, since that's the condition we set up
>> > for making sure that update-ref cannot take the lock. But it would
>> > probably be fine to just confirm that we failed to take the lock. And
>> > there, checking for just "Unable to create $Q.*packed-refs.lock" would
>> > be sufficient.
>> 
>> Yup.
>> 
>> As this came from 6a2a7736 ("t1404: demonstrate two problems with
>> reference transactions", 2017-09-08), that is as old as Git 2.15, I'd
> throw it
>> into "not so urgent" pile.
>> 
>> -- >8 --
>> Subject: [PATCH] t1404: do not rely on the exact phrasing of strerror()
>> 
>> Not even in C locale, it is wrong to expect that the exact phrasing "File
>> exists" is used to show EEXIST.
>> 
>> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
>> Helped-by: Duy Nguyen <pclouds@gmail.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>     I've grepped in t/ directory for the exact phrases of all errno on a
>>     recent Debian box, and this was the only hit it found.  There
>>     are two other hits but both in the comments.
>> 
>>  t/t1404-update-ref-errors.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index
>> 51a4f4c0ac..f95a64c911 100755
>> --- a/t/t1404-update-ref-errors.sh
>> +++ b/t/t1404-update-ref-errors.sh
>> @@ -614,7 +614,7 @@ test_expect_success 'delete fails cleanly if packed-
>> refs file is locked' '
>>  	test_when_finished "rm -f .git/packed-refs.lock" &&
>>  	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
>>  	git for-each-ref $prefix >actual &&
>> -	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists"
>> err &&
>> +	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q:" err &&
>>  	test_cmp unchanged actual
>>  '
>
> This passes on NonStop. Thanks.
>
> Randall

Thanks.
