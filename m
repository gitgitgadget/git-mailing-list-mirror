Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3E81FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 06:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbcLHGnw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 01:43:52 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35699 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbcLHGnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 01:43:51 -0500
Received: by mail-io0-f193.google.com with SMTP id h133so1536655ioe.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 22:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ja1bcPNdZG4mJMfY7/+zexr5p3q1AKphNstv5IQUpE=;
        b=tRJQUg7kgDCwgTL8lX/fukxubfenLplrF3Nw5Lv2JN1eyuVBJcY7NKTLRCFiWQfx1R
         2vuIhSaP6lvlf13kgDY/+pOli1tGtvGeUGJPDhumlmZjK7U4aZvGxUA4AUPt9ebfO5ie
         DPVrWo1sbbyZIY2Ne5b2KxDVQkng3T+/bjrSwFn1WF0HzJemqMzTm0w7sKdbXjjwUqz1
         gcPV/dL51FYcJ6e01n62yCFWnK5IGuLygQaXNU9ZQHYogC6U2CJuLmtiHQAp22HfoVEu
         knc8CaZW3cXIlL8eIs0TG57Z8FAX1/uC5OKu86sPveIZ18fQJxL3VRWmHY/PuFx7Jgws
         uNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ja1bcPNdZG4mJMfY7/+zexr5p3q1AKphNstv5IQUpE=;
        b=MvlZMkqnFpoEsMVJktbu/cXppDf/7WPcAUZVMKRV1dDeIpEA9VHBuQoAqKtfXjMMKC
         NPdB8SzBeIbGYUiBi5EtuAJ8vYXk02BBRpRL+TR+2jI2pPL741afZLSeHy3XfInPWQtW
         oMfZgE9fL2aYqa5cEjtd/568yCWjBFmYo3JSsfztKfFAK8/BksFQiPs7DmGTXiL2QNa5
         nK5oXmAfwgl8pTknmVehQnQqgnU2PgjbNtoabGhPUY1uXYQkmugWUZ/r7f09RNpEuI0s
         2Qv4RuoOR1LBvDQqpQoZyXb12HaiD+gQWb6Qml6ZsaXM+Rmj0L1OqvHxhf+WsCS83zmH
         yZIw==
X-Gm-Message-State: AKaTC02itpjxK/at1rjJ/xY1ovo+ri2Q8hJr2EB0oQbNuOEOwKBR8P/+7Dc6FAD8G73otvs6gx1WVDcNv907og==
X-Received: by 10.107.53.165 with SMTP id k37mr64793167ioo.74.1481179430143;
 Wed, 07 Dec 2016 22:43:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Wed, 7 Dec 2016 22:43:49 -0800 (PST)
In-Reply-To: <14b9ba3a-4568-2e4b-0b1a-f0ee75a7c677@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b54-0ac61448-98b1-4c7d-bfdd-47af95f52153-000000@eu-west-1.amazonses.com>
 <0cc22155-2b3f-b69c-9ed4-2b1c55e40eee@gmx.net> <CAFZEwPPTnfOYsL8OB5x5n9cm2s+chMwg=xo459kVnFV9bB+5Hw@mail.gmail.com>
 <14b9ba3a-4568-2e4b-0b1a-f0ee75a7c677@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Thu, 8 Dec 2016 12:13:49 +0530
Message-ID: <CAFZEwPMeEwUQivPjFqw+RPqsAp6u6LPAqtHbZ9bQYNecDw98kg@mail.gmail.com>
Subject: Re: [PATCH v15 19/27] bisect--helper: `bisect_state` & `bisect_head`
 shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Wed, Dec 7, 2016 at 5:24 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit,
>
> On 12/06/2016 11:40 PM, Pranit Bauva wrote:
>> On Tue, Nov 22, 2016 at 5:42 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>>> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>>>> +static int bisect_state(struct bisect_terms *terms, const char **argv,
>>>> +                     int argc)
>>>> +{
>>>> +     const char *state = argv[0];
>>>> +
>>>> +     get_terms(terms);
>>>> +     if (check_and_set_terms(terms, state))
>>>> +             return -1;
>>>> +
>>>> +     if (!argc)
>>>> +             die(_("Please call `--bisect-state` with at least one argument"));
>>>
>>> I think this check should move to cmd_bisect__helper. There are also the
>>> other argument number checks.
>>
>> Not really. After the whole conversion, the cmdmode will cease to
>> exists while bisect_state will be called directly, thus it is
>> important to check it here.
>
> Okay, that's a point.
> In that case, you should probably use "return error()" again and the
> message (mentioning "--bisect-state") does not make sense when
> --bisect-state ceases to exist.

True. Will change accordingly.

>>>> +
>>>> +     if (argc == 1 && one_of(state, terms->term_good,
>>>> +         terms->term_bad, "skip", NULL)) {
>>>> +             const char *bisected_head = xstrdup(bisect_head());
>>>> +             const char *hex[1];
>>>
>>> Maybe:
>>>                 const char *hex;
>>>
>>>> +             unsigned char sha1[20];
>>>> +
>>>> +             if (get_sha1(bisected_head, sha1))
>>>> +                     die(_("Bad rev input: %s"), bisected_head);
>>>
>>> And instead of...
>>>
>>>> +             if (bisect_write(state, sha1_to_hex(sha1), terms, 0))
>>>> +                     return -1;
>>>> +
>>>> +             *hex = xstrdup(sha1_to_hex(sha1));
>>>> +             if (check_expected_revs(hex, 1))
>>>> +                     return -1;
>>>
>>> ... simply:
>>>
>>>                 hex = xstrdup(sha1_to_hex(sha1));
>>>                 if (set_state(terms, state, hex)) {
>>>                         free(hex);
>>>                         return -1;
>>>                 }
>>>                 free(hex);
>>>
>>> where:
>>
>> Yes I am planning to convert all places with hex rather than the sha1
>> but not yet, maybe in an another patch series because currently a lot
>> of things revolve around sha1 and changing its behaviour wouldn't
>> really be a part of a porting patch series.
>
> I was not suggesting a change of behavior, I was suggesting a simple
> helper function set_state() to get rid of code duplication above and
> some lines below:
>
>>> ... And replace this:
>>>
>>>> +                     const char **hex_string = (const char **) &hex.items[i].string;
>>>> +                     if(bisect_write(state, *hex_string, terms, 0)) {
>>>> +                             string_list_clear(&hex, 0);
>>>> +                             return -1;
>>>> +                     }
>>>> +                     if (check_expected_revs(hex_string, 1)) {
>>>> +                             string_list_clear(&hex, 0);
>>>> +                             return -1;
>>>> +                     }
>>>
>>> by:
>>>
>>>                         const char *hex_str = hex.items[i].string;
>>>                         if (set_state(terms, state, hex_string)) {
>>>                                 string_list_clear(&hex, 0);
>>>                                 return -1;
>>>                         }
>
> See?

I can do this change of using set_state() keeping aside the sha1 to
hex and such change.

>>>> @@ -184,8 +137,8 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>>>>                       state="$TERM_GOOD"
>>>>               fi
>>>>
>>>> -             # We have to use a subshell because "bisect_state" can exit.
>>>> -             ( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
>>>> +             # We have to use a subshell because "--bisect-state" can exit.
>>>> +             ( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )
>>>
>>> The new comment is funny, but you don't need a subshell here any
>>> longer.
>>
>> True, but right now I didn't want to modify that part of the source
>> code to remove the comment. I will remove the comment all together
>> when I port bisect_run()
> For most of the patches, I was commenting on the current state, not on
> the big picture.
>
> Still I think that it is better to remove the comment and the subshell
> instead of making the comment weird ("yes the builtin can exit, but why
> do we need a subshell?" vs "yes the shell function calls exit, so we
> need a subshell because we do not want to exit this shell script")

Sure I will remove the comment.

Regards,
Pranit Bauva
