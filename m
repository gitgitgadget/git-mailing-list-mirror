Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309314;
	b=ojI9k+QS/4xb1p5gqChQssVGF1+TLEMNAyyiWKa+QK6Zztow97kLVqtf7F+Rwj4yP0Nh
	 2WecZkx2U9X7QBfGLo7qKaaIdHgDEoyCCmjPc2/Rz8vO/xztDU+dViHJ4XtrEiM7ArNWo
	 8awuKzXvL5s0PwvLnisitzc8h5sZQ/grgzofxe1+Iafc5YzP5P8jFgZ8g5q31F11uvF/+
	 aeefD55bJv1ISRdQ9o0KBUqXE4vHih3DS4vv33FE5FdBEZZtfIQo8oRatotfRU2hS9rF0
	 frdx1eSGHLQmWGNj/xmrxmRLUr1s54FsRczuU4tT2dzORBiok7nGhm8jZryOwWUmbxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V76xTQhjXc98jOqU73kLNGML2cNykIjtckZLpJWX3T4=;
	b=1oUtjvnlq7SqShOzhZCRUdYZP7AQwOK/QfNP/ikGFi55vmPvQ/EhlvXvx+/YOnYfbcqO
	 lSMN63bM/YVOLcPJFMslWzpU6eu4XMrJTpjF3XiuzbRwkMPYywnZOrBMp+JoPWozIv6Ui
	 uQc90sIHFNy53tiPTDzMcuXeiQizdiPJRvFleBpAPGt6M61ETYNsrAp0koG4JaUmWrrlr
	 xYXuId1iLx1EpeK/vb0cKBuYfEN+QfpB5nLciwELQoJbtxJmdnCler9XRYDmj/ljPS4Yb
	 9zryaqiDovyq92LVPzEg3cZU7n2RWc0z3JRkCF1j0BcMHtdJMYqCpgY6EMsfONfrytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRoqijYu;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310C606A337
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A310C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRoqijYu
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491846221ffso1322752f8f.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309312; x=1794914112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V76xTQhjXc98jOqU73kLNGML2cNykIjtckZLpJWX3T4=;
        b=gRoqijYu0zAEgNhDb/LjP1F3r09FOhnvpZZyARIYV+8yEZLG8AVEKuauNjWF1Gavpx
         YcXYcBD+opj8wMOSQqH4b1Hd6nIZNxvgWTTQcGUHV5IWMxp5ZbilFs745qrqvP7IaM9V
         UdwsNL9iFvuOnvmp9k+KrRiyDWLMoVBPZPSIMykqNarmHVpartcpLwwa5hRihFT40VhS
         HsDI6y4bxtG1tWrgFv4FmyWSbuJk0i8B4oyGvlpNWEJq9ZrnB/9HhqAW0Mc2LKW2H1iP
         Pb1uQRF5hXvJtv4ZrCFZuJxamOjL+SB8Gzue1z4DQ/LC3K2zWKi5m285L+DkzMUYTqFP
         Xc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309312; x=1794914112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V76xTQhjXc98jOqU73kLNGML2cNykIjtckZLpJWX3T4=;
        b=0u9kzRoaYnAzAl+AgG0HQ/+liWcAYf9Bwr6mSNN7auUMAGnY1D4ovWFg5naG1MvCTa
         0gheCMtagK5ReqxcqnbMNUp8JAHU0xPCDykzMNuTIEqC2HnSqC/SCKTjctvz2Ug6dfv5
         YYVRznNCi8AswPV6lxqPU460gVfZupirHoAinX5IJMfs1Lt8F2dlcNHMB4DI/r/QDMIe
         pmxH73Q3mAKPvCDRs9oqsMO/fhNEWLfeN53S/LSgAWRJgrpXuTZAEA8sXi2kyGHeSZX1
         d2LglMAudbyKvInxHOui5FiuRtX/Do9rAENYUtcl7Cn3niUuVTP9wETYEdU8LHW48Yo2
         pnIA==
X-Forwarded-Encrypted: i=1; AL+hErGcqzpxKXlWLGlPDGM+d6D8as6AYqvfnQlTwpHnYAspsCTbJVvJxIaxE69B3e1w+xa0tDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O3X6KWwZPgf7B6b9L7A2de44kivR4p6nDYk7M0W2tB0G1ocdg
	TWBQSjfzyX/lXVlzNL3FT3VuUXYkFn0mPhfw0F/fTeo08mhKxnoylfdC
X-Gm-Gg: AYBFou1ZKmi3WxCCvAZGXL+4ScFeNgPVVIlUlZr/+FMJY4ExnwpTbyobBN8ElsmN84q
	oQgA8QR/BfUhUaaVnUZB3A2vYlBuTUmJcWEnvookosPaEXb0qK23FrNd+xcvR0C/z+FlM6RXZN/
	4/VY2kSKXdXA5rDNDpEHK4jpj35RSK0wPbzv1X5e+BteKzQP14JUdVoJsl7xy75l302o2AJ8ynS
	NR0IwOqF3F/9AxHM82hDobZvpBdB2ntMBWVXcWJjlqZNSSg3x0/xdofroYQFRCcpx2OBCxw2/ni
	k5d4IvtljrMGOb5tvzmrZ/q3vgTmjvCMMK0jGNvQILmH4M4+tfBnQLSoq4b5mSQpjwzYHouGhu1
	OIQkKLwxfMqT3WYdTd42cfGzEoQKvVPflrLQ+tChU0qmXSwvYxyeJslW08/fDsCnEyePrHg1rP5
	x/oDbzxhcoLRei0hwDP0FQOrwOQ5Y3O6NH7lRSCKEAI8xxgAyi+w94o2yT5pcu8QvKjRQncwckh
	E/iHgh28Gto7GQTMf9rsoqjQF3Dr3PoLs56LebYTmXHE3669BkHifBHduSZaAURUX4zVC3OBmoW
	lVttPp/5mQf0Wt/ivIviwD9y6qUi8Lh1tS9lXxIF10GR8U2gO9ab5A8n7ycweh67sbHditoWoL8
	1iLo3RKOW
X-Received: by 2002:a05:6000:26c8:b0:48e:669b:76e9 with SMTP id ffacd0b85a97d-49830d818famr4735695f8f.47.1794309311783;
        Tue, 10 Nov 2026 03:15:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c99bsm4572527f8f.7.2026.11.10.03.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:15:11 -0800 (PST)
Message-ID: <fa01c0c6-bd7d-48cf-bcaf-48a516053ebf@gmail.com>
Date: Tue, 10 Nov 2026 11:15:10 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/15] rebase -i: handle NULL value for
 rebase.missingCommitsCheck
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
 <47224a9893e9cf87c0ee16bd1a79cf1355694175.1794296205.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <47224a9893e9cf87c0ee16bd1a79cf1355694175.1794296205.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 10/11/2026 07:36, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> A rebase.missingCommitsCheck without a value, as in
> 
>    [rebase]
>    missingCommitsCheck
> 
> or "git -c rebase.missingCommitsCheck", makes "git rebase -i"
> segfault as it writes the todo list: get_missing_commit_check_level()
> passes the NULL value to strcasecmp().
> 
> The setting takes "ignore", "warn" or "error". An unrecognized value,
> perhaps one meant for a newer version of Git, gets a warning and is
> treated as "ignore". Treat a missing value the same way.

Sounds good

> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 809f76a87b..9eb70b09b3 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -30,8 +30,14 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
>   {
>   	const char *value;
>   
> -	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
> -			!strcasecmp("ignore", value))
> +	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value))
> +		return MISSING_COMMIT_CHECK_IGNORE;
> +	if (!value) {
> +		warning(_("missing value for option "
> +			  "rebase.missingCommitsCheck. Ignoring."));
> +		return MISSING_COMMIT_CHECK_IGNORE;
> +	}

If "value" is NULL  we print a warning and continue as if the user had 
said "ignore" - good

> +	if (!strcasecmp("ignore", value))
>   		return MISSING_COMMIT_CHECK_IGNORE;
>   	if (!strcasecmp("warn", value))
>   		return MISSING_COMMIT_CHECK_WARN;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index b3ee96f560..5b9fc67c19 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1562,6 +1562,18 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>   	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>   '
>   
> +test_expect_success 'rebase -i warns about and ignores rebase.missingCommitsCheck without a value' '
> +	rebase_setup_and_clean missing-commit &&
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="1 2 3 4" \
> +			git -c rebase.missingCommitsCheck rebase -i --root 2>actual

Because this uses "--root", it is hard to tell if it is dropping any 
commits or not. Using something like

	FAKE_LINES=1 \
		git -c rebase.missingCommitCheck rebase -i HEAD~3

makes it easier to see we're dropping a commit by looking at FAKE_LINES 
and the upstream commit passed to rebase.


> +	) &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&

This is quite common in our older tests, but makes it very hard to 
diagnose test failures because it does not print anything if there is an 
error. These days we can use

	test_commit_message HEAD -m D

> +	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
> +	test_grep ! "commits may have been dropped" actual

We check for the error message caused by a missing config value and also 
check we don't complain about the missing commits - good.

Thanks

Phillip

> +'
> +
>   test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
>   	test_config rebase.missingCommitsCheck ignore &&
>   	rebase_setup_and_clean missing-commit &&

