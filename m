Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7902C683
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjX7GGLJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e5f746ac4so49826645e9.1
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 03:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705317881; x=1705922681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK8LDrXL1TLcqhSA8GgpVmTELfShouUSoYm2lqgQovM=;
        b=LjX7GGLJHa73TkYeVugcHMJPmEGyjSoYLfTPUal++6TcxvvioWLYXZT+xEnrYGZJoH
         eZ+vO7Mv8L4FSXolSuJfwkDcbxUKS5pHaZCLbqekAYrlxKV7vtnEPCFrZIlT5ox+c4vC
         QHxbQY1dBAB4hKifboBXJzdTb2UQm4ATe4z6KtClrcc8hGGSAlTNIM7B3TabFp5X4CKB
         mFkJlq8Sr9PlQed1GQZECyGP7mgmpGayD64Ifc675WOb8cYC5eK9vqHhV8b51mnSE/Uu
         /XjlYHFR6z/kZhOVA/P8cr2tsB4rMLrzTC4LvBwArEEmqVRSJ2Rnxo2Ue1naA7Kg+VPH
         I7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705317881; x=1705922681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK8LDrXL1TLcqhSA8GgpVmTELfShouUSoYm2lqgQovM=;
        b=rRcxk5OQwXOlei5SzYYxzEoOQqfOMRnhRmT5lkHRWp6zrNjyoPgyv2Mu6a8Zrx08RJ
         iV22+j2LHn8eaWrYU8yGp/QiYFvw+w8V5rde2xW4XxGcFOmP7tjYshUZXZDF089pC3Kb
         AvPTkOSHSMVja++GWQv/WrKZtnTPoD9svGMzQ32MJdm7f38VejFP6RsEKFr8VHY7GVp2
         Pj4TQYnnuxc+RGuxUntbDeAa+4/fqP5iOXdHvza7dxurGBVckSCU+TYu4J0yPDu/DNO6
         1M7IOV3s1BKfqF/LD7yNSbVA8hW6UGZBoYeUdRxGoNxA1hp2OXLEWvcERwV3kLaFfwre
         Iwig==
X-Gm-Message-State: AOJu0Yzkh62AAG8bKTHC0P1USnPwBQs51RpbJlPH7+A/tW1PbLIR3pJC
	RLc71EQvd3+/28HgaTrtjEk=
X-Google-Smtp-Source: AGHT+IEoCOct7d7NQeNyi8q7FgOeoBPfY65TRtRZHKtL+g+dcVV8sMnsgFF1kxYyTFaDXMq3iZCKIw==
X-Received: by 2002:a05:600c:1c85:b0:40e:555e:ebff with SMTP id k5-20020a05600c1c8500b0040e555eebffmr2917526wms.150.1705317881237;
        Mon, 15 Jan 2024 03:24:41 -0800 (PST)
Received: from gmail.com (195.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.195])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e45799541sm19398605wmo.15.2024.01.15.03.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:24:40 -0800 (PST)
Message-ID: <7cb6cae4-3de7-4c2f-8e4c-ea653b6b802f@gmail.com>
Date: Mon, 15 Jan 2024 12:24:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: allow disabling the automatic hint in
 advise_if_enabled()
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
 Jeff King <peff@peff.net>, Dragan Simic <dsimic@manjaro.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com> <xmqqsf326vpn.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqsf326vpn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12-ene-2024 14:19:32, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >  advice.c          | 109 +++++++++++++++++++++++++---------------------
> >  t/t0018-advice.sh |   1 -
> >  2 files changed, 59 insertions(+), 51 deletions(-)
> >
> > diff --git a/advice.c b/advice.c
> > index f6e4c2f302..8474966ce1 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -33,50 +33,56 @@ static const char *advise_get_color(enum color_advice ix)
> >  	return "";
> >  }
> >  
> > +enum advice_level {
> > +	ADVICE_LEVEL_DEFAULT = 0,
> 
> We may want to say "_NONE" not "_DEFAULT" to match the convention
> used elsewhere, but I have no strong preference.

The "_DEFAULT" name is rooted in the idea of having a default but
configurable value.  I'm not developing that idea in this series because
I'm not sure if it's desirable.  But, I'll leave a sketch here:

diff --git a/advice.c b/advice.c
index 8474966ce1..1bb427a8d8 100644
--- a/advice.c
+++ b/advice.c
@@ -39,6 +39,8 @@ enum advice_level {
 	ADVICE_LEVEL_ENABLED,
 };
 
+static enum advice_level advice_level_default;
+
 static struct {
 	const char *key;
 	enum advice_level level;
@@ -122,7 +124,9 @@ void advise(const char *advice, ...)
 
 int advice_enabled(enum advice_type type)
 {
-	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
+	int enabled = advice_setting[type].level
+		      ? advice_setting[type].level != ADVICE_LEVEL_DISABLED
+		      : advice_level_default != ADVICE_LEVEL_DISABLED;
 
 	if (type == ADVICE_PUSH_UPDATE_REJECTED)
 		return enabled &&
@@ -139,7 +143,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 		return;
 
 	va_start(params, advice);
-	vadvise(advice, advice_setting[type].level == ADVICE_LEVEL_DEFAULT,
+	vadvise(advice, !advice_setting[type].level && !advice_level_default,
 		advice_setting[type].key, params);
 	va_end(params);
 }
@@ -166,6 +170,13 @@ int git_default_advice_config(const char *var, const char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
+	if (!strcmp(var, "advice.default")) {
+		advice_level_default = git_config_bool(var, value)
+				       ? ADVICE_LEVEL_ENABLED
+				       : ADVICE_LEVEL_DISABLED;
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
 		if (strcasecmp(k, advice_setting[i].key))
 			continue;

The way it is now, "_NONE" is perfectly fine.  I'll use it.

> I do have a
> preference to see that, when we explicitly say "In this enum, there
> is ADVICE_LEVEL_DEFAULT and its value is zero" with "= 0" in the
> definition, the places we use a variable of this enum type, we say
> 
> 	if (!variable)

OK

> 
> and not
> 
> 	if (variable == ADVICE_LEVEL_DEFAULT)
> 
> > +	ADVICE_LEVEL_DISABLED,
> > +	ADVICE_LEVEL_ENABLED,
> > +};
> > +
> >  static struct {
> >  	const char *key;
> > -	int enabled;
> > +	enum advice_level level;
> >  } advice_setting[] = {
> > ...
> > -	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
> > +	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
> > ...
> > +	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan" },
> >  };
> 
> It certainly becomes nicer to use the "unspecified is left to 0"
> convention like this.

Indeed, that's my feeling too.

> 
> >  static const char turn_off_instructions[] =
> > @@ -116,13 +122,13 @@ void advise(const char *advice, ...)
> >  
> >  int advice_enabled(enum advice_type type)
> >  {
> > -	switch(type) {
> > -	case ADVICE_PUSH_UPDATE_REJECTED:
> > -		return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
> > -		       advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;
> > -	default:
> > -		return advice_setting[type].enabled;
> > -	}
> > +	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
> 
> OK.
> 
> > +	if (type == ADVICE_PUSH_UPDATE_REJECTED)
> > +		return enabled &&
> > +		       advice_enabled(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
> 
> I like the textbook use of a simple recursion here ;-)
> 
> > +	return enabled;
> >  }
> 
> >  void advise_if_enabled(enum advice_type type, const char *advice, ...)
> > @@ -133,7 +139,8 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
> >  		return;
> >  
> >  	va_start(params, advice);
> > -	vadvise(advice, 1, advice_setting[type].key, params);
> > +	vadvise(advice, advice_setting[type].level == ADVICE_LEVEL_DEFAULT,
> > +		advice_setting[type].key, params);
> 
> OK.  Once you configure this advice to be always shown, you no
> longer are using the _DEFAULT, so we pass 0 as the second parameter.
> Makes sense.
> 
> As I said, if we explicitly document that _DEFAULT's value is zero
> with "= 0" in the enum definition, which we also rely on the
> initialization of the advice_setting[] array, then it may probably
> be better to write it more like so:
> 
> 	vadvice(advice, !advice_setting[type].level,
> 		advice_setting[type].key, params);

OK

> 
> I wonder if it makes this caller simpler to update the return value
> of advice_enabled() to a tristate.  Then we can do
> 
> 	int enabled = advice_enabled(type);
> 
> 	if (!enabled)
> 		return;
> 	va_start(...);
> 	vadvice(advice, enabled != ADVICE_LEVEL_ENABLED, ...);
> 	va_end(...);
> 
> but it does not make that much difference.
> 
> >  	va_end(params);
> >  }
> >  
> > @@ -162,7 +169,9 @@ int git_default_advice_config(const char *var, const char *value)
> >  	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
> >  		if (strcasecmp(k, advice_setting[i].key))
> >  			continue;
> > -		advice_setting[i].enabled = git_config_bool(var, value);
> > +		advice_setting[i].level = git_config_bool(var, value)
> > +					  ? ADVICE_LEVEL_ENABLED
> > +					  : ADVICE_LEVEL_DISABLED;
> 
> OK.  We saw (var, value) in the configuration files we are parsing,
> so we find [i] that corresponds to the advice key and tweak the
> level.
> 
> This loop obviously is O(N*M) for the number of "advice.*"
> configuration variables N and the number of advice keys M, but that
> is not new to this patch---our expectation is that N will be small,
> even though M will grow over time.

I wonder if we can drop entirely this loop.  Maybe a hashmap can be
helpful here.  Of course, this is tangential to this series.

> 
> > diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> > index c13057a4ca..0dcfb760a2 100755
> > --- a/t/t0018-advice.sh
> > +++ b/t/t0018-advice.sh
> > @@ -17,7 +17,6 @@ test_expect_success 'advice should be printed when config variable is unset' '
> >  test_expect_success 'advice should be printed when config variable is set to true' '
> >  	cat >expect <<-\EOF &&
> >  	hint: This is a piece of advice
> > -	hint: Disable this message with "git config advice.nestedTag false"
> >  	EOF
> >  	test_config advice.nestedTag true &&
> >  	test-tool advise "This is a piece of advice" 2>actual &&
> 
> OK.  The commit changes behaviour for existing users who explicitly
> said "I want to see this advice" by configuring advice.* key to 'true',

Technically, when the user sets any value.

Maybe in the future we transform the knob to have more than two states,
beyond yes/no.  At that point, current rationality would still apply.

> and it probably is a good thing, even though it may be a bit surprising.
> 
> One thing that may be missing is a documentation update.  Something
> along this line to highlight that now 'true' has a bit different
> meaning from before (and as a consequence, we can no longer say
> "defaults to true").
> 
>  Documentation/config/advice.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git c/Documentation/config/advice.txt w/Documentation/config/advice.txt
> index 2737381a11..364a8268b6 100644
> --- c/Documentation/config/advice.txt
> +++ w/Documentation/config/advice.txt
> @@ -1,7 +1,11 @@
>  advice.*::
> -	These variables control various optional help messages designed to
> -	aid new users. All 'advice.*' variables default to 'true', and you
> -	can tell Git that you do not need help by setting these to 'false':
> +
> +	These variables control various optional help messages
> +	designed to aid new users.  When left unconfigured, Git will
> +	give you the help message with an instruction on how to
> +	squelch it.  When set to 'true', the help message is given,
> +	but without hint on how to squelch the message.  You can
> +	tell Git that you do not need help by setting these to 'false':
>  +
>  --
>  	ambiguousFetchRefspec::

OK.  I'll add this.

Thanks.
