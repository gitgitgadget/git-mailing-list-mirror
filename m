Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986093;
	b=1OvyIYXvFd2aF+DG6yAoARuUmsfxGzO/kXaGCJrF2pd5n8eR2EacsypQkMjhhFlBhBfA
	 M3Q4LPLrse02PpQrUl9r0vxia41wVKt0JneP2bt1OqWInhYITwTOh537WCPFiVEhRWTCB
	 eha0VWSnSXnxjk72qfAjJ8QamhzZBw9p9mpr94jLpYo8MWpqL9IiHkcBmbAtQtYl4tCCV
	 onu+ol/nlnowJF5MYX1JYlIGnCWgjpRCufJbb8Rp0FuixQiCZoT41WNOK7wNRTj5ttd0K
	 eFLl+jVhCXX6itFaApq208dMYXl/l/22d3jYL/QlvTXnkm/KTnTQdd/e5ZV/y3/m5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986093;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aBbznbrbC2+I1d6ThTclyAwDzHA5uxHWSGKbWxmhuOg=;
	b=3n1BuzW1dZrb2KblcH1Ix6MJ0zrp1EVfNDMgmokVuGIG5k/WGDdz2y7yhSQg4/HCjbT+
	 sVuSilJkhKR3MGKOAFhgVadGiB+M+M/JfqbfyjvoEdz0YHRz9nlS1vTMyTczG6T7WJPfb
	 an3ai5We1eSPs/rciv//Slnm34F9D0sIrVTr2qnau/M6KtdXTneNnNX9pkYcHgN1uJKjy
	 uqEH7Qk7aThH8ZSq++vYVMVvAasaubPPmCCJqffdAMLhzdE2jYvpxmNi3GU8HkF7IWtmS
	 jB6kgV3613Gp51RUBdxirH0hr3zQpymQtGCAvLqiI+QlkZBdeRMmsT94MpRSVuH1ORw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PPXn4pEK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MM3z9ePe;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C8606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PPXn4pEK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MM3z9ePe
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 99CBDEC00EF
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 23:41:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 25 Oct 2026 23:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792986091; x=1793072491; bh=aBbznbrbC2
	+I1d6ThTclyAwDzHA5uxHWSGKbWxmhuOg=; b=PPXn4pEK4GmwdBfNCzGCeCsnYV
	b9eJBl3TvhrhqFEuaed3FRjonyFhyXj/RFWErV3KePYUTpPQGioAfvDAKwluy2yd
	dMQtXSVRQgw+zlIMQC56bk8QGboftZnAJRNtVxAT7nPy8EKuzYEglKQ64P/QL5qq
	PIM8bK/9cneGITwCEmyLyp01+Aqpx0HRZSGq9nv5RIGjbWkztClvn5lKFHAZWvYX
	jefcxMt7ibgXh30xZGqrFq9z1jNyfDff9EASi2eufsP4SZ2CAAKELh7acRB1rN9Q
	WIHYHMtl5w/DzlylcQibfPVwa7KK4TlL7jwYaudIdDnrHf6S4V0Beq9Eceww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792986091; x=1793072491; bh=aBbznbrbC2+I1d6ThTclyAwDzHA5uxHWSGK
	bWxmhuOg=; b=MM3z9ePeHL5o7h8K+LvoqwFml5Dv16ev8T+V4iiqTp4c7cnGhtY
	sm2+wSX5LLzG92MohkM85HM9+4OwkbxchiCJDprZl/dVzh/IdfT0Orch8ODXEvtB
	CKbc3iqcd+oAL1MN//qQt6eJxN+583Pzhq1ZMMYhG7jHzZelkHp8HbmA10tOexh3
	v+UEMX02nwu2s5xeYtndUjR40X8tBrxphIGO4E9CCKInIw0naohDWwhFujXYhHII
	IxUrWPw0/zXi8iBwL16vwcqz7MX0vMPzVtv+s4lOrCkCFsthDfy3j1wCV1aagBe4
	+gDWMz/+8wWC4QuPkx5xvjW1d5MjadSFGYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792986091; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:it3IynwsdoXWiun98dNJO/vXUYR8MYLCpV1B33m9O2omD55
	9g3ynrJ7pQ7Zk98bNFxMKKzJm/Ci6QVcxeKVI5U14CjPkpYrc2MNmPWOXJo7gu+h
	uuXuZX34PdQe/LdMYw9vfylzK9ZYCninGfpcSELeesyrjsSJVZPfEs8Fl/FxEQPJ
	yP0lD9N6qASCN/ek2rVoezYUK+n9PRabCTKm7TDY9+G3l9vRmfL0Aw3+8MemWrhZ
	SRptqApDmmzNm4+c6G7fydSznMoG9pstTQJtuwK74B8kK1k00OmCb2h2PXhUbmkt
	eRvuRmJPl/IQvj+WYUxU75i6T2hBu3N6+PVARkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XpdPQsbII9J3Ie+mHq5KVbxfS0n94ejGXoLdkrzsidM=:O4IyT9Giul6AI+fX4kuTOIZNaYxQF/GdmNznolISll4=;
X-ME-Sender: <xms:68veamco48zdOIFPH94ZMykG0Up8RO6_isUUqSR7cIOBbVkRunsHOg>
    <xme:68veanN-J0euuDOj_AFErBRt61Xx-hO1aaj4Z1f8HqPp4XQbnZcs53sO6aYEv5J2d
    FDdwwNIUKL8kZPoivDCnYkotqlhttw8j9hGIJPGLnltM_LUS7l5pQ>
X-ME-Received: <xmr:68veasg2WoFyvwGoVXG7U4eBVHunbDlowDTx_1b2F7Kh7dSZ2kTGVVX1HZs7zI5vfVcYd0iHjjRDWuCDbEaX88TNLC4QetVn7sC8>
X-ME-Proxy-Cause: dmFkZTGmLbRsYp7J5ycYGVAudJN1d93AD7w8ANK57iBs4z2moKOgu6iKGeHZUSsnk/weFl
    hYUhMP3tMnRE9OLa4S3E+W2CQU1hWAJy7Sad8pvJrm692rV4UKZbPXWAwn62/7nRc+maHB
    CaAslK9AKsSbiu5buMSIyMSL13nimOiy9Z4TuDFq4oNtYKymSdMvGEKcB9mKZpgDWj5Veq
    u5zGYo29u3YSUFfTaz6f11HFUPbnlsQ80jUT96LfPOHN2IgsYnYY1nKfz6eUZuwkHlkvUF
    4Md2Ohx+nRaspZ2GhZEQWze6kG/ISIORpo+dhD+LiZEFTVFbC5XiFrnLCbIU3alx+OB0ZN
    1EfvyH62eZtwh6DK8qL4msULRB4RPMzEuxqELiPIe+p+AapdB1kx2ARsNcDTl+hj11LuFV
    r3APUHyjxFOs4HGQRL//d0No/Kct+1o36kOUQrTkF1WhxxLQexIAMJrC1KFUvdIPTDJpBy
    bbaiOpV/MwVBuSeNisCBM7MdNkOh9Azbbq3zGzMJnKos7Mbj5D/arLf1eEZ4j57uzJdTts
    Q5tKj5KURv+J7cXXCUyohh33arJgVlBNuXmdRk/T2FG0oUzXGwrVZ0ay2sj4Yl44DbRdX3
    l+GnBSJL4qQh2u9PSaMemXJLZ09VYpoAicefiG/IQREmv28u1qkUaY61+XYA
X-ME-Proxy: <xmx:68veai0RIeqDrmco8k3VxEMLvQNtHP8ErcIjOK7loQxhyG1OP3vndA>
    <xmx:68veaujzP-7kLlzpnzrGJ6ZlKCDxDxnyyLfa784viFVWqO-3S2sIBA>
    <xmx:68veaqeX0z7VmSUJ0E_kAtWo1VoY0ZUnZ42jQDXyncZdNlv7eawB2A>
    <xmx:68veapmvNgLizEEID3SFKhAt-Gin9UJo7GfCgfvQY9AeNhRJrSfbtg>
    <xmx:68veagf5_orAJOIfMdcdLCAGdArHNQV0dJmhVfAfTPyOWRluvaZqH0w8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 23:41:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: jyotish kumar <jyotishkumar725015@gmail.com>,  git@vger.kernel.org
Subject: Re: [Discussion] t1006: testing %(rest) with object names
 containing whitespace
In-Reply-To: <20261026013254.GB3575069@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 25 Oct 2026 21:32:54 -0400")
References: <CAGjZMyRqv5RsLF4Vo439zy4urfr+R=CTwuDzmYjiemauuZan0Q@mail.gmail.com>
	<20261026013254.GB3575069@coredump.intra.peff.net>
Date: Sun, 25 Oct 2026 20:41:29 -0700
Message-ID: <xmqqjyn5w2l2.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> So IMHO everything is working as designed, and there is nothing to fix
> in the code. But using test_expect_failure seems weird to me. It avoids
> the test suite announcing a failure, but it is not really a breakage to
> be fixed. A test with %(rest) and an object name with space should
> probably just be skipped. We _could_ run just those cases with the
> resolved id, but the point of that test is checking how %(rest) works
> with the name, so I don't know that it would be testing anything useful.

Yup, thanks for finding old (but not so old) discussion.  We really
should have fixed the test including the fixme comment as we knew
already back then that there was nothing to fix.

Perhaps somebody involved in this discussion thread can volunteer to
do so this time?
