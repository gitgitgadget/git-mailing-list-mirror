Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925379;
	b=FWVPTtEkFpmO/khDhKaUzjEJG6iarYVDWgk8rYV9fgE7na/9aao8ho6QKQ+MGIl6a1ui
	 cH7uEkVKZzg+DQ7WiqA1eqHlTcwxDhnUkixu0e4A/eslH3CagDMNModVyW/zlDwdPcnwx
	 Ucb28kGZfm9jcka6DmgS2HXnXoOL59+D4R7/dmEHNfS7g8QtUjtcr0q9DTH4oKYh7puij
	 766FAgDz0nFmy0MsmGCTd6p08Aiv0D2aAX7L0xVIe4rxJX3A0ZC325j/6NzMkCTHDaB0n
	 7H61vLZVe+vYVuOU+JG+zPrfSHyddt5ECuxa996Pq22V9eepwx4E/MAW/tjQzFrjWLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925379;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mpSs8xFW8KBGUOLak6SzYhCgZWmqbJR1gyKhZjjcFmo=;
	b=sTelrIPwzncBIwLo6lN/4KB6zROKfZeST7l1WNYclLubO3hNhmpOkBB7upcnJjjq5uFP
	 lVFDj3cIhOx0zTEfWOUnIQKv5T/z2fY6eiCh/7QanyeC2gRBdj9Zd8v5BKgxd/azRVWst
	 8EAxNglDK1OP/QcGKqZ8AcJQEx4IFvUv6n4t0D6ofrg0qs+MRPihgSfz84aS+03CFc9+s
	 zyaYZ0Z24UX7l9W0c1iPi97JeL69XgV1PsgP8liouNMp4fDP5FBy0khOEXL2CFC4mXEKA
	 IFco4AVP45UGhZLzQjUuFiXhy44pY/iKazt5XH1dRH7Ca6jcDbhGGlvmZ3BfkXiryBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hjwcrb5X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=moRgNZcP;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FB606A32D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 00:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F9FB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hjwcrb5X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=moRgNZcP
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 98410EC01C2
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:36:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 19:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793925377; x=1794011777; bh=mpSs8xFW8K
	BGUOLak6SzYhCgZWmqbJR1gyKhZjjcFmo=; b=hjwcrb5XptZE+YdIKwcWeR2Ctr
	3FaZYAkWakbFsBqmm2wvyPit1GtQXQA3Q1k8IDeYtYBgMv7oT2R4hb/0kuf7UpAh
	YWhyTPTbh4XGOsqM/Qk5CuF+nzLnl69LxOa/66YT7dpAvslDQWeqW5yOOygRByG0
	8yIOmI/b/E12QKRi1FMTu6NbY3/ckQm90P11Vblq4zQr2MMZVTX213LVqfHVL6M+
	sVpQWLsypGMqg4tuNlgLWuxeAK9UYhZJ2UCCuJ6BTcOyUVe2FQlJqEXJ3J8s1ofE
	TS2oMo/61mkc3yKQQnm33OAE5bI6AYfOssUdmDI0Sh96K8sHg6XqTbSaMX/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793925377; x=1794011777; bh=mpSs8xFW8KBGUOLak6SzYhCgZWmqbJR1gyK
	hZjjcFmo=; b=moRgNZcPH7YVspdrOP7tcLsgmmPIqe1VeW26yTuabpnAS4e8udK
	gG3eg4NX+UTJFVVFuig+JQs6H5BK8fWcRP16LucFRI4GirGxbfoSg3xnW7mFTCVW
	QMSm/pBHlEonUL3l2Dq0tM2roC6CjxWRiK1nZj8NuFdf4iDZ9NV9m/vy8NlyRdIH
	KuR42p8RCfSdcHRn3jTWy7qt3Bvt2dRMUAk3QnG0Qx7nZN61FSc1Lqs6xkFM3enK
	RM5jeTq6uYre4PnUYkEv+9Gat4LLp7CPXgKQiW908EotiJFlIBX7JoJPpq6YLjFj
	WIjq6tWST23uy+aJHNzZQpsgOEWkuQeMbAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793925377; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ARCIDrWq3WtZijhZJ46p8toCVjyleELzosdvBDfTOCuFtYs
	uTyGuqkYJ0Ezv06YWsBvK3llGzyL1X1dWlqvY0EYTttqCU0btpOG1tTW6Z8kEsl9
	CiLOmA2EqXkCUjqY967TqjdWei/SpzPyJUs1yEC41RjB13tVkU+C1uPaPGEKeAYM
	hfKlsxoGqMcZtzb2z9mO5qVOBxBHI+JCSEQuSSple9rsN2EC1nY6WBhwJsLqsmYv
	j/kHBLdPyWntP5P2WSNMr4z7SB+7RkEgvTUA14FxoEJ7KjwlQXXatC1Kai3hJJUD
	HpMfwsopA7Ee4ZUBjOUGz25XcV88jtniXbIjHmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Sj4RDclMVtPS+khcTDpB+NTzyqdIgjMGKQH7zNaxob4=:A/KPv6XTZzC3/WWPW/WYNEylDdUv9vMsESCTU0ggTIs=;
X-ME-Sender: <xms:ASHtahWaaJzU5NK0zjZduqAPuAqJk2CH_woNJbX5tmX1lPV1Hskmqw>
    <xme:ASHtalS6xctKjzNPE3jWCN-PLPTqTdrszr00CtfK9kho90Q8GJzXAnxIoeIaHsjui
    ZwMqdRR6nP-6SsA-HQaOLrncxp5-tklThZln4ZAHi0FQE79iluS3no>
X-ME-Received: <xmr:ASHtanMoy06JrPR5tozJhxC0AR3t4ReuckfmbtZ1oGsnRVXAaWB9-2GtOt3KmBp_NSlZd7ZqLuyiZadFkLNS2xfDZphxgYnB3c6v>
X-ME-Proxy-Cause: dmFkZTE5w6sIj8MfDprLS+zolgbG8u/oCq1uzrWyryPNSMNXTcLCDIBuRLALVrA+et/H0M
    JZ2TpoGpGcPCvSXHzTQS2Lr/6Y2hyHBNc7yEsHEOnZp7HXvhB02Odd3Z7IBcAiqnLrq0jm
    x/D9QM1HpEkNLsuv0wbkUtMWQhBnB05xnZAUOP1pRLmuCjUtGAFDJMq+Vf01SjUdbHAmqh
    Mo4f5uSbsQfplqhPN/WXR0a7PjJZK06qnnYWVpEQom0EoEEDAkFEUvOpUdrfYnksbbNyZT
    BLmF/5jLp+sDFTYZs3uEWWDllvGudsvT8AdwJOPG+iNyKAt2TWeAyWzWu3UUC3GbS0SjDx
    k4AiWIe+5EgPIoMS3IpgN5aF6mS1N09Q5yExX+UpFjofU6wv8uFZFKjQNGn6OUym3v2Zhs
    KkInFsEO55cxoP9LNIQAygizq58xRSq8oEPgx3sp10arQz0BjTeZTOn7mdR2Qg4RqbhiFS
    nDFFWvg2t2KO3wouLP9zjOr50RUPyAVkXt4r3q2MgElm82ahaxmmfnxnngCVbGI3Tm+HN5
    nZTpLQXMdUbTnm7uqCtoXpm0qMmeqSSJCWNZDtLK7t0CFlI0yCxid1Qy2xRwuazvTi669H
    BJAujUkDXuv28SlCjFtne3GdtO3BPHUDW9K4YE5Qf/JimfyE4tDHKO09KOIQ
X-ME-Proxy: <xmx:ASHtarT6yPr5OsD0pIjRf0rX-orIgsmgoUPnnmoBZVE5suLytxI8dA>
    <xmx:ASHtathFNvV0Gn-uRkqC7WdjI_0JOFJB3vKw4qEMTkmgnrKCgapLfw>
    <xmx:ASHtas_rK21YBHh1x8z8R9UrvyTSrJq_KgggGTpH_cyt5DvBlpjmsg>
    <xmx:ASHtasHXa-SI65yUFDq1WPYGMJIokXqD9M5u5Yidhukekz_pmliDPg>
    <xmx:ASHtav6niFWoX40E0qg4x3nvXegSPideSKMUXFEwREZNorf9jRfr0d7z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 19:36:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org,  tangajoris@gmail.com,
  pushkarkumarsingh1970@gmail.com,  christian.couder@gmail.com
Subject: Re: [PATCH v4] rev-list: handle arguments in early option scan
In-Reply-To: <20261105120937.10269-1-azuama69@gmail.com> (Azuama Odinaka
	Maximus's message of "Thu, 5 Nov 2026 13:09:36 +0100")
References: <CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com>
	<20261105120937.10269-1-azuama69@gmail.com>
Date: Thu, 05 Nov 2026 16:36:16 -0800
Message-ID: <xmqqwlqqokxr.fsf@gitster.g>
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

Azuama Odinaka Maximus <azuama69@gmail.com> writes:

> The early option scan in cmd_rev_list() looks for options that
> affect missing-object handling before setup_revisions() parses the
> command line. It must not interpret an option's separate argument
> as another option.
>
> Use parse_long_opt() to recognize revision options that take
> separate arguments, and skip those arguments. Handle -n and
> --default as well. Stop scanning at --, where subsequent arguments
> are pathspecs.
>
> Add tests to ensure that --grep and --author arguments beginning
> with -- are not mistaken for options during the early scan.

The commit log message explains the motivation well, and the attempt
to address the feedback from the previous round by handling all 19
options from revision.c is appreciated.

But the approach of hardcoding an array of option strings that take
arguments is inherently fragile and scales poorly.  By duplicating
parser knowledge into the early scan, this patch falls into the
exact trap described by the NEEDSWORK comment just below it.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 071a0e3cb5..4dd646050a 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -744,6 +744,47 @@ static void prepare_maximal_independent(struct rev_info *revs)
>  	revs->no_walk = 1;
>  }
>  
> +static int rev_list_option_takes_argument(const char **argv)
> +{
> +	static const char * const options[] = {
> +		"max-count",
> +		"max-count-oldest",
> +		"skip",
> +		"max-age",
> +		"since",
> +		"since-as-filter",
> +		"after",
> +		"min-age",
> +		"before",
> +		"until",
> +		"date",
> +		"author",
> +		"committer",
> +		"grep-reflog",
> +		"grep",
> +		"encoding",
> +		"glob",
> +		"exclude",
> +		"exclude-hidden",
> +	};

Is this hardcoded list complete?  It misses options parsed via
diff_merges_parse_opts() in diff-merges.c (e.g., --diff-merges), as
well as options handled in diff.c (e.g., --src-prefix and
--dst-prefix), which also take separate arguments and are accepted
by git rev-list.  Would

    $ git rev-list --src-prefix --missing-only HEAD

take --missing-only as an extra option or a prefix?

Thanks.
