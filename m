Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16011FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 19:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdJTTCL (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 15:02:11 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:43613 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdJTTCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 15:02:10 -0400
Received: by mail-qk0-f182.google.com with SMTP id w134so15534046qkb.0
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=40obDKt11DcxiH41i7huueWfBH/8LrvYvOQ1eQ26nmE=;
        b=pg8LinPCf3KK5hSaNoKzdRzIzrRZ1FU46NRa733fa02SW4omzO8IVwKHq771h4gr/J
         V+xQRIbLVEQKiMt4tMZekxPQBJ4GwkUAH+180DVDr1FQv0T9/dQ2XgnkAGFSP1PN5u2U
         aYPqAkLs+j9SMgcdNZPp1Qp1KFe/Y9PBLN+d213nri4Ch+S6zl9eUobl+H75puF6O+V/
         9cV9orQlGVax7bwIMECcrlBcz1yh+AfnVOI5BvMy0a9zuU4a9HWuY9F/4IipGcVEdxSf
         CJ6cNNJ2AztjB7LMCKqAT4QaNwLkmRWwm6a6Fnj321RaDDVzBbvkqrrHBoqMFu8t4CGI
         ufew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=40obDKt11DcxiH41i7huueWfBH/8LrvYvOQ1eQ26nmE=;
        b=RhWRIolvOdVac6aabIgNDi8nKqYWB1jBwr5FZcr6OpnbiVsyZL26Oejs0/MP3yOHs5
         W7PkrOL/kXAAp9E3J1vqLAQ+5G5QcwBpDVbSyh7OVEqiGfilldnmSN525tBJlU7xIuGV
         MHimoc5reqEo/orEt2GQJ0zS3DcbmdDYT+vdjoXeeqUGg26wAOmwlyNT9zOIY1r/K7ka
         XtfVqjH6TGk40vOpFryRxBFXOQxp9a1ZxKjfbr13tG+wDRwkkuc+/jB393CbCQDm5KWc
         T+1+SAjjaay/EiuW2fGU8/NfXyHQevG4I6xHyPo7Eg/ZRcAKBxgO0UhsK+2rq7L+3qv1
         Jo3g==
X-Gm-Message-State: AMCzsaXy81H9SPtalLf+Bzb/Q2Nkyb1ZAMim+znKv2wgdNBnPwf+f2Ln
        N+UQM3hSGW0tB8InVApXiBDkEpGg95Y5VLSPhov0kA==
X-Google-Smtp-Source: ABhQp+QCrZqgfV/0bDOBoN+4VhCDxh3pbb/x5f7bCYncqsYvwmlk79yCVNlGOFTDCHxpfL6z5bWlOfZTmsAkWIT4o2o=
X-Received: by 10.55.129.70 with SMTP id c67mr8803432qkd.230.1508526129747;
 Fri, 20 Oct 2017 12:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 12:02:09 -0700 (PDT)
In-Reply-To: <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com> <20171019174715.6577-1-marius.paliga@gmail.com>
 <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com> <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 12:02:09 -0700
Message-ID: <CAGZ79kbEmdJu9a-h07UvPaymMmLJ4Azm+iChSpCBwvvtOW8gog@mail.gmail.com>
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marius Paliga <marius.paliga@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 7:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> @@ -161,6 +161,9 @@ already exists on the remote side.
>>>         Transmit the given string to the server, which passes them to
>>>         the pre-receive as well as the post-receive hook. The given string
>>>         must not contain a NUL or LF character.
>>> +       When no `--push-option <option>` is given from the command
>>> +       line, the values of configuration variable `push.pushOption`
>>> +       are used instead.
>>
>> We'd also want to document how push.pushOption works in
>> Documentation/config.txt (that contains all the configs)
>
> Perhaps.
>
>> So in the config, we have to explicitly give an empty option to
>> clear the previous options, but on the command line we do not need
>> that, but instead we'd have to repeat any push options that we desire
>> that were configured?
>
> It is not wrong per-se to phrase it like so, but I think that is
> making it unnecessarily confusing by conflating two things.  (1)
> configured values are overridden from the command line, just like
> any other --option/config.variable pair

because they are single value options (usually).

> and (2) unlike usual single
> value variables where "last one wins" rule is simple enough to
> explain,, multi-value variables need a way to "forget everything we
> said so far and start from scratch" syntax, especially when multiple
> input files are involved.

ok, my view of how that should be done is clashing once again
with the projects established standards. Sorry for the noise.

>> Example:
>>
>>   /etc/gitconfig
>>   push.pushoption = a
>>   push.pushoption = b
>>
>>   ~/.gitconfig
>>   push.pushoption = c
>>
>>   repo/.git/config
>>   push.pushoption =
>>   push.pushoption = b
>>
>> will result in only b as a and c are
>> cleared.
>
> The above is correct, and it might be worth giving it as an example
> in the doc, because not just "give an empty entry to clear what has
> been accumulated so far" but a multi-valued option in general is a
> rather rare thing.
>
>> If I were to run
>>   git -c push.pushOption=d push ... (in repo)
>> it would be b and d, but
>>   git push --push-option=d
>> would be d only?
>
>>> @@ -584,12 +599,13 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>>                 set_refspecs(argv + 1, argc - 1, repo);
>>>         }
>>>
>>> -       for_each_string_list_item(item, &push_options)
>>> +       for_each_string_list_item(item, push_options)
>>
>> We have to do the same for _cmdline here, too?
>
> I do not think so.  The point of these lines that appear before this
> loop:
>
>         git_config(git_push_config, &flags);
>         argc = parse_options(argc, argv, prefix, options, push_usage, 0);
> +       push_options = (push_options_cmdline.nr
> +               ? &push_options_cmdline
> +               : &push_options_config);
>
> is that the command line overrides configured values, just like any
> other configuration.  Adding _cmdline variant here is doubly wrong
> when command line options are given in that it (1) duplicates what
> was obtained from the command line, and (2) does not clear the
> configured values.

Oh, ok. Sorry for the noise once again.

Thanks,
Stefan
