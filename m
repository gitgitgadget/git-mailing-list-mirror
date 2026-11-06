Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986384;
	b=SIOuWiqPagUFahnTi1dHOLrK65KoH25u9Pk4tgyQAge6EAiO84BsoB3cJ9iWmccIwneO
	 7J7i2l/UUpZ6gPhNGlL+i1RoE9Epp4nRFJanTw6wQ9KsT7ts4NaTCanpcPpjycMyWsImy
	 HAIpuNFbc0Xrtka5zi2LGVeP/JtZ9bb6YGNGf/95rqpGYTT3M7pHn2yGrbEvhrNAeH4XH
	 4aIffNUnDpfVTl2kqBBrjBNG5nRrPZ2sMpo3f5Z8dgzWA76xE4QRyJQCJTPKNTSLJntyW
	 gM2rbIrJTd7dXno/BGNQg+UdjtXAztaOFzdPQu0VPnWkop5QmF0dR3/MlT4Crb4kOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986384;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mSwIQIjrlcopwJoZzvYr17y5hJMac3GE6AaIAeSuQZw=;
	b=U33r7UVdK+7vX+NQEFqhOmq62tZMtH/1uf6DC+QGm7WNKRAwQJW/PJNPt2LZz0OSW/g8
	 2bqEyU2O3d8g/1wteXSkJ9atQ873Rq/NcMQ3AILaCZ8fwT9XXXDIcfbrEXxWL4TFJ1y+1
	 0yQxCwP8Wu/EpwIyxtr8zuKabeMfKxR0zIDoZnwuhCttUmD5yZ0Y3LpLg9vvVL+OuntPm
	 kGWPkJ81eKhkj9H33LrTg93sIh3pYsK456YgkjxqRGGUZ6ArC4q6mc3bXHp81vnbv3Zsc
	 TTH1V6/dmotr2Ysd3nX7PCAkKfmnz4USj40QPBT+lTmr4+R1EU7fkSSQHUW/uCOa9aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QUGmt4xq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="b/H9zTiO";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139B606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2139B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QUGmt4xq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b/H9zTiO
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CC1B7A00A1
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:33:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 12:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793986383; x=1794072783; bh=mSwIQIjrlc
	opwJoZzvYr17y5hJMac3GE6AaIAeSuQZw=; b=QUGmt4xqxhSQi1oQ7fxoA4GxAO
	He16WrJmXKCBuNcBvvOqAxqR0KNxGOILxYPMtjE9a60wDnWsfszu+xlgrHj/I2IT
	BE7QC8HpXqKAY440+MI38+CPT3KzxJ5kZL9FfZdyxD5JCksjYv5TBcvTWOpf9eya
	Ynars1yUKg+G2lrfUo/Vatd9RSCO+WFoz1he/AfytbWR50vOF9nsqOyGfZ5L0dkq
	FCbR+CRqvUudwe4vPE7pJXO5mzRiTo9tQL0jXOEUu06EJvN4+ZHGExEBPAbnG7I9
	IdiMW9srN9UHc+40ntPEN1Rb/HG+6dLm8WVF5cQ/iwmwA5eZFtJlVi6fLASw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793986383; x=1794072783; bh=mSwIQIjrlcopwJoZzvYr17y5hJMac3GE6Aa
	IAeSuQZw=; b=b/H9zTiOnS+8nZuFM9RfA0uDssGJw4hSaqO/WN1VgrtA8YiBHZ3
	D+UXoUvdyoa3APKueBvWqzuzrMaARI6+aYsEG7CmKTyYLY4w9vohJL+KkIHvLmqq
	eidHHjJhAi2u8mr17eaVdcdDKyOywZACc5GMbQgQnM84n832X32ch6jqE12A+NZr
	nZBdCpmNKTQJDSL3q2QiCRT6qphZb1nnCjW36V+sUdSJv93aSYBbFS+0/IDB9EaL
	KM2w79gbHVP73MA/tGX/P0sP6WqwS34a03V6dnM+v98dTU5Mgj0oCCmg1zQRyEeA
	6H5Db+Ma0iyncDuVoObfYEkhRAeLwgoqyGA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793986383; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MaggrbGbvw5UWJ0te58BSmG4UTGhlWCaub7ra9m3kMgZY02
	EoVDx45c+x5u/QAPL+TnN1dBmI/Uey3EZB964QGkhmDioRB4LNGFpUHVkeoACfId
	I5FVaxhap9puq0LJyD2VizI4faZPFblOGPEVX9E7DMYSUUmbkHobHGK7dQuMjqBC
	CJfS9wgAMwGsEp80E6dAegB+T5vlSdhERnsqjU5pNslYVm/zairIYWcWx2TZTa0c
	EWBPsGsrYGcoqv9DC5+wxWoMkIs0l7gP3r6qcbGlrI4cTjceKDL2o4il3tf+laIx
	K306OOlz0h6rQM5rclWO/6IaarKde2dSwv+IZxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b4IGPF2pcIot4R3U036fgr6sqHv3fa1LT7KKEyhf3Ns=:jTehLK0olc+GtdSCTHxpzy1CThB9iZH/2calJ26ugMc=;
X-ME-Sender: <xms:Tw_uakDZUOkBvwXcaf33OsMYS6EdgD1b0oQMVhFBVxjdEPbpGL4sQg>
    <xme:Tw_uatjAyiQZgCX4bjnBfRbQxQV-2CzdDfBxMTzobOUNPRrLlJl5YZMJeApzQ44Iu
    CfcSIhMVL8MN_G9G9Vn2PvccOmBZtKNrQorX5s8tUCkMmeHCzDBk50>
X-ME-Received: <xmr:Tw_uask5oFiMZqp5aIJIHi_JOALt6SDTIJ7YXF2B0IvhiVXA2Vj7WfQ8_qGa_CycL7ZEzqg1ndGVuE4X4poVmMtcsWtLGJhS6o9Z>
X-ME-Proxy-Cause: dmFkZTGkjSOyew6rZ/s3P4+SJDBeJJD5b/YQVJwQB25x34IhZcHTFYSid6UKW1qDWWb2ep
    Rlv4ejl3kBQhzaDMNRPLTpDOUloCLwumTXnt3a9no7DfWeoxG4/e8JiMthZcX3jUGH/yDJ
    9wHptwk4e6g6r0y9O5j62U2P5hvUiZ22fU8UUrlzcamVWLT3/q/Gi0G+9VDSYV/dSqeJ+p
    m7szTdOHvNymgICiu1QL1kqVjJ6eXb2IWgjcG4Yv95255G5VkSuRAKn3YMImOIGKNwHXaF
    Q6d0t9wYpZy7kYvvgcNnUBU4uMA/YV7uIXoh3gh0/c2WVcC5oBp0WepXhP+hP30ha+d2JC
    U/+UWBhBZeK5p9/hoqVp65CzcTAPiOCEGA9edTQSG5Vpvxo87Nze//3tsuDgNeemnOB0Xs
    mqtfKFMrXFvfcMwvU95JdWbGq1wZeXAACKggAI28YJ1r7uEcYK5aD6cJ4hUMD/cb7J9Yys
    wykOG5kE+/elmd2Wiue5TNphOSRYJ4vrVGxwoXHj1YAB+tBWXyQJSLeP0XtpIPPxAZ4I0S
    SrjV5hWt+lNZsm+0armOq1vgVsPh5HSPjBXHsqwBdNxLbsIzJ2rM4wrGgmDupdY35iHh4u
    DGLzDrIYH1QfAbTOVXQc3EsqVguBLiiimVU7igWpaRYsyXAwl1zJqTmdLTfQ
X-ME-Proxy: <xmx:Tw_uapo-jxxpxPh_x3FTkaisvGPLs0BQbAqsWpa9zGWEE-j8KUb8xA>
    <xmx:Tw_ualE5dcoOx4Dkb0ck7q20QvqmHkSEMJeKRmdzSbY73S-UCF_Dyg>
    <xmx:Tw_ualx7quhQOXRRzWauZVp7nnrpnmowJyJUe_Y7wRRzO8RkY60MyQ>
    <xmx:Tw_uaqpBJkQ5af6BGw0oCBgDoBtJ2zBtt9LekU4X-teTTYyliwU3zg>
    <xmx:Tw_uamjyJK49vOMnf0uyCWEDNhj_JR6RcLjMjHeY31JOnzim9l8G0TwP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 12:33:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/7] t0027: optimize how we reset repository state
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-4-1fa0374c7287@pks.im>
	(Patrick Steinhardt's message of "Fri, 06 Nov 2026 11:30:04 +0100")
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
	<20261106-pks-gitlab-ci-speedups-v1-4-1fa0374c7287@pks.im>
Date: Fri, 06 Nov 2026 09:33:01 -0800
Message-ID: <xmqqv769kgqa.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>  	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
> -	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
> -	do
> -		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
> -			rm -f crlf_false_attr__$f.txt &&
> -			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
> -		'
> -	done
> +	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
> +		rm -f crlf_false_attr__LF.txt crlf_false_attr__CRLF.txt \
> +			crlf_false_attr__LF_mix_CR.txt crlf_false_attr__CRLF_mix_LF.txt \
> +			crlf_false_attr__LF_nul.txt &&
> +		git ${ceol:+-c core.eol=$ceol} checkout -- \
> +			crlf_false_attr__LF.txt crlf_false_attr__CRLF.txt \
> +			crlf_false_attr__LF_mix_CR.txt crlf_false_attr__CRLF_mix_LF.txt \
> +			crlf_false_attr__LF_nul.txt
> +	'

Hmph, don't we want avoid hand-expand the list of files even though
we may want to use one "rm -f" and another "git checkout" command
to work on them?  IOW,

	paths=
	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
	do
		paths=${paths:+"$paths "}crlf_false_attr__$f.txt
	done
	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
		rm -f $paths &&
		git ${ceol:+-c core.eol=$ceol} checkout -- $paths
	'

or something?

>  
>  	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
>  		test_when_finished "rm expect actual" &&
