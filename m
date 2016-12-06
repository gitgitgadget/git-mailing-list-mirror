Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1961FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 19:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbcLFTd3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 14:33:29 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35066 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLFTd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 14:33:28 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so23418440ioe.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yBmKYe6u8n/v8YBTIFboXtAtwNz1SX+VdCUOGkW1HUc=;
        b=DO5+1ASmGkSvh8MR8Lm7eNyYNCLuD3cQPW6mA58kkFdwPOoWA36N7fZhoZ0GwwA08C
         Hu4I9jrX0kc6nwFSohDMDrRh/SmN1VHJoTqgljjB40zMdgY0jgIGhCrjd/qUV4rbn8e5
         H6IMs0cJpOmv4GJUxc15iq0cS4BCNwUmEMJwD5/wkzSJFnhSTc51BN91aYpVQ7AqLwn7
         8zSjRhbccaX1dz24QWcvR1EnMtOkyOzZ0rxW7hsdz24f/l5A4ayvfjYG9XzEFrR9kIyg
         00+VN+/TdgP3ao+u+qUS6i8Wf8Eox5r9BqGtZZUejVZgmQRzUd3skeL29M2yd2FjA2xK
         ln7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yBmKYe6u8n/v8YBTIFboXtAtwNz1SX+VdCUOGkW1HUc=;
        b=nMgcmqQ8S7aCPxGfT9/5Y2AyYQGbAhxBNsVesywfuU5AkPZZidLQu6FiRDquMmu58H
         5Pqn4eLK4IQFYzqThNwlXYOn9wYEHAzYvnnJ+KrJ2vGIAYKR73aS7LzWILAGYsYyXVsM
         /bK7bA60IgfTVcKbQufl74VOrRGXPVfl0xwVAOsEW2lDfP7uC3jwJPjsHfIDAptdQBEM
         Oeyx9cewnqQ6wfwO18skodRqiJdVTMypAeqWJbO/laQJOC7qpRarun409IjDnpqxSLuP
         lQFHwiah0X5y1Fa3aqS8UTmq6fyvllfSRr3zsFuGTYxAcbrQoLLGjQicf4jxdiPKXXZ0
         Qw3Q==
X-Gm-Message-State: AKaTC02xTa4P7YOGux8AbEhH3GKsXV5jn1tEA9s8+USEaYN3q+oegsJ3mLZaMlGFnI51gc6Ykgnr1ABPTEz9zg==
X-Received: by 10.36.70.21 with SMTP id j21mr208844itb.60.1481052802695; Tue,
 06 Dec 2016 11:33:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 11:33:22 -0800 (PST)
In-Reply-To: <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
 <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 01:03:22 +0530
Message-ID: <CAFZEwPOZhO=sXLVwh03C8QN0uVXBUfb=xZ-JS003tgCNLgVOjg@mail.gmail.com>
Subject: Re: [PATCH v15 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Thu, Nov 17, 2016 at 5:17 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index d84ba86..c542e8b 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -123,13 +123,40 @@ static int bisect_reset(const char *commit)
>>       return bisect_clean_state();
>>  }
>>
>> +static int is_expected_rev(const char *expected_hex)
>> +{
>> +     struct strbuf actual_hex = STRBUF_INIT;
>> +     int res = 0;
>> +     if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
>> +             strbuf_trim(&actual_hex);
>> +             res = !strcmp(actual_hex.buf, expected_hex);
>> +     }
>> +     strbuf_release(&actual_hex);
>> +     return res;
>> +}
>
> I am not sure it does what it should.
>
> I would expect the following behavior from this function:
>  - file does not exist (or is "broken") => return 0
>  - actual_hex != expected_hex => return 0
>  - otherwise return 1
>
> If I am not wrong, the code does the following instead:
>  - file does not exist (or is "broken") => return 0
>  - actual_hex != expected_hex => return 1
>  - otherwise => return 0

Yeah, you are right. I should update this. Thanks for pointing it out.

>> +static int check_expected_revs(const char **revs, int rev_nr)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < rev_nr; i++) {
>> +             if (!is_expected_rev(revs[i])) {
>> +                     unlink_or_warn(git_path_bisect_ancestors_ok());
>> +                     unlink_or_warn(git_path_bisect_expected_rev());
>> +                     return 0;
>> +             }
>> +     }
>> +     return 0;
>> +}
>
> Here I am not sure what the function *should* do. However, I see that it
> basically mimics the behavior of the shell function (assuming
> is_expected_rev() is implemented correctly).
>
> I don't understand why the return value is int and not void. To avoid a
> "return 0;" line when calling this function?

Initially I thought I would be using the return value but now I
realize that it is meaningless to do so. Using void seems better. :)

>> @@ -167,6 +196,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               if (argc > 1)
>>                       die(_("--bisect-reset requires either zero or one arguments"));
>>               return bisect_reset(argc ? argv[0] : NULL);
>> +     case CHECK_EXPECTED_REVS:
>> +             return check_expected_revs(argv, argc);
>
> I note that you check the correct number of arguments for some
> subcommands and you do not check it for some other subcommands like this
> one. (I don't care, I just want to mention it.)

Here we should be able to accept any number of arguments. I think it
would be good to add a non-zero check though just to maintain the
uniformity. Though this is something programmer needs to be careful
about rather than the user.

>>       default:
>>               die("BUG: unknown subcommand '%d'", cmdmode);
>>       }
>
> ~Stephan

Regards,
Pranit Bauva
