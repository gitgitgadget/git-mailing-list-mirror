Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214490;
	b=Yrkqxc5LtV2u7DKVR7n6hFakL6MWQ6mxn6SUgCHEsJB7eGcSwsY16dHqFFBLCLSkTXFq
	 N15PHaSeGedV5j2zsYnhL44s0BIkIuvrI70BOR25xu7/Uzib2wy7PVq4AhI80We5E0vG8
	 0dr6IO3xqHrdM+mA9KmGvVCMLctkwY7TPieiUEapzI1UiFefi/bfPI4Avgy6RWk+UNhD9
	 SK9vSR1GWsHa5fkpz4DCCao2I0mlVJipcf/9HES0cjd+Tk5eIoESrtGhJW6oDaNyzYYYQ
	 LO78C4IeLHwHc7NTJavOPcv6CrYMf/8ZcDfwHJunpXQHwlTuvZpbRbvD51a5WDHEr0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214490;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oylL/rH0ZIo5Ybskf2/ljVk2WShua+VSJOt5QUtZyKk=;
	b=jCdT/hKMv6OmZ5AC0SgzG+OefYiit3wvEy8/CVbsmseKdBuRr9gniUI4tc26Hqq9ByPG
	 UuxMvff55GVqJF+pFK05Unvcve3C1qVvy0ygB7EqW1fxgcHyxP5M4334lrUUccHdb5/gV
	 H1Ad+gvRsrJqQBZ88d5hSvDSgHtLX7R23yfwsyBxHDDVBBu9VeaTCCxh5RpPxb9/NNfbi
	 CgSGE2zzQbNw3BkWSTQYJHtlVDFXMPZFr+AK1mpklytQAdCR5M3zKP6l51B7Tm9mLOXpB
	 3SfpLu3la5FzaV9R84f+h2GqVsDYXb3m9HkVR4oBWs9qR63TO1MLcgbKwKgMBpuVSHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=E6np9G4F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zMJVyPf2;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237D606A68F
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2237D606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=E6np9G4F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zMJVyPf2
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60DF71400036
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:41:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 17:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795214488; x=1795300888; bh=oylL/rH0ZI
	o5Ybskf2/ljVk2WShua+VSJOt5QUtZyKk=; b=E6np9G4F8aCAwZsuimR9MdFpMa
	va6c2CvYl6jF7rUkYmD/XVtPBVDXIHNiBH83jv6ZH271EEqmkyVlSHsS0oGO0ucw
	YbAYhxBo5OS/hzYST+e8T+VGgVahJs2v/0mJsL9OWX/RG7jlI0rIdx56MiTsMUy0
	tretvjRzPEga5zsZq0PmyivoDi2Z/54JjNNki8lqHiDINZBzBgZYxuDf0OBij5Fo
	Z4oiS2XvWZDOqXRoYc9/wMkx3QjPkIPhSJltGSVf+RWMoWLEprMtUvGjmsenmHHy
	kIfBZMNPyn5n9coPjaO/9uaewOeBXAHKYnx4CUNpUPSAb6szZGhZTnKnxGMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795214488; x=1795300888; bh=oylL/rH0ZIo5Ybskf2/ljVk2WShua+VSJOt
	5QUtZyKk=; b=zMJVyPf26iXQFRsGeDD67zlncnTmOLEOZdJNJOr8BZ8l+bm+9I4
	WtWZPptvVBfJK7unHzpC7zPfw+J7XLJdawbMntYT4GABeFsiiicAu5JyztVG4uRN
	cPSq+y1ZsonM6QClcMJ4uFxChOBtDZSXtvrPLfLo6+i/CSSwJaHqVLrTILpawiJ1
	PSxijM05UXp0L3vl6Zxra+gwAkYpww+LaKvSupsuQ2aix3MuH8fdL3G3QdBY8lp/
	lARJ7yV/ETHsQ5Ndem5BjX96UPp7oCBwvFNv/F+dCXAErKgDKphvgnkcOK1agdZ+
	1QCWu1buaCZx/JKEwo1Hgl33I8OltLAYSAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795214488; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:V8200moULLjIE8YzokuN+eGlRdjX0K1NaVibRmVzAjqqWdb
	OtQSCJx0+pabYhS9YVBS8rO7nhUgV9cGQnHCpmAZbMRO2+xg6H0Z2JbQA/rdQzHj
	mJkppPLzeRTCw3BOkOp8yqEF/GXDoNomvmJVZKLC1DFsIJb084sDk1SRR685Oylg
	Q39EsJ6bE9whvG0Smyc5ykacdrV/S/oSIG44tziYViOigiMf69ZJ5RDvwRn24/1O
	DH6GuBygCAIiORlze8nOhJjd/U33YVGqg7dDEFWTFdRzlZvsbTRDe22FoqXZF3JN
	kci84Xbh4bf9s4ST2PLO/h9Kf3cEdU1S6/HZSqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5VJXg39CyBzKx08kdAYStkrV7NbUuWiH6N8T3bYpe/E=:iJVmvPSYD5ptahEv9ffH4sUUvTmRwkFulb6y3UyFaQ0=;
X-ME-Sender: <xms:mMwAa-1m0gIDo6paWt7SA60NXy2dwmRxOy47hppJVjXgPPw6nXuwpw>
    <xme:mMwAa0wC_JtAV5OrhjlQfpBC9cILZO8rG5Ntp7cOx7HC16pgrYjDDWGsVKveLGGdF
    L2CpJ9I9OzNm7kzNy9w4dr_aFSgruqiaMQiTuIB4L6wOTZQx8MQcko>
X-ME-Received: <xmr:mMwAawudMCOIvb30gMT7VDp4dMeutcMx8x59T9U3GMdpYT8xVA1NGNgp5HqvjYRYh18MJWLyGt7sRJj3Fih8Cjupv2JyVE2o3sw1>
X-ME-Proxy-Cause: dmFkZTF2K7UkQND6D3u4Y6mMMTfctKE0L5ZTO5chEuDgag7PIzxfSyNJgDrWu8xI1pnh53
    ldyjMsQPG3AESS2/gS3H8smm1fDGdEbB970aQrzQiUmycXP5/30C/FCSqYdWaTHlAWnn4p
    7z73nOpAOmVjvPxlqwXQFtzsceLuypF8lhZ1yNgQKypIb5F3nr4pyxzofyZ3ET0Tc4aQNq
    WCz5odhNA1M0LNJTCebm71k9CrE0ED/UuzRkWHx6UCUJY/ZAUR4nl5ezqHM5lpgaeffTzC
    n42QALfNP/jj3ziqd9Tmhpen96cQ7f1VJEo7k5TI6xhcjADxEEfx1OKERJaZkR5lTBTJSH
    xugyiV9xcFaCuEN8EeNW/5ofGpRNxJMFQl/k7kvuoT+QXtngEhkR8jahOyeAeZKk0ublJE
    P9s0DqA/pP8aXS5Ln7I0pxu5bZm70ut5vFeG59uBcxBTA7ToOle6g0HMBQbcFOBW0VpP/A
    5f29Su91hZeVhGmAKZYVnNxH5xSSm36NFJUgDFjqPnjyNgpTupihw9v4c++bpRSoTldFdE
    P73d2INAcOokN82ptQT1q/qc+l+iAx5+92tmSx5sPgFODdg55YjLEtaji3zDDHd+myqgM2
    RvENxIvZMTYxz3yybhW/PvvuPi82jXhgqVhGMg+38IhBdZU3QpDVfIC21zag
X-ME-Proxy: <xmx:mMwAa2wv3NyykNpZ9n50J-Ou39kaxlzaU7niQ-9t6Gf_5EhQoBwFdA>
    <xmx:mMwAazAIYaIk_be87x5bbGB7rFw8yYft1HZ40sx_qVEg6KI_6u2HdQ>
    <xmx:mMwAa0e7GwykS9ySSNQQUnFGaF9iFXUThZlEuHBSsl2_qiqsI8imdw>
    <xmx:mMwAa9n9jFeSkbvnxKsUiAYkfdIEuGLe_-YVIhsDbpOgCtz0LlzD2Q>
    <xmx:mMwAayvg0LpWDO3MnAykqBI8px_u1Jp0HyMc-_nS-Va3JvoXcBARYry2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 17:41:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] object-file-convert: copy unknown commit headers
 unchanged
In-Reply-To: <26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
	(Adrian Ratiu's message of "Thu, 19 Nov 2026 16:18:22 +0200")
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
	<cover.1794932695.git.adrian.ratiu@collabora.com>
	<26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
Date: Fri, 20 Nov 2026 14:41:26 -0800
Message-ID: <xmqqa4n3nn1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Make convert_commit_object() copy unknown headers and their
> continuation lines unchanged, just like convert_commit_extra_headers(),
> so both give the same compat object.
>
> The author, committer, encoding and gpgsig headers were already copied
> the same, so their separate cases are no longer needed.

In other words, we note the headers that carry object names on them
and make sure we convert these object names, and pass all the other
headers intact, since we do not have to even know about them.  Which
makes sense.

> diff --git a/object-file-convert.c b/object-file-convert.c
> index 63ee18630b..ae21eedc3d 100644
> --- a/object-file-convert.c
> +++ b/object-file-convert.c
> @@ -167,7 +167,7 @@ static int convert_commit_object(struct repository *repo,
>  		if (!eol)
>  			return error(_("bad %s in commit"), "line");
>  
> -		if (((bufptr + 5) < eol) && !memcmp(bufptr, "tree ", 5))
> +		if (((bufptr + 5) <= eol) && !memcmp(bufptr, "tree ", 5))
>  		{
>  			if (((bufptr + tree_entry_len) != eol) ||
>  			    parse_oid_hex_algop(bufptr + 5, &oid, &p, from) ||
> @@ -179,7 +179,7 @@ static int convert_commit_object(struct repository *repo,
>  					     "tree", oid_to_hex(&oid));
>  			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
>  		}
> -		else if (((bufptr + 7) < eol) && !memcmp(bufptr, "parent ", 7))
> +		else if (((bufptr + 7) <= eol) && !memcmp(bufptr, "parent ", 7))
>  		{
>  			if (((bufptr + parent_entry_len) != eol) ||
>  			    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
> @@ -192,7 +192,7 @@ static int convert_commit_object(struct repository *repo,
>  
>  			strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
>  		}
> -		else if (((bufptr + 9) < eol) && !memcmp(bufptr, "mergetag ", 9))
> +		else if (((bufptr + 9) <= eol) && !memcmp(bufptr, "mergetag ", 9))
>  		{
>  			struct strbuf tag = STRBUF_INIT, new_tag = STRBUF_INIT;

The explanation in the proposed log message did mention these three
headers, but I do not think it sufficiently explained why comparison
started to include the equality case.  It said:

> The "tree ", "parent " and "mergetag " cases only matched a line with
> something after the space.

I do not recall the details of "mergetag", but I fail to see why it
makes sense to start copying a line that is "parent \n" now.  If it
is not "parent [0-9a-f]{algo->rawsz*2}\n", do we still want to pass
it to parse_oid_hex_algop() in the body of this "else if"?

> @@ -223,17 +223,26 @@ static int convert_commit_object(struct repository *repo,
>  			strbuf_release(&tag);
>  			strbuf_release(&new_tag);
>  		}
> -		else if (((bufptr + 7) < tail) && !memcmp(bufptr, "author ", 7))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
> -		else if (((bufptr + 10) < tail) && !memcmp(bufptr, "committer ", 10))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
> -		else if (((bufptr + 9) < tail) && !memcmp(bufptr, "encoding ", 9))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
> -		else if (((bufptr + 6) < tail) && !memcmp(bufptr, "gpgsig", 6))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);

These are "headers we know about, but our knowledge on them do not
matter as we are copying the bits verbatim" cases.

