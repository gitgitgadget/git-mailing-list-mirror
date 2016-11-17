Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC492042F
	for <e@80x24.org>; Thu, 17 Nov 2016 03:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbcKQD4m (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 22:56:42 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33215 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbcKQD4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 22:56:41 -0500
Received: by mail-it0-f66.google.com with SMTP id c20so12162779itb.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 19:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XvFYkVaSXHg5rUgPrQ9PJBGIiSGwruwZ0P34aVltNPk=;
        b=D8B5TApHhyywrLa+keFoW/0lp5ANb1DlXqTgoVX3i+mJsmPKKvWYCROcaHA7KlSS/a
         TgEGvD5AuUC5WCgCQp4qU/AXel/qaOhAnKAtrMaI+wacB2J3S16exH3RCNmIG+bgCiUh
         VEKvbAwwU/FhGJ3FoYvnTzpA8BWtXd1kNlPrQj1gukVteRg/h2qUAR0WXQuQZH91rkT7
         L0QgCrHyAfK9IkUcIdmGJbh33/g6wMdQ19lTRw00ovYdQBPcY5dRhCD65iRPuj+7NGVV
         0X49NW8MeuBBUZHHr0O95EsK77BDlWMqwpYBTTD+RL9qnXdgVlgqa5mH1Xf4702sEupK
         FBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XvFYkVaSXHg5rUgPrQ9PJBGIiSGwruwZ0P34aVltNPk=;
        b=Nhufutart/N5Nh6ia76Ds/v2er1/YwhQPYseJHwPjOhs7eNST748Ewf4UyXNqoo/Sh
         MkTY+6kb0yhstlVaNsNeSvQzVmGr6RW7eHsklgcP3fMwq/lA/CBs/2m0r+4SqpmMZcx8
         x4Qhh5+CyACE30glTdlNVN5H7sGGmal8AZBKRb673MF1Ot+8J04z74v2R+yxifhWu14+
         R5OU2EfF/OyoCbNYZw1yprovwNLnkYk6iJZJS+7LdLbNYb0lqejcB8WwBcA3UEfbnFEB
         kr+nZwgucaHeVdpsuxBx72W5jTR4cY6+u3oYjy3sxai3avtrZjKKsN5fCCRM2Xre9Q7p
         YqAA==
X-Gm-Message-State: ABUngvfxRZkv0qW24dERc8f5WeIEPQlibraVwc4hRxnm4Zn3UI9c1nw8y1wEzsPuszkRHzyFUlM//H0FDoKB5g==
X-Received: by 10.36.246.130 with SMTP id u124mr11414082ith.45.1479355000522;
 Wed, 16 Nov 2016 19:56:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.27.209 with HTTP; Wed, 16 Nov 2016 19:56:39 -0800 (PST)
In-Reply-To: <1190e37e-d54a-7dbf-412d-8dff90ca677a@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1aa0-0c1fed14-e058-4621-9958-973113d7e45f-000000@eu-west-1.amazonses.com>
 <1190e37e-d54a-7dbf-412d-8dff90ca677a@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Thu, 17 Nov 2016 09:26:39 +0530
Message-ID: <CAFZEwPNtSAKut3t0n-WxZyoV=xuf9-s7XJO9gvGQWVsL3vTouw@mail.gmail.com>
Subject: Re: [PATCH v15 07/27] bisect--helper: `bisect_reset` shell function
 in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Thu, Nov 17, 2016 at 4:53 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 4254d61..d84ba86 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -84,12 +89,47 @@ static int write_terms(const char *bad, const char *good)
>>       return (res < 0) ? -1 : 0;
>>  }
>>
>> +static int bisect_reset(const char *commit)
>> +{
>> +     struct strbuf branch = STRBUF_INIT;
>> +
>> +     if (!commit) {
>> +             if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
>> +                     printf("We are not bisecting.\n");
>
> I think this string should be marked for translation.

True. Thanks!

>> +                     return 0;
>> +             }
>> +             strbuf_rtrim(&branch);
> [...]
>> @@ -121,6 +163,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               if (argc != 0)
>>                       die(_("--bisect-clean-state requires no arguments"));
>>               return bisect_clean_state();
>> +     case BISECT_RESET:
>> +             if (argc > 1)
>> +                     die(_("--bisect-reset requires either zero or one arguments"));
>
> This error message is imho a little unspecific (but this might not be an
> issue because bisect--helper commands are not really exposed to the
> user). Maybe "--bisect-reset requires either no argument or a commit."?

That sounds good.

>> +             return bisect_reset(argc ? argv[0] : NULL);
>>       default:
>>               die("BUG: unknown subcommand '%d'", cmdmode);
>>       }

Regards,
Pranit Bauva
