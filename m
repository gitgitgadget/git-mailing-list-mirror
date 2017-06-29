Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AEE20281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdF2SQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:16:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35255 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdF2SQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:16:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id u23so4045131wma.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gTHKTHyYoEU8mc2OtSosKHbg7qJRiPc7FyRfx8/oLlY=;
        b=MZibcepggfzQkyKEbBSpKhC/Le4o50TUr3sp1HlY5mS9561HZ8N6MA29vEqPFchQnd
         lMeo/9C3MzoS57/uxrKZmWINcBQDgt628FD3SlDUwHZJlg/ODZmQOcIpY67bWtI9EBaO
         TT4BbKQ7zt+b7B4O/yvO+1uH2utB0OrpQF2wJJ3yIPNRlsbwB1CNREVfJUJfXLPh/c5A
         6MR7GB4TZmQYLlbS+GLd9TpggZAI6fYdivOLvFk3/JjA40WA5L88wlfahTRMKFVnI3pF
         Qs3Zqz3Lxe/gPBM9slVUYuwI3grbkd+7yQNZVyHJjyLI+PYw73NN8e4oOW7/1GY4sXBY
         QjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gTHKTHyYoEU8mc2OtSosKHbg7qJRiPc7FyRfx8/oLlY=;
        b=hxzudtjbcIOq4fOMZ8hZcBoP1k+sO3uQg+uYQRCbotXUdwpjyV4vBPt66H7YatlcIV
         FzScM5Gj3dji+VnCP/Yq6PT2iKksWFIVXlGPDaWEbkISqgHTPxfOOdJRDbeWTFsrwVM+
         qlTbEqeOB0qQMHOODq3Mp7mTQ5e0rtvdyHwE2JxC1POR1DwtYZA2iZU22TKUMjVyaeXt
         JY5vskTOIyu9idhD6KM1faRd2j0H7s4qwymEk9V8FjYLkndCnfGbVjF/jtcNz6gOtrlI
         v8CiKH86Gh6d4nS1uwD6W1PH14DAbtATm4yORcd7EJxZSCxHzddWK1D51QMKWiUggMP6
         a8kg==
X-Gm-Message-State: AKS2vOzbMPA96lc378DyR8cLfEySuaqT+t6013+Pl+LkAI0z1fPuCL3O
        5rVyh8Eqo3YbopXzAxg=
X-Received: by 10.80.226.140 with SMTP id p12mr2058506edl.37.1498760181714;
        Thu, 29 Jun 2017 11:16:21 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id r28sm1001134edd.33.2017.06.29.11.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 11:16:20 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dQdzH-0002Ao-NH; Thu, 29 Jun 2017 20:16:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 5/5] grep: remove regflags from the public grep_opt API
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com> <20170628215809.23060-1-avarab@gmail.com> <20170628215809.23060-6-avarab@gmail.com> <CAGZ79kbOpMpi0Dv6=ViW45gq5E9KHgpz4GE4o8XA-KMaiR78Vw@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAGZ79kbOpMpi0Dv6=ViW45gq5E9KHgpz4GE4o8XA-KMaiR78Vw@mail.gmail.com>
Date:   Thu, 29 Jun 2017 20:16:19 +0200
Message-ID: <87zicqirrg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 29 2017, Stefan Beller jotted:

> On Wed, Jun 28, 2017 at 2:58 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Refactor calls to the grep machinery to always pass opt.ignore_case &
>> opt.extended_regexp_option instead of setting the equivalent regflags
>> bits.
>>
>> The bug fixed when making -i work with -P in commit 9e3cbc59d5 ("log:
>> make --regexp-ignore-case work with --perl-regexp", 2017-05-20) was
>> really just plastering over the code smell which this change fixes.
>>
>> See my "Re: [PATCH v3 05/30] log: make --regexp-ignore-case work with
>> --perl-regexp"[1] for the discussion leading up to this.
>>
>> The reason for adding the extensive commentary here is that I
>> discovered some subtle complexity in implementing this that really
>> should be called out explicitly to future readers.
>>
>> Before this change we'd rely on the difference between
>> `extended_regexp_option` and `regflags` to serve as a membrane between
>> our preliminary parsing of grep.extendedRegexp and grep.patternType,
>> and what we decided to do internally.
>>
>> Now that those two are the same thing, it's necessary to unset
>> `extended_regexp_option` just before we commit in cases where both of
>> those config variables are set. See 84befcd0a4 ("grep: add a
>> grep.patternType configuration setting", 2012-08-03) for the code and
>> documentation related to that.
>>
>> The explanation of why the if/else branches in
>> grep_commit_pattern_type() are ordered the way they are exists in that
>> commit message, but I think it's worth calling this subtlety out
>> explicitly with a comment for future readers.
>
> Up to here the commit message is inspiring confidence.

Thanks.

>>
>> Unrelated to that: I could have factored out the default REG_NEWLINE
>> flag into some custom GIT_GREP_H_DEFAULT_REGFLAGS or something, but
>> since it's just used in two places I didn't think it was worth the
>> effort.
>>
>> As an aside we're really lacking test coverage regflags being
>> initiated as 0 instead of as REG_NEWLINE. Tests will fail if it's
>> removed from compile_regexp(), but not if it's removed from
>> compile_fixed_regexp(). I have not dug to see if it's actually needed
>> in the latter case or if the test coverage is lacking.
>
> This sounds as if extra careful review is needed.

Note though (since I didn't say this explicitly) nothing about this
commit changes the semanics of what we pass to regcomp, I'm just noting
this caveat with REG_NEWLINE as an aside since I'm moving it around.

>>
>> 1. <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
>>    (https://public-inbox.org/git/CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com/)
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/grep.c |  2 --
>>  grep.c         | 43 ++++++++++++++++++++++++++++++++++---------
>>  grep.h         |  1 -
>>  revision.c     |  2 --
>>  4 files changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index f61a9d938b..b682966439 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -1169,8 +1169,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>
>>         if (!opt.pattern_list)
>>                 die(_("no pattern given."));
>> -       if (!opt.fixed && opt.ignore_case)
>> -               opt.regflags |= REG_ICASE;
>>
>>         /*
>>          * We have to find "--" in a separate pass, because its presence
>> diff --git a/grep.c b/grep.c
>> index 736e1e00d6..51aaad9f03 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -35,7 +35,6 @@ void init_grep_defaults(void)
>>         memset(opt, 0, sizeof(*opt));
>>         opt->relative = 1;
>>         opt->pathname = 1;
>> -       opt->regflags = REG_NEWLINE;
>>         opt->max_depth = -1;
>>         opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
>>         color_set(opt->color_context, "");
>> @@ -154,7 +153,6 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>>         opt->linenum = def->linenum;
>>         opt->max_depth = def->max_depth;
>>         opt->pathname = def->pathname;
>> -       opt->regflags = def->regflags;
>>         opt->relative = def->relative;
>>         opt->output = def->output;
>>
>> @@ -170,6 +168,24 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>>
>>  static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
>>  {
>> +       /*
>> +        * When committing to the pattern type by setting the relevant
>> +        * fields in grep_opt it's generally not necessary to zero out
>> +        * the fields we're not choosing, since they won't have been
>> +        * set by anything. The extended_regexp_option field is the
>> +        * only exception to this.
>> +        *
>> +        * This is because in the process of parsing grep.patternType
>> +        * & grep.extendedRegexp we set opt->pattern_type_option and
>> +        * opt->extended_regexp_option, respectively. We then
>> +        * internally use opt->extended_regexp_option to see if we're
>> +        * compiling an ERE. It must be unset if that's not actually
>> +        * the case.
>> +        */
>> +       if (pattern_type != GREP_PATTERN_TYPE_ERE &&
>> +           opt->extended_regexp_option)
>> +               opt->extended_regexp_option = 0;
>> +
>>         switch (pattern_type) {
>>         case GREP_PATTERN_TYPE_UNSPECIFIED:
>>                 /* fall through */
>> @@ -178,7 +194,7 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
>>                 break;
>>
>>         case GREP_PATTERN_TYPE_ERE:
>> -               opt->regflags |= REG_EXTENDED;
>> +               opt->extended_regexp_option = 1;
>>                 break;
>>
>>         case GREP_PATTERN_TYPE_FIXED:
>> @@ -208,6 +224,11 @@ void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_o
>>         else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
>>                 grep_set_pattern_type_option(opt->pattern_type_option, opt);
>>         else if (opt->extended_regexp_option)
>> +               /*
>> +                * This branch *must* happen after setting from the
>> +                * opt->pattern_type_option above,
>
> I do not quite understand this. Are you saying
>
>   opt->pattern_type_option takes precedence over
>   opt->extended_regexp_option if the former is not _UNSPECIFIED ?

I mean this "else if" code *must* be in that order, i.e.:

	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
		grep_set_pattern_type_option(opt->pattern_type_option, opt);
	else if (opt->extended_regexp_option)
		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);

Not:

	else if (opt->extended_regexp_option)
		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
		grep_set_pattern_type_option(opt->pattern_type_option, opt);

Since we only want to pay attention to grep.extendedRegexp it
grep.patternType is not set. If grep.patternType is set then the
pattern_type_option will not be GREP_PATTERN_TYPE_UNSPECIFIED (but
e.g. GREP_PATTERN_TYPE_BRE).

> As grep_set_pattern_type_option is only called from here,
> I wondered if we can put the long comment (and the code)
> here in this function grep_commit_pattern_type to have it less
> subtle? I have no proposal how though.

Ah you mean the whole "When committing to the pattern type by" comment +
code. Yeah I think that makes sense. I'll try that for v2 and see if
it's better.

> I think I grokked this patch and it makes sense, though the commit
> message strongly hints at asking for tests. ;)

*Points up at "moving it around" comment above*
