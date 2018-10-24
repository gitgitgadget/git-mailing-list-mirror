Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD301F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJXOM1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 10:12:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41441 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXOM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 10:12:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id q7-v6so4069217wrr.8
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mAkY+0EEmand+XoV73smOxkjhddUBBw7ci7HKmIO0Jg=;
        b=FM1yJJyJcobyOCMhRhvAZMctkWG8iq4bZvZ5BARFgbXYZqp8vTojzjoeuYpsLTzM6/
         XmfzcrIslCbkeTYhsKl1GhwzIbr0vGxxj/51gWyBYOK5ZztTbccaG43W/ztUvERSzCGC
         W3Y0CkY3z0yJ1Dg1CZNLDQrmcWuA4q/VDUn78PzOrhg8sB1dhVyGLWxebc24r54B533S
         HSFSYEzCGomVVCQAPMX6Ad3mj+7yYjOkLdx45WRW+8oJVQ0uiI/M7A5Ddz+M4YTX6ps2
         uciOnDfdXuw05wZ2w1kuHrq2jOf+S1i7zb9nDVrIHhCN8SQFP7dCX+ZWXcef8Lf10LQC
         crhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mAkY+0EEmand+XoV73smOxkjhddUBBw7ci7HKmIO0Jg=;
        b=ZGhNEJf7WhGu+XjxfOflD4LdcHYEcgySnIWw/oibcHpKKpd4hCZhZ226hJTJvvLWrR
         Q/sMCHTzg/WKv3ysm6Wl5GgghcxYynTsO8uqtfDzoQAWKe/y6tXJX1TP086zaP2Z0DIj
         ph3WKNsu5wyT7/rvbt4tGU7QcxNhjShf4TZ0icWutaGkyRDHVufh4YO0I1Z7eUYS4AvU
         IREdt9h1dgt/j5Mtrs7lI41k1n3jZUofokZAeWGoXyxhwR2DVMwjrT7nqwkvn2t82iLT
         mf0vssRg3iO6E8f7XgYAPg8Od9yrT79zoCS+sIaIdNGuxRuOsINQYDnYE6kogtsbRHWx
         BPog==
X-Gm-Message-State: AGRZ1gIE1M7WAV3z/ianzD3B+MDR8rtQb2H81ttzW2Mzn6rK6y+0RAix
        U9YgXEQjACtpRDJAnSPOxIU=
X-Google-Smtp-Source: AJdET5de1PKW8qHs9XbEXnY8P0UoN9ih1PBaWOzf15dcfBd/IQU+u2SD7OPJJ4LL37xZnYpbejcM5g==
X-Received: by 2002:adf:9563:: with SMTP id 90-v6mr1275226wrs.60.1540359950921;
        Tue, 23 Oct 2018 22:45:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d6-v6sm3576613wro.72.2018.10.23.22.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:45:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
        <20181023210154.32507-1-avarab@gmail.com>
Date:   Wed, 24 Oct 2018 14:45:49 +0900
In-Reply-To: <20181023210154.32507-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Oct 2018 21:01:54 +0000")
Message-ID: <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Notes on the implementation:
>
>  * The only reason we need a new "git-sh-i18n--helper" and the
>    corresponding "test-tool gettext-poison" is to expose
>    git_env_bool() to shellscripts, since git-sh-i18n and friends need
>    to inspect the $GIT_TEST_GETTEXT_POISON variable.
>
>    We only call these if $GIT_TEST_GETTEXT_POISON is set, or in the
>    test suite, and this code can go away for non-test code once the
>    last i18n-using shellscript is rewritten in C.

Makes me wonder if we want to teach "git config" a new "--env-bool"
option that can be used by third-party scripts.  Or would it be just
the matter of writing

	git config --default=false --type=bool "$GIT_WHATEVER_ENV"

in these third-party scripts and we do not need to add such a thing?

>  * The reason for not doing:
>
>        test_lazy_prereq GETTEXT_POISON 'test-tool gettext-poison'
>        test_lazy_prereq C_LOCALE_OUTPUT '! test-tool gettext-poison'
>
>    In test-lib.sh is because there's some interpolation problem with
>    that syntax which makes t6040-tracking-info.sh fail. Hence using
>    the simpler test_set_prereq.

s/In/in/, as you haven't finished the sentence yet.  But more
importantly, what is this "some interpolation problem"?  Are you
saying that test_lazy_prereq implementation is somehow broken and
cannot take certain strings?  If so, perhaps we want to fix that,
and people other than you can help to do so, once you let them know
what the problem is.

> See also
> https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/ for
> more discussion.

"See also [*1*] for more discussion" as you've already have
reference below.

>
> 1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> Here's a polished version of that. I think it makes sense to queue
> this up before any other refactoring of GETTEXT_POISON, and some patch
> to unconditionally preserve format specifiers as I suggested upthread
> could go on top of this.
> ...
> +int cmd_sh_i18n__helper(int argc, const char **argv, const char *prefix)
> +{
> +	int poison = -1;
> +	struct option options[] = {
> +		OPT_BOOL(0, "git-test-gettext-poison", &poison,
> +			 N_("is GIT_TEST_GETTEXT_POISON in effect?")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, NULL, options,
> +			     builtin_sh_i18n_helper_usage, PARSE_OPT_KEEP_ARGV0);
> +
> +	if (poison != -1)
> +		return !git_env_bool("GIT_TEST_GETTEXT_POISON", 0);

Hmm?  If "--[no-]git-test-gettext-poison" is given, poison is either
0 or 1, and we return the value we read from the environment?  What
convoluted way to implement the option is that, or is there anything
subtle that I am not getting?

If the "default" parameter to git_env_bool() were poison, and then
the option was renamed to "--get-git-text-gettext-poison", then I
sort of understand the code, though (it's like "git config" with
"--default" option).

But if there is nothing subtle, it may make sense to implement this
as an opt-cmdmode instead.

> diff --git a/po/README b/po/README
> index fef4c0f0b5..dba46c4a40 100644
> --- a/po/README
> +++ b/po/README
> @@ -289,16 +289,11 @@ something in the test suite might still depend on the US English
>  version of the strings, e.g. to grep some error message or other
>  output.
>  
> -To smoke out issues like these Git can be compiled with gettext poison
> -support, at the top-level:
> +To smoke out issues like these Git tested with a translation mode that
> +emits gibberish on every call to gettext. To use it run the test suite
> +with it, e.g.:

s/these Git tested/these, Git can be tested/; even though the comma
is not a new issue you introduced.
