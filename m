Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DD71F453
	for <e@80x24.org>; Wed,  6 Feb 2019 09:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfBFJ2k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 04:28:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39420 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfBFJ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 04:28:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so1808622wmi.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 01:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ax+Xw62p5M1AWCObnsMZ6KLB0xvG+H1RX5MQr7MLfqs=;
        b=bmSGfx9YmEvBYiiND3QvuFBRbOs7zHdD3MMe0FzPJ0G0ifWn9ixPxS+Lu/Gsn52Xz6
         nwZxW5ODPzxmaylmXz/9qMEL+63I47w8fZnSAw6bCzBaAdUQgTyqEkCkpQykncs9VmLS
         JK+mqg0yjZsENl2/MQfebEHj0PZ+QMLIjQnV24h6wYCb6t02lzQ/WHGAjNQ4WlKbh4zI
         8IzNFm35yHog9RI2X5pVdugumZSp1x/fUaBkHQ2tAiitaL1UjvAGTqAHfMn7UrOikEPY
         +q+i54sJrcj4wgQal7EHl5555dCas3shPCBLBtfUOm2u72itVd/SpJTEMGI5TupYZ81M
         9ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ax+Xw62p5M1AWCObnsMZ6KLB0xvG+H1RX5MQr7MLfqs=;
        b=GR4aO4lOWeeq+9qsYpVqAm7PA3qKd8jgRTgLns5wvnJhX7294O6+B1mdIfjGVxSqfp
         /U5PzjRA+SItmZs82cW5T+jCVe3lclZ/5vON/k+twRUSsKnyDNOddyzmylsC/CDwHlo6
         lqgt2gpM2o+8nCypfyLf8m67qKwE/XwuT8NKdq2DSjUI8oBwDSNV1jBsf8CViDll+qHe
         i3VlAS79laV5SixF4rzcmrnDxZPZ/Hu8Lprt5X1aDHyPbb3rOtIWSWvPk+KrSH5MLoAb
         3sNqwsrElKQLXmGRIMaAIWlTvQrqwPa20R3wDvqXocntHxE853rc+VcPYXrXnE5xbPS6
         LQfQ==
X-Gm-Message-State: AHQUAuYL1K1JOXQu+CB70hh4RgkBPDv8JZI5izufbX9PGxatCiBD32Wp
        SDTLqrxt7By62P/mXMGCCzE=
X-Google-Smtp-Source: AHgI3IbwAeHuTC/8YUYe9exXp7b6DNKqOrsLAuxuwTfda8tB1RmzYgN9kqSdfiTJwlr2mY8KWIw/7Q==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr886680wmj.65.1549445317315;
        Wed, 06 Feb 2019 01:28:37 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e9sm24138475wrc.56.2019.02.06.01.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 01:28:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, William Hubbs <williamh@gentoo.org>,
        chutzpah@gentoo.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org> <20190205195212.25550-3-avarab@gmail.com> <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com> <87k1iekkea.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87k1iekkea.fsf@evledraar.gmail.com>
Date:   Wed, 06 Feb 2019 10:28:34 +0100
Message-ID: <87h8dhl0zh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 05 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Feb 05 2019, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> +static int set_ident_internal(const char *var, const char *value,
>>> +			    struct strbuf *sb, const int flag)
>>> +{
>>> +	if (!value)
>>> +		return config_error_nonbool(var);
>>> +	strbuf_reset(sb);
>>> +	strbuf_addstr(sb, value);
>>> +	author_ident_explicitly_given |=3D flag;
>>> +	ident_config_given |=3D flag;
>>> +	return 0;
>>> +}
>>> +
>>> +static int set_ident(const char *var, const char *value)
>>> +{
>>> +	if (!strcmp(var, "author.name"))
>>> +		return set_ident_internal(var, value, &git_author_name,
>>> +					  IDENT_NAME_GIVEN);
>>> +	else if (!strcmp(var, "author.email"))
>>> +		return set_ident_internal(var, value, &git_author_email,
>>> +					  IDENT_MAIL_GIVEN);
>>> +	else if (!strcmp(var, "committer.name"))
>>> +		return set_ident_internal(var, value, &git_committer_name,
>>> +					  IDENT_NAME_GIVEN);
>>> +	else if (!strcmp(var, "committer.email"))
>>> +		return set_ident_internal(var, value, &git_committer_email,
>>> +					  IDENT_MAIL_GIVEN);
>>> +	else if (!strcmp(var, "user.name"))
>>> +		return set_ident_internal(var, value, &git_default_name,
>>> +					  IDENT_NAME_GIVEN);
>>> +	else if (!strcmp(var, "user.email"))
>>> +		return set_ident_internal(var, value, &git_default_email,
>>> +					  IDENT_MAIL_GIVEN);
>>> +	return 0;
>>> +}
>>
>> In the v5 patch from William, author_ident_explicitly_given and
>> committer_ident_explicitly_given were set separately depending on
>> what variable was given (e.g. user.name marked both, author.name
>> marked only author but not committer_ident_explicitly_given).  In
>> the original before the addition of this feature with v6, giving
>> user.name would have set both, as we can see below.
>>
>> Is this change intended?
>>
>> Or did you find that committer_ident_explicitly_given is no longer
>> useful and the variable is not used anymore?
>
> No, that's a mistake of mine when porting this over, but also clearly a
> blindspot in our tests since they all pass with this.
>
> I haven't dug (don't have time right now) to check what the effect of
> that is. William?

I did some further digging. One of the confusing things is that we've
been carrying dead code since 2012 to set this
author_ident_explicitly_given variable. We can just apply this on top of
master:

     cache.h |  1 -
     ident.c | 13 -------------
     2 files changed, 14 deletions(-)

    diff --git a/cache.h b/cache.h
    index 038e3764a9..52308bd5e4 100644
    --- a/cache.h
    +++ b/cache.h
    @@ -1631,3 +1631,2 @@ extern int ignore_untracked_cache_config;
     extern int committer_ident_sufficiently_given(void);
    -extern int author_ident_sufficiently_given(void);

    diff --git a/ident.c b/ident.c
    index 33bcf40644..95fa2370e5 100644
    --- a/ident.c
    +++ b/ident.c
    @@ -22,3 +22,2 @@ static int ident_use_config_only;
     static int committer_ident_explicitly_given;
    -static int author_ident_explicitly_given;
     static int ident_config_given;
    @@ -169,3 +168,2 @@ const char *ident_default_email(void)
     			committer_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
    -			author_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
     		} else if ((email =3D query_user_email()) && email[0]) {
    @@ -434,6 +432,2 @@ const char *git_author_info(int flag)
     {
    -	if (getenv("GIT_AUTHOR_NAME"))
    -		author_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
    -	if (getenv("GIT_AUTHOR_EMAIL"))
    -		author_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
     	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
    @@ -470,7 +464,2 @@ int committer_ident_sufficiently_given(void)

    -int author_ident_sufficiently_given(void)
    -{
    -	return ident_is_sufficient(author_ident_explicitly_given);
    -}
    -
     int git_ident_config(const char *var, const char *value, void *data)
    @@ -488,3 +477,2 @@ int git_ident_config(const char *var, const char *v=
alue, void *data)
     		committer_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
    -		author_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
     		ident_config_given |=3D IDENT_NAME_GIVEN;
    @@ -499,3 +487,2 @@ int git_ident_config(const char *var, const char *v=
alue, void *data)
     		committer_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
    -		author_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
     		ident_config_given |=3D IDENT_MAIL_GIVEN;

A more complete "fix" is to entirely revert Jeff's d6991ceedc ("ident:
keep separate "explicit" flags for author and committer",
2012-11-14). As he noted in 2012
(https://public-inbox.org/git/20121128182534.GA21020@sigill.intra.peff.net/=
):

    I do not know if anybody will ever care about the corner cases it
    fixes, so it is really just being defensive for future code.

I also found that the bug in my v6 is easily spotted & fixed. We just
grep stderr to see if we emit the "Your name and email were configured
automatically..." message. My patch v6 introduced a bug where we'd start
emitting that.

So it seems to me that the best way forward is to produce a series
where:

 1. We revert Jeff's 2012 patch (or not, Jeff?)

 2. Fix the tests so we test that given a combo of env vars & config
    create the expected commit objects *and* either emit the advice
    about having set stuff implicitly, or not.

    These need a lot of improvement, e.g. all our tests pass if I apply
    this:

        diff --git a/ident.c b/ident.c
        index 33bcf40644..f68e3c32ea 100644
        --- a/ident.c
        +++ b/ident.c
        @@ -167,6 +167,4 @@ const char *ident_default_email(void)
                        if (email && email[0]) {
                                strbuf_addstr(&git_default_email, email);
        -                       committer_ident_explicitly_given |=3D IDENT=
_MAIL_GIVEN;
        -                       author_ident_explicitly_given |=3D IDENT_MA=
IL_GIVEN;
                        } else if ((email =3D query_user_email()) && email[=
0]) {
                                strbuf_addstr(&git_default_email, email);

 3. This {author,committer}.{name,email} feature on top of that.

William, is that something you're intererested in carrying forward? I
can also help if you want. Sorry your first contribution to git has
turned into this mess of re-rolls, as often happens we find that when
trying to tweak something that the existing behavior doesn't have any
tests.

I think it's worth spending a bit more time here to prove to ourselves
that the changes aren't e.g. spamming users with the ident advice in
cases where we don't want that, but maybe everyone else is tired of this
and we should just take your v5 and fix the other stuff later. I'll
leave that up to you / Junio to decide.

>>>  int git_ident_config(const char *var, const char *value, void *data)
>>>  {
>>>  	if (!strcmp(var, "user.useconfigonly")) {
>>> @@ -480,29 +551,7 @@ int git_ident_config(const char *var, const char *=
value, void *data)
>>>  		return 0;
>>>  	}
>>>
>>> -	if (!strcmp(var, "user.name")) {
>>> -		if (!value)
>>> -			return config_error_nonbool(var);
>>> -		strbuf_reset(&git_default_name);
>>> -		strbuf_addstr(&git_default_name, value);
>>> -		committer_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
>>> -		author_ident_explicitly_given |=3D IDENT_NAME_GIVEN;
>>> -		ident_config_given |=3D IDENT_NAME_GIVEN;
>>> -		return 0;
>>> -	}
>>> -
>>> -	if (!strcmp(var, "user.email")) {
>>> -		if (!value)
>>> -			return config_error_nonbool(var);
>>> -		strbuf_reset(&git_default_email);
>>> -		strbuf_addstr(&git_default_email, value);
>>> -		committer_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
>>> -		author_ident_explicitly_given |=3D IDENT_MAIL_GIVEN;
>>> -		ident_config_given |=3D IDENT_MAIL_GIVEN;
>>> -		return 0;
>>> -	}
>>> -
>>> -	return 0;
>>> +	return set_ident(var, value);
>>>  }
