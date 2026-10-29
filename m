Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283458;
	b=chTdIcvdYy+Wr9nVZZmZrXn0sACyMsvKeBt72SBJkoQhSvbniY0R1A1H2m+bUPNnGLVd
	 u+8HLf8IzZTNkN87Mc22t8xCvbGf/lwhlLhCVNozgTIIFompz8IB+YbDx/XRDe1Bk/nyO
	 njQ90GsQEDcedJgNsc9EdeHwzkdOZpRLjPAqv1pQ7XjXg2eAyPxeku/qNsCyimQD3Nu6t
	 FHFlS2NzM0iHCTxg0UV3YG42mvgzOk4Tcs98D6RuJCVMR9Wo/l7BgBaw7GuNTx30znQkC
	 btTYaMwuW9JOTwFJttTb4Rc6upCqB5npPWqi9C6p/h/dOKVPsfcBelBHS/TgEex26yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=gL1cAGYkT4bPsuaW51pJmX7q92UP8CFE7nLAK9H4h2Q=;
	b=iUAphbxtTsHOTwkP3Zt3nOzfUdt8hj3uUrKOHwoXMH+Ma90t085xrbPpRT6tG9aW9kLu
	 FJf572l9T7PBfFHWxZGBmUI9eZ4oPch3i28/554pRGJA7+SFmXU90q0zl9//ty7nQMIc/
	 POMfJMh9XShpPzqss9qkxWt3SktPfki3FUyEFGddJsAyfqiKDZNMJawYvKYC5cKTZGQkP
	 FeqA8RICXaxvmOGAShpRVZQZPi2y8PTsRFnr+jdZppgSq7aa5kOT3DPvuMZ00rjsMGpti
	 HA32Ahs3kY2kfvdpV0C4ejU+lv1qNAcxl0H1HpR1mspRs7DPjlJySHaad0pLgt5q4pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9RAjKBU;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47658606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47658606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9RAjKBU
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b55859245so28913466d6.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283457; x=1793888257; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gL1cAGYkT4bPsuaW51pJmX7q92UP8CFE7nLAK9H4h2Q=;
        b=Y9RAjKBUEPWtZ9aN9H1SBKw9Ui0Lv+oNrhsU5HOuIMsnai1lM03sxkrHbslfwa3BTz
         RaHY9s6jClxwz4FYEBXcOeyKaXxGc1jS699JkfqKJVlcDfk+FGWOHO1FsGskcezXa7wR
         jeHnLuc8+85Jr7PopnwH3/496fQrYscDMGypiW6nHDGPGtoQyGBPCwc4/dz3+iKhT0y3
         lK3GYFiTg0yom/7PKbD8Tv7IHpA4MUihxNM2PAtu2tyz+Oz+RKG8ETLVLfdBxY3cYt60
         BhlhOUTS5Ak5y8AxK7ghIrnumIOS4VD7gjQ1YZpug+f78VXnk2DNzJg0zGP+u6vzpIkr
         1Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283457; x=1793888257;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL1cAGYkT4bPsuaW51pJmX7q92UP8CFE7nLAK9H4h2Q=;
        b=u+gQqg9yxHQQe3xO4G0TYWSNSNjkSlnimuZ6TdQGM73vGUuujhaz3FoDMEx75kTE+p
         jvYesWjz2e6l7ZTnFtb8CKndr9LWX2zAd3mgDxITh1+KGGGlQWBHFzW5yBnFg240psP+
         In6k811JawK8vP8guDQPWOmqALs3TIQJGfsk5qkJQiuj5qiEXAxgY7iMy4Dutbq6VZHQ
         1JQ1yhN4TsmQ92QIEG39vt4lT5g3x3X69GBARChIL/GsDEjp0DDNGxK3SSxqApoqiKUB
         Pev2hf/qGOUCffMr9mfbefgrJSt/XGvql2q6fWFtghdhXCuyM19zvgtm871jRrG9nJSs
         rIOw==
X-Forwarded-Encrypted: i=1; AKwUvBw2LM0edViKm61s9WuHbsO/1EaqqFC3NrNJmonBRS0n1IdPbAh1uj6wUSKyhjc7AOP+bjE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0RFodvtKkjcKUPkTzFxmd4j5WOEEogUlZ2Oy0Ha2x3p3oInI6
	An6+LU31N9Fl3bZydpuu4VkUE2Nt/dRTBWlwXx/MCsy4Ll3lgbtZ9IcsnkhR/g==
X-Gm-Gg: AYBFou2wjFgvdS9iLfMsBTaGs+clxPzrOJ482+xxfvTjlCyAhuc+mfoVLGXUUlb/RVP
	I4FuWbo/VsRI8YIAY+SdF4bPAHaTgBmkkH3EK7LLb3P9wJjimiZDqIN/qSFD//mPSX3NYzy9ov+
	gsGO4MwW65LYOmi9X3PqfCDhUrqQP+5U7GcEG/bsEawcsw0ZqJGeXgJvv8WW0ZGE4w+5xrsp0LQ
	EKnXz2/2Zd+KV0MidBKbWJIyIfdxesIPRonI2qIvattVRAAOo5e5aGC7g1Fm/St88uGgB13YRz6
	kAguYqZeT6VHfbs0FYtCDDKD2ghDADDUYy+1/C6aMmZ9X5W0shX0NUmuOuIfSfZ1p3APIpOld0Q
	WdK8XI4CoXn8+XWpqSSp94/k8m68IYNbzjfTkorPFGzSL44BbR8YoIexvNJ3YK8QJAWG2TZcKww
	5fK7TmISfouClVSdF+aqDJ93IepT9nF6UaPxatUKt8OZKFDri2jebxwPgv4KdOOoqF7uiw7sJ8W
	beSEfHR3OQc4i5MnNESKf0/EMHAiyaFM/ldhNSu3nfdwsTEMmlWECIhVV/eWgzk7PJdeUyRDFow
	xOhEOu0P+DzwG4KCZy2vUKyk3uc1PC8q2If/w9jnmvlVjN/xmnbOSNge5+sKM5tR0wHU97MSmg9
	eGclEbKp0JexWgyVbYbFxlhPkXmG5IkX/UVZL2cOE2wOuW7D4J9ZD/RCi4MxJEEC77CqKdz8gTo
	auZZU=
X-Received: by 2002:a05:620a:4515:b0:93e:6620:bde7 with SMTP id af79cd13be357-94408cf3ed5mr866182885a.20.1793283456927;
        Thu, 29 Oct 2026 07:17:36 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:c1f9:7732:784f:faa9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c879sm1541050885a.16.2026.10.29.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:17:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] bash-completions: add --[no-]graph-indent
Date: Thu, 29 Oct 2026 10:17:25 -0400
Message-Id: <E1710743-1244-4959-81AC-DAA4DFE4B702@gmail.com>
References: <DMHD8RCO7V74.2BK7C9T4HNLHO@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org, toon@iotcl.com
In-Reply-To: <DMHD8RCO7V74.2BK7C9T4HNLHO@gmail.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 29 oct. 2026 =C3=A0 09:54, Pablo Sabater <pabloosabaterr@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF[Cc'd Toon because of the mention]
>=20
>> On Tue Oct 13, 2026 at 8:50 PM WEST, Mirko Faina wrote:
>> Add missing completion for "git log --graph-indent" and "git log
>> --no-graph-indent".
>>=20
>> Signed-off-by: Mirko Faina <mroik@delayed.space>
>> ---
>> contrib/completion/git-completion.bash | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
>> index c3a49e2e22..2348a3cfb9 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2298,6 +2298,7 @@ __git_log_common_options=3D"
>>    --right-only --show-linear-break
>>    --show-notes-by-default --show-pulls
>>    --since-as-filter --single-worktree
>> +    --graph-indent --no-graph-indent
>=20
> Thanks for Cc'ing.
>=20
> I didn't know about this so I completely forgot to add it, however from
> what I read, this is the __git_log_common_options and I'm not sure if
> this is a "common" opt, as I don't even see --graph here.

=46rom memory, I think =C2=AB common =C2=BB means =C2=AB useful for multiple=

completions =C2=BB (common to multiple commands), not
=C2=AB commonly typed =C2=BB?

> I searched where --graph is, and it's here:
>=20
> l 2383-2409 'git-completion.bash'
>=20
>    __gitcomp "
> [more opts]
>        --graph
> [more opts]
>        $merge
>        $__git_diff_common_options
>        "
>    return
>    ;;
>=20
> I think it would fit better here (not sure, I just quickly skimmed the
> file).
>=20
> Also, I missed this for the --graph-lane-limit option so maybe it should
> be added too?
>=20
> My main doubt is, both these options proposed (yours and
> --graph-lane-limit) are --graph dependent, which means if someone
> autocompletes them but doesn't use --graph, they will get an error
> saying that --graph is needed. I'd say we do what other --graph
> dependent options do, but AFAIK these two are the only ones.
>=20
> =46rom Toon's Git Merge talk, more options for --graph option will be
> developed so we should maybe think about how to do it in a way that
> doesn't autocomplete if it's going to error? (maybe that does exist,
> given the multiple options that depend on other options)

Sounds reasonable, though I also wonder if these commands=20
could eventually be taught to give their own completion help
like all the parseopt users. =20=
