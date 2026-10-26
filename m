Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005139;
	b=druqw4S7u8C4Bdiq+0tpvnm4GMnSUWTKOJ8hk4Z6RJeLGWwQI4TLyxHRjY/gfbKyASX6
	 xoj7rt8hbkYfSjIFe+/ILa2zyBKAI8qclVltrG0R/K2XgveRDd5PJxHb4vgIU6wULxeH1
	 7iiAKHo+C1JgpsgxYPWN1W5/OKfuUw9j/vH3A6B8i0CmaLnPZDdPy0zAIvEvXpUQ68Mc0
	 lS5KYUMvrVpXBsRd+myEv/c1K0+Wl4rk3bR7Gpb/QMKk5BUj3JK2wDo5DIhS2rJSZD1Sr
	 FIk6O+KYlDdfxn74uNz53R5tGM1GflTSc/x7kZ9AJUGIrUw5yOLUS3t6ri05XDIMByg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005139;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZRqDFtJl/S0tcpxRN74Ce/cxJwbiNPZNcqVl2Z0wDlA=;
	b=f2XkJtp6h3qJsoIvQQWVzMEIZAPvL/gsh0j3PwWty2L4SizKwE1mOvCxcvQgoLAeUEYT
	 Tlcj+QjlV4RM6eX02LZs3PDF+atEdaj4RlkF1J0OPVa/hSnS1pCz4KyenG+QXUYjS0rPm
	 uH5yve72O9uh+s3W1u8bl4hPUyOyvaKaIvdhdoX3peORZIGC/c4Z98AvAFJp7GJ/Ctur7
	 eYSKqV/bKv/MWlLvz6KISZ5G0KGx6nwNDcuSuAW4WAoi6gIDOWCFBEWFBRIQ//bltkIM8
	 Qi5QFCwlQe7XOvy/t8XozbFfAW7wT6fzv7wLfSLys2WoZ2hYwi0vrVCo8RX+B5p+Zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=u+ImH3Zf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=erfNdm9a;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44556606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44556606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=u+ImH3Zf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=erfNdm9a
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F43F1D0023C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:58:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793005138;
	 x=1793091538; bh=ZRqDFtJl/S0tcpxRN74Ce/cxJwbiNPZNcqVl2Z0wDlA=; b=
	u+ImH3ZfyKP1A+zwAzYrEXFGzxS2hTU40x205E+cPXZfRCh6iGYiCQB7rTO6r6mU
	NyUKaec50J6DAMEb7yInSb2877sJ0BErVL8HuMQOn4jHohD0tx8Ejz0l7yix++Wc
	d1ryfUR5Hue6SRq8nq41ieqNxuSWLN/v3Ha8WT+SWGCrvOoFfcZeBOUaP2SpnW4b
	UsChzFeevkkrDGmPnBDy73TBMzE/1tOf6h27U4blXtb0fo9MwSS5bPxy8Roh3DaC
	yx7WAlJlP/N9F7yGNv6KatLWSBFt445grm+P86zIk6ehwWhkd5TyBqTLW+Pk9fsR
	rIMr1iQbPKpxIRKszDSHXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793005138; x=
	1793091538; bh=ZRqDFtJl/S0tcpxRN74Ce/cxJwbiNPZNcqVl2Z0wDlA=; b=e
	rfNdm9a2HqVZsLxRXzAkvwa/2byRDbTOtQkIHUnLkc8JnLX6ote1WR48Glh3qT0L
	Iy1yX2xy1ZmHFXhzaidylcPeoun+VkitChCfUTw+1TWN/Bh2GJB4Xr+/XJnkoPqX
	Uiwhh/PG/nlEELA45PEfmlkXlfM/vEL0DO69nj5LcsBY2Qb1kwq3lFl41JSMg67Y
	m1NV+orBQNUf9h9X4oP85PoAuP3LCQU8v3y5FOCKtMbjYV7roVF0OSKHKbZuyhp+
	ITuBaLOU7BP0RC/XgL77tNJdRA+nxwaB6vGW2Oo+W6GdbJajL8NyKCdIUawet+EM
	bKixose1H8Cjq2JBNTyAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793005138; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pH92f9BsKct2fWwzCMi1OiMg5byFcFIZe2D0Nvn/6e9mUNE
	Fr9GCbJ3HlhMvCPD59ECDcXoPT0BzDaQK43G/kYsKO2BfelU5PIMh9rOMvsh/Lbe
	iyZc3iKLgBXNZ5/RAObX/x2/E1ed1Czpp+ORbSspeBaOFTJKMXYXO1HT2Yh2dKJ4
	JS4C5Wum4fthvw+/Zil8EM/sNs7VcV4cfRZgBtel3i/i1vLXtxJzIAbWCmGEjot7
	qwjLsGACF4Oss0zTwzxidl6KGYSZgNJWrXCLhv9Je+EOfA+cQBepTjSP/I52HA07
	ua3rGpi8A/cuGGD6XVVfy3q6d9lPng5YfTMkqMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XpYQLOiGPIUTjGbDGzgRF1tYe0QWTc5S4BSyltPRQ6s=:pE0Swfe7uifsyjYL/hH7TBy+1xHLGEhevRrDmsBYMZA=;
X-ME-Sender: <xms:Uhbfag-IA8zrAr0GcupYiDLnIcHJKciMYZ5lCmcaIDNAuy_rANuuOw>
    <xme:UhbfagJgZCtsH8-xIm2ua12_J71W100guABnfzEuD1hKc6CdGhzWyjSpifucbxIAX
    F5oDumiucthlvzVT1DsbuHpfhHVZoj-nQ2ocfs34JYTgYMFNQUXug>
X-ME-Received: <xmr:Uhbfaja1VBqHrYDWwI-2TAwpbF9FwxvQoFgrCOG9KKyY3rC_NLQWjA>
X-ME-Proxy-Cause: dmFkZTESVcLDMxMyxhg0EiWOhd6PRF23rGhu0cP3eh7sKf/1F+XGThL/2mgelkCY4r4u9Y
    chzJ4tbl/4EwJt2S8s4/i6W3AzOyZE8+NCtrVJnqjuyguHoPH2Zq5DEDRL2i2IKS0OZ1PV
    h4kaxWRoqRfQOO8DY0ZEdFgPUaJA1mGZWjowygdUkHkyIN0yy6hQ0wkZGi1ew2OGQ4vpgr
    KaHwB6KDqnvjWvtRRxKUOI0ZL71L7cpjBwKdAKWJUJcB8Gary1W0Nnu2JV687TXU5mwTj2
    bi/2cwW86sq4H5xtLTFJbZxl2xmSHjdwdzEorLa00Y0lxYnes/LuXlxr+15VTQqgoa/7B1
    Y70JDLBkjKfqo7gZqNNJbjTbb0MSiACovGjgj0ND2lqSYVg2QIY6aGLJUKTYhZhrU70v4R
    krfV1M0aQjdT1laYBSU2d76RpSM+O+HKsQgXsAb0UWkcBKVZ2pDlm1887aDvHUn2udcme8
    tX1VNFPWpfjat3wucz26w2qiU4HMrNA6qz/7qlKQ+Hkd/2edEgZiPnF1kM2wMM5B4NN3KT
    6ANIve3FU4d7CdTFQ1OGubqmv32IFBenW+vhrZfr0PqG2Cu7aAbfo4OecC+0jmSl2yw1Dm
    XdasI/xpOHWbYGK3GrABifqPGVcxEbtdbg2+FvVILeHhXerIUMlhIC4IHrfA
X-ME-Proxy: <xmx:UhbfaqIvchspk6TfOKvBZNgKxKLXCZqkMuBKPVg9AjSvXh7O50GeaA>
    <xmx:UhbfapBPIxZvs83Xy7paJBIpGsz0RbCTFcUUnTmQyUI4R_ZIzN2pXw>
    <xmx:UhbfanrB1WnftuwXH3XlDQ7i73tmuVFbWqhiPRWbFwshT5K1btYVnw>
    <xmx:UhbfasgGIrJCkpEbU9sufS6eAtVJ975ujYSg6ZqTglLJpGy1PXm6zw>
    <xmx:Uhbfamnoykpa-TI-40IA2x6lBdRHAI_YjXiwRHc4HeO-N1yGOamKgC73>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:58:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 624a8514 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:58:55 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:58:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
Message-ID: <at8WTDeuv0s3iWI6@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
 <at79nEHLDrcoCgn_@pks.im>
 <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
 <at8KIQPtBHXyLPyY@pks.im>
 <CAHwyqnUwSv4Pa1GT3rikOcho2MVYA7sRV7RpP_KXcSa-2dWrWQ@mail.gmail.com>
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
In-Reply-To: <CAHwyqnUwSv4Pa1GT3rikOcho2MVYA7sRV7RpP_KXcSa-2dWrWQ@mail.gmail.com>

On Mon, Oct 26, 2026 at 10:13:26AM +0200, Harald Nordgren wrote:
> On Mon, Oct 26, 2026 at 10:07 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Oct 26, 2026 at 09:38:10AM +0200, Harald Nordgren wrote:
> > > > > @@ -121,9 +133,16 @@ macos-*)
> > > > >
> > > > >       mkdir -p "$CUSTOM_PATH"
> > > > >       wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
> > > > > -     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
> > > > > +     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
> > > > > +             echo >&2 "error: could not install perforce"
> > > > > +             exit 1
> > > > > +     }
> > > > >       sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
> > > >
> > > > This line is a bit curious, it makes me wonder whether we want to
> > > > tighten it as well now. Any reason why we wouldn't?
> > >
> > > I asked Claud about it and it said this, does it make sense?
> > >
> > > 'wget/curl never set com.apple.quarantine in the first place (only
> > > Safari/Finder/AirDrop do, via the LaunchServices quarantine API), so
> > > xattr -d on these files always fails with "No such xattr." Tightening
> > > it to fatal would break every macOS build, every time.'
> >
> > Well, if so we should be able to remove it without any detriment, right?
> > Maybe that could be part of a preparatory patch.
> 
> Best way to find out is just to do it, I guess. I can include it in v3
> and then you can trigger a build on GitLab with it? I'll let GitHub CI
> pass before pushing anything out.

Sounds good, thanks.

Patrick
