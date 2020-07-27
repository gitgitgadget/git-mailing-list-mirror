Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FBCC433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789EF2070A
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPNmP+hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG0WvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:51:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51350 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG0WvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 18:51:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 638C66FA9A;
        Mon, 27 Jul 2020 18:51:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ernwKSgsFUmemirARnrISgPnQno=; b=OPNmP+
        hTWJ0tKv7Bj+ZBQKEHviY/HPhiu1Z0CKlSwVRpUwHGKmF0tw+zRygrnuTtxAL7sq
        sMYOWJIX+kh0PQiQGI6hQdcsNk3MuwJ4SQehQFoUGrzeyIEYirpNZlv06dxL+Yyb
        GwsaIt0Cs01eUW+8urq4eZMaKuYFyvDg3/S/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wmKK+PNlPZv+yXZ78Ttnbqu0JLXNuV35
        VvAkhuM+NuvoYAscJv3fsGrSHErLZBTrwAlpl18uyjv1hdpjiHeSmZdFFzJ+d6pG
        g9WvrGgTBABVxtT7DUQDqlTZLt7xtT2kPPYT2ZOuMy6vUWvmrFjFbjcc+F+BYr6T
        lBWgAlHURmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59B976FA98;
        Mon, 27 Jul 2020 18:51:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8F676FA97;
        Mon, 27 Jul 2020 18:51:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/5] ref-filter: support different email formats
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 15:51:10 -0700
In-Reply-To: <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Mon, 27 Jul 2020 20:43:04
        +0000")
Message-ID: <xmqqeeowfu75.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA7B5B34-D05B-11EA-9965-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hariom Verma <hariom18599@gmail.com>
>
> Currently, ref-filter only supports printing email with arrow brackets.

This is the first time I heard the term "arrow bracket".  Aren't
they more commonly called angle brackets?

> Let's add support for two more email options.
> - trim : print email without arrow brackets.

Why would this be useful?

> - localpart : prints the part before the @ sign

Meaning I'd get "<gitster" for me?

Building small pieces of new feature in each patch is good, and
adding tests to each step is also good.  Why not do the same for
docs?

> +static struct email_option{

Missing SP.

> +	enum { EO_INVALID, EO_RAW, EO_TRIM, EO_LOCALPART } option;
> +} email_option;
> +
> @@ -1040,10 +1044,26 @@ static const char *copy_email(const char *buf)
>  	const char *eoemail;
>  	if (!email)
>  		return xstrdup("");
> -	eoemail = strchr(email, '>');

The original code prepares to see NULL from this strchr(); that is
why it checks eoemail for NULL and returns an empty string---the
data is broken (i.e. not an address in angle brackets), which this
code cannot do anything about---in the later part of the code.

> +	switch (email_option.option) {
> +	case EO_RAW:
> +		eoemail = strchr(email, '>') + 1;

And this breaks the carefully laid out error handling by the
original code.  Adding 1 to NULL is quite undefined.

> +		break;
> +	case EO_TRIM:
> +		email++;
> +		eoemail = strchr(email, '>');
> +		break;
> +	case EO_LOCALPART:
> +		email++;
> +		eoemail = strchr(email, '@');

The undocumented design here is that you want to return "hariom" for
"<hariom@gmail.com>", i.e. out of the "trimmed" e-mail, the part
before the at-sign is returned.

If the data were "<hariom>", you'd still want to return "hariom" no?
But because you do not check for NULL, you end up returning an empty
string.

I think you want to cut at the first '@' or '>', whichever comes
first.


> +		break;
> +	case EO_INVALID:
> +	default:

Invalid and unhandled ones are silently ignored and not treated as
an error?  I would have thought that at least the "default" one
would be a BUG(), as you covered all the possible values for the
enum with case arms.  I wouldn't be surprised if seeing EO_INVALID
is also a BUG(), i.e. the control flow that led to the caller to
call this function with EO_INVALID in email_option.option is likely
to be broken.  It's not like you return "" to protect yourself when
fed a bad data from objects---a bad value in .option can only come
here if the parser you wrote for "--format=<string>" produced a
wrong result.

> +		return xstrdup("");
> +	}
> +
>  	if (!eoemail)
>  		return xstrdup("");
> -	return xmemdupz(email, eoemail + 1 - email);
> +	return xmemdupz(email, eoemail - email);
>  }
>  
>  static char *copy_subject(const char *buf, unsigned long len)
> @@ -1113,7 +1133,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
>  			continue;
>  		if (name[wholen] != 0 &&
>  		    strcmp(name + wholen, "name") &&
> -		    strcmp(name + wholen, "email") &&
> +		    !starts_with(name + wholen, "email") &&
>  		    !starts_with(name + wholen, "date"))
>  			continue;
>  		if (!wholine)
> @@ -1124,8 +1144,16 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
>  			v->s = copy_line(wholine);
>  		else if (!strcmp(name + wholen, "name"))
>  			v->s = copy_name(wholine);
> -		else if (!strcmp(name + wholen, "email"))
> +		else if (starts_with(name + wholen, "email")) {
> +			email_option.option = EO_INVALID;
> +			if (!strcmp(name + wholen, "email"))
> +				email_option.option = EO_RAW;
> +			if (!strcmp(name + wholen, "email:trim"))
> +				email_option.option = EO_TRIM;
> +			if (!strcmp(name + wholen, "email:localpart"))
> +				email_option.option = EO_LOCALPART;

The ref-filter formatting language already knows many "colon plus
modifier" suffix like "refname:short" and "contents:body", but I do
not think we have ugly repetition like the above code to parse them.
Perhaps the addition for "email:<whatever>" can benefit from
studying and mimicking existing practices a bit more?

