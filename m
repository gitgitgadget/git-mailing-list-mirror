Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780253;
	b=NZKnUdfTDPzH2+DryxOwvxE6jPYQybV00zCjHqPbm10T4TIwLezCOyrs/ShucQcr/xMb
	 2Hvuf6U0DqoW39bnF5FNQQgvvz0Cilkqbw1YjQRSYpTW1bhYvclGtfOeMvBzgBBC3qy4u
	 OAE9siCrWRoktpo2RveUA0hxeSIEag2NFWCSI0Q9nt6U7ZVL+BBnbcM1gM1uCPVa/tpx4
	 bxJTj71kSA5FTMvDp13COAVjz8Kp5u8AQRRaO5ZQC/Lq6A0IYwDwtVTyvFm3xJcjWBKNF
	 9JW7mI4VCKQGtBkrMUtatkJJ50ZOH9WDF59Hh3x6HECqTlZZFFW08nWmjRKpv7t94yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780253;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vDRRObT6DlciyFK/t5emN/p4dn9oeXbJszj6QRqzwYg=;
	b=Hq4XJSSOWiJ829t4AxWYaOio+l4Un3PFrnmCLhYi4m5giHtqZfB4A5g30MB0FkFU8tL+
	 BjKxGk7SltShSb36ZHKnZCO9MX4QSxuJ2aNcW9HCd1fsGoFC1oaG2M+ETBesMX79S6Hah
	 drbwYl56N/HjyhrQJBiv13v2h5DB8+bz8MUKAjH5kRouUx4aje3lv0W3nAMJA42rDhJsw
	 4kRZBrsB7WrA+vP87mZQ+3ZeSJgPh85iEDOvt0GT3SV78iVtyCFBFk/mDCGLoLryPoS8V
	 lR3mZfWDrIiodYW4kxK7VWmCTzIHig1nQuaKpMW7LBSX83ne/JPUpFd10HJ2qds0oIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PEUNIVxf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=apkvlDed;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F045606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F045606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PEUNIVxf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=apkvlDed
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC7D17A015A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:30:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 14:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792780251; x=1792866651; bh=vDRRObT6Dl
	ciyFK/t5emN/p4dn9oeXbJszj6QRqzwYg=; b=PEUNIVxf1zvPoX3krcTcuuXNPk
	6Gb7aASOPvg3ZrW09bwblQEgi4MPICM7XdF/wTBUlUg9/OTiilp3lrD8UbLQ+Vsr
	XZN7Imn4654goZrbTg5nmjM/ujGumPOxIlWwXe54U5n2y5YjU9e8uiz8QeEUQ/0f
	Oqow6tr15G3lUiX5XFaqwCy1kKBWukt1RbAgLQpmstPPjF+wDDRSjFdQaSEdh1Yz
	MOVW65suoYtr+kC6004lO1X+u9wqVl2QckwbLte2l/L+iUm6ENqcNpumcQJhnw6a
	UJjt+1OfjcTKZHkj16tXRr+k7SIkQQvOmlDg4SnhmtAglWDWmvx//fmMaGFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792780251; x=1792866651; bh=vDRRObT6DlciyFK/t5emN/p4dn9oeXbJszj
	6QRqzwYg=; b=apkvlDedOL09shys7ayTvAr0lJFtJEw3TLBO0hv8jwff3XLRDJ3
	KBiTo3+ywxnWkwjC45R8pyqgFGBPrv/2IDP/nsx9slIOD5o2s7j45T1qtRE3tfxt
	2Rrt9xKMyMoTc5PQ4CWGMBHBcJtVVvb8YqnuwHhlXCL2pumhpQHg1Ul58g+od7OC
	Xuy9m1/zaB/n4wZQoZH3r6ediCpcs6nEjfw2fo7oLxfIfiDLV2umaQs7Aj0pY+1o
	xRxHDDomopjLtA9Qth3bOxYQuBaBupF+X8jY3aNrLKnIgiDrPSz7hI+E7epI6YIZ
	fa1fZYb/zOoa+rV8+hx2q2qo/Eb63xBbTZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792780251; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Tg/1qlLQ5DJ+GcsUtV9L33CVeA/+qYkgKjxBxlaStBBYhiF
	LXWG2zuqogyhM8TSQAxui7Dy6RI4ZAwfVDhS+85aa3DKMAeP136r9/2ZGROC8jTI
	aNqzt+PjeGzxYI2hvzZpLZQTYDVMakQj4hZXBiCYpf3NH0cz8HON06e7DrDb42qC
	M+nn/qWsrNIoWNK7wr3kOGdjjywfVGR4G5FXRufN5ZyW2jC+mx3A3FTz7X8hfXY5
	tcupcSbH79hDmU6E8O8bp8a68hxxgor0YijHDp7ZAAiHswnPwtGxRHdJOjvdYX+L
	xwGAjPfGJw277gmNhjim9w8GvLbEn+94Y7HyJdQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zr73bdDgHRW9uTH4iOnxfuC/chMlWkCtUcyOlDbuuY8=:MriUmMMGIQQuNxFoRy7X9ZOkHlHmQnkR4XapvoJU8PA=;
X-ME-Sender: <xms:26fbaiKFzxlGVICX9lsGkQs3AnHSs6An85hfslE6V2K3Fo5Uge0KpQ>
    <xme:26fbahAifcHTnz4Dl23GiohjH_kwC6zmwjSSdZwGjC6yfs8fJtQC_g6K8nFjcT0t8
    HBRrDVzyVTWOcbrIYQneQKjXuCiQ9DlJ8VsITUst1eGrdAAP_Pyitk>
X-ME-Received: <xmr:26fbarBztLgXVV0BlFSSRlOWs4E80ku71TVbOiWrwdR8OSdAkbqHuuoA6YzG9sBgnMtr-VwxBd1oPYhgNT5WNfaW1eQz50avCICj>
X-ME-Proxy-Cause: dmFkZTFw4NrhrfJ96QkdzEeOKUIwWBsyoBcxYf6YUg3yalWOT8HT/q0zdrIkMJcxf4YTPL
    ztmE6M39YkUfnx0iEQPxBIx4lM8x8rBKkE4mu5b3sOkY3i2MT/t1ub1AstJm2NfWcu+01+
    ZBooA7ekIQCxTXrlWKciyg4L9TyLOYK0XP8OQcUHlvV/W0OVQ67ebCeCpwEnxlBc6ggUR1
    vZOl4qcXC7D1nNKpw2g7pHw0aDkGUiwrd40QCSKE9poclizLBsizyMVmj1w97mlPVmQFke
    p3Jw2cj8sBcqDLvH5Z9irWzB7Wvpg1MqzVQgoiw5sxNz+Aydy1+ZlQxXljxyRIvdjRlORX
    O/QOma2zHGsOUeL/m8zCusEL111xiVujThwE8iP89L9292KD0dX3GjHe+T6aEA2jt1BNpx
    h7k1DkJS8aTuNLoK2sHFfJ7KFRm5N5+pstxubXv6yEvsfnfdp7o1Tbla30NNiDgPogZwGY
    Nru6NDRnaGruOqcDe/icHP1alZ6pDMEVZw3NBtqfIgPWRC5JCC+8u+hW3RoqvvHO0k4am5
    ujMesCTubE7HH+fvemJd4uZZXMZkZK6sXfrU/bB9F6NNmxhrx46TXb+iOk1TDt/Vqwyp+l
    5X8qcKfBClpnpUFWtR0jctkKe7l/Nz2TMiOhwSkeB8cAYfWCeuarh0HoiKIA
X-ME-Proxy: <xmx:26fbajCMppBG5Mt1E9cmydnR2mDdHp2XSU2WDC2LH7li2pqXgihWHg>
    <xmx:26fbamqNMkqBBeN31RKS1ZYPHzdnJLn3W9UmZ8AlpSJajci52y1pww>
    <xmx:26fbatnLR1DOWZVA3eeU4tYtvaQwjb7f6fCaan27U5MZlx48nNN1-w>
    <xmx:26fbamwJ_B8oWGyjyd3aXRBHb1wn2ntDIteEVwc_BHv1VxWXO1bz-Q>
    <xmx:26fbamQKrJ7CVCxBJe_AkMUHMiBr-xvTv6CRxK8HbSCrhoM1JH_Q5htB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:30:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  tsukasa-ino <inoue.tsukasa.4@gmail.com>
Subject: Re: [PATCH 0/2] checkout: finish switch when tracking config cannot
 be written
In-Reply-To: <pull.2275.git.1792637495.gitgitgadget@gmail.com> (tsukasa-ino
	via GitGitGadget's message of "Thu, 22 Oct 2026 02:51:33 +0000")
References: <pull.2275.git.1792637495.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 11:30:49 -0700
Message-ID: <xmqqmrs45kx2.fsf@gitster.g>
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

"tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When the tracking config cannot be written (for example, because
> .git/config.lock exists), git switch -c and checkout -b stop halfway. The
> worktree, the index and the new branch ref are already updated, but HEAD
> stays on the old branch, and the changes are left staged.
>
>  * 1/2 makes setup_tracking() return an error instead of calling exit(). No
>    behavior change yet.
>  * 2/2 makes switch and checkout finish the switch and exit with status 0,
>    as push -u, clone and fetch already do. git branch still fails.

Thanks, queued.
