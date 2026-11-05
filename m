Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917957;
	b=0Cz3j4Z+fBqkPeEyAfWTQOap7Mf2D7gb37A6ule02zfumq1dN0kHIEwTyrVIvnyJR0tR
	 SnA6BR3EKp2jXV8b/LlU3wj62i41BHJ2125lka/H1bsrgDNUlpEqvWMiGVTej0ilPZ5F+
	 lT/8RS2t+H0zpxacyevPEOiaJh2kAK6rF6Smv1yNyyPd5ICY47j7uXc/mXcSyWC+bvrip
	 ZqpV1z7gz6yDU5+jh4H9jhTreD2ZnO98IcBq8Js4pCVqnEGUoH065tu2KFDJP+AG87Jq5
	 9eBeO5n9CkFXdhWXDRQP3f5i/IMURsVNrVNNMY8Qb0SfAlgoju+wh/kMJccr+tVRKDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917957;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8mRpL5CpcKHrVS3H+Jt1Bu8I0/udWwJC833g6p/TNbo=;
	b=0a8RkpsxqMBHnf6haxI1OJryqmVV15fRe5v6QEPTAdWsB2ohc4OpZIf2b10RN6iEfdDj
	 bDPx+RrVA3BaiKlNTAFoPdj3coAvhAvGhcn9KFAcBrS+24mJZeIF54whHHT63VNRM98I9
	 O0joReL2q8F3eJTfphmwZp0u/AlK/Y0Tlv5VVyUWMZCUhN1W7HrbImf7HHVX4QDtJ789p
	 ax+Dtns9Lt56A9IpYQZmTK5Xg03coFDCPwy0Hnbzd08ptUKQhFCuCspKYnMUrjGwHhdPy
	 kOw9s7XYWj8FHuStB4k7Ov2VrMzmpijE8lYa7K9V+4gyVK2rXBlAN6t12YUGgc7O9BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=HzTUsVVq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nQCHHQ6T;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08F606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE08F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=HzTUsVVq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nQCHHQ6T
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45E1014000F2
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:32:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 17:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793917956; x=1794004356; bh=8mRpL5CpcK
	HrVS3H+Jt1Bu8I0/udWwJC833g6p/TNbo=; b=HzTUsVVqeJ/qzxYU/gcDbmxiVd
	o5prsHWZpHzdB6LhLUkqPkHb0+Cw5s3EnrwfVrqSestt7zmbvzMpeJmr44pjKt4/
	WNDv5vSQlfOWoVVjREkSPtjxoKdhXTrHK2w9hUgbOb3o+MY6MQEAqqj7f1Ch36tj
	8qRGLeYQCJzMVkmAoBasy4GV6/IUNCR/cay3+1Wxo5ZCKWVx7TPyhsi+txcGX4N6
	t/V+j/zQ4FO6Wt+sHKTx7pE+2tT81hEILuu1m3cEmJy45XO291D9Mlx5VNl4qlIW
	rvVXuEwNz3hOgbKxSsBNaAhLo/zqdU13knQOwyWZuzc9cybHGGzzdA+U3KhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793917956; x=1794004356; bh=8mRpL5CpcKHrVS3H+Jt1Bu8I0/udWwJC833
	g6p/TNbo=; b=nQCHHQ6TKlxFac0hOyDS91sXL3lObHoOrkKDdl0MaavuSrv8pEo
	4B2Z1gXMzOGfZBaFSV1ajiJ626j+qc05KfgHWOF05dBXTc9VTrfr8poes2MVArgF
	X1vyuF40ZnFVHv0uKMCVObohAzr3fRmZrvYL+BapsgDbJ00TI2tU495E7bBiSFIl
	d5GSC63irzeStDaExRR+dUmtud/Y6TC+ct1GfSC5QwXFDJ4GqZoqsXks2nxHK6vK
	loOUQbqSMtsVViQAdzjxcGaLT1/mc73Y1svWEJJu+rHvUtHf9zSEawrvnkPHymT9
	fvN/bC5L0uA7/CmllGrPA6hBpdrnXqtn/6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793917956; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UFpAvunu15iryz8u0Ay9KWDI+4+EXWm9mb3za0qMAQFmjvm
	q3vBNNFBldXJjJWEyRrdLKc9UHb+CNW7SLyUX/gCOUCRT4/jl6v6PY3JRO0p2oHK
	ybp+cFKC4DB5opGEUQQgQZEHl+aLKClZpgpgUcFJ6IcpPQpS/8Dz0HYngPNr+pZV
	Csrqj4UbK9Zwpy52xvX57QFGYjGyvYXkFcPFxnjebY7s/YZTSwkkcIx3r6E3HXYY
	YShg3yU7uwEIyS0+PEYArIuxHH9wKh7pXy3fAbUymNriBQFADwgAIKa3WjAUXQbI
	J6mCv/qY0xFwtvPThu7CuWpcxnQuJdf4TCZZz1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:TQrril/+ZRmPoLeVOqWinfnMYIfAlkxug+C+/eUhlB4=:aU1tEaRddPxu6gz/6sVod2A6ylZL7iutJxPfFIIFNAs=;
X-ME-Sender: <xms:BATtavWPOF-AUa65GcVxnXk_Ovt5lPJwACtJPBHBcwcwO6J_2dLBsw>
    <xme:BATtavBgGTpY1xQI0oR1oRWXm41Cb3UtqKeT3BB40tu5XOP6W2UtntWw6ZxR65Ct-
    1MUCMg1IPOxb_l1zF8Vak9soVKQU8nUXD-bsFx8Zc_ZuhJzHQFEoVw>
X-ME-Received: <xmr:BATtaozuozuwvju_HFkfk2jBLYgqz97W5fqVtcP5FhmnyHp1mAIXp46EkO6T8BUvZC_clqsRQIaHMgR7PcfG6hTGUyyZ9TBW7z6k>
X-ME-Proxy-Cause: dmFkZTFJmtaqye5AwQjhZ3CKkQcs+/Kug6UfqRH/7OgPvos6aN4nQiegLwYwgEWCSTZPmX
    zFbSYPFAavocLXCI+iyavPFAbVCSSx3sUtwd0bsVfpdLP7CT/kXxiGR/j562dHZmRiCoSK
    XIxAPAmOTS4FkSeubyjtAM6K8ckqR3a0y2fynbPLSicrU2Byk1rzQRJEYN+YGHmDwQ4y1S
    Sg8bpk4U8deR1hpnYXyt7z4k96rdgsXAiPzWhLO8KWlgQUr4UBvqZ2N/KABL1CL+o+HWgg
    E1g2CRge6JHnQ3QogkM5txAARHjnxgdO7Ky9UeA5Y/PvWYy+W5DVHELkW/wepg/Pe1DLHC
    t3FQV3Z6ElAu3bWZIekcjWG2OPtfRxYcN/VHN8aaU5q9ECpqERkBqoy4rbFyKR/W6lIt1x
    GEMUY7yqV2r9qd9vtS2s1wWqq+5i8xTVzUvbu+0/WmOLPooGF0xwTirqHrxt541Sl8nTbk
    t/o97znn7rMyuhW6WI6PJc465iUTkgnyq/467uj5HXc4rk3n7iLgpn1B9yGEXNXiPzDZP0
    b5OQfNWN0WDw7nL+GFENEMp0t3dIEltUNVxOfaABzj3g2xxlvptsl8fIvhc4FDfF6anBAq
    xIDUSzRTxRveb2ZkJwwFooNtUE5celUoFq1xgWgAMdpqYToUIte8ooyIJPlw
X-ME-Proxy: <xmx:BATtakDd-OZXTV-GsmBcM_I3W-ohTnxsdYCMV1XuMHHYeO1kOEVJvQ>
    <xmx:BATtatYvH9A-y8-GF5QJaEGi_k8B7xwhMEAy30z0EkQbdhxgxacrXg>
    <xmx:BATtakgjG1rYTGmC2gcEqB-eX20NkRFzFJtJ78SGODwCegEHwYraHA>
    <xmx:BATtan6_cyN0nLXdU_b1Y-YWvo7VYTzQgdQNKgpCGWScZG5WgoQ3bQ>
    <xmx:BATtasqruYjQHQHcwKI6LPwQmCJwocAYSPBfez0zbKSI5r9xm6cGuWfU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 17:32:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 08/12] remote: reject duplicate destinations on an
 empty remote
In-Reply-To: <20261014031347.50433-9-jon@jonsimons.org> (Jon Simons's message
	of "Tue, 13 Oct 2026 23:13:43 -0400")
References: <20261009192953.81794-1-jon@jonsimons.org>
	<20261014031347.50433-1-jon@jonsimons.org>
	<20261014031347.50433-9-jon@jonsimons.org>
Date: Thu, 05 Nov 2026 14:32:34 -0800
Message-ID: <xmqqqzgyq58d.fsf@gitster.g>
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

Jon Simons <jon@jonsimons.org> writes:

> diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
> index 7af350f01c..1e34880323 100755
> --- a/t/t5408-send-pack-stdin.sh
> +++ b/t/t5408-send-pack-stdin.sh
> @@ -97,25 +97,25 @@ test_expect_success '--stdin refs are sent after cmdline refs' '
>  	verify_push A bar
>  '
>  
> -test_expect_success 'cmdline refs written in order' '
> +test_expect_success 'two cmdline refs for the same destination are rejected' '
>  	clear_remote &&
>  	test_must_fail git send-pack remote.git A:foo B:foo 2>err &&
> -	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
> +	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
>  	test_must_fail git --git-dir=remote.git rev-parse foo
>  '
>  
> -test_expect_success 'cmdline refs with multiple duplicates' '
> +test_expect_success 'three cmdline refs for the same destination are rejected' '
>  	clear_remote &&
>  	test_must_fail git send-pack remote.git A:foo B:foo C:foo 2>err &&
> -	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
> +	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
>  	test_must_fail git --git-dir=remote.git rev-parse foo
>  '
>  
> -test_expect_success '--stdin refs come after cmdline' '
> +test_expect_success 'cmdline and --stdin refs for the same destination are rejected' '
>  	clear_remote &&
>  	echo A:foo >input &&
> -	test_must_fail git send-pack remote.git --stdin B:foo <input &&
> -	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
> +	test_must_fail git send-pack remote.git --stdin B:foo <input 2>err &&
> +	test_grep "dst ref refs/heads/foo receives from more than one src" err &&
>  	test_must_fail git --git-dir=remote.git rev-parse foo
>  '

So these were already failing, and the only changes are the messaging?

Regardless, making sure that a push or a fetch that updates the same
thing in a potentially conflicting way fails is a very welcome
change.

