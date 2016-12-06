Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242471FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbcLFWnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:43:32 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34664 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbcLFWnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:43:31 -0500
Received: by mail-io0-f193.google.com with SMTP id r94so9643542ioe.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cU6uFRaMteYEO9Sw5drMqN4sJI/C3oxU0ASulQKlOBY=;
        b=XOLjhKBhEDDqey4mhHCSxYHQalfGNQ7K8Q51ZACLN53HsvYXXcQlVAcxw+xkzY8CXt
         PKtXZemsNlHoyYAV7Vp5nd6x2EEbAdmW48+Dtwrk2rSuKfyEA+E6CROjFWyhms5WTLwM
         fpHqRfbhbT1TKBqZK+0iB5p4qeWoeNNdEcBYmb+wII5ackkIfm9BX4v7JeFc6VcJRB5a
         gZgqbQ98m8AnAxc/3o/ap3qZZho76eDZnpi0NfkUIwu6rmnuUYiJI+ZKaAJO7ilZqe3r
         IKM41oJ6rZHXASljD5m7azklG2MSNV8fAv/f5QsqSuT+bdyXsTObQxIcNX7Is7wf1yZK
         MajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cU6uFRaMteYEO9Sw5drMqN4sJI/C3oxU0ASulQKlOBY=;
        b=dr9Qai/QEO9OR0ciS0j+7I2SaluSzBXEBB67M4JOOFFJSgV6zJMGqXWkrUcqqYem1p
         qRgHrIgq7GNfP5i9iMWJBzg3oJ6jy9zYl8itwtnF8S1VmGvQwHKyfR6hnxxljLs/W7fa
         zweiH2ODNmMdCanZn/DsTeGhLD6FaYQDgRFqbnzBm8Ezhi+eSIbOxv5Cf7THWP3dwJ6j
         Fh1kpXzREfE5SfX3buJKPt6vWk+CuMwri+BnZ7e/eoKoaV3RWlNrJw6+zqkh2JXIaSIR
         dAOzpGSl5uBpqzpxV5PsMqVNfWi5x4Ifu0El9SuSswqYaqdriKID+zboIZjwhAb9wZFT
         Y/Dw==
X-Gm-Message-State: AKaTC007TUOIcxJl1Gdj4FbTyhrHprZyiJp2FTS73YrHSbHeZ0VAXed+3VJ8L4sz1KvZVyHqcjI0ntK0FZqABw==
X-Received: by 10.36.246.130 with SMTP id u124mr864548ith.45.1481064210646;
 Tue, 06 Dec 2016 14:43:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 14:43:30 -0800 (PST)
In-Reply-To: <b7691fac-9642-f87d-f23f-5175b5ead05b@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1aca-0c26fb8c-404f-4f57-afe7-7ebb552a1002-000000@eu-west-1.amazonses.com>
 <b7691fac-9642-f87d-f23f-5175b5ead05b@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 04:13:30 +0530
Message-ID: <CAFZEwPNctpM3KAsYK587aJvokE2FzyTvMoCJ_ztO3ijpUiMcwg@mail.gmail.com>
Subject: Re: [PATCH v15 10/27] bisect--helper: `check_and_set_terms` shell
 function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Fri, Nov 18, 2016 at 1:55 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 3f19b68..c6c11e3 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -20,6 +20,7 @@ static const char * const git_bisect_helper_usage[] = {
>>       N_("git bisect--helper --bisect-clean-state"),
>>       N_("git bisect--helper --bisect-reset [<commit>]"),
>>       N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>> +     N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
>
> Here's the same as in the previous patch... I'd not use
> TERM_GOOD/TERM_BAD in capitals.

Sure.

>>       NULL
>>  };
>>
>> @@ -212,6 +213,38 @@ static int bisect_write(const char *state, const char *rev,
>>       return retval;
>>  }
>>
>> +static int set_terms(struct bisect_terms *terms, const char *bad,
>> +                  const char *good)
>> +{
>> +     terms->term_good = xstrdup(good);
>> +     terms->term_bad = xstrdup(bad);
>> +     return write_terms(terms->term_bad, terms->term_good);
>
> At this stage of the patch series I am wondering why you are setting
> "terms" here, but I guess you'll need it later.
>
> However, you are leaking memory here. Something like
>
>         free(terms->term_good);
>         free(terms->term_bad);
>         terms->term_good = xstrdup(good);
>         terms->term_bad = xstrdup(bad);
>
> should be safe (because you've always used xstrdup() for the terms
> members before). Or am I overseeing something?

Yeah it is safe.

>> @@ -278,6 +314,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               terms.term_bad = xstrdup(argv[3]);
>>               res = bisect_write(argv[0], argv[1], &terms, nolog);
>>               break;
>> +     case CHECK_AND_SET_TERMS:
>> +             if (argc != 3)
>> +                     die(_("--check-and-set-terms requires 3 arguments"));
>> +             terms.term_good = xstrdup(argv[1]);
>> +             terms.term_bad = xstrdup(argv[2]);
>> +             res = check_and_set_terms(&terms, argv[0]);
>> +             break;
>
> Ha! When I reviewed the last patch, I asked you why you changed the code
> from returning directly from each subcommand to setting res; break; and
> then return res at the bottom of the function.
>
> Now I see why this was useful. The two members of "terms" are again
> leaking memory: you are allocating memory by using xstrdup() but you are
> not freeing it.

I will take care about freeing the memory.

Regards,
Pranit Bauva
