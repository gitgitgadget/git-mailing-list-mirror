Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A01020C11
	for <e@80x24.org>; Sun,  3 Dec 2017 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbdLCUec (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 15:34:32 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:42359 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdLCUeb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 15:34:31 -0500
Received: by mail-it0-f42.google.com with SMTP id p139so8103013itb.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uQVpHF3yYGsdmeZNCsJW3GxhTcBCYPV5fSkrok5dcI8=;
        b=n+1wf+j2sb+gppoiAEedkC95yeVG0pu4DhmAKt4oEN6gfq6spx9UeppYhah5UuH7Hh
         NsDlrcPhwhJVzRuOXJ/TjajrHHw3R8+YHvwuP1rFXru0kS/HLTVWb8u8fhkXHFFiBqAU
         3K+1QoeaBJSGorb2OvEb5un2LmXFLKQ6GbJPL9OmTH0K4B19UcC3FaUwKZkY9ipF+ZNh
         pJVktOmIuO9bwufadnAholoiCvbUmV90mGNWItP88H1QyO9fjPJcsLf0Rylrs/HfqNHH
         wajijMt5ub9iZDUap3b4q+3mccqFDC79EVuc4ciopvAzEbB6wpaj6Y6vlNz3MmdkykHm
         lJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uQVpHF3yYGsdmeZNCsJW3GxhTcBCYPV5fSkrok5dcI8=;
        b=AiPiqJCEwRWX6rX/je1LwWm1cYvvZgyDB0TEvOc7BPr23kGSkdaNCctpjgNeN5nMu0
         8ezDAcCJ577vR39XLL/c/j0nOisFMWlrL/w7/aFjDoymhhC77/1Tac4JxEVML1ybmm9f
         URf0TW101CNFshhN41NiLvgYLGxlP3Y6m/EhD56uMzfHz9B1puNyU24ElNfHgg21Qs0A
         D2JFiGuppMEZipVGrmOBiXbrVOwbpt+nLBE96wbaikHQfE5inH+TU5wMfQupdIhlsJtM
         7m2SdHAxLDMGwaRDBB+k2zSIgvj5K6NSxL5O62VXtspzhsGS3tDNiDpWui6gppQLMuGP
         XAjw==
X-Gm-Message-State: AJaThX64Jf6cbj4+KeqYIb7gZoVYn2jBPjMpzlSkMflbBZnIkWHwwJIw
        S447MvYAjKIqRKLGwAwIz6AB8cLxFJKg0gqqE+imY1Kh
X-Google-Smtp-Source: AGs4zMbzXIAeVkv17++Rzsj2Pvq4YrJAYPS8boRCs1qtWEU560jbjq+1I2QLFwGYH0JlFtaSENTc1MQBG7+G43IbxXk=
X-Received: by 10.36.0.209 with SMTP id 200mr10704254ita.55.1512333270244;
 Sun, 03 Dec 2017 12:34:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 3 Dec 2017 12:34:29 -0800 (PST)
In-Reply-To: <xmqqk1y3ira9.fsf@gitster.mtv.corp.google.com>
References: <20171203170415.15939-1-chriscool@tuxfamily.org> <xmqqk1y3ira9.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Dec 2017 21:34:29 +0100
Message-ID: <CAP8UFD2OSsqzhyAL-QG1TOowB-xgbf=kC9wHre+FLc+0J1Xy+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] git-compat-util: introduce skip_to_opt_val()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 3, 2017 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> From: Christian Couder <christian.couder@gmail.com>
>>
>> We often accept both a "--key" option and a "--key=<val>" option.
>>
>> These options currently are parsed using something like:
>>
>> if (!strcmp(arg, "--key")) {
>>       /* do something */
>> } else if (skip_prefix(arg, "--key=", &arg)) {
>>       /* do something with arg */
>> }
>>
>> which is a bit cumbersome compared to just:
>>
>> if (skip_to_opt_val(arg, "--key", &arg)) {
>>       /* do something with arg */
>> }
>
> Sounds sensible; especially if there are many existing code that can
> be shortened by using this helper, that is.
>
>> Note that, when using skip_to_opt_val(), it is not possible any more
>> to do something different when the first argument is exactly "--key"
>> than when it is exactly "--key=", but in most cases we already don't
>> make any difference, which is a good thing.
>
> Note that "it is not possible" is misleading.  skip_to_opt_val()
> could be written to allow the caller to tell the difference if you
> chose to, but *you* made it impossible by assigning "" to arg upon
> seeing "--key".  You could assign NULL to arg in that case, and
> "--key" and "--key=" can be differenciated by checking arg; the
> former will give you NULL and the latter "".

Yeah, what I meant was "the design of the function in this patch makes
it impossible..."
That's why I wrote after the diffstat:

"""Another possibility would be to add a "const char *default"
argument to the function, and to do:

      if (!*p) {
              *val = default;
              return 1;
      }

This could make the function more useful in some cases."""

But yeah I could have added the above to the commit message and it
hopefully would have made it clear what I meant.

Anyway there is a design choice to be made. Adding a "const char
*default" argument makes the function more generic, but this might not
be very useful as there are few cases that might benefit. And if we
want to make the command line interface consistent and perhaps avoid
user errors, we might want to have a rule that says that "--key" and
"--key=" should always give the same result. In this case we may also
want to make it easy to implement options that follow the rule.

So my preference is to not add the "const char *default" argument to
the function. But it is not a strong preference.

> Not that I am convinced that it is a bad idea to deliberately lose
> information like this implementation does.  At least not yet.
>
> If there will be no conceivable caller that wants to differenticate
> between the two, the implementation that "loses information" can
> claim to be easier to use, as the callers do not have to be forced
> to write something like:
>
>         if (skip_to_optional_val(arg, "--key", &arg)
>                 do_something(arg ? arg : "");
>
> to treat them the same.
>
> Having said all that, I would expect skip_to_optional_val() (as a
> name of the helper I suspect skip_to_optional_arg() is more
> appropriate, though)

Ok I will rename it skip_to_optional_arg().

> to store NULL in the arg thing if there is no
> optional argument given.  Also, the caller does not have to even do
> the 'arg ? arg : ""' dance if it is so common and natural for the
> application to treat "--key" and "--key=" equivalently, as it is
> expected that the actual code to work on the arg, i.e. do_something()
> in the above example, _should_ be prepared to take NULL and "" and
> treat them the same way (that is the definition of "it is so common
> and natural for the application to treat them the same).

I'd rather add the "const char *default" argument to the function
rather than have the function just set "arg" to NULL. I think setting
"arg" to NULL increases the risk of crashes and makes it too easy to
make "--key" and "--key=" behave differently which I think is not
consistent and not intuitive.

> So, I think you identified interesting pattern that can be cleaned
> up by introducing a helper, but I am not sure if I agree with the
> exact design of the helper.

Ok, maybe the above explains the design a bit better.

>> Note that "opt" in the function name actually means "optional" as
>> the function can be used to parse any "key=value" string where "key"
>> is also considered as valid, not just command line options.
>
> Yup.  This paragraph is a good thing to have in the proposed log
> message, to explain the reason why you force callers of this helper
> to spell out the leading dashes like "--key" (not "key").  I think
> that it is a sane design of the input side of this function---it
> does not limit it to an overly narrow case of command line option
> processing.  For the same reason, I think it is saner design of the
> output side to allow callers to tell between "key=" and "key".
>
> While staring at this helper and writing "does not limit to command
> line option processing", it occurs to me that a helper that allows
> you to look for an optional ':' (instead of '=') may also be useful,
> so the final version might become a pair of functions, perhaps like
> so:
>
>     int skip_to_optional_delim(const char *s,
>                                const char *prefix, char delim,
>                                const char **rest)
>     {
>         const char *p;
>
>         if (!skip_prefix(str, prefix, &p))
>                 return 0;
>         if (!*p)
>                 *rest = NULL;
>         else if (*p != delim)
>                 return 0;
>         else
>                 *rest = p + 1;
>         return 1;
>     }
>
>     int skip_to_optional_arg(const char *s,
>                              const char *prefix,
>                              const char **arg)
>     {
>         return skip_to_optional_delim(s, prefix, '=', arg);
>     }
>
> As the first one would not (by definition) have any callers
> initially after your series, it can be static to a file that
> implements both of them and it is OK to expose only the latter to
> the public.

Yeah, I thought about the above, but I am not very much interested in
implementing it now. I wonder if the callers will always want
skip_to_optional_delim() to take only one delim character or if they
will want more than one delim character.

> I do think it is a premature optimization to inline this function,
> whose initial callers will be (from the look of the remainder of
> your patches) command line parsing that sits farthest from any
> performance critical code.

Ok, I will not inline it.

Thanks!
