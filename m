Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518071F453
	for <e@80x24.org>; Wed, 26 Sep 2018 15:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeIZVoF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 17:44:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40099 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIZVoE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 17:44:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so2815815wmh.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yjfAHRREWRxXtlpap41JtUKrsemJHZCjzBSrcbyrIvU=;
        b=FIBdE5RlNNBzCxfGUPikS+Cbehd0YLSiY/wcWItrNhZn8LLRTgkQW1R/Qyh40dNSNz
         U1vWjK+dv9IF3WDhSdqvMBHbjA7k3mL1a2+zhQfKRESo8MCURuVfHGnfbaLVkgTtgPQR
         qTso5d08bjTzkJOS+WWNSP1uxmhJNfywhPrVa9HAldqQ/PaY/D+JkS094tueqcjtB+Oi
         /5n21r0o4h6N/a88jRlTjcL6BrJbaGG0gQfra5fBF9IToexAi8l1l2qoP9LQ9Ip+78Vf
         LZrFVhPrThGJpI4DnxtWYbM1RbX0jfbG6gvyxaacJMXVhbM8z2KNmXkfISPUGEAdNFud
         TiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yjfAHRREWRxXtlpap41JtUKrsemJHZCjzBSrcbyrIvU=;
        b=mc35/5tQUdtdRM6eE4QaBKebop1okMm36a6kP1wRheqFXa76r5Qo6tkVrXkv2kHDTJ
         NtfWyngog38NdQIRTtfzkeqwoxhKsqYdTyClEn4bTrWpL+MHQIPWLHv/fjAkUOb3Jo2u
         r2Xu50UOHbD9/KRyS0yOmvJ4s+uHcN0IOdbpF5OTq/GNpvPD1qvvbxAnZ1dunh5Qn8Xg
         xTgCnKy6iH8a8OG0hpPqON49c8WmQwZuEPFLzjPe8xE03JzwLRcD6JdLyAck1r8cVhRP
         ki9v4RQBklwiY8OywEwN1WMd7NWV+YZme4kIc8WpJNi0ThPs7KveqJFX3iltv9j8h/UD
         nCpQ==
X-Gm-Message-State: ABuFfoia3dVKRrING5gqxrXLi/ggnlajKt6xRA+nXoHBmYLJJJjGHG+K
        9a4sL6Zu+aZB0JoFcVyj9mE=
X-Google-Smtp-Source: ACcGV61UxYbANaR91iyuXEcxhrNRxtbk2pFpieV9MQokMvq1ziqA0+jUNrliS0a+aAMOUU7A4vtsnA==
X-Received: by 2002:a1c:df0b:: with SMTP id w11-v6mr2774039wmg.126.1537975833760;
        Wed, 26 Sep 2018 08:30:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u127-v6sm4786552wmf.48.2018.09.26.08.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:30:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
        <20180926143708.GD25697@syl>
Date:   Wed, 26 Sep 2018 08:30:32 -0700
In-Reply-To: <20180926143708.GD25697@syl> (Taylor Blau's message of "Wed, 26
        Sep 2018 07:37:08 -0700")
Message-ID: <xmqqtvmcmg2v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +help.followAlias::
>> +	When requesting help for an alias, git prints a line of the
>> +	form "'<alias>' is aliased to '<string>'". If this option is
>> +	set to a positive integer, git proceeds to show the help for
>
> With regard to "set to a positive integer", I'm not sure why this is the
> way that it is. I see below you used 'git_config_int()', but I think
> that 'git_config_bool()' would be more appropriate.
>
> The later understands strings like "yes", "on" or "true", which I think
> is more of what I would expect from a configuration setting such as
> this.

That is, as you read in the next paragraph, because it gives the
number of deciseconds to show a prompt before showing the manpage.

Not that I think this configuration is a good idea (see my review).

>> +	the first word of <string> after the given number of
>> +	deciseconds. If the value of this option is negative, the
>> +	redirect happens immediately. If the value is 0 (which is the
>> +	default), or <string> begins with an exclamation point, no
>> +	redirect takes place.
>
> It was unclear to my originlly why this was given as a configuration
> knob, but my understanding after reading the patch is that this is to do
> _additional_ things besides printing what is aliased to what.
>
> Could you perhaps note this in the documentation?

It may be that the description for the "execute the likely typoed
command" configuration is poorly written and this merely copied the
badness from it.  Over there the prompt gives a chance to ^C out,
which serves useful purpose, and if that is not documented, we should.

On the other hand, I'd rather see this prompt in the new code
removed, because I do not think the prompt given in the new code
here is all that useful.

>> @@ -415,9 +420,34 @@ static const char *check_git_cmd(const char* cmd)
>>
>>  	alias = alias_lookup(cmd);
>>  	if (alias) {
>> -		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
>> -		free(alias);
>> -		exit(0);
>> +		const char **argv;
>> +		int count;
>> +
>> +		if (!follow_alias || alias[0] == '!') {
>> +			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
>> +			free(alias);
>> +			exit(0);
>> +		}
>> +		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
>
> OK, I think that this is a sensible decision: print to STDERR when
> that's not the main purpose of what're doing (e.g., we're going to
> follow the alias momentarily), and STDOUT when it's the only thing we're
> doing.

> Potentially we could call 'fprintf_ln()' only once, and track an `int
> fd` at the top of this block.

I actually think this should always give the output to standard output.

>> +
>> +		/*
>> +		 * We use split_cmdline() to get the first word of the
>> +		 * alias, to ensure that we use the same rules as when
>> +		 * the alias is actually used. split_cmdline()
>> +		 * modifies alias in-place.
>> +		 */
>> +		count = split_cmdline(alias, &argv);
>> +		if (count < 0)
>> +			die("Bad alias.%s string: %s", cmd,
>> +			    split_cmdline_strerror(count));
>
> Please wrap this in _() so that translators can translate it.
>
>> +		if (follow_alias > 0) {
>> +			fprintf_ln(stderr,
>> +				   _("Continuing to help for %s in %0.1f seconds."),
>> +				   alias, follow_alias/10.0);
>> +			sleep_millisec(follow_alias * 100);
>> +		}
>> +		return alias;
>
> I'm not sure that this notification is necessary, but I'll defer to the
> judgement of others on this one.

I didn't bother to check the original but this is mimicking an
existing code that lets configuration to be set to num-deciseconds
to pause and give chance to ^C out, and also allows it to be set to
negative to immediately go ahead.  follow-alias at this point cannot
be zero in the codeflow, but it still can be negative.
