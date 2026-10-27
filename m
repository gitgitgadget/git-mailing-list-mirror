Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134774;
	b=WQP1PuMHoi474iXgvckZ83qMnGz1mix9PHdoc+qser70cDwBf0qLYGzC4sEyJtOIgErL
	 PGNSpUsE0k8IpGmbbdtFU2gm1xZ4jYQWMPSnOVKSn6C/Ob73MuKR0htrwwhfTtrApussX
	 ik7dgs32V0L7DnuelDDj/jnCm4p+/IYZuksc+iKAbX1U1HQMKbRQ3Re7009WA3q98az/f
	 8rJXFJ5U07pePyVyeAosRCLxTy/H1qsbJYEcbeY0w3OksG9cQ3e7nrWUgDRGJQMMhhACq
	 hTkucnEdeMPxL56PvED4l84Xs7BcmP+vGZktlWrTHa4D+GzZaO+AvgPWCr7UEFFKOUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134774;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2yekoQT8Vo/RaV4LMrpXDAd8othBmCFKKfPuGrhf+uQ=;
	b=bvCPM/zUcuyG+oi3MrOh9UAqKttaIvTt72MFjdFgBpCnwMgT/im0+Ap7op1BEBKMItAp
	 h8Xa0uyJX+gQtj0/G28qDp/KUr881MhTS5IGsPZJz96NRUIdcuoOWNdgnNviGmK8EUwVd
	 LZixiQLD0chksrnoLW07PowwvIkK55fTcwuFhwY+P09moDidQeyOcCEIvi+vgGSxwCBOw
	 NFG2N19iMME4ox7EN5OXXXCBIZwjgIu/N6S46gsC3p3M8DApl41nWe1ASdZPgqNzdPlbS
	 IckzW9vYaqcEpKqg04F4TG7H7KBUn3wfJY0zuDscz861x7XfaNIzkusCprk6+2Wxz1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=B8SBRS89;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FNmKk2lr;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC0606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=B8SBRS89;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FNmKk2lr
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B2A971D000E8
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:59:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 16:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793134773; x=1793221173; bh=2yekoQT8Vo
	/RaV4LMrpXDAd8othBmCFKKfPuGrhf+uQ=; b=B8SBRS89np7tfZvXkN4WWGoeYb
	KCer/8TlwJAHIAboYf7dlOmftuy6lj+bthkPBTVoMAw/SY1hfnS0soh3xvKsu5dy
	u7PBlZpnkmrCE3pKr4drqY1/bG4HkybQJ/3Z1CqoEay6jVI3gdGwdn/ZA0NON0m2
	GPSX0imp5sgA0x5s+b4ZbIyzS9eDkdGEUyHu8LGOR/bdczXo5qZgxkZGm7bWEavE
	VBOPDUNmGkirX06wSM1tAWsrQjjapBrOhdGtsqL6iL78De6iR/U5Vp/bF2j4coVQ
	S7q59xPjbuy2L1xkIT5DAHG+I3NZLUhhjzy2/YUwrgueH67UeFf0CO1qUj0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793134773; x=1793221173; bh=2yekoQT8Vo/RaV4LMrpXDAd8othBmCFKKfP
	uGrhf+uQ=; b=FNmKk2lrwQDZsU3+0+IS5VdhzedKQ/gUJqO40NxBxCs06mn8YQO
	p2F3aD0spyCwGaLGuMBOTXa0KKQU6TuyPXwi75W1s0rNhGRDId+tsy5sqfnBi5oC
	yyfHKzslLuO5j3U6L41ONwpHeUtF/pO2qhQdqq+6TdZ08vXd6eTVBlAbTxcoDwP9
	DnnKgp54rIANyUCY+Y6h33+y0ku0+ealaoCYpUUE/R1YKydXSJLtYJrkKUk266F2
	em69SYhFudwkZTuNaoL7K+v+GDWIxGuv47fKhVJdHTvhTI/kjRoXgIRqEy2djyck
	cAM42XinlzUxiZgOkr+zhc5te7nzgHpZO3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793134773; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:D76ExmYc7B1qtMoNjquI94m4N3vLF3nV7WirNDkrWBozicw
	iTFRrnD19m7O/rBEFwHDiiLWHwzKug/TGz7d62Sn463raYTiT1h+MQ+GU//OblwN
	DN6+6W5oOYKqwQnOFh/rUaMdpkFxUDw4Lr8QMBKCtGNZE97GUVcvtAB263CS8ErV
	rPdRv7s3muQE3eFYBI1LN5fwhMfFQxc3v34L0TiLXSZvhv9JZ0ls8aarlezm5SUU
	HD79SlRb4580hazTNM5wuxgQwxub1rZijCc1wd/c43dRMdlIzLN1GgVfKlvQV9rh
	RQT/tJ9inxeL2AyqBmPK8lQimJ+hx7OYyTRwGYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UxYnk39aPJzQOe3WrinwOSIpOaN5MnLQgFjCY4IHo/k=:blLfi66FdMK4iL7JFh2PamyxAlinPbRF0es2+/3ASL8=;
X-ME-Sender: <xms:tRDhak9u8d0CiY41fA5TF4zzzLQa8KvEswpgCQgem8u_FdOU3s_pUA>
    <xme:tRDhagYzLJMS2D4yM-7LBeDaHqVjieTtVpf66hrNLyq9entfJv6JY_aMgyS4QQ9M0
    mUykEk5qKNzH0dShb_z6lqTCjJoFq3Yp-MSLQU2os5CAgJ1IlBpjnQ>
X-ME-Received: <xmr:tRDhaj149OWtwBpzrSaB4hJ0f98sJWMguPQShGmYc6cSGgPgrXi2iIkatcLUFBcWUp8PWkGXjo_rnDojxwNCg3_BruK4ZB3LPFcr>
X-ME-Proxy-Cause: dmFkZTF0hpXZcMMwpI2jqqINJ3y8wYqQd4hQ0AD8ocSb/ImyaERrazkKYuNiLkQvSuZLeG
    TxGAMUZN39+oSLsTXbF6I9myuIeAwequVhY/BaHxX+UeyihvGjV4sPOMqmJgmQv1KpDdN1
    Nr9CACDmm+6RIRIJAiwcqHji2Sb2V6KnUUOgxoWpwLq1WN3pzZcFp6PmfLDX9nmj7FRbBr
    qtfIFpB8r44vAe/3BI13GHFYDkxtcVl0/N1DJJEBPjFGGDrRG71OjFUp96SCKbUreTorcr
    EIJv/27/BscPzeS4bAz2kFRqi/xLthQCCJLVoJ7oXX+xJdxfxSjfNBLm+e+YWH+2S72WUd
    GaRZGGr0RlaWPgB7+DjzuXdVJ2uTBJB/H0ApVwHobfdb/84qNk4RBpGoNanDAokXZ/WBDt
    JfLtW7bygWQf/YKb9xLjXbwh8OsZIgZfqP3GF1uUQn+ktIgL+ZnYZLzWQLBbOA19J3HlcL
    VAD+8RaVQaZuuQzpbtnjP4PY7RFOO4KGPk0IEMRYkWeS+qVzAcV7nUXTuPjfDmPAe7XIom
    nicpBIFLrGuJ69p/GYbmbtsKD9ym5kCYh+heT20d/Z0+djxXDz/TSunOzGe60nVA+zA2+D
    gT8gnvfmOxtSHLaohXIUgK5MhLbScbgHbdUoMo8668exn7E1S7M3dGIpadwA
X-ME-Proxy: <xmx:tRDharZvRy9vNf4AskqgtCpena6pbMmMHiqpZoiPvrQb4fgswcHKFA>
    <xmx:tRDharLjBYYo-_abznAP7Fx6EYBA3f3C6btrhA9rdMddNTMhvZc5ZQ>
    <xmx:tRDhaqH9Wy6OkfGs8XAlnV5rRvBxV484jUDzzPdgFpnfOZY_ro6qcQ>
    <xmx:tRDhaisaft_zZ0VjeFBeKGeOwsLiEZrBV2ZBo6YHwfBAVRhHzFmZ0A>
    <xmx:tRDhak1PatRACX0ffGD1H02WSWSQHs-nVmno8SpZ8gjvJe2wQGZdMOaz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 16:59:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
In-Reply-To: <1da30fde-75bf-469f-80e1-ce90cd29c84d@gmail.com> (Phillip Wood's
	message of "Tue, 27 Oct 2026 14:53:07 +0000")
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
	<20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
	<1da30fde-75bf-469f-80e1-ce90cd29c84d@gmail.com>
Date: Tue, 27 Oct 2026 13:59:31 -0700
Message-ID: <xmqq4ie6j1vw.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> That all sounds sensible, the commit message could maybe flag that the 
> "feature-testbed" also sets OPENSSL_SHA1_UNSAFE which 
> "--feature-testbed" does not because it is only concerned with GIT_TEST_*.
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index de566309861..8863bcac930 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -202,6 +202,14 @@ finalize_test_case_output () { :; }
>>   finalize_test_leak_output () { :; }
>>   finalize_test_output () { :; }
>>   
>> +set_default_env () {
>> +	if eval "test -z \"\${$1+set}\""
>
> This made me scratch my head for a couple of minutes, but I think it is 
> correct
>
> 	set_default_env ABC 1
>
> evaluates
>
> 	test -z "${ABC+set}"
>
> to see if $ABC is unset.
>
> Thanks
>
> Phillip
>> +	then
>> +		eval "$1=\$2"

This one may want to quote the right hand side to be more widely
portable, i.e., eval "$1=\"\$2\"" or something along that line.
POSIX Bourne shell does not require the right hand side 

    VARIABLE=$VAR

to be quoted, but CodingGuidelines has observed some buggy shells.
It may be better to be extra clear than sorry.

