Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F90520281
	for <e@80x24.org>; Tue, 23 May 2017 18:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030528AbdEWSOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 14:14:11 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35204 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967057AbdEWSOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 14:14:10 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so122044466pfb.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rZgGMUwi80copcmr01aC2FYa9Ofi1/JsToa6IC3Ok/o=;
        b=JwFaZ1EZPJj+yLDMWaqkiR9Ue+6L00NA7loL6nBKO0+y1EL69ju0QJCvxwV/USrF8S
         uM+sXTBJomkvt/vfnfE4JkG19U6kQ/+9Vu8wfAPZmPCer6xORw8+oY6uY4f9gOQceX4N
         2kiW7jQeU77w3rKWGloT+Si+pIub3JgOfHPnGFa2DGwU3D1lm5dK7ssk8Bk7KhJCsXro
         Vl3MSRJstAJf5s5gowWiENBibiEu0W+ZMsICGA/26GuniSrLW+HpXcZ4Ykaueyx3s9Nq
         FkiLVI5bo33i5HidYIK8jayN6C4OHwP52YwcqTzkw7HeNX5+ZQlgL7qIX58ZVo4hzE5p
         zylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rZgGMUwi80copcmr01aC2FYa9Ofi1/JsToa6IC3Ok/o=;
        b=XDZ3z18CGzqO80ck28YefJUnsYfGtc3smiKhhhBTkykBEduqBDwyHolzrjmHhZTYG3
         Dt616QX0lMS79Ot/1gM/bgxkUu0LIuKdABg/Ae3W1JhnNkFPVLCKlXuNnpVKnpr3e7Q0
         9Eb6X1Aw6osTOaj7GiaNu7gCXhGZlkLjWwCHBC5aipLLRFda+wqp1ZpJkjcy/EqpF1go
         KaxeIGgCmX1pSg7hE8KX6TIjHMGDmj+2U/2zXHrY6m00AH+kq9pq+zZBN+8Z22EiW0vI
         RKyCfR0aZYJVlrmS6Ikpc1qBxvlzwOWefz39UeXim2QzXXHkLrc6GWqqUgK/0fsec59q
         kl3A==
X-Gm-Message-State: AODbwcAitphNRL/MFD35bLIDmiB/7WfkJCYBnJqTTK0f9rzPU9XAmaxJ
        8O9UomnBZUYSjLs+9ZKjpSqJaK05PpUs
X-Received: by 10.99.56.66 with SMTP id h2mr34529117pgn.40.1495563244472; Tue,
 23 May 2017 11:14:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 11:14:04 -0700 (PDT)
In-Reply-To: <xmqqinksktaj.fsf@gitster.mtv.corp.google.com>
References: <20170518193746.486-1-sbeller@google.com> <20170523024048.16879-1-sbeller@google.com>
 <20170523024048.16879-10-sbeller@google.com> <xmqqinksktaj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 11:14:04 -0700
Message-ID: <CAGZ79kZ4_giLxXeRLZRDbCzNK754QthscthmzaU02oSpv3nw8g@mail.gmail.com>
Subject: Re: [PATCHv4 09/17] submodule.c: convert show_submodule_summary to
 use emit_line_fmt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/submodule.c b/submodule.c
>> index d3299e29c0..428c996c97 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> ...
>> @@ -547,15 +543,16 @@ void show_submodule_inline_diff(FILE *f, const char *path,
>>       if (right)
>>               new = two;
>>
>> -     fflush(f);
>>       cp.git_cmd = 1;
>>       cp.dir = path;
>> -     cp.out = dup(fileno(f));
>> +     cp.out = -1;
>>       cp.no_stdin = 1;
>>
>>       /* TODO: other options may need to be passed here. */
>>       argv_array_push(&cp.args, "diff");
>> -     argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
>> +     if (o->use_color)
>> +             argv_array_push(&cp.args, "--color=always");
>> +     argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
>
> This makes me wonder if we also need to explicitly decline coloring
> when o->use_color is not set.  After all, even if configuration in
> the submodule's config file says diff.color=never, we will enable
> the color with this codepath (because the user explicitly asked to
> use the color in the top-level), so we should do the same for the
> opposite case where the config says yes/auto if the user said no at
> the top-level, no?

That makes sense, so instead we'd do

             argv_array_push(&cp.args, "--color=%s", o->use_color ?
"always" : "never");

to override the submodule config in all cases.

However that changes from current behavior.

You could imagine that you want to see the superproject colored
and the submodule non-colored to easily spot that it is a submodule change.
Currently this can be made to work via setting color=never in the
submodule and then run the diff from the superproject.

What we really want here is a switch that influences the automatic detection
and say: pretend "dup(fileno(f));" was your stdout, now run your auto-detection
to decide for yourself.

I am not sure if it worth the effort to fix this hypothetical situation, though.

Thanks,
Stefan
