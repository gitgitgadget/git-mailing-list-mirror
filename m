Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560653;
	b=q74Mcx4hj75cMOl7by8Y44rz387Pb18cwspXC9GoeHOWKQMqixVH7uh3TN+3f1A+SDA8
	 xwrwc44Ed7iyZzTFsN3iwJlO9C7TAlsf3IvJL+1mVZiHZ8Cg6pHBHOdgqUU288xq/CGJB
	 bKv0ZkH4m7k2HWHEoea79LmsaPXlLJYg6DAh1suZdatW/n6z23nifl8TeeUCgaWjKHWmC
	 LmAjS9Df3egfmqA3LRWevEg2NDc5M4ta+MVlDRElPlzulmnU6vcLwAuzzVLbOeJX2A1No
	 dMu8jhdaA0QLY6vm232mWQ4r3jIKBRB79quMaPw2wlT5VqwE6GrbGF3JzUHa9yvgXkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560653;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2Z26zU5SsKIF7e1C/RVirJV78zjhDOI7qJ2nZ/mDGDw=;
	b=3Vh3aJXqUugvF2LsWRdF9hOqCMWhY+icOZHNR6vdTbTn4V9J379CBWwFjeWuACrNDwO+
	 SYyyAGhFRjASQnC6PaHpzUyjvdI0JhUtqM+ErAfbHSJW3IMUwgOdyZua4LsjXINEfQOO7
	 4tC2s6yY8uwcooQo01qixbv02rnCO0DOF/eY/T8ZgKxf6F51X/QWSOtRTlRM36jyh/nrI
	 N8BDmY/IKpdusn6NpD2a7/WES0DAbu9w08yCQmqaxv0RB4mmFJIYEXQNVJzlaagGEKVhW
	 Q/XxxrXNSCIR9ZclTX2RqO3AHNhFfU3MLZ2U+xZhdSOmheLCUEdJsgfWrZFpJW5zL6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZLEDf663;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="YDQ5/KOb";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F6606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 119F6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZLEDf663;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YDQ5/KOb
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 256BA1400333
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:50:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 17:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795560652; x=1795647052; bh=2Z26zU5SsK
	IF7e1C/RVirJV78zjhDOI7qJ2nZ/mDGDw=; b=ZLEDf663CPNg5z+WVJtLIeFDXk
	KNuFIMLKr3UKhj2Zt4ueMj/v1ztaYYKX7gWnRT7aai3BO7O0onWE5B6VXjuCWHH4
	OgsX6+66oMOfrZq2CH74R+BQ6Pcvw9luWjT/8px9aVN4MJaprV1nKx3aX249z9NT
	OIECAQ934ldbu0GOB8RZvobQbNdbClZqLU/TiJ0Lzfirf/LPzDkIbEQDClofBU2c
	zoSAuV5I+5IDmgfG/DijZlV2zTfxL4V89mlpWoHGzqKQi3jjInGXDo5+q53gNd4x
	2TDthAjkb0KQJWFC36hjPQ050sPCVTigqCk9EP0HMSi/tbGosuqSoCgHgbmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795560652; x=1795647052; bh=2Z26zU5SsKIF7e1C/RVirJV78zjhDOI7qJ2
	nZ/mDGDw=; b=YDQ5/KObE84A/9+TmYTkVq78etnASQaKnLAyuI/cfHqHp6oFSKo
	e4QK77gfJ4XBOF0R2RkbZkNfCgOg8DKL7YV5NQxBsnVIg5FAD7CQQ4dt1uuByooC
	jyR2vROSBqPy0dnAny0sHS9xdwiz8T2Bgxc/NjVFNjbDnrdGSxvYhVD+T7DFswVu
	XybjGlsehmE/i6VpXdd2G/wyGEkxTw2TfSTFPb9RLBhSDpk081x5BjV9eZ05I6S7
	zpB0nD/PHtlE2wNoibWwTJLnmyrJsGsmnV8sDZMuwo+WfnuDVgzihhYhX93gNkfp
	acbXQ8591Wn+YYOkHqsU5MntuAtyGMvOswg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795560652; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PU94jlH5UE0z5ENbhKVrMnJWZI6vW++5sc2YH4w9zYdKsIe
	zUWZLzgoFtSvi+vsdf2pzzHEUKiBnMyy9oJ+y9GIBwz/oNqvThFkUyt4iGNxwGqa
	YyXxyn+prggdYEWzn1C+uwRSzKNfo+Wm2jgddzYRU9tRjZsfbl8lOmEikIPV32z/
	J3NPcdbXT6uUCB44UPgmVoR2K9bws1epE+lyWSgF6KTKcugeIIFfhk8nTZindkdB
	5gjYsuB424SOkWwXu08jCaRadXVQxecG12m7ImiGn9BXH+BGfAVnbYcbG0H26GlU
	PhL45OpmqtsM2K7GwR2c1ofciBzFsVi9UejjR0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:1CtVfOn0emvaJf2oD0TRUT1/vq0Dsleimr1LZK40JRI=:5q3E7uFPuGs4Ohvyyx95dmhrhFzi8mnBJ1y5yPWajyk=;
X-ME-Sender: <xms:zBQGa1Cq4tKzrmE_GPZv3O1HAEZn7XJ-bLXUUUrpvizHmcVG36-rvg>
    <xme:zBQGaylfr19r9tbs5WlDxaXCpsOEtoil3twLsu6Bc-eNfpdx4OFdI_rLukRxP7oeP
    jrWpMwGMZxbGDFk246oUtLMlwd7fPM18rAG84uOjhpxhxU9emENtw>
X-ME-Received: <xmr:zBQGa2wYgygk_WrpmJVGe-6pKka_fhFahg9wxyrR2Ve0BmFORJZEg6Mgudmm9QizjuZY21ZdyNKDO6Z24O5b7NjrrPo6fyTIL-ujeHA>
X-ME-Proxy-Cause: dmFkZTERoLLCwWyeJGEhJFvHIGuCONRpwtvaOyMcWKK5aTQ6/B/I8F+8hIyPMswtzHmg7x
    n0+TqptaTwFWPGb+mflsQGliQRKHUve+GRynWFtuXWEiUGiLlrPab9iDMe70lOwMtU6/jK
    WD486mq5GjnqzvmBTI9aKLI0DD6SWl9upc67e2ftQYGwjsLNd8PcfDPAkrUDcm475PCbvU
    i9NCeF0CApUWSa6Ut4tpSB1A5vf/f2yxpvE4BpSZYjHTb2gl8uwmBKVqcu6r32Pkm23Vf0
    RHqbziG5wb1Xm4y8yu/4napW8vwoDJrzCmdGw4vakA8+0JLwmJi2g+klYma+qasKZf3Ljq
    9/SUsGgOf3Fm2Yby2QwPGO0o47Hv6VIia0+RJOFKBu5qYIRSiNfN2N2ZaOv+c6xzZPnh1k
    Y6yc99Lv0wsHeI320m6lUG3st5x/HUcpnx5WRBZJ+QFkkfxRYDZ0iE08+Zt+pfWlqE6cHG
    lBSH2YfRXs3tFB1EfkNrGr7X459ETtg9wZEvpsKrJYG0qVf7ihxt8MLyDTZ4BPtjzQJ+uD
    Z8iBarxLbcr6rGtecInvZkWQufYLbWYesS7OH+OUKXi4VSP9Z8foYtjNRrCqUIaKSZygQz
    PGaWB/7FwqVX1yAjWHpWHXJs0HFEIG4yGLUwHj5D/Jpo+BYkjI+BMsVZer5w
X-ME-Proxy: <xmx:zBQGa8SLO6j2Vop-Ac12B70IaLAkDrCgw8sSntYwzmXwtHVq77muvg>
    <xmx:zBQGa-8o2xlxvnKwKhueqqx08GAy0mCp42tRbDHua6PXArx47I_Zyg>
    <xmx:zBQGa6slI8iXZle6JbQCm_0cE7M-SctPZSsKhqHGZ0480YVy2c1Dtw>
    <xmx:zBQGa2P8NVG1A_GKHhdfMRNzqWq5x4ZBFgeuEFRehzM3d-JU4mIJKA>
    <xmx:zBQGa6AcXa9oZE1Ebn-jTQe0VDVVKeMEwjfJMBKScmT8ZS1ofVCk2DKf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 17:50:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 0/5] notes: start passing the repository through
 notes.[ch]
In-Reply-To: <20261124172146.18330-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 24 Nov 2026 18:21:41 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 14:50:50 -0800
Message-ID: <xmqqld6hkfn9.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> This is a preparatory series.

Whatever it is, this claims to be a "v2", but in the same discussion
thread, there already is a two-patch series labelled "v2" from November
3rd.  The original sin was the initial iteration of 6-patch series from
November 5th that did not identify itself as "v3", and calling this one
"v2" again is making things worse.  This is breaking automation, e.g.,
"b4 am" gets very confused.  I could use the "--no-parent" option, but
I shouldn't have to.

The next one should probably be called "v5", as this is what should have
been "v4", probably?

Thanks.
