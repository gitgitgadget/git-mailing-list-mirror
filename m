Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178445;
	b=3HWAreDWZ98rPGjDNubYyE/jSCWhpaYpNIZ9IJaF3V0fCV93o0BKBVT1cEcNFVBJq2Pe
	 8oHWy+zByVFuit6RK6AWKeAFLS1zN5zBMSx7a7MJ6BxiXDzqdMpWsPDTwKAWOLNoUaj3d
	 rOEP1LwiRd//3LVUw5FUgKfiKsROzUu6tEY/hlTf7D2yy/IbGjSGbfgNHocG/xRthTbpX
	 1iifJbsr8n8/R6SNBkK4dnm6L+gPl/Dwd8o6h8guGuaK/eEKWPTL86VdhAZUGvUaTV5DB
	 1730Iz6jsErK7Hg4hStMNMcHS3cZMQTEdhRpCY2lQ1eN5XDUPfukrhbQ7/DDp62S4Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178445;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZG4XY4YZNlDuh7tFOErLfy25Oi0Ffk35PKrWRmSTTF4=;
	b=JzmhFogxX+4ZvCGOFUuyTBDJvLf+QieDF4IiNdwxr5MJJkyS9/FCX7NfHIH15n2pAheO
	 QF03txVCh+JurXHU6y3fs6CegWC5o835o7XRd1sFi2vbMO+UrE6XI/z1xFd8o4sKRqZ7v
	 7Vd9dlQY2xat8vt9gwDyKI0qs4xwY/1V2p4kv+OJAGKd3bRPQtXWFmfgPqiQkFA/RCKpE
	 QjGiGq7oxpaZiGJzU9RayOWrEue3AQ53jMPW7UYBDfFzc8S73Ndz2kY8PO7BD622XvIDv
	 PAJwM+gsFLqcg4dGiMxw62ydctFjPwE7+qjLgund82FbfRaSKgP647yXNTVFbXekobQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JKrpoUdQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="L3fnn93/";
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BB606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 628BB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JKrpoUdQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L3fnn93/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A96237A0169
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 05:07:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 05:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793178444;
	 x=1793264844; bh=ZG4XY4YZNlDuh7tFOErLfy25Oi0Ffk35PKrWRmSTTF4=; b=
	JKrpoUdQ3nLAAzSEdL0AzlpSK+G9E3mO4MjQqqsB5+8lpbn5sKR6B1qwYm3mjA64
	xvJG/I7HgHb082EL6eR+YaY+yGhCRZy2pmttlifnXJmNAU5hqrvh1M8iLQQAhFdV
	GPftsg1ntdEjK90jiz+UQOBjv77uxPIctcSfPOSupzlKHsfNd5DTSsfypWUAavQZ
	zx6xSRiGJPAlh6PT8UFBezO1OQmXHN7nPXTk7ZUeIVozpWfb2NK2IqiGefWOa9mx
	sQf9hgOEcrko5Vx+1wLS2tJBe0eIH9+KApuazY45ySvsBP6Puywzi2/RwsdNpACA
	h+6qsDZzU7/oS+IzqU6rBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793178444; x=
	1793264844; bh=ZG4XY4YZNlDuh7tFOErLfy25Oi0Ffk35PKrWRmSTTF4=; b=L
	3fnn93/ngf0nMZucBJU16v/g3hIqdLzvTSilVEl1fqFsDGEFSnS60FW+Ngx/dwF8
	0EyWy0zQwJhFYxLoHe/jECnt++QeA6WF82/mt9PZmoRaLx6F8Mk77x7I3xgvyBKJ
	9oNAGrD42YJaln4tb4w4w2SDR/aIOWFCXakOgPDUFlmP4KSk5w21HkQLfNK9qYSk
	Ymm/2TJSYVUcxiKFY3GQ8xlBJ1eOLlemUY5taUJ09y6RKZ6K7dD7zRXuP3A9QZWT
	Cxe5eLmp4pVU+bVk0/porsYw9RtkSFQFDgOlj9NcK81yJWsV14IDlO4A86gLijwN
	ny9V/mRmhH75/l4eBdpSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793178444; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rG9ZMvLuPamqDAmYMR6HPMmN5s+KlmH5pN32/yziAJiWV5u
	yc1UToACipB1Qj7zeU4h9xzrmI2xu4uaSNKnYRmmOJNtvCaMqrlil+2jzxt7+y/K
	wXD60EVKAktqExCzEEgakhtrILbY8yZZRkh+3tZ7Xd8B4gg9tVXRx14Rg0Rq5kRv
	VAAk4zDfgeqOhm875vOEn195WG0XB9a5OCDsEDr2b3dn3mEFi1M9Fpvfbp28HGDv
	gbpGwJvpPXE49WC9D1ariO2I5YIvmIYe+GUd9dXTNYRc89iq7ym+BWbauAbiGU/n
	WzKatEAvguza+WnJpmbft5CBLQUO5fnvhXdEAEw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RnsoSuQWk/FFqtL6PC9uZDsLHA62fmFZ/dwbHi5/gqE=:PvJ8BMeya4vQSnydUaGe+/+mWxUN2G54wsLpY0yMmKo=;
X-ME-Sender: <xms:S7vhaln7CLvE-szuzdJukHzzAXVlO6KbkfvA0Zfb20z3szZbgtwIkA>
    <xme:S7vham2aRHH42qb4GnIE-LYP3RiBjnC6Bp5gfgDriO5MnbUJ0N4bVSmjqEhE6Hk65
    aUmm0YYVajgD7TNx58xaFBbNmpq7fAcQrtxsrH7qinloIWVsQiplDI>
X-ME-Received: <xmr:S7vhapSkuPOyguMfeVaLSI3SxARSPUmP5rkCSY3b2I6_Y8cXOj8c2w>
X-ME-Proxy-Cause: dmFkZTFgwi6vl9EeM12OMbSfcqYtBQIY0w0Oy1MADthxIC/NxJhObTsdO53qMmFExXtyHr
    R8MSHZ6J3pmfYqAdaTIARuCpwpRDKbVS2Ooj3gUi/8kUwMycCH0u9KMnhFh/2PNAbw4WWJ
    iEoR30qfaa3xwhoUiagOOiP7N2AjgzWF44LJjQdFpBB2hP2G+cxfYppWLoTT0Ut1Dr18lk
    i+cqJNzzklvW1e3QyMRN3J4gwUEgNPowIRbfkQsL3qB1K/Gvcxoce+oPQXJIRKLJq6xJih
    1u7JAkyCL0ncIqYmCwxz0lvmN84K3LfPfPW4im5+3PgYpbNL38IVh1Abo8WViKjNyzJjUf
    IO9ZpQE4NIbStwn1DiEMowLgPZpRtrrNBpRWrAPO52yecB3cPVFMvATc7bJACgpov2ln1T
    DCHD02Cpw7xBOb+QaCKDJFREbUuUwbPYEcpzBAkLdeLRxCkfaV3b0tXAnlgaYDfQKnechK
    BOT7nO9gJZ4Qkf+711mKhSGJJ/S5E4OFM5r53Lj1KQNxDQS36u4QtCIJ5VjcSn5zUyjfZe
    uEJBmfdk6gie2wwA3XQqRKv1Fo2wYVvaPneHbaBXMxM23oZ7scAwbD8oeFnp0Wh7vLGAfX
    2753NrnsC8xds9KWbukESuPnNEFhGIkATLuLy5s7EQfxQMvBB7LUgpmmX3Pg
X-ME-Proxy: <xmx:S7vhagtUxeHJ_FHL0ZoMdLIH2hLvP7BA3knGzAoniVv_o3yR_XDynw>
    <xmx:S7vhamYocVgxUBM-A2K6fLuykXOaiWdbOhnFFFK-XHaIzzZx0UnHGg>
    <xmx:S7vhatvCGaJo8h7tK6oTrkUlHNkmwcWC9OZo4oRg3H18mbEAZOnq0A>
    <xmx:S7vhagFsgZHjxItqdtwhaR62Sn_euqo6K-PjtMNJDLvasW2fQ3Bh7w>
    <xmx:TLvhauVDXtRUY--TApjT7H8NOkgNAv7OzY6kkNxdxJwgz2VYcgb-iFok>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 05:07:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be8c97b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 09:07:22 +0000 (UTC)
Date: Wed, 28 Oct 2026 10:07:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] odb/source-files: simplify directory duplication
 detection
Message-ID: <auG7Ru6MhhXzrVd-@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
 <20261028-pks-odb-files-reload-alternates-v3-4-011ddb64b626@pks.im>
 <CAP8UFD2Os79AwJrFvoPti-AD=v6wDf7BVWy4o9dQxQriFD3FzQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2Os79AwJrFvoPti-AD=v6wDf7BVWy4o9dQxQriFD3FzQ@mail.gmail.com>

On Wed, Oct 28, 2026 at 09:59:57AM +0100, Christian Couder wrote:
> On Wed, Oct 28, 2026 at 8:11 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of
> 
> Nit: s/dir_paths_iscase/dir_paths_icase/
> 
> Otherwise the whole v3 looks good to me. Thanks.

D'oh. To many s's that tripped me here. I've queued this locally, but
will refrain from sending a new version just to fix this one commit
message typo.

Thanks for your review!

Patrick
