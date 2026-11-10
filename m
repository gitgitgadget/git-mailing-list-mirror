Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293597;
	b=4KhZ02HDsrXgSSi3VF5IgmL28aO3+y5EVobNg4hxVNHOixGG4TLJ39EjU9BI+C74WIy8
	 r5BJ8RjCTtmCu9axroAoY1ajPEOJ2aaHsCQuFT+i0VS4v66MvlEcscFL1EfzGfjHqUu6Z
	 dk5xgt5ZbkF1HNuBVfcWk5pUyEaio8FVf+GrPu0YNVZs7MisUNhoAbUtyyO8vFwBXG7Ic
	 ixtFh00XbAGGKIdOOg01IOyXhW2SJjHz+yEIN1LuIrMDZ9B+CVlFCegOz7JgsPreguNTJ
	 NabgtK9XeCQd5eblFKwIzinlQjx8Yfrf16kdDpSyMA6W5TE9hiu4Hxwy4qnhduFECqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293597;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kUh1qfh72x5QnVOIn3dNjPNzmSVjEEOmGimIftaPmV4=;
	b=R47E9n3OMEoEjLqn5Tdzvak7qFTx/a+X0d9KfzTw2XdBz+zffBt4LaVWcIDPzJ2g91Mn
	 tIevuL5uK7huuHwwCzn85bfnr4a7j1aFx46vVUwYGeKwHyYzWlMV8mx37p6fYY1ojN+qk
	 gMN/dJeT4mUWlRkgbdDsYnjMrjlSCvcAHeHozsyOy8ZeamVHhlJR4ftd1AQnRCuBP6FkW
	 SCr1iokAQYw26PJep9nhaGotepcKUrEYUTxlJa0U92C9reEL8hBSKM220LpdOcelRAm8Q
	 dFfxvB5en64JWmO8Q+LosB1HiBHlay+cTktzexJooAXAM+QhXzt1v6DZDSu9exsGt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pILJpQfG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=O2GrRlYJ;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97776606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97776606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pILJpQfG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=O2GrRlYJ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2B8814001E1
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 01:53:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 01:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794293595; x=1794379995; bh=kUh1qfh72x
	5QnVOIn3dNjPNzmSVjEEOmGimIftaPmV4=; b=pILJpQfGEecL/wjwhmsoGoiEqF
	NkQNpl0SCixCTC/CkxiD7XLiYFRrrmUtBRvtN587/KERVSUXwqeb1bEbooTgY++A
	vq4iNNdrXmUABk0jPbJvJFOySBcj0xw1Z2HZXbPmhW4XAeE2aCKNsqp/KLXX1jqD
	uSABK1XWFh94DSSMlRZaDtLZjVBOyd/zRBXmAYdJB8hjn83rlvfU8t42I+FQ5wEk
	eiB2CWuPx/uzencT8wUMSduwbpdbZwLqtsMijGn4ubGrP94c8jDJhbif7hnDIO4V
	RD+3y4858hfuKYtTholoYfg2NADKoAHnyiSgooaiHLQRNEXl25+oWqNa3ZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794293595; x=1794379995; bh=kUh1qfh72x5QnVOIn3dNjPNzmSVjEEOmGim
	IftaPmV4=; b=O2GrRlYJ2wDR8cichNFUfymUi0mHOr7WSXyWsutqA00AE0vJM1F
	LJMPzUVPXApTeZRwr6tFtZmb157sAH6mr/bw5dU+OMwqdGm8WVo0HubHhhi1SsGr
	/yD9B5PB+rjAcsy2nwCVmJr50cbsYUvxYsOMypkJz3zPuYV32cDmcjxv/RX8Q2RW
	AINceORiTHWh1RFKgbnvqTYnMp0R8xDxSggQWbixcrh74eXKiGGfQEmsDIZIcOBf
	vGEgF25rObsZrwMXRk+awhqdVGrJrvLB3q+oEiizCG6ZGK0/tH1l4TkjYds5N4jv
	70Bo21AIX4Gw0vLbdD17Go5kc/pLba/a3wg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794293595; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:S3jI3tS2eRpYEIlEyYg2I/UOfJMA4Psjt5HLa9jxsCQ+eoh
	XSpRgiAIblYTPNhIKD6t41OUmHcVC/Q2QTOE6+1AUHMYVQXfX9pCEJHYzG72h2zR
	Z9iO8Hxrv+89+Z8rw609mSGmQc1rQDhMdsQN62YH0nB3/YBGs0fhdd7U7YWhxRWh
	F26zeA2epkm4YjCjm8oLHboCVbJjGPPcJ1ubh5HZotmkZWf/i4eCzT/jw/Gh/w46
	AcuTfpoenkK6WOeFSdPYLjgk2BGJ2QQyg/NJHS70PWLGvKrPjDx0YCl9ic2398HS
	/o2vg5ovhir0SverXJp3Y2YmNdKhtMlCd4+Lh5g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CidWfwcxOBHd9DpmxDB0m18mViIdmQlEfUIVCFkR9SI=:JOPJ+HlqcxKae6pmJQULV2+utoWUZangh6zNsQQLCxM=;
X-ME-Sender: <xms:W7_yasbf1ZaBkSHb28IFCefIEAjNTYI0mhUyPnuemnRU7ZXBuyWWcQ>
    <xme:W7_yaubr0sHutPcirhWQRxZwXpfaY7PlDxBfyfrIguyZ5W_95rHY1-YhFZm5neR2_
    jhBnT-5OFwpgMgC63HWJQKOVY9s3VvySegal1DL_2YfE0x_EErczqc>
X-ME-Received: <xmr:W7_yar8isWAPY5_zVrPDPWsJWlu9hOaPF-yRX5gFFYwhRZQpRqpuG2yV65xu-6aSuVY87w>
X-ME-Proxy-Cause: dmFkZTGWA/i6Z7ODJncg5QP8+bN777nlGniiWGxJhzdUfkPwLM5xi0sa+xk36H6FIM2/W3
    3XDMvXwmD2UuOTHp4DQ1ob97OPivlw2UaEZdoO7jdCcylQ1vVw99LnFXJA8Deied2y6WYY
    n612N8EnA3D5AKEVRv0nUTDzqhp8cu5qpY4oTTsegqHsaHQ1ZvQm3kIiikYb4a9z+ja2wI
    QQordxLG1cwvjpqH8JRQM98dwC+7wsEAiNhsf0ZuAl6K7xVBMx4i6jhMeEZj8JBeuoAgoN
    ox8JRW6wA9IrRFKRDN5DnebBJseDItGGinL31x/Yrv09LirRmsNZHFToNnNFGloC0OP/fQ
    KYedfaPJDI3FHTwF8G6ppZ2xTJWWHJNB71ERbDNCOowH0PmPzACuo08fzP3WvGkQVF2B+A
    CxXyJ6Qu8WlEGp3bD/RFlHxRtnCVdL2aYz3A/D23UoyePr2Mj8OrPj48ZRfywh5qg6ALFG
    nUFl666ySjNYzSQR/kePntYWkCN3WWDU2ca7t3NVN6uyGpTT0oZ3MgRUCg1tZhiZKKqBOS
    +yHYzyopOGJm23XskFoPG+p1qiiBzfqkek0gMcGYaZNEGL0l2oAbRCLw5GIpt3mw7U7xGM
    7OF1oiRtQ21Kv5wPI8psr7/A/nj+eBsSxS0/G48Y8/o+tR3wKrZ3exLifFqg
X-ME-Proxy: <xmx:W7_yalhz19MVxb921pMApRHj9soWkFfzpvaTy-i-P91LGqovSmAiHw>
    <xmx:W7_yajdivhbQop9UcYixLNJm1kDwAUDeBIHumOyCwCeHKwIJA5JgcQ>
    <xmx:W7_yakqJl0ZAj6W-hk291rO35YTMSQr-l9fhWsFpnRnmY0ZPY-Mo3w>
    <xmx:W7_yagAEAXgfZ5tE-rWA6cocpmVMo183dnZdmh-AsJFSzZLcWapC3Q>
    <xmx:W7_yajTL0ZBOWY_XURzJRg-SooWatZhEy8vCkEu32ayMsTvfNjSS0FR6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 01:53:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd71a3c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 06:53:14 +0000 (UTC)
Date: Tue, 10 Nov 2026 07:53:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 4/7] t0027: optimize how we reset repository state
Message-ID: <avK_V9z8gw20WS_M@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
 <20261109-pks-gitlab-ci-speedups-v2-4-508832602d0b@pks.im>
 <xmqq1p8u0wlg.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1p8u0wlg.fsf@gitster.g>

On Mon, Nov 09, 2026 at 08:59:39AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> > index 49dbf09da77..504a7ea54bb 100755
> > --- a/t/t0027-auto-crlf.sh
> > +++ b/t/t0027-auto-crlf.sh
> > @@ -305,11 +305,12 @@ checkout_files () {
> 
> A micronit.
> 
> >  	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
> >  	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
> >  	do
> > -		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
> > -			rm -f crlf_false_attr__$f.txt &&
> > -			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
> > -		'
> > +		paths="${paths:+"$paths "}crlf_false_attr__$f.txt"
> >  	done
> 
> We may know that nobody has touched variable "$paths" elsewhere in
> this program, but I would prefer to have an explicit "let's start
> with an empty $paths" assignment very close to this loop to help
> future readers.  That way they do not have to wonder and look all
> over to find out after what string we are appending these filenames.

Yeah, makes sense.

Patrick
