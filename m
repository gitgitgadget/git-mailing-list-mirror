Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4034322E
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721514590; cv=none; b=J4AxsLLF0aZgZMAShPlFlbBqxE+wqbWLP6ZqgaA99AOboW9XW3UCCYwSFaATu8gWEqcoYIgLJPz9DC/VDpwWt8reocTMGXepQsmhATJkKFlWiU0Lkqsq5rh7WbnwLaUcyBPfqXrWtTsMCQrKxgs58PxhqFUXi/Wn+r+djoWjcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721514590; c=relaxed/simple;
	bh=ku2a9XdAOGGE4veWXJ5cUZRco95xrxks9Pv0zp6gnFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBIisxmFr3FPS35nP+yTcbCSNVs1UBROLZosUJlGNGakrFC9fRXC1HRKJMXEhMdNoDnBM9RRyUijfWxFwqVpyT8/GWN2jgUWWBBeEv1JaZtwlj0AnrlKllOPiR19D727ITNjtfd4X1VmP2+FQaBQZNl8PCMOS8NlSeCIVZxJWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VespZ7x6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VespZ7x6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so24608095e9.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721514587; x=1722119387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZVfe7t0ewxvsgWy+xtQxuUk0YND9wIAEoIL3l6GY/s=;
        b=VespZ7x6xJGLnRMi1ZBGQbm3IxHP3d9SfRtzfttUUS3Ux42tRFrFrqCOl5W3s0enML
         AGFR+K7+trxaPOnQDvEhQ+kxczF666ZcFfZSjXx+RPTqlBkx5KhHVEZiRxTlc6PSuB0G
         q6XhRsP42NgRfyqG/DdGFRIfjOl2hzQd8Q5vVIZ+DXBlv4EdtWpDQ+kLte0G+EWfy5iY
         kb+uLcljSr9ns2/w7oEt7RsNWsUkpGM35qMGVQw7nlFSDpANhgbjQ/p1QDlE8b28OweS
         Y5D2yBZx8XKj7bKeC9s1p0LmdRRUgVnN1w4C7m7hAYsYxo0pPzB2FFdh0500OFkXkANV
         j9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721514587; x=1722119387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZVfe7t0ewxvsgWy+xtQxuUk0YND9wIAEoIL3l6GY/s=;
        b=kDVlIRB8jd2u5+GmCvUnbxgnYrPQOhQDLc0A4QxrocWBaX4/E0ko9HXKninsZYYa7G
         rtlw9o4Ck74NpZys8CwCaDPgAJmIRYMNcshM4XuXCVHDVUXI0rF3NiidqPxpZWuXrz4V
         frowO6sU6/Wr64y8+hqZs9+d/0q7VPulvGzMl6orHbsqPMjfn7XlN3Ax5MIWMZrXLXOn
         W7cdBsb9t7a8+KeZuYbF9WlgfuJL2vLe4XdqQjOBqJdKHueX/zViSg+MPs7mqsDtuz/5
         mx99mjZlFrwg9y56Rs8un5+W61ccU4PdU/3JZSY+NH/SfXQNPG0qHLt6bsWwn4/2He5B
         M9JA==
X-Gm-Message-State: AOJu0YzcFKYyXYSJiCrk9tig78pakd3jw4jcZAkLYtEbJa8rjeavhh71
	lgz30MLyZkUGPdn94PjdoM6HmW5eH1cpy5UBYmtepTT+7u26CNjt
X-Google-Smtp-Source: AGHT+IF9ifmsm5eOnl42fCOHEgWsfpEA11o6aZHl+3uXB77MzK2qku5KuaJnacj7T5vAqh9ulRhemA==
X-Received: by 2002:a5d:64ea:0:b0:366:f04d:676f with SMTP id ffacd0b85a97d-369bae3a43emr2197511f8f.12.1721514586582;
        Sat, 20 Jul 2024 15:29:46 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cf156sm4706612f8f.70.2024.07.20.15.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 15:29:46 -0700 (PDT)
Message-ID: <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
Date: Sun, 21 Jul 2024 00:29:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <88f9256e-04ba-4799-8048-406863054106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 17, 2024 at 08:39:12PM +0100, phillip.wood123@gmail.com wrote:

> On 17/07/2024 18:20, Rubén Justo wrote:
> > Squashing this fixes the test:
> > 
> > --->8---
> > 
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index c60589cb94..bb360c92a0 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -616,7 +616,12 @@ test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
> >   	test_when_finished "rm -f huge_file; git reset" &&
> >   	printf "\n%2500000s" Y >huge_file &&
> >   	git add -N huge_file &&
> > -	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
> > +	test_write_lines P q |
> > +	(
> > +		GIT_PAGER="head -n 1" &&
> > +		export GIT_PAGER &&
> > +		test_terminal git add -p >actual
> > +	)
> 
> That's surprising, why does running git in a sub-shell stop it from
> segfaulting?

The fix isn't the sub-shell;  it's "export GIT_PAGER".

> 
> > ---8<---
> > 
> > However, this error has exposed a problem: calling `wait_for_pager` if
> > `setup_pager` hasn't worked is an issue that needs to be addressed in this
> > series: `setup_pager` should return a result.  I was planning to do that
> > in a future series, for the other commented command: `|[cmd]`.
> 
> What was causing setup pager to fail in this test?

Because GIT_PAGER is not being set correctly in the test, "git add -p"
can use the values defined in the environment where the test is running.
Usually PAGER is empty or contains "less", but in the environment where
the fault occurs, it happens to be: "PAGER=cat". 

Since we have an optimization to avoid forking if the pager is "cat",
courtesy of caef71a535 (Do not fork PAGER=cat, 2006-04-16), then we fail
in `wait_for_pager()` because we are calling `finish_command()` with an
uninitialized `pager_process`.

That's why I thought, aligned with what we are already doing in
`wait_for_pager_at_exit()`, that this is a sensible approach: 

> > I'm wondering if the best way to proceed here is to revert to:
> > 
> > diff --git a/pager.c b/pager.c
> > index 5f0c1e9cce..5586e751dc 100644
> > --- a/pager.c
> > +++ b/pager.c
> > @@ -46,6 +46,8 @@ static void wait_for_pager_atexit(void)
> > 
> >   void wait_for_pager(void)
> >   {
> > +	if (old_fd1 == -1)
> > +		return;
> >   	finish_pager();
> >   	sigchain_pop_common();
> >   	unsetenv("GIT_PAGER_IN_USE");
> >
> > This was a change already commented here:
> > 
> > https://lore.kernel.org/git/3f085795-79bd-4a56-9df8-659e32179925@gmail.com/
