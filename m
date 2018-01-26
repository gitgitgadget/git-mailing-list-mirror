Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6D61F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeAZTUG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:20:06 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35346 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeAZTUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:20:03 -0500
Received: by mail-ua0-f194.google.com with SMTP id x33so969550uac.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1umYs29Mh8I9iz38y5AY7phwteZW2xUUzs/n7luByYE=;
        b=p1WWq8d/bMZo4BVMeehgcwhTGhuciGmdKAeGCZ9D1nLrHMCcSJokiX0T7A5xblzTHN
         H+kfdAqBS4oJoq5QPgbgc4Sq4OHuP5RX1RX9PdgaojXO+V33nP1JCwCYm6XAfpyIlYt6
         xdGy9Jd9TQUrTFt0I4d/8wHFwklg0/ws9/BfnuJZcYzpi74fyzu2a48xhS8UvRer3t2K
         WsC83lm1bbDsVrpwhbRlQq2oaAAhBaCim14r7d1EpugIbTG8JFkCM6pRFRjBNZeGmaNB
         COH0GCLo1z2oqTJnwS0G39fdrZL0ldUkgjHOKzd+E51zjZTaibjvBRdQdDQQ8kxckcgE
         lp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1umYs29Mh8I9iz38y5AY7phwteZW2xUUzs/n7luByYE=;
        b=YoTafOoY1MYnZQ5kv/mQIuXdMrINTgfJrT2fzIvWRzbA6DRUpQzKECve4iyIirQ0/F
         kqAKK7YDq9tK61vWQi+irt7o/Glw1rqmT8jGvrdZAbeeYr0b4zZES3ea8zRGYjH+Xu4I
         WQax22khmBM3EQZjo2wNLNg7ObBFz2RX3omGi01Ytl3YOz2P6wFHcrZXp1YHz8Vg8Y+I
         BimvBMMhC7iZ6hD2R1X54DCGUi2iOFgv7VcBeCrxWGBWVtSWdf2lh2ZecFmPRhl64hPd
         Wpbx/LmZlE0yp6gWLN+1KTu8xh3Rhf7mWom5JakvmYtzvY9p5dR/CwQX/peiUxCmxa42
         yseg==
X-Gm-Message-State: AKwxytdE1kPZqL3twh2M6NK0iuPPpT57+DT3PqaW4saBoIGrrE/a23Rt
        Xf9hX/JKbPUEZTFIqjCFS+dCKzlcgPtIBj9mzhI=
X-Google-Smtp-Source: AH8x227vXcrXT3VuQexIRbL2aOzknH9pmAqe4ZNk/nTAqESRUxA1E7e/5394a90fwnQC5T1KlVAyoXBhlhLJsrDarbk=
X-Received: by 10.176.76.43 with SMTP id l43mr10741420uaf.93.1516994402998;
 Fri, 26 Jan 2018 11:20:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 26 Jan 2018 11:20:02 -0800 (PST)
In-Reply-To: <xmqqa7x08p0e.fsf@gitster.mtv.corp.google.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-6-szeder.dev@gmail.com>
 <xmqqa7x08p0e.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 20:20:02 +0100
Message-ID: <CAM0VKjm0uveCRpNy8H+inwTKa6fzHAjGn=f9tmQ4p1MCWGuirQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] t5510: consolidate 'grep' and 'test_i18ngrep' patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> One of the tests in 't5510-fetch.sh' checks the output of 'git fetch'
>> using 'test_i18ngrep', and while doing so it prefilters the output
>> with 'grep' before piping the result into 'test_i18ngrep'.
>>
>> This prefiltering is unnecessary, with the appropriate pattern
>> 'test_i18ngrep' can do it all by itself.  Furthermore, piping data
>> into 'test_i18ngrep' will interfere with the linting that will be
>> added in a later patch.
>
> It is very likely that the prefiltering "grep" will not even see
> what it is looking for under GETTEXT_POISON build in the first
> place, so this conversion is the right thing to do from that point
> of view as well.

No, GETTEXT_POISON only affects the translated messages, but those
'grep' invocations looked only at refnames and formatting.

This is the GETTEXT_POISON-ed output of 'git fetch' in that test
(probably will get line-wrapped):

# GETTEXT POISON # * # GETTEXT POISON # descriptive-branch ->
refs/crazyheads/descriptive-branch
 * # GETTEXT POISON # refs/others/crazy  -> crazy
 * # GETTEXT POISON # descriptive-tag    -> descriptive-tag


>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  t/t5510-fetch.sh | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 668c54be4..3debc87d4 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -222,12 +222,9 @@ test_expect_success 'fetch uses remote ref names to=
 describe new refs' '
>>       (
>>               cd descriptive &&
>>               git fetch o 2>actual &&
>> -             grep " -> refs/crazyheads/descriptive-branch$" actual |
>> -             test_i18ngrep "new branch" &&
>> -             grep " -> descriptive-tag$" actual |
>> -             test_i18ngrep "new tag" &&
>> -             grep " -> crazy$" actual |
>> -             test_i18ngrep "new ref"
>> +             test_i18ngrep "new branch.* -> refs/crazyheads/descriptive=
-branch$" actual &&
>> +             test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
>> +             test_i18ngrep "new ref.* -> crazy$" actual
>>       ) &&
>>       git checkout master
>>  '
