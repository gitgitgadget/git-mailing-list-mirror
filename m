Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F87E1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDXWhx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:37:53 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:40122 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeDXWhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:37:52 -0400
Received: by mail-yb0-f171.google.com with SMTP id c10-v6so7557283ybn.7
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GZtnOREU9kz3xG/C3LgZSVW6coth6LnbT1tajUjhECE=;
        b=AhCx27hxTrPg8XxsC9fAcv51AEC35b4SfE8Bv0IE7/9jC9r54/2z4sT0vtJNeXtYq4
         ToCYm7FVnQjCFyYV01WjbdUnwAZhUJU5VXYHQuE6+zW4Tjrz48ZoDV5Pb0ZWZmDjKNPT
         6n0HMgJ8LzDIWFzWsrpvOa3JGYeFMff6+8jj0g6nFlmA3GFbdQ5INm1O2HASxrFEoU/B
         eA1jwaWcxO2iHfLxZURC3xGt98joVAaXSq3U7eb5oZzhGN63m9LJaJz6Gg1QrTn9eVyi
         MXdRcCnosiaSQj6lg9ERB1DlfXzB1PplVDaaEZ7LLDm4utvsmxaGtTgme+LZWW9LmTqo
         mQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GZtnOREU9kz3xG/C3LgZSVW6coth6LnbT1tajUjhECE=;
        b=CpRdkHCfCYwKSATc9POvSuTj/L2MNgRBe3/VLnFZNq1Q0isjsGd0i+8GxUyh0uL42Z
         zIawBMECU5xYbLzlCZ7oHjv/bO3dpUnYBEBwbg4y9m4BoS72qjre1abqtQZ3YiB7VftH
         tDPeEYw41KQBLrDayh2MBaDD8ZIMIlQJ/NPbWR8wwuS+mafH35cPpS2KPioXNIyp4L0v
         nctcX3At77tpAOPrvLNst6vQ2IFuqPOLP9xcmaH1e9sZg0bb+Eka5BCu49EksBAO6JM2
         5O53RZ60WzQRmIf5lrEozi25I7yODaOuElY+oyQ1CTPbYZI9Er9nlPqdE7iY7OADlDEX
         13nA==
X-Gm-Message-State: ALQs6tDMvsiv4ADfkIM0ln+5U5pHt1LmGJJQ6bS8vsa5uvVpICUujMj7
        4tozMZGJG6R7tod7pTFR/IdlDSYVqIdn7lJTnvPoDA==
X-Google-Smtp-Source: AIpwx4/jZLwiKon/oYt7YhZbsQcr+itzJ9fQ0IFpbPuFEHlp7ZM0M1LUpqpTrMWyecEjrd6SlO2LI50RF+1il+ZKXSA=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr13721271ywe.500.1524609471525;
 Tue, 24 Apr 2018 15:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 15:37:51
 -0700 (PDT)
In-Reply-To: <20180424145050.e0ad29d4f304216441656057@google.com>
References: <20180424210330.87861-1-sbeller@google.com> <20180424210330.87861-6-sbeller@google.com>
 <20180424145050.e0ad29d4f304216441656057@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Apr 2018 15:37:51 -0700
Message-ID: <CAGZ79ka9Tdk=ijbw6Hyxs9OsBMK9O69_3_cY8oX2j=wRc_F5-g@mail.gmail.com>
Subject: Re: [PATCH 5/7] diff.c: add a blocks mode for moved code detection
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 2:50 PM, Jonathan Tan <jonathantanmy@google.com> wr=
ote:
> On Tue, 24 Apr 2018 14:03:28 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>  (https://public-inbox.org/git/87o9j0uljo.fsf@evledraar.gmail.com/)
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Firstly, I don't know if this is the right solution- as written
> in the linked e-mail [1], the issue might be more that the config
> conflates 2 unrelated things, not that a certain intersection is
> missing.

The "plain zebra" or as I call them "blocks", has the "heuristic
for a minimum of 20 characters" and "few colors" as its defining
features, which solves that use case.

Stepping back a bit, we have different "building blocks"
at our disposal:
* move detection by line or block
* alternating blocks
* a heuristic to skip over small chunks (20 alnum chars)

These can be combined independently, so would
you expect the user to expect two options for them?
For example "--color-moved=3Dzebra" could be split
into  "--skip-small --alternate-blocks"

Eventually we'll use various colors to inform the user
what these building blocks made of the diff.

=C3=86var wrote:

> Which is what I mean by the current config conflating two (to me)
> unrelated things. One is how we, via any method, detect what's moved or
> not, and the other is what color/format we use to present this to the
> user.

So instead of building blocks we rather want to split into algorithms
and presentation layer?

The presentation layer would be things like:
* use a different color for moved things
* alternate colors for adjacent blocks
* paint border of a block (dimmed zebra)

The algorithm side would be
* detect moves
* detect moves as blocks
* skip small heuristic

Am I still missing the big picture?

> [1] https://public-inbox.org/git/87muykuij7.fsf@evledraar.gmail.com/
>
> Optional: Probably better to put the link inline, instead of in the
> trailer.

ok.

>
>> -test_expect_success 'detect permutations inside moved code -- dimmed_ze=
bra' '
>> +test_expect_success 'detect blocks of moved code' '
>>       git reset --hard &&
>>       cat <<-\EOF >lines.txt &&
>>               long line 1
>> @@ -1271,6 +1271,52 @@ test_expect_success 'detect permutations inside m=
oved code -- dimmed_zebra' '
>>       test_config color.diff.newMovedDimmed "normal cyan" &&
>>       test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
>>       test_config color.diff.newMovedAlternativeDimmed "normal yellow" &=
&
>
> Add a comment here explaining that these colors do not appear in the
> output, but merely set to recognizable values to ensure that they do not
> appear in the output.

ok.
