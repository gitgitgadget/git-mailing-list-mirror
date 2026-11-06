Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006994;
	b=1FLtpGdP+UJ+TL8WBLz+pkgjtDc5O1XdOO6FQfNlbEx0P/jWuOKwg5iY1+CHH/e2MQVM
	 zs3bkqxipGMWQBIPn0NRp+Wg5OWxqj0CxLqFZ9ERKFBBFCMajdXKgkxnlyhIuU1uHtnIz
	 Al2JYkhmhS5MX9cjuDcd4CnYrqCx7io26UQpeOMOFQ53z73w94ZcLM85IYpUniVUS6m3o
	 8ek3qxCpZtqfalYUBOZfcIqRMvy7TSri1eF6Oo2K3gOaVNnT2sAfsGxOvJ255XG6QQeTg
	 UNBh/7x5HCxi6QZMveGVDQr4s5G53u8UAlE/kUd+hHXzDPJZbreDaf8abFMJpxJKyHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006994;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=YDAycdAIt54fLeNP7oWWJJrv5bBDx6WlvTW0OGJ8YaU=;
	b=rmSxGIgU2HuArGdTYHh7Cgtr5CeKJC071pUh8zhVCMgvxLSJgYvyy6CTJSub6f03USzD
	 hiAxvi7PUoPp1bXuLZobQTvyL0DVoxRXiPUEk3+CwZAEyQvvuAqI+uF8X0Q7cMuxgnCm8
	 ErwzFTkqjpMZ1dKrdIEupLYGmkDGvz/9KWEkfKjL+g/pidWVvYXMACk1vOaYDuzeZTZz+
	 6zyOAYfWknMPnEGWxf7Oy8WNlhUhCRxpeNXQAab6GWiKUHU7sfAdYczeu8HP2VgGiqfFD
	 RVoGPYUByMYHhoXlAnR3zdgOITt0PB/llgfI/f2tAn0qig6gCNkB94hXZ4v3L3eqDhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ktpni7xX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hqbyvAkL;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7D606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 23:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E7D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ktpni7xX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hqbyvAkL
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 66B9FEC014B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:16:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 18:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794006993; x=1794093393; bh=YDAycdAIt5
	4fLeNP7oWWJJrv5bBDx6WlvTW0OGJ8YaU=; b=Ktpni7xXp4EeGf9DDpdbPuySEM
	5f/qvx7MhpKaQM53v/4R171PqE47lbfwF6XHYxQe6XGIRXV+W3bLark2qdZ7xRff
	RTOi3aBAFfbQm5C2bDbsFg80cKthKc1J5PMSqfgUcGe1okMzxivx31mEFEdpK+Oa
	6JfFYDfEnAGQVWSNKSrsScVVkKVFpQGAtgod92B4sPoqWn6HniwyIl4wKz84CzGw
	ggjHBhRN6QRXFH4KO11eCHnJPwFb1X+u5Xju7GdJEePiZwQIuTRzcdAOpF3PPEyH
	irTgUleYKeUbRWM4JR/uA22zW7j2I3E2Teu2OwuIS3htb48/T0evRoZou1pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794006993; x=1794093393; bh=YDAycdAIt54fLeNP7oWWJJrv5bBDx6WlvTW
	0OGJ8YaU=; b=hqbyvAkL/6mgiCDVvttU645O7Zy6CD2dCfYKztosF6KMUAjVv12
	lF3WkYNEMna2oj3xlGXEMlNXIVPbmv/EqTGyJlAQMOPV+pxgple5+eUHMG8By39Q
	ril3KiDBx3AGsQvnmUssQq/Q6Gqpq6OKT9VJG6dQhpjO1cgzGfqLEU7caVQc8y//
	lavZie8910wacX1DiO/93Zzm+6bU1tHjmW2HpOfDR1+KV/zIxZbJcvqz07G/xkLq
	YP/aJpsJMXQ1OUjepFaQCmrkegjAwgWQg3trLugZOLgsWhzr9sfdac2WxwHZipK2
	6ssCquH1sup+yuZSxEi7EvfUbTulYWKb2sg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794006993; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hiEUtwtuUVMmkYfeEAABbCyZksHyOw05M4d37BWq9PrlLbk
	Fee9mPaY0Co2bIaKFRsFYl/TD/q9lcR6REUJQ5mBlhqtIihCA4/68pQv6dH096oB
	vn0u+4z9KlvwsTncFITJV9ROeHdyGSAXn82bNmJBC7CRoxSfdx7n7zcuvakvjCAH
	enw9n8e2IUXDQefgmgKdGdQF9jiX0F8sutrZmWmFFCVGtrws7aoPU1IpcF7jWiyw
	lXz06dctgsSYHfPQ+Ar9IbNd7AuVcUQriQt3l7XXpwbPdfdedpwTaEvo+xe42Joz
	qv4nuWni0M/ZeiLuM5nv4fcjTF4H2srnFIuL5Hg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:adaN3pKzp3XXCGW7/e84cK9NTFGGqUdPvOcSjnG70js=:eE2EI5ZQ6Eviyr/V0vlDHmzRrgLbv4XWIsN4dWIb2NI=;
X-ME-Sender: <xms:0V_uah0sm8nHt16Xef2qZcOdIqB0g4TdLrnW0fmp07bjPEkmCgWzIg>
    <xme:0V_uarwX4Qj5l0wkjt_mPdUH1Ca9Uj7IzzNlHxBtQiQzevplAgVyGmNbaktUdSpre
    UjCv2ldWEmzYirWcAGBcHPRJpB2SePhc02X7Utmb-dwG3aU-U8gQKg>
X-ME-Received: <xmr:0V_uartdPTXgR9mZwfbfXH3GtI-B_yNOtGVQuoyJKId0Fpif_4EodLHm3SMuntmQuJL1bxp13A-6UssG2L2cOoED47o9J1wS62lh>
X-ME-Proxy-Cause: dmFkZTFIIpD6LeFp7Cn1992wTWqfbu5gSlkYuSWbfngiNa+q9CE88QdjbJo28gWvj4xbe2
    pzm1nrPtMJhkGgxdicXwryBjw/9qGTuc5bW/f15bsh7imiLX2zm6/vpoCAmlr6Ie7eHKeA
    +WeA+M11mwjpw7GSfd6y/uBHaNGpQIbaJjD3XTcTHT6JlZmxpBcqJDglGM3kNjYuH7Mqi8
    dmYmZH9XRRl8kyNWNnqDFzh4jtfPMh6VyE2CWt5DHBbaewKrK/5fZZFW7/R/axsM6yVFul
    LzjRPQ9PVP4WCmAO8vL6+/jBcHRq4uw0fZ0BZ+Dr0cRg1e7VLU1D/n5xSLzUEzJ0UjCzcw
    fqXX+Xvl+WMXmQJPdDy4cXNCkSBpQN7+qNXrTkPCqZcPD2nnBQkGGK+yW5am1S7tVXVUAK
    zXaFA0QC8IbaKUkNv+qcOkq36T3CBnGscJwymE4slgbKMYY9k6CCr8HhXjxpgGGqD+sGpN
    ROBFaRv0Rp6CxNVolpXPI+qZELfMW+HD7eEYKhOqTi8eDNkGU9grfi1Cn5JaqQGqIbxK6r
    1Zs+Lk9RJwQJSy+UNQORIf0+6viHnH/XyqtL2ZcxS+kRMjzLh13M9TejQkgqNnhTduKigr
    lFSmOJe5M+4Qd9g6+h85FBVbwjZZaSdwzljJeT3Yi0ziSGzVafKy9E8xEGtg
X-ME-Proxy: <xmx:0V_ualxaqEM6dRWGVMHwxthswY7GqY8WzfJ5p6V_z-JddxQCLYwFQA>
    <xmx:0V_uamDwIosMO-CyDkvt00pzod0Rq2_ivcQ4GGjGP28S3s713e40Tg>
    <xmx:0V_uare3hgn9mBkV56BAkmzKi8ZRp51uI7pzlFHl6WVuTz5XK9VHJQ>
    <xmx:0V_uaokZJzT3MlRkN5zDFfjk4OCnBfY2xbGQwLAM-Ct3CDl7YQRu9Q>
    <xmx:0V_uaobMeIKLfVTf9MUM-Zhur2ETeqmojIMr_xl6tkcD4S5HfnVfkt9U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 18:16:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 4/5] refs: stop calling root refs pseudorefs
In-Reply-To: <2c3f3ab1951cad3771f5856ed8146286bfb0f5db.1794000450.git.andy.koppe@gmail.com>
	(Andy Koppe's message of "Fri, 6 Nov 2026 21:31:07 +0000")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<cover.1794000450.git.andy.koppe@gmail.com>
	<2c3f3ab1951cad3771f5856ed8146286bfb0f5db.1794000450.git.andy.koppe@gmail.com>
Date: Fri, 06 Nov 2026 15:16:31 -0800
Message-ID: <xmqqmrrlczzk.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 4a2fc421db..6ff32e919c 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -48,7 +48,7 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
>  		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
>  		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
>  		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
> -		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include HEAD ref and pseudorefs")),
> +		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include root refs")),
>  		OPT_END(),

Correct.  Not just HEAD, but all root refs are included, e.g., ORIG_HEAD.

> -	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
> +	die(_("--merge requires one of MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));

If we do not want to think deeply only on this one, just stop after
replacing pseudoref with root ref, but do not drop pseudoref and be
content.  Otherwise you would end up confusing users this way:

    let's see the --merge option I read recently about.

        $ git log --merge
        fatal: --merge requires one of MERGE_HEAD, ...

    oh, do I have to give one of these?

        $ git log --merge MERGE_HEAD
        fatal: ambiguous argument 'MERGE_HEAD': unknown revision or ...

    puzzled. why doesn't it work?

It might work to say "one of root refs to exist (e.g., MERGE_HEAD,
...)", or give it a more operational message, like this:

    --merge works only in the middle of a merge, rebase, etc.

THanks.
