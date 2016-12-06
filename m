Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B891FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbcLFV2x (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:28:53 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35403 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcLFV2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:28:53 -0500
Received: by mail-io0-f193.google.com with SMTP id h133so24068858ioe.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0EBNSBjnQchizByjX6SQ6hx6ZJK2J4JyXhoZcrZZ1xc=;
        b=EdQJtnjBLqoNdRGoowwyZlO2Rp6SxlkDoG2oZd6HFzcfA+YMxSOHEzlKL9JeNgWurH
         HqLQx8M8VYEHfUXjJSuP7DFzRWE1KxXFjCoezU2dkAUJ1k2vfG3sbXNC9Pqx5+XsTGl1
         McEAz40Mu52ea9cdkskAikGjsTZmKlyTprtQhFZwSnZlBeD1w4An46r1TKEaA1epBDCH
         Jj5DgsaEXd76IJxvE++for0q2YRuQvPJaaNh/+gLsoXRZhlGiMeO2HHOGFLAsXDoqrxp
         /WQEWsp1/kvIPWAv3KTxvqRRVMMvROz+KLf71b1F/ocq0fUHjgDEk5RUj8ch4BxkxPcT
         yKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0EBNSBjnQchizByjX6SQ6hx6ZJK2J4JyXhoZcrZZ1xc=;
        b=DHwmno7dj2Y1u4ccmRSoV5XLcdcnh4oJo4aiGizgagWjTWRVWiOqVItLkX6TOa6eAs
         iSMmNWvTc50XaRdXnEaurCMoTFsVs/0n5bntw7xCpCNXKYVk4RDL25y5tOcDNP63+/LT
         v44qMVR53T0V+L+OBztNIbYMrpt+OXToUWVsEVn8bIeNLs4dkHG0fetLgeDtFNDojm5h
         Hl4a9bMnYGB6JbzS+l4XrMAh8jA0oCIpSrsKKi5umzsqI5jbFj9YrM62RcFnTENbIvXd
         QCV7kbgExLXoIZr8t8Y2peIAUlIfidNJb7bQ3VOpFF46Lg1dF3bCGdDamRZdPMc9WOVE
         DrwQ==
X-Gm-Message-State: AKaTC03N09UtrAFP2fQw1nKtJLhHUhyMJj73lStyaAVXskaREl+l5wMsf9JPJhvGGJV+UNlHUM0r9qZkEU492Q==
X-Received: by 10.107.141.211 with SMTP id p202mr52965404iod.47.1481058850839;
 Tue, 06 Dec 2016 13:14:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 13:14:10 -0800 (PST)
In-Reply-To: <b54f7f46-a3c0-3334-24fa-e8d1e7d8f653@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad5-0f90c88e-2077-4155-94e9-7d71dbbac38f-000000@eu-west-1.amazonses.com>
 <b54f7f46-a3c0-3334-24fa-e8d1e7d8f653@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 02:44:10 +0530
Message-ID: <CAFZEwPNZCSGzeabHMH6wihz-51OUMMtnBMsffwJJVm9G8Fn=tw@mail.gmail.com>
Subject: Re: [PATCH v15 12/27] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Fri, Nov 18, 2016 at 3:02 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 317d671..6a5878c 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
> [...]
>> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>> +{
>> +     int i;
>> +     const char bisect_term_usage[] =
>> +"git bisect--helper --bisect-terms [--term-good | --term-bad | ]"
>> +"--term-old | --term-new";
>
> Three things:
>
> (1) Is that indentation intentional?

Yes it was intentional but now I cannot recollect why. I think it was
because I found something similar. Nevertheless, I will fix this
indentation/

> (2) You have a "]" at the end of the first part of the string instead of
> the end of the second part.

This should be corrected.

> (3) After the correction, bisect_term_usage and
> git_bisect_helper_usage[7] are the same strings. I don't recommend to
> use git_bisect_helper_usage[7] instead because keeping the index
> up-to-date is a maintenance hell. (At the end of your patch series it is
> a 3 instead of a 7.) However, if - for whatever reason - the usage of
> bisect--helper --bisect-terms changes, you always have to sync the two
> strings which is also nasty....
>
>> +
>> +     if (get_terms(terms))
>> +             return error(_("no terms defined"));
>> +
>> +     if (argc > 1) {
>> +             usage(bisect_term_usage);
>> +             return -1;
>> +     }
>
> ...and since you only use it once, why not simply do something like
>
> return error(_("--bisect-term requires exactly one argument"));
>
> and drop the definition of bisect_term_usage.

Sure that would be better.

>> +
>> +     if (argc == 0) {
>> +             printf(_("Your current terms are %s for the old state\nand "
>> +                    "%s for the new state.\n"), terms->term_good,
>> +                    terms->term_bad);
>
> Very minor: It improves the readability if you'd split the string after
> the \n and put the "and "in the next line.

Ah. This is because of the message. If I do the other way, then it
won't match the output in one of the tests in t/t6030 thus, I am
keeping it that way in order to avoid modifying the file t/t6030.

>> +             return 0;
>> +     }
>> +
>> +     for (i = 0; i < argc; i++) {
>> +             if (!strcmp(argv[i], "--term-good"))
>> +                     printf("%s\n", terms->term_good);
>> +             else if (!strcmp(argv[i], "--term-bad"))
>> +                     printf("%s\n", terms->term_bad);
>> +             else
>> +                     die(_("invalid argument %s for 'git bisect "
>> +                               "terms'.\nSupported options are: "
>> +                               "--term-good|--term-old and "
>> +                               "--term-bad|--term-new."), argv[i]);
>
> Hm, "return error(...)" and "die(...)" seems to be quasi-equivalent in
> this case. Because I am always looking from a library perspective, I'd
> prefer "return error(...)".

I should use return error()

>> @@ -429,6 +492,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               terms.term_bad = xstrdup(argv[1]);
>>               res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
>>               break;
>> +     case BISECT_TERMS:
>> +             if (argc > 1)
>> +                     die(_("--bisect-terms requires 0 or 1 argument"));
>> +             res = bisect_terms(&terms, argv, argc);
>> +             break;
>
> Also here: "terms" is leaking...

Will have to free it.

> ~Stephan
