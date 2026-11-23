Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400945;
	b=nRWg7bpCkA7Sr0PqZRdJYPtyzy9G2voUUa04uKTnIO1HxD18enK5acEwLP9aXr8zCuHv
	 wzevk1NST1RCARMIL2w9Rb80JN4vI5pPBlc4JbdkMuFguBWaneyi0Lmqu4XAOaX4InvoD
	 m2Cb97CKE2SfVcTFgVq+vsZu0oY2m+1QCYa6OwV1mp+/uIA8pvM59T8I3q7xFMtVwgBbk
	 ruqeWaxgydLUXRu2CgjQ7piU6NrK7T47IkLI2kSm3xJ3Hzqpjec41iQlCVH9v9+eCuPk6
	 uub8U8aMaeZmoqAcwcVerydbhUsIet9miX4Ay+tTAOy+qN9VDCkE8/aAiy9+g3TncUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400945;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Nh2APwO3MhACKtmLjr+hei/KRlqtawyq0Z7jvtvMZdg=;
	b=zcUUpqXzc/+Q4QOin/r9sN7nMI+95XF9xOGKfWbyRm9PaYgfy4oQgbdZtufnNR477Hcc
	 msEHth8wsJTIbuhRCJRCivINH20GF+VGUgz1VRUjnJem+Icc1FT8b1/5Tf1xSgRLKJ3lA
	 iJ1gasKmBQt6Ibi6BrEsqYioLCfAKOnxNgbqiPxvlJLjAFrXjZbUJEd3lT7TqC9XUgcvc
	 975QzZBKizA/z9ptciGtyD3l9VWy6uD/gRphj2nN2BdNIQYCb8HVAPMTcSJqOCiyiofUo
	 3Dvrptsp9ENYGX08LhyhD/2xud83kes/nH0J9liLEtWeHongT6mphaYJy+9JMWSPVjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mFwXW9OF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="cC3/f0r9";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2735606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 02:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2735606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mFwXW9OF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cC3/f0r9
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9527514002DD
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 21:29:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 22 Nov 2026 21:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795400943; x=1795487343; bh=Nh2APwO3Mh
	ACKtmLjr+hei/KRlqtawyq0Z7jvtvMZdg=; b=mFwXW9OFL7bK6yFkkdLRJVyVMa
	VkxaPxHKWDKtWcI/51QVutEcY+BgYFpdVw375dtBBTY4aqhcwKwR6a5/Jn/NTHvK
	M6+Gj7oJ55T8CPdiWNFvkcJxhcXYCAi7TVuebIp5Z2uZ/D1iobafpzT9Rdl5ETtd
	tGDIr4Xm0W+qrDzddshr1c8DIdX2DE7CoxvaTOcTj1rq/I/D39KDZ5nH7YUa12mR
	rOQFwx333lnQpqOJL4qTbmG+im+adpcnWnKEi6Woo08NVOmFy9qmubbgngu6kMSg
	CkepB2VsVNhM5EpScHZGj0E38oqyV5Pvx+v2zCfq1o1kp5ui+QUv66Hk76qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795400943; x=1795487343; bh=Nh2APwO3MhACKtmLjr+hei/KRlqtawyq0Z7
	jvtvMZdg=; b=cC3/f0r9Q/lsEpC61QY59juti8vl1kOJsJnlAnSiA+/v4x1pPcg
	GTLZjBH66wgQ7x1AihTz6pn/4c+NC1X7VGoKALbfoi50Ng0joumUGw8tHy9xiVaL
	XRWdNi87dO8QiC+ZbIafFQ8cPuIbbl+xMg5CDC7LHzPy2+njFtnCcvyjoQR1VGiH
	JVHqU2pve/+JIAhc+YIno4+PW7Y7YrNaEJVw9XAHGHknzNWqPVcn36fMLmEo1auG
	gsESWQbUTdxtKYgMe4ROUiST8CKBQYTqC2jTRQD4OUCXZ+SWsetaKu80zsepUOyL
	pSGQ9J18VvP02srOR28Nvx2W2h96HeJrWsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795400943; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bQFXDLkANhJgfKVYyGvtEFzsh9VhS9EvzwmEoWkz3Mj9uVq
	CS/PiwEdKCzb2qMvdJoGh+ZeamTxlYWo/qjWORpWuV/UShrsv1lGfgu8girnQgym
	iK6OTHgQKxjp7dl1DD1Zj6287TI80fT/rK95P6Om+pLoghM8GUtk3erO/SfuPej5
	MDxroYPJ4EZN08P6bLP7+xuMMHDj7JaDaGqESkFGvNWHNh6yqAv/DfeMFBEUA6ky
	t6OQ6/gZzrPB2uT4ZdDBmocxxcaVYFqC5gaPNyofUWW40e8gGk5CS8TAczOhfvaB
	7NsJ0Qs7FhiCnzXjqz1rCVus18rR5N3JA23wpsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:9H5Tmn3gc5I2tmf75wasab8wmAlIFBDz8fFQ/v84nlc=:wuVrtYzn6b44beu6zsVbY6+c2Wd8UffD+adloICmxIw=;
X-ME-Sender: <xms:76QDa_mYnD88Qcvb59v3Tw7N2eQ3wKc9ZDc1QIXx5PpJKj3Qi5RM6g>
    <xme:76QDa5u-1dUTLlUqDMxzOYG6D0-Ijz1uiKQPlMkkDRy5QaPxw9GplOfOq2bFkvdYP
    4Vfu2XGwR-pKy9lRAwnClT71KKCuAKARHZO8kvRTuzn58oc5qP-S7A>
X-ME-Received: <xmr:76QDa9_8N9kCDSKCeaOROf4SdrFCbwwtkuRc-LMP0iwK2_3rTpbfPSTL4kfTsQgNwA7aTWEyTebRyRudJPn00wUrkqFKNR1tmuiq_Ew>
X-ME-Proxy-Cause: dmFkZTEXQj5j/WuIcYbjeqf6tMUUQQdcLBzgseWyj2YsnrvU4Jd75mrWmVvBuRRRbqoFd4
    AzGgpAQzD+DuJKmczZA3lJFmi7Op/qHx6TN9bvdrgUEyNbzZ887aM7EC26BttYWpVz9oio
    jlyWOCpkqOZIvtefA56iizEaz95R+1MoP76LXMh6NRpYLylNuP050jMdmrNB7kSHlTAe4r
    lD+1/b4oODgb72gEJyOqBoSTUY1rqqPHwyvMP25AsmaNElpQLp/DAtV6SgYzqopzQ9LkTi
    JjtYFgamth6Pk346ZXBoDTlda+0tyZVj3YjMAiIVq5krwIuA0dZI0/f2eV4oLU/g0mb6H/
    AErCq+OL8i3PcGNg7Todwg/IYtp5Ad4EPiQX7IoA/Xup7EbfluDJappol0GiJRMRNIGlVN
    hQtr3AHwpdqf3hASWNd/Zj4XJsM4SuXwZXSUUT4pndVjoU6Yml40qJuNOCVwfzoUCe5wPC
    1aQSbxLIlpZ2eDKWbqhv/OVMfxIW8ePXvKSw0BAio3PLXAtALmlJzKoHzBjxnlcf/jNBXp
    fIWtZ5WFueu49xEwB5BAG9xYVx7ACAE2ctcTGv5k1oPhe7sQtptJZM0dlDk6otrM1wOR6f
    xLD3faN0WU1u+nogvnvX3W9CJYWcQo9d2Uxo3Uum2D4oD6B4hEsXiWanDXYA
X-ME-Proxy: <xmx:76QDazMvPM8BUnR4uXBjAeyj4fOUkeJq82hP33MMUaiwHyRKrrs4qg>
    <xmx:76QDa7GnIUG_gNeng3WfJR82D07xD--h7YBqttkT6Teo-fEgKeE_zA>
    <xmx:76QDaxTGJREDO9Scp7dH8Nky7VzljpdC9bJh1I3aH1xeYpo_79OzBA>
    <xmx:76QDa4uWtIVu30ssLidvsyelnh9vWQiK46HWmMC5DMt8bDpHWkh_Qw>
    <xmx:76QDa-_EeX2OobjFUyinwbRpY7p7ruRtP7VxlRndSmH9HRgmrn_CC-g->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 21:29:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v4] setup: fix hash algorithm detection
In-Reply-To: <20261123011403.720209-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 23 Nov 2026 01:14:03 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261123011403.720209-1-sandals@crustytoothpaste.net>
Date: Sun, 22 Nov 2026 18:29:01 -0800
Message-ID: <xmqqmrr0gu1e.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our current hash algorithm selection code has a few different problems.
> First, we do not actually default to GIT_HASH_DEFAULT because, due to a
> bug, our code has never considered GIT_HASH_DEFAULT as a default for git
> init and if an algorithm is not specified in the config file, we assume
> that the repository is SHA-1.
>
> Second, if we have an algorithm chosen by init.defaultObjectFormat and
> we re-init a repository, we will change the hash algorithm, which is
> very much not desired.
>
> To fix this, let's restructure this code slightly.  First, if an
> algorithm was selected on the command line, assume that's what the user
> wanted. Otherwise, the other options should only be chosen if our
> repository doesn't exist (that is, repo_fmt->version is -1) or it's
> specifically detected as having no hash algorithm.  This latter case
> should not occur, but we preserve it just in case.  In those cases,
> first use the environment, then the config, and finally, the default
> algorithm.
>
> Then, if the algorithm does not match the repository, complain loudly
> and refuse to reinitialize the repository with a different hash
> algorithm.
>
> With this change, we will choose SHA-256 in breaking changes mode and in
> Git 3.0, which is what we want.  Add several tests to cover this case
> and several others discovered along the way.  Update the comment to
> better describe the situation.

;-)

> * Update comment.
> * Place `sane_unset` in subshells.

Changes relative to the previous round all look good to me, and I've
read the previous round fairly thoroughly, so everything looks good.

