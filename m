Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BE61F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 12:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJJT7L (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:59:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJJT7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:59:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so13332696wmd.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uP7v0cNEfT6uwExEhpkXuVidJxqmIckmd/e4TnprFVw=;
        b=WTw3VUN7Vyt7Agcxnr7cKskFMwpnJif8J6K60UnM4sDJwCNySeLIhjPuKoSEX9WdGm
         0Ppa6lu/U+WHe9rGtHwTjm5IHDGkv1ZXW5wYiQxGJ07tHOdRFLIBnKrwJZQJZY/fbtAZ
         3lbHjGA0vTQ2/Ni/WM/jQumhQ98RmCPrryhGCKZc2nMW3wSCUPqSxN7t0zC9O8KwQQ0L
         NPVvwMh8sFSs3oMtzaFX3hU/bHUUO82NAupchzA0oPTylQAW3Z5DHwOx5diABjScEfol
         jEMJnqRB1B+ftqcp3WrKSFe2wZrxAnCs/5/6TSxIb0DuXuidU5u85LAE+Ux/DaKJSt14
         bdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uP7v0cNEfT6uwExEhpkXuVidJxqmIckmd/e4TnprFVw=;
        b=FDwFUql4lDEm3gSiA7EkEIFbe3qHMcFcQ3+BuKFqBBpZke2W0LY/pqKo1HKLe3VxJe
         agm4kHBqqLss97kqY89r3Zq8UnYYPEqsncxsgU414NfkgLApGoKlt9P+nfLX2jzCG7MK
         BMox04/jMd1elkSxE0RAtkSwKHxkPoYxCH6P98gyiCcd3WcaLKo63wC6by+u9wYGokb/
         WZqutsbDyi3oiI3YYHBUI17K+22ccnPmRy9WccGFDSq/IybTu8D+oegqtzcrvfN47DuN
         R8ZDPKIWYaZeEJWRpUFNDFnyESBG2B4EzdgY1CK3pGyThXozB5Y1gzml3S2tUoQp68Vg
         gpiA==
X-Gm-Message-State: ABuFfogbQ63qk+eNWtUJ3pThI1U5OvUjblA5WZ+rZEwA8AafY+kTu33M
        3Yj5Hdaw84raCT8gS1JS2YUQdL+YDLg=
X-Google-Smtp-Source: ACcGV605XUQfKe7V4tkNSS1U/R+20+X/jOp24bSZHRYgnzWri2uxsghOWEeM3toP6ElT0D/uCAZ4YQ==
X-Received: by 2002:a1c:1804:: with SMTP id 4-v6mr726657wmy.29.1539175029561;
        Wed, 10 Oct 2018 05:37:09 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id j203-v6sm26462382wmd.46.2018.10.10.05.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:37:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
        <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
        <20181009234502.oxzfwirjcew2sxrm@dcvr>
        <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
        <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
        <878t36f3ed.fsf@evledraar.gmail.com>
        <xmqqzhvmkn4z.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqzhvmkn4z.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 10 Oct 2018 14:37:07 +0200
Message-ID: <874lduf05o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>  - We use this warning as a proxy for "let's not run for a day",
>>    otherwise we'll just grind on gc --auto trying to consolidate
>>    possibly many hundreds of K of loose objects only to find none of
>>    them can be pruned because the run into the expiry policy. With the
>>    warning we retry that once per day, which sucks less.
>>
>>  - This conflation of the user-visible warning and the policy is an
>>    emergent effect of how the different gc pieces interact, which as I
>>    note in the linked thread(s) sucks.
>>
>>    But we can't just yank one piece away (as Jonathan's patch does)
>>    without throwing the baby out with the bathwater.
>>
>>    It will mean that e.g. if you have 10k loose objects in your git.git,
>>    and created them just now, that every time you run anything that runs
>>    "gc --auto" we'll fork to the background, peg a core at 100% CPU for
>>    2-3 minutes or whatever it is, only do get nowhere and do the same
>>    thing again in ~3 minutes when you run your next command.
>
> We probably can keep the "let's not run for a day" safety while
> pretending that "git gc -auto" succeeded for callers like "git svn"
> so that these callers do not hae to do "eval { ... }" to hide our
> exit code, no?
>
> I think that is what Jonathan's patch (jn/gc-auto) does.

Yeah we could take that patch to skip the eval {} suggested upthread.

As noted when it was discussed I'm *mildly* negative on hiding a IMO
meaningful exit code like that, but maybe sprinkling eval {} or other
"run but ignore exit code" in stuff running "gc --auto" is worth it, and
we could just document that you may want to check gc.log.

> From: Jonathan Nieder <jrnieder@gmail.com>
> Date: Mon, 16 Jul 2018 23:57:40 -0700
> Subject: [PATCH] gc: do not return error for prior errors in daemonized mode
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 95c8afd07b..ce8a663a01 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -438,9 +438,15 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  	return NULL;
>  }
>
> -static void report_last_gc_error(void)
> +/*
> + * Returns 0 if there was no previous error and gc can proceed, 1 if
> + * gc should not proceed due to an error in the last run. Prints a
> + * message and returns -1 if an error occured while reading gc.log
> + */
> +static int report_last_gc_error(void)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> +	int ret = 0;
> ...
>  	if (len < 0)
> +		ret = error_errno(_("cannot read '%s'"), gc_log_path);
> +	else if (len > 0) {
> +		/*
> +		 * A previous gc failed.  Report the error, and don't
> +		 * bother with an automatic gc run since it is likely
> +		 * to fail in the same way.
> +		 */
> +		warning(_("The last gc run reported the following. "
>  			       "Please correct the root cause\n"
>  			       "and remove %s.\n"
>  			       "Automatic cleanup will not be performed "
>  			       "until the file is removed.\n\n"
>  			       "%s"),
>  			    gc_log_path, sb.buf);
> +		ret = 1;
> +	}
>  	strbuf_release(&sb);
>  done:
>  	free(gc_log_path);
> +	return ret;
>  }
>
> I.e. report_last_gc_error() returns 1 when finds that the previous
> attempt to "gc --auto" failed.  And then
>
> @@ -561,7 +576,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>  		}
>  		if (detach_auto) {
> -			report_last_gc_error(); /* dies on error */
> +			int ret = report_last_gc_error();
> +			if (ret < 0)
> +				/* an I/O error occured, already reported */
> +				exit(128);
> +			if (ret == 1)
> +				/* Last gc --auto failed. Skip this one. */
> +				return 0;
>
> ... it exits with 0 without bothering to rerun "gc".
>
> So it won't get stuck for 3 minutes; the repository after "gc
> --auto" punts will stay to be suboptimal for a day, and the user
> kill not get an "actionable" error notice (due to this hiding of
> previous error), hence cannot make changes that may help like
> shortening expiry period, though.

Right, because it still writes the gc.log, but we'll still be yelling at
the user on every commit/fetch etc. that we discovered such-and-such an
issue on the last gc for that full day.

That 3 minute comment was in reference to if we'd apply Jonathan Tan's
"[PATCH] gc: do not warn about too many loose objects without any other
changes. Then we'd just keep returning true on too_many_loose_objects()
even though gc wouldn't help to resolve it.
