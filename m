Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494375;
	b=escgBziUczAcXSOuM+c9+ibUEhwWfz9rH7tRt//wwqow5If2IQRnf8v2mTUunloiIGxx
	 5RJmJlrLRk4dVgvOKQX68G5QtG/Dtaq7CjZNo/f5/WF2WL+I9v6Rz7hzFrURuyI/ZLmmN
	 HzmydNCATrJ3HEjLyPfKGVdYs8WJ7oC9bGadIbfSQkLAOusUJejWDrHCEISlYnXAP/idt
	 PLy1SMi0jY5aLvwlakQ8Fdoi/mkYwm+eq6ogaotmbos0tjZfw8QrldD+zV3gjPtFLxxwR
	 PB5sHuJ1pR2OlhhdVKvvjqKZjUGTIhuQbDF0eMpUdvIhxenWgxr+a96hc/+SU1LIDdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494375;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HhFn7PDpmXRkmDBGS58OgmSd8qngCB7iq/oBoTJe+uM=;
	b=uOBGVzBlDF/EiD9+I1mlqLFk0wDcBb3uFMIl7DGqIYhvdH0W4QaEo9ZF2qG6soSOD9YI
	 7lt4Pgr3iAIXhS8IfcJqx7/BfxYnO5DNfW8XNyFeMrf5BTbeaQIY98c//xVcGbFpgrPJm
	 OTypULHe+Z82boI3ItXEqg7WlfxgV30hbJ3yozFGk+sfxAjLEIPtRYPnKD/EmeHl+xG1i
	 0TVsg8K52NotZAKtoYBOdpRAJLVzUrPDDioZEQ08KOTWYEB38cQ4y/yCOUWWyhyl47F4a
	 QX4/SgQdZOG6xkbWme+fl4LTOSne8h8cjWDul/CO4c9z3QHQA1WkkfomrTBk5gZdW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=n9PMdJaK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fjK1BPfN;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B0606A31A
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 00:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C02B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=n9PMdJaK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fjK1BPfN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 044BDEC017D
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 20:52:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 31 Oct 2026 20:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793494373; x=1793580773; bh=HhFn7PDpmX
	RkmDBGS58OgmSd8qngCB7iq/oBoTJe+uM=; b=n9PMdJaK9I1dMFDeEc6qfBY7XD
	3i6hb/PTBTqAFzDWzbDcTO3mPB1qvL8y/jcGLmI9a7kKvMp/tk5zTR1prAB8+noD
	2xu97y8Qk0n6P6zGPcJWvvN/7OQz5Oneasom40M0guatKfOnn6M/PHUPhjfhsflk
	FObw1A5lRT0XN/lBfZ4YLzKWLJCFc0YkjEmCwd4nS74j4BtWJXowjUMn0Vi+mWFm
	Ztb7WWomdYYSU1PEHhobeGrU+ujYOcOS3kGNuKwlJx0cLErk3/Z4b5WTbaOmt+Rr
	UQMeAZEBLXpNxl7LNWP3T4mzhvtLBkxw1IFI2fgqA9fHRuE4tEoqbD34Hfww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793494373; x=1793580773; bh=HhFn7PDpmXRkmDBGS58OgmSd8qngCB7iq/o
	BoTJe+uM=; b=fjK1BPfNZR+FrHJiWpPPfJWrXvlZ1lQZ6tgdu2XTebQ1bQ8ou0M
	NEePef+UkL0tlWGwxR4BCQry5+m6KIsjkd1XzJs1st4eoYcjF1ACB7HIDLnaKNoo
	qQvwivAMZ1X8ucQmiWh/8DgPi/MZqEpSKX5SIxW7n4WwbL4TnXhrP54lAJyQ3xik
	hqAYKln6Uv0N/vf8guGULgXqJKdr9a/f47SAMkIMCHF9fIcjNJYdH9G1hjNSLn0o
	UDSmOwE1zrgUznktn67s3mwjU+cAlwdRqWXre7KKPrVVr1j92uQyr787a4Z4u7MX
	KnA5qJz32a323C29nMPzPieR4hNWx9+4SAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793494373; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LLhp+UP2LeYErqaPKmy42yvF+iaxon4R1jNMsl14y7uYPU7
	g9vCzkWzFpva4X88DArwiQEdwC9z9jyuN8eCBBSK0pxWdYHPRV6cDukVMTyI/2Jl
	u+lv/3mpE3aub2Zv5EzC8zCitkRpfR5mOxUMGXUbfjSNEGu3i2VmOEP6qYuLpZ5+
	S/hxbHknSLmNR/tvlmk3p4aUDXwYTU6e2rmvDtDg4Cmi52d3P9YRwt6hLo3y2Ah/
	fjoeEmbgFkFx8oq41ur2Mj+hngFET73SSuNOnTpxSoGlA/ABDT/tRtxIiNb5ydjq
	khOPcErnfKW2IO20TYFpPaahyGvNiGeAc7PHe+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2czSUs8NJOfKDpWENtw3ooqaRH+fPjtaArj0gJD/2JU=:YL9t8+7H5ym8G90TqIAoXfmDxl1mNk8mP1XBmKtR7U0=;
X-ME-Sender: <xms:ZY3mamBr6b1egtjm0BXPqcqubvtpEMAoS21tfNvrqd0DLFpOOFZqzw>
    <xme:ZY3manbeh-oagEvuw-vHSPwHye0MmpJpR9y4_E5segeCQ3Hf_kA597vUYO1v7I2Jc
    zEf-93OJRij-Mh3Hf4BCKUw1ThAKtROqsa_g5AnDB9XPza53PtoY2o>
X-ME-Received: <xmr:ZY3mah5Pkvnkj8rL8imtCY3IwBP5-psdhPL82DC8z_ajy0AWKEwDAUNhHBmsMl_YuhcpC3sJLiCcykq0Z1AiRwczlxecGdaXH89A>
X-ME-Proxy-Cause: dmFkZTEl7sj4Vx8ZMP9/wyMKcpe9K7KpQ0CtSjzUKxWGuNYMNNmrPReXn+3I+lg6er0pzI
    npdLGeClyT3LxPTc7IvhXdvgwY5bPPWxotJy6ybaReIodd8xIfp6TDTmHdXPrE4vyQXOtR
    +1pUVMfrqCBemouJ+6zpLbykaig9INh6ol/VWVPi1HyDyKbfhXIAmSs4Jvs5o/lmgIpADX
    DtwBuRiKNlwen6zmSaG7zD4p8PnENe5jo/1TzYYltzq2BLp6e/S2nxP/kl574ODnQu7+o5
    OH8PwEJpKfqwRzkLfSkFTokPk7BBnMLJpZHEwODm7tvafbkiKUTMbHlpky54piJzj/xOhi
    /CmflNrCMmbICCJcseJUeOMkyzUCPV5jeNYTlFHFLzcvlO4gVr2rOh/DMiU5OgRyjykWQc
    wZe108vnJgJGdSPZI5gFmyp4sZIv0kZr0kCCSSHjlRTnJOswwsUd1ia6u+T+tXse68l13d
    5WLJjDWEY6xniOle50R4LoocxUJ9+pCb3VwnO0+4OKzkvGg2+QgAkd8/EpMJWB3CVo1g5Y
    L0asbTas049HWCOLG0UN6p9koxbHEzCoEDaRPIG1ZgArwGzZpvYBLS+LzoJBR3p7+r0pUI
    ZkCFXQOk2/fDRhGlNFoOOsYSHzW2JvKBptge1//K35keKcmZVAMl8eQ3GE3A
X-ME-Proxy: <xmx:ZY3magbOqS9QXE8PCCAflpCPJqXKifU9d2Rk5iNgt3_eGJvgSMI_Fw>
    <xmx:ZY3maojZAzF6VhQk633A0Cc3D2tWgjsf7-Vpr3mF7ZTqYzWr4y88Pg>
    <xmx:ZY3map8ocNF6PQmB65hR3gJeLEfevk9wpRh3dRJ36rvUSsbdzBdViA>
    <xmx:ZY3marptDZzckFxLWP-oOIeN8N6J01FKxqLHVLlIkMOuG7j1KLrLxw>
    <xmx:ZY3maupcmb9XBkQJDi0sKww0-JJbOcHewPjs5gnQGXAmIU3VD1R5kGKt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Oct 2026 20:52:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Thomas Bachem
 <mail@thomasbachem.com>
Subject: Re: [PATCH] merge-ort: accept rename settings given without a value
In-Reply-To: <pull.2284.git.1793441202854.gitgitgadget@gmail.com> (Thomas
	Bachem via GitGitGadget's message of "Sat, 31 Oct 2026 10:06:42
	+0000")
References: <pull.2284.git.1793441202854.gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 17:52:51 -0700
Message-ID: <xmqqjymx2x0c.fsf@gitster.g>
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

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Thomas Bachem <mail@thomasbachem.com>
>
> "git -c merge.renames merge" fails with "missing value for
> 'merge.renames'", although git(1) says that "git -c foo.bar" sets
> foo.bar to true. The same happens with diff.renames and
> merge.directoryRenames, and with a setting written without
> "= <value>" in a config file, which git-config(1) also documents as
> true. Every command that merges through merge-ort fails this way.

Searching the list archive for "valueless true" tells us that we had
corrected a handful of instances of config_get_string() with a call
to config_get_value() in the past half year.

And this patch seems to be in line with the other efforts to fix the
same misuse.

> +	if (!repo_config_get_value(opt->repo, "diff.renames", &v))
> +		opt->detect_renames = git_config_rename("diff.renames", v);
> +	if (!repo_config_get_value(opt->repo, "merge.renames", &v))
> +		opt->detect_renames = git_config_rename("merge.renames", v);
> +	if (!repo_config_get_value(opt->repo, "merge.directoryrenames", &v)) {
> +		int boolval = git_parse_maybe_bool(v);
>  		if (0 <= boolval) {
>  			opt->detect_directory_renames = boolval ?
>  				MERGE_DIRECTORY_RENAMES_TRUE :
>  				MERGE_DIRECTORY_RENAMES_NONE;
> -		} else if (!strcasecmp(value, "conflict")) {
> +		} else if (!strcasecmp(v, "conflict")) {
>  			opt->detect_directory_renames =
>  				MERGE_DIRECTORY_RENAMES_CONFLICT;
>  		} /* avoid erroring on values from future versions of git */
> -		free(value);
>  	}

OK.  Since get_value(), unlike get_string(), lets us borrow the
value as "const char *", once we used to drive git_config_rename() or
compared with fixed string to turn it into an enum value, we can simply
forget without calling free(), which is simpler.

Nicely done.
