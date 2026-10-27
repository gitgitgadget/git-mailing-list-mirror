Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126895;
	b=v87dChlil3EUeKxVbmXXwAIQltaXDM4hG/pPZ8jsd5yzkeUg0Y1bUGi5qU5GcXz9kahS
	 Pj+NeWEwq/WsUL2GM3C1g7Qvw7O76kH2gWdAM5Jhec3JMTCd4T93r93W4781B5Y0RdomX
	 vbzebBStW5rI59hYPofR32ITi8VPrn6cASKfr5Izscrtrmc7aKr5tpzVJDU53EgO/Ecc0
	 ui0klCh+AelTuZRiLoCSdunfN4eud+x7KZH+02Vt1F834ofo9AqLeZwFvXC8mLKXg1Ag9
	 bXFujnucY9L7v9M/jriUGH0P3wr509y2yWhnJjomMDEgkdl9rpijnlA5BSG+DNnLl/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126895;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tNoj3JbLMSUeq99FLAJYEtY6YWIuGDXbE8k+5sfTb+M=;
	b=f/E+9a3AVBX6iJI5WigrlLXLlqDIQgr6djaqHlXRU2FWPh1ZPezAvbN/s8mljifIpZl4
	 fcKPfymRMuOLOAh8SqVCdb3khaz6sL8xTSq0d/dTXQ0VarHARTt8uX2ODqv905qicOF3u
	 wGJvg3hkBPTwxGyl7RtYnxAcOUzl8oxC7b1axk2OeDxMjGsharKGe9vUTY2xRMS4mdqeg
	 kdYJkNMDZz7wU/J6w3ypA7N9UVPvxRUyw2+hEkex4Bh/Qo6M1IUS6hJbaeiTbu0XNPD/M
	 Gj1mG3qJtKU0wptmg2UrPhz5WMuokeIGeMzHV1bsxyvXrqUljF6OnORG0D1EZShiKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kFfuirH8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p+j5nsak;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C45606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kFfuirH8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p+j5nsak
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A06931D00100
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:48:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 14:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793126893; x=1793213293; bh=tNoj3JbLMS
	Ueq99FLAJYEtY6YWIuGDXbE8k+5sfTb+M=; b=kFfuirH8f6ncunGBImLV9hWk0P
	tL5+4qNZ63J/4w96mGNm3nIBArY3u8oHBWz5d4Em0X34YMtoc1cKuZniUHniYPUA
	o+do55veIG7Igt+TbFVXnRushGnFqiP8MO3J0+R3NhOe4HIwwJCtEgjs4FuqAaOO
	AAdvFZB87kBg6yZMhYPwCNalKL8Yy4kdZafoVA8zF/5t8FUjd1OIkFqrVE14xsj5
	Ia0LZUxcZTY+WIx+calw/RekHrlFuKX2hlAqGbqpVS2TPdqOhMLO4KQGiuoS+Gh7
	nTn0789+8m50hta2Z1jST8Mdv2XtmxXqVi1DlgKU6TSEevp3/ZCtWoWkZ9Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793126893; x=1793213293; bh=tNoj3JbLMSUeq99FLAJYEtY6YWIuGDXbE8k
	+5sfTb+M=; b=p+j5nsakBtdHjdzUs5OpE1dPzytLBN6yf7rlsvCc3wjyjLXm6xu
	+TfUEmrfDWFiJNMqDWzwGjgiuc9KI5KPzxR5ft04lQVn3VS0vyf/1lPYhD9g/gNg
	AD3vU1Nji7iBb1j6cbTg8hdBWESp5tGa9bhUp4H51HfZby5gQO2+/H70ZxdxuEKW
	Aontz0B6yB10ykPacCZTLc0qZfRDVEc8LRkc9RqRYYwvX/8YAM6fG83cExI+OaIE
	BEgl2GU55jhQq0YKo+rfGtTmdILJA4zvMITlr0Irp0YbKod8f8Sl6X84+vTlNd7w
	MEhpRAy10/pjoR8KBjsF0Ko7cEmQM5Mc4Rg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793126893; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:i7Fd1O6XZ/V0usSv+M1Pgl/uU4UFPHvvSLJCNTYcEMNNbhX
	AsGwCRbCvGiHFBmy+yXEEDwR/lq7uQ6TfaWNFcYMnIWKw5B9IaGT8Z6o6vE1SaKg
	8HK8lvW93+Tu7EIZvl046MY3pfD7lZTQzOGBIqpOqRG2aVe6DFsk45OlneNJ/2H/
	zNQNlU5Sqgn13y9fhCFR8TMBRgy7y0OC65eIvgtUYQFu5Ip05c5jj1r2jR7eqqqY
	QHOfuQQ5xRUtKIlM/WtHawGQZjBlL0VVNu4HEFY4SWMJ8ySV8e5FeheRU+T73qGo
	5ojdtHPZSmqk4n9ZH3NOfBemmeDzSYLllYAMuAg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:uGybLatOhLA5YmC0sW9LGjBQ/bnJHGTiRgZbgN9dFfg=:w4YJslm1EVn5AK1909Yl0FbhCGc+LcDCq+Xzh+Rg7RE=;
X-ME-Sender: <xms:7fHgapRRa9Rwd0PSZtuR7ZYdZtw2G1zajXtB66cmk3h8wtu-hwyAmw>
    <xme:7fHgah2v1fc4-Io9kobgR7MlyA876KrRCt5uQ3uA0v4nm5QpnCVL7J6Bsi6tTd2UK
    IoeGoz-PeER7NTKcvrLvSBkZLC-4prYpydPmF5AMC8QtubzG7gDhuE>
X-ME-Received: <xmr:7fHgalBbmKnFlRGIOJsLFrR_RRGF2Zcu-qZNFKW5PsLUwX9UAXwFitpmTN4xUYZI1Osbsr67V9OkUUxWyygEhzHrvyn_ez-_WA-6>
X-ME-Proxy-Cause: dmFkZTGLyDm+4aj1iikoBm+6a81oop+mH6btB1BoM9+cDuvcI6Z8WwnEp/zThuJloMAJAN
    WOcgVLXHXbWnXkVS832UV76t0OqHrar9SGeY9x36wBy8+vKCFUyrAJAmeB1TazVKCnMp6O
    +sr2LYYGL9kd1AkZnu8fZwpRFTGvNPqOE+zB7DNIoSt4ljsgrclNGQ/WoMl7UoCe9DLU7L
    Y6CY2GpDoHVx3TD1cu/lqO+OIBgERnKtGQAInMIHddkkUz02x+SWvBe1mujcehtQPzcxGZ
    U+LkA+cUJGevKMSP+zTrGDy+k/89Ipa1gjelaxGOTL3tnwJemR425hBT79VLl54GBan9Hq
    jjyosEf8jgU/PpeC1V9F5cJ6USkUb19R7t+zQkVljB3U2awtQbyu+1Frh0bENNAje3LGP/
    9JgG7460dlNmGsF+umOOEHPexPueYfOlXHJbNDi6lLZNW+Us+Otbv6lBQCOPVD+QQs//2B
    6WNjGGbaCtq8sX/mjet25V7fgJsz9dmDWUmQewVqQDYV5fnSxem60qyJ8ETzrYwXNUPnEc
    U6P8YimLpJEwgoxz89Kt2KRtLT1kuTsfUZnRe96U217ANfpY5lasaN61YiZwW/feSNXsMK
    v5zcB/BQswweuMqijxdgGFddiD/GjdyDDMwBa96hiAK++q8wuNT4zxhCbQGw
X-ME-Proxy: <xmx:7fHgatjekRqyU6I_H9pjiBIS0Q3FAuFODE5twJhh8IA1Asp5hcUNdA>
    <xmx:7fHganOAsEWdFwFQTOUSJbNVNAWWrOzXRGUBgw5yndLI_YKyqADw3w>
    <xmx:7fHgat8ASkTxMnUtYVgkChnfRvZ3CGdldLAkMAzbgElykpCGJepN1Q>
    <xmx:7fHgaocJokKPUq3WWdPQb2v-irWPDIfDJgdUjsJonxMIhW7tMBvC6g>
    <xmx:7fHgarHCCgCwAPN14T2iB5ZDyE_36EDYPWHa7mcJHhOSH9wGE9WxPT0i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 14:48:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] test-chmtime: use parse_options() to parse command-line
 flags
In-Reply-To: <pull.2280.git.1793099688076.gitgitgadget@gmail.com> (Shashank
	S. via GitGitGadget's message of "Tue, 27 Oct 2026 11:14:48 +0000")
References: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 11:48:11 -0700
Message-ID: <xmqqv76nj7ys.fsf@gitster.g>
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

"Shashank S via GitGitGadget" <gitgitgadget@gmail.com> writes:

>
>  t/helper/test-chmtime.c | 46 +++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)

Forgot to mention one thing.  Do we have any tests to cover the
behaviour of this test helper?  If not, should we add some (not a
rhetorical question)?

Also, one thing I missed is that the original ignored --verbose
when --get was given, since they contradict with each other.
Shouldn't we make them explicitly incompatible with each other,
perhaps before where we call timespec_arg()?

> @@ -68,40 +71,37 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
>  
>  int cmd__chmtime(int argc, const char **argv)
>  {
> ...
> +	argc = parse_options(argc, argv, NULL, options, chmtime_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT);
>  
> +	if (argc < 1 || (!get && !verbose && argc < 2))
> +		usage_with_options(chmtime_usage, options);

	die_for_incompatible_opt2(get, "--get", verbose, "--verbose");

>  	if (timespec_arg(argv[i], &set_time, &set_eq)) {
>  		++i;
> ...
>  }
>
> base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
