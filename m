Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196750;
	b=X33L0zDJzNXlR5smEVTwNbFeZBrUO7uXKCuau91ioXbQ7hqooTYczC4YYT7hKkohPd3F
	 1puokihQ38ZPVt0dL0SceI1SB3dOWEGvTwmdNZCLad5OjpbOwlhDRR4xDPjzMxPmcYkVw
	 xceuZzZo8i7IJOFOvS9xstc/7UO+uEZEDd3A86XcSVKwjK5RAjls2fH77dBPVPbaE//KS
	 myDsHbu+9MPYLUGQH1Fk4hSmKHx4yzTToj3YNSeZt7r86YoDT9qGsvlvgrPKCwXGnT/kO
	 kkSh6h0MKOBl+A/kmdwKfGC/f27o+ZCjmXhn19BkgUYukx2HRJp/76LVfrPLmlEM6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196750;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8Jm7g8vxbphpacBuh2iF+YTDhbgo9cUUxZvgU+up+/w=;
	b=Soah08KltEPERVgN5GqShyrjCUTPkrnyCPKKuU46NVo2xEcXRNsGquOy4fGkIEUF0XG/
	 xSqh8JmO+P9qtjUNVs7J0Ibww5vLDtTw2o6Oejj5b3vqqQSmy8yzECegsZPeNM7rHiAmJ
	 AurQaGIJmS4SVb0/boylyJKEe61hQUcQkPNYklwNdsIc26JxHihsgNl3zVmSgkTlmKWmP
	 QvCh/0+oay1/sSItHyRXIyGVQcFL2NmJRRWgixWTh4B4iF6GPWazR6r1VMNv1FJlTH+tF
	 fYzXJ1xc/2gHY16UinVxiQEfQ5DAERvYZ2zVLcs1cNc9UtNLEaU6bluIJxgwcpcIVnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bJv0Dxvp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ORc4CVmx;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F187606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F187606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bJv0Dxvp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ORc4CVmx
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 036147A00E8
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 10:12:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 10:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793196748; x=1793283148; bh=8Jm7g8vxbp
	hpacBuh2iF+YTDhbgo9cUUxZvgU+up+/w=; b=bJv0DxvpSw+Lzs1X+uembAUW9R
	97SfxioDpjyNQJ1EORmQsHccvC7g54GZ3wPZY2cZYHhk7Y1Mx5n+EOw2PRCnFqh+
	Q4P+G4SYa6AztjR+iHuhwdCArhQyWFhJzBTyCyeKn6gk+aeBKlJ/X7uhrsa6vHKR
	I0t35q7pT9Awie1tKbNuKFKjSzT/vQoW8NPf4YMXEt7HNb8jv6yMr0g3wCSAP97M
	hZVpeXGINVqTN+Zc9cgMyJBqZCn+Cz2OvEl4A8+YdID3YtEIcPAOO6kpH8j/JEjK
	b+qd+dW+dZDBfSMg5L7Z3Fn+H9plLQtWMUC2+kPXGelfGiRgg+HIenn6hoZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793196748; x=1793283148; bh=8Jm7g8vxbphpacBuh2iF+YTDhbgo9cUUxZv
	gU+up+/w=; b=ORc4CVmx4f/KtrWpeZYDceYDHwuvBNGN+5HxORmSAST6EfZWuw8
	kMRyAzpGEr/vD3O8eZAzIa6kn1cLBzSZkimpbwb0Bjfr/pG2ps33E3adXIMc1YFS
	szp0awgkPTvyCbqIU93k2iHiv5UHv5thQjj3aYfCFoXG+e2+SWukyL9mLGyHrclY
	s8Hj2o/m7XxNy7lUR7BZ3iZ0Kmw8OkTj5KISmIdagLYftlOkh9UQG5YvWMqZzLwb
	DV6IfNELtbVd26OSGNXzlwK8QzgNWkZit8Od+n22C4ouliv7xfMdxgyMCVVOGgG2
	UPchvfld9uGM/r08MJyiij2acsJuBmSEE1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793196748; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:V1mX8ggrnJTvilMmHu/uKopCcnpHfYz99/5hN7S4vEz3G7I
	tbrWx1rG5d1pnpFoeVJnBa0S4RmFaQUOwQbC1anIstQHMQCJiWCBi4PrA6O3fQ6Q
	o8F8fpj0fkYUyCdul3abCIVGiHSFW1f/v2zm0XdUFUGtzQbO3bRejTQNX0i6UcPs
	BJGu33jsrFH3CO1CLLRKcN2qqqEDl6DVg552WQNNNEKrSOTfEOCDGxXqwdXfiO3p
	qYnTQ1wV+xrzcpRdzZIFSby7XzS7vYqZ4svOqDPSLrP3YdBzkeO6jU9bpGwXd5xa
	Lpj4IqV0VUTN0J2V2eFwllODJopHfalJoMTgz7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NkZ99y/pgQZ5soGhVOkdp39FTas55lkQ3hQRyuXaTVw=:nlhW6PqHdVU1HeN+e/BRDpNQr+9Y52C1huvR+WIJWDE=;
X-ME-Sender: <xms:zALiagssU1NeG0SGAggImnUCqyhqXbW6pBaoQqNQWCfxmphWaV0r5w>
    <xme:zALiahLkkE-Vio0hpx_7BVxQpkFTifay5V7gIovyW2C7wRPlkVltyK0k-aBud7Aw4
    f1EY1y_L2YG5MWBfiZ4Smj-fZMEPHNFap5apSOFcF_VZfiJD7bPsQ>
X-ME-Received: <xmr:zALialmi9DIUqwhUQtGw9THjD6_PrahIlMqW26u-_6HsKZFN-R1kKV-NiumD-lHXWVEp8rYAfL6pEJ3tk5ZVLhL7a38CnNwqzoXk>
X-ME-Proxy-Cause: dmFkZTEBUZ1GKPlvsm9vs2pLfnC8sgNDtsD8W8aWTSBBcL2uS1cFeTuBaBBm22/zOrxnSS
    R+MQ31hGX3eXgdxCQj38Mb0fn1sDwiuZVRM6pzSCIlykhC5MNDnD6nINI24bzddZiIGcP7
    RvV1AfwxQF6lDi8ht9qrYr4DkO6SD2a76EK8rTrvP3dLDT/B3WKknQRiWobo7fiJ7GzPc8
    6Q9dMW4eyY0Lki2ycgoquhBkmsrNjklpDzWOmDRiljm/60K8z4Ci8u/o5C2DItyK9xLDPw
    HkXo0EVyuPuFEwAMAUQZwqkhyrkvZhLxDByyheoDn0TrhBfZHWfe2LEJUwgVDU5uZ1b5Wc
    M3VuiF0W9xuUwaHrEgR77QEjtnXKLQQSW9yIi79pi9p9xRTI+RAJvcFZgknCfjiwRBYoYf
    5NY3kX+sFm5QzAGvZ2E1ho6mMjswhkhRJumcYYEO6iDT7WJUUj/sSIrHowFlF/UAafLJgZ
    CjocD0O6UzLlxWVS98c/GDO4FnHe9zqxuxaDyWXGKx/w0eaL+r2wjzfkehdHqohCI/nMMf
    2CMbDaryNAb7/kAk4U/aErHmheIzB/qrIcQHWeNfFnIA57uZHZTlcTG0NzCf05iiRFBima
    J/rwRHfO4Xvpv6My1+UdGaiojt1QsWeXGCBz2flhHwpXCtWE+iORSW7AAyFQ
X-ME-Proxy: <xmx:zALiaqKF_jcCCosI5NDFOS5FztFnmHrBlGuq9aq0Rg2Y_MxrWfEacw>
    <xmx:zALiai5BPJcy9dF38mr6r_YvFHeIcuT_HzrbwsnSWVVXueehOQVu6Q>
    <xmx:zALiam0zzxCtK15HEB5_ClhpDT4sHOvRJozgNkDv_rcz6UotORVKNA>
    <xmx:zALiagdK8UxfUv-D_MQTUjRzDgep5Id3hLRssUtDD7nM1pgyMUtgKA>
    <xmx:zALiatTqg39BqcDh4gaVedpP8wlz6W0Hakt1kJZQpA8547jXo7owlOf8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 10:12:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2] t5300: modernize test path checks in t5300
In-Reply-To: <20261027183623.3600-1-ogundipesolataiwo12@gmail.com> (Ogundipe
	Sola Taiwo's message of "Tue, 27 Oct 2026 14:36:20 -0400")
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
	<20261027183623.3600-1-ogundipesolataiwo12@gmail.com>
Date: Wed, 28 Oct 2026 07:12:26 -0700
Message-ID: <xmqqy0bhdid1.fsf@gitster.g>
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

Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com> writes:

> Improves test t5300-pack-object by converting old-style
> path checks to use the `test_path_is_file` helper function.

"Improves" -> "Improve".  It would be nicer to state how use of the
helper improves.

See similar test updates from others and review comment on them in
the past 4 weeks from the list archive.

Thanks.

>
> Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
> ---
> Changes in v2:
> - Rephrase patch summary to remove redundant wording
>
>  t/t5300-pack-object.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index aac139e6a0..e5ce478484 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -283,11 +283,11 @@ test_expect_success 'survive missing objects/pack directory' '
>  		GOP=.git/objects/pack &&
>  		rm -fr $GOP &&
>  		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
> -		test -f $GOP/pack-${packname_3}.pack &&
> +		test_path_is_file $GOP/pack-${packname_3}.pack &&
>  		cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
> -		test -f $GOP/pack-${packname_3}.idx &&
> +		test_path_is_file $GOP/pack-${packname_3}.idx &&
>  		cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
> -		test -f $GOP/pack-${packname_3}.keep
> +		test_path_is_file $GOP/pack-${packname_3}.keep
>  	)
>  '
>
> @@ -376,7 +376,7 @@ test_expect_success 'build pack index for an existing pack' '
>  	rm -f test-4.keep &&
>  	git index-pack --keep=why test-4.pack &&
>  	cmp test-1-${packname_1}.idx test-4.idx &&
> -	test -f test-4.keep &&
> +	test_path_is_file test-4.keep &&
>
>  	:
>  '
> @@ -616,7 +616,7 @@ test_expect_success 'setup: fake a SHA1 hash collision' '
>  		cd corrupt &&
>  		long_a=$(git hash-object -w ../a | sed -e "s!^..!&/!") &&
>  		long_b=$(git hash-object -w ../b | sed -e "s!^..!&/!") &&
> -		test -f	.git/objects/$long_b &&
> +		test_path_is_file .git/objects/$long_b &&
>  		cp -f	.git/objects/$long_a \
>  			.git/objects/$long_b
>  	)
>
> Range-diff against v1:
> 1:  ca6cd5870e = 1:  ca6cd5870e t5300: modernize test path checks in t5300
> --
> 2.56.0.116.g6de20f6092.dirty
