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
	by dcvr.yhbt.net (Postfix) with ESMTP id 808CA1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 12:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJIUB5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 16:01:57 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44725 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJIUB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 16:01:57 -0400
Received: by mail-wr1-f51.google.com with SMTP id 63-v6so1664465wra.11
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hxURVzqu9BVauJ3sZw2ZFYR2Ruo0QFvyENTEhbCLm5o=;
        b=dR5ks2flw+0NrGHG9Flh4BJXlFZMRQmKqlkAZJvgeE3zGOT0/7xyJmmnFJlgYHpits
         WlpbRtouNu1hLx1w0vfFa+R1rhFdJ0OkO5Owp2VoRqU1hIf6VjdP/v0VRBv6aNxBmj6Y
         xTamhdaqg227AMDwT/kz/wQ5eqhb5tX2tcQB9Qkki4gRcb32VaNjI1voe3pvB77wh0RP
         I4bj/TjaL5Tr1AHoZRcptFMp2fGLZDfS+qIqnermeG29DRalFPeIdlhVzxi1u6fhz8Pp
         PIguj84FovmN3FXZvqag5u71NFH1pqZzBzOM5BL+YxxFFnppHn8oZa1XDVVnPPmURQEt
         teCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hxURVzqu9BVauJ3sZw2ZFYR2Ruo0QFvyENTEhbCLm5o=;
        b=Uz5K5VIfM4ORQ8hggNxEFXYKEih7sOTQyvHxqF4Ep0sLC3NqmHo7E9jmBhId4X7L3O
         CVVVILo3YN5US9g9h2KgeQPzdE0p+6EjtplLqpaIuV735ucD1Y9AleURXTtPAkstW/Rw
         csXbiiCsPeODtrA1bAziMaWNo3kvcyGl59/xfNRtLN2j5tYfxyXtyqjeNpcIALuKyTan
         loIBDPthEy1X8bPdhobrAb6wE+c9k53bhXCcus5dhXgEK4dUPJCBUM1C+ZCpw0Tvbc03
         sxhYciHEJKCn97mQGKSWi6ST78x/ASpE7PGqSs9WkBWbfBpsR9BUy9OgKRinPzBjrf1H
         t0LQ==
X-Gm-Message-State: ABuFfojY9MnGHLlTvX/5r0tCVurDvFX81HDkZEkIH0kHvrIHU5RbnMfU
        PBsEka7McwyQhDHUKS9t/R4=
X-Google-Smtp-Source: ACcGV62i/KAE4bL3W8wJwnCtlU7EfjwhPGYn/KL+VF/l7OGIqwX0B1HQNFuvJhx9Exc5WuBbPPSvRQ==
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr17938337wrs.173.1539089108394;
        Tue, 09 Oct 2018 05:45:08 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o130-v6sm10354831wmd.11.2018.10.09.05.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 05:45:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
References: <alpine.DEB.2.21.1810061712260.2402@hadrien> <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com> <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.21.1810070719200.2347@hadrien> <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com> <20181009032124.GE6250@sigill.intra.peff.net> <xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 09 Oct 2018 14:45:06 +0200
Message-ID: <87lg77cmr1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 09 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> I think that is the best we could do for "-S", though, which is
>> inherently about counting hits.
>>
>> For "-G", we are literally grepping the diff. It does not seem
>> unreasonable to add the ability to grep only "-" or "+" lines, and the
>> interface for that should be pretty straightforward (a tri-state flag to
>> look in remove, added, or both lines).
>
> Yeah, here is a lunchtime hack that hasn't even been compile tested.
>
>  diff.c             |  4 ++++
>  diff.h             |  2 ++
>  diffcore-pickaxe.c | 22 ++++++++++++++++++++--
>  3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index f0c7557b40..d1f2780844 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5068,6 +5068,10 @@ int diff_opt_parse(struct diff_options *options,
>  	}
>  	else if (!strcmp(arg, "--pickaxe-all"))
>  		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
> +	else if (!strcmp(arg, "--pickaxe-ignore-add"))
> +		options->pickaxe_opts |= DIFF_PICKAXE_IGNORE_ADD;
> +	else if (!strcmp(arg, "--pickaxe-ignore-del"))
> +		options->pickaxe_opts |= DIFF_PICKAXE_IGNORE_DEL;
>  	else if (!strcmp(arg, "--pickaxe-regex"))
>  		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
>  	else if ((argcount = short_opt('O', av, &optarg))) {
> diff --git a/diff.h b/diff.h
> index a30cc35ec3..147c47ace7 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -358,6 +358,8 @@ int git_config_rename(const char *var, const char *value);
>  				 DIFF_PICKAXE_KIND_OBJFIND)
>
>  #define DIFF_PICKAXE_IGNORE_CASE	32
> +#define DIFF_PICKAXE_IGNORE_ADD	64
> +#define DIFF_PICKAXE_IGNORE_DEL 128
>
>  void diffcore_std(struct diff_options *);
>  void diffcore_fix_diff_index(struct diff_options *);
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 800a899c86..826dde6bd4 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -16,6 +16,7 @@ typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
>
>  struct diffgrep_cb {
>  	regex_t *regexp;
> +	struct diff_options *diff_options;
>  	int hit;
>  };
>
> @@ -23,9 +24,14 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
>  {
>  	struct diffgrep_cb *data = priv;
>  	regmatch_t regmatch;
> +	unsigned pickaxe_opts = data->diff_options->pickaxe_opts;
>
>  	if (line[0] != '+' && line[0] != '-')
>  		return;
> +	if ((pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD) &&	line[0] == '+')
> +		return;
> +	if ((pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL) &&	line[0] == '-')
> +		return;
>  	if (data->hit)
>  		/*

Looks good, but I wonder if a more general version of this couldn't be
that instead of returning early if the line doesn't start with +/-
above, we have an option to skip that early return.

Then you can simply specify a regex that starts by matching a + or - at
the start of the line, but you also get the poweruser tool of matching
lines around those lines, as tweaked by the -U option. I.e. this:

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 800a899c86..90625a110c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -24,15 +24,13 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
        struct diffgrep_cb *data = priv;
        regmatch_t regmatch;

-       if (line[0] != '+' && line[0] != '-')
-               return;
        if (data->hit)
                /*
                 * NEEDSWORK: we should have a way to terminate the
                 * caller early.
                 */
                return;
-       data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
+       data->hit = !regexec_buf(data->regexp, line, len, 1,
                                 &regmatch, 0);
 }

That patch obviously breaks existing -G, so it would need to be
optional, but allows me e.g. on git.git to do:

    ~/g/git/git --exec-path=/home/avar/g/git log -G'^ .*marc\.info' -p -U2 -- README.md

To find a change whose first line of context is a line mentioning
marc.info, and then I can use -G'^\+<rx>' to find added lines matching
<rx> etc.

Then the --pickaxe-ignore-add and --pickaxe-ignore-del options in your
patch could just be implemented in terms of that feature, i.e. by
implicitly adding a "^-" or "^\+" to the beginning of the regex,
respectively, and implicitly turning on a new --pickaxe-raw-lines or
whatever we'd call it.

>  		 * NEEDSWORK: we should have a way to terminate the
> @@ -45,13 +51,20 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
>  	xpparam_t xpp;
>  	xdemitconf_t xecfg;
>
> -	if (!one)
> +	if (!one) {
> +		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD)
> +			return 0;
>  		return !regexec_buf(regexp, two->ptr, two->size,
>  				    1, &regmatch, 0);
> -	if (!two)
> +	}
> +	if (!two) {
> +		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL)
> +			return 0;
>  		return !regexec_buf(regexp, one->ptr, one->size,
>  				    1, &regmatch, 0);
> +	}
>
> +	ecbdata.diff_options = o;
>  	/*
>  	 * We have both sides; need to run textual diff and see if
>  	 * the pattern appears on added/deleted lines.
> @@ -113,6 +126,11 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
>  {
>  	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
>  	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
> +
> +	if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD)
> +		return one_contains > two_contains;
> +	if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL)
> +		return one_contains < two_contains;
>  	return one_contains != two_contains;
>  }
>
