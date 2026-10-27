Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124001;
	b=kj/UF8pBeoxYRGHCYSTEwpb1aOJalgRobxwQEZyvztijaENvTUM5Ph2LTkiYMIl4FRDE
	 kC/14tERhaHXego0laC9SK+Kkw5DCgnmKEnraaeOMsgzlgc7Dz2U0NUIG1eCNXOCjErP+
	 yt/T/uJ9uWayhZpOvTR7BH1sShp/bcd7Krg4sKy/8emLeNu3NmXHKQVXh3LAgl+xFe/AT
	 uVMeAIkagGtEdmO9VShmMU1xsl+P7zcf9XtMt1mermpBGn/1/c/4E9hJK0XD93ucOKLah
	 U83RV9jZAyeSrh5FGKNobsu28Ic5Y2aeT1fs7MRtVHPBRCZVwjrxuGcnM6FBjPzJdIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124001;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uV+pbojLzg6CuiPIKO+7S0ypNA/EvgqHU5ZWDEvsOek=;
	b=qzBKfv/zhlcqO8ZcGtJY5Du/hvqgZWctMO0bmSXydzj9WKrSW4aWqyDC/Jt37iscq/6C
	 t72JyQ8HshYBbE2f63hWXMJJwXBCqIgnItRX/YLL3isyShw+CeivoFU/kSajgpyQVea1F
	 AwSKXNA7wE0H8EaO7kSxvjWkDPw+kchi+1xuLaExztpTlyXWf0ooInqZ6roKSyfFDu53A
	 2nuCHqVnbKaEzBN4SipwHrVQ2NXZNR4Ytx8BYGRJhntdDmSWlUQG0zxNKuOPF++JWzg3I
	 E3mGcnNZLG42Otaej1WyJMvqyQ50lLodjz8Ol2tFqUaD4rUyGEQORRWGGMv+wRsnRgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="E/4jgl27";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NbsKbq4p;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA6606A326
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01AA6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=E/4jgl27;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NbsKbq4p
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 040A61D000D0
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:59:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 14:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793123999; x=1793210399; bh=uV+pbojLzg
	6CuiPIKO+7S0ypNA/EvgqHU5ZWDEvsOek=; b=E/4jgl27PUFwxiYouDbx3aibF1
	cNEVmFtCfdN1gXN0KKodEy0sz06IzbH/O4218nlTAQ0+kWrR1eFEL+N8y6FcEHbd
	/HyBVabEkh6yeeLbGigZqlNwrXiGnb192vTfb2jV2cskoQJ1eYsByyMq0GxIYrcl
	3qnYZG1CUppt+Sf/hlsm2CJHFRM9xDmkglHc9cyP4qkH7s/00zObk8g5p/OliApK
	wsxnsszKDGY1lJrPoQz3FBidhnLFyjbSeBvC057re+ek7oeP4aX8wt4i9rblt1wE
	FyW9ZwnWVpbLJWqXHLcLKrpnwQz/bassJBUAGcLIl3CYC3KQpa3shh41S1sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793123999; x=1793210399; bh=uV+pbojLzg6CuiPIKO+7S0ypNA/EvgqHU5Z
	WDEvsOek=; b=NbsKbq4pZDcH9JPpquuOaGxVXZrQBOTdbJ2IrGLq8tSxWB551fg
	zxuVonfLTObUQ6YHL2uo6LiirWtBGpJPgH98rnVK9zTKkkvcz06JqFPxvaFWqvM+
	l8wYI/knvpBCC48ec21ziZa47KM2I9LxEUpYjC/bbeLTaADDZCmNQ2Mk0Tpyj9BK
	cUW9bj3D84YDeKd1SCrpbuDrXbM3qRF39po1qsEiRvBMstXMAxYNeSYs8JeMjTTW
	ZmYHZYSTperLOs4Mn1MWeQ6EozI6MbpMvti8NpWFZNMQWO6NPCoiOkcYychwModG
	27keGpJZ+GC7wLE2+uBr9P0pYN+OP/8taNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793123999; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hMO53l6b+OB/jNJcAI0dzgPQQgCP1Ie+Z2/IdVoCnlzXZ9z
	Bdw1Nay5uxzEuSkfBjvFR0XEJBlz9BBuDFhsCHNKj3PjyK98No8BHwJtDKZ5Avyn
	fN+hsSILE27ahBuB/VVV4dJKJD7ZX4Hz5gSvgnk6GuRKOSxpn3HLWAHF6MdDm24h
	JtT3pxOqOfKtgLbCa/ZIxZXQH2IAP7fMG25HnSyeWRjcUpOMQX9ll5G8v40QOxRh
	69dd8NttzPJH1ryY7w4L91OXU430eoNvOHarLt5EYYKgHep0fqRJHA5tJx6VPySF
	HueEZFRuDuXTzYosHNU0V/eBUhQPb2fPetYJ7vQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:PYtYVbYSDQ/SSFWa+p7mA9wPS8xnMAl9iiaQLGzHf14=:isstFffF8o5JTh0mLqj1DLdMzltVQZTPCB4QKPC2xPg=;
X-ME-Sender: <xms:n-bgaqX7LpHUYw-pudLJx_gw9CdjzI_Qm0y0p_Z88Bi_Jpv7JXYoiQ>
    <xme:n-bgaqSkpBD3DtrbZWD4ErJR1LFGDOL5Zol8aJ_yUD6Ep76npy15Wj8vD4b5mC4kM
    xV07nCe_ZuPzoFonmQZOns8okAo-twD9gDEmepH58cJe5DxXi8ulw>
X-ME-Received: <xmr:n-bgaoPM-Elw1ytfaC5OrXDAq_J_ydCwfE0tAL14Q6gxYfPDFiVFuN4ND8EdiACr6cqgYwTrvprlsZPFWfobnBHHLVp90OL38yRo>
X-ME-Proxy-Cause: dmFkZTFvKcqeObWROAmmg/8vn2esv7/lAdCFEwzZd7R8wzlEpmVKW2TGp0FR144IFJPz2f
    CozTa7QGvlXmtuyasjd4Fatz/0H9B6BmNaHj0BZJZrxnadbr505ekVe/b4Fw5jWV2mQWa6
    YRsWBpUiA3Ou7V7Ib73M5DmZvHrzLFc3OMv2nDUcaopK8NrFQrXssbDGoGDs7aRDfFGWtA
    VZfw0cEMUrU1B6VBS90itDV27e+lA4Xakh4w5S5goIfz8fbt/mkyaA7f70ZXl8j5ZBDOj2
    86WKc/4cNQh9iel6qmMKUs88OskSMqbcKglO4ARUcWESGKqfHYmoLx8cmVNXwi2sNprlMG
    aDc9UCNq3EkuneYabAJv3PmlYudMgbCD5szkFWxc94XbGFncLzD737dbLFaXordbnt/wcP
    mHcXhlid5mmv0A5WEmwHTEh0Ii/GznHLO2Y6VvnBVhkgzTeXRHGLsqGpTBbm9qqTPAAO06
    /MGH7Vwf5FSSoX7ndaDa1zQpu0lZjrFYdwXdEldMambTvUKmKmaMzRBeL4AWvJwmiFT8M9
    dSe3SFXanrn/VkfUsPIYGDFQs8U7gv6u2Z7X6lVkeY3AGEXx+vLavKDjpqtj33Jf+Ak81A
    gXOwiyaFbFioeXybuBtHrNLtVITUAhJ6jwZe8InWvDO2w1XrIq7syl19kqgg
X-ME-Proxy: <xmx:n-bgaoQ1Xg3HooyCkA6kAGogosiXwABxD8vd5651062IRiKNwOwcng>
    <xmx:n-bgamgwV4n8OdpaQb-cJqxMMJ-7V-Tt9DIcG_ncmPA9o23VMhqZxA>
    <xmx:n-bgah8rrS7rPvTU6sO0gsxgUxgIDnXq0zhgQ5QKfXuZ6YZxu21ztw>
    <xmx:n-bgatGsFSUGVeL33Vw70BnCDA_01Nz_vseuWRnYNFvqKlco1Pvd0g>
    <xmx:n-bgao5mcl9DwbqWEBEsNW7Blgkfi1Fjk-KJbnNTAmQ_GlPIDYXt2FEF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 13:59:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Fien Dora <fiendora5@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [Outreachy PATCH v2] t1402: test --no-allow-onelevel option
 precedence
In-Reply-To: <20261027145451.8617-1-fiendora5@gmail.com> (Fien Dora's message
	of "Tue, 27 Oct 2026 15:54:51 +0100")
References: <20261026132525.45414-1-fiendora5@gmail.com>
	<20261027145451.8617-1-fiendora5@gmail.com>
Date: Tue, 27 Oct 2026 10:59:57 -0700
Message-ID: <xmqqcxsvkorm.fsf@gitster.g>
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

Fien Dora <fiendora5@gmail.com> writes:

> Unlike most Git commands that use the parse_options() API,
> check-ref-format relies on a handcrafted loop to parse command-line
> options. Although the --no- prefix is commonly used to negate options
> in Git, the precedence of --allow-onelevel and --no-allow-onelevel
> is not explicitly covered by the existing tests.
>
> Add regression tests for both orders of --allow-onelevel and
> --no-allow-onelevel to verify that the last option takes precedence.
> The tests confirm that --no-allow-onelevel overrides a preceding
> --allow-onelevel, and that --allow-onelevel similarly overrides a
> preceding --no-allow-onelevel.

Nicely described.

> Git's planned work to improve argument parsing includes replacing
> suitable handcrafted parsers with existing APIs.

I haven't heard of anybody planning to do such a conversion, but do
you mean you are planning to do such a work as a follow-up?  If so,
write it more like "I plan to do X in a separate series".  If not,
please do not make up hallucinated facts.

> Signed-off-by: Fien Dora <fiendora5@gmail.com>
> ---
>
>  t/t1402-check-ref-format.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index 9dd64662b2..6036df0210 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
>  ref='foo'
>  invalid_ref "$ref"
>  valid_ref "$ref" --allow-onelevel
> +invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
> +valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
>  invalid_ref "$ref" --refspec-pattern
>  valid_ref "$ref" '--refspec-pattern --allow-onelevel'
>  invalid_ref "$ref" --normalize
