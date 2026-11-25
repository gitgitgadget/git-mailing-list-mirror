Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568049;
	b=c9HAztBPDtT+nvlQEa0NNyBpoAt0zgvq/IypmGzjHxTV6Djxl2YtS/Zt8DJWjPNOkFuy
	 QRilj5JIrpdFMA5ee0dpV6ZDXl77g067OK9fQa8XDujj8ZbhrAX8h37dAhG6KCHMS+Fbn
	 Tu/meB3LnAemVizWqOoE7r/ggeUx4E4NfJ7EmWaGfhAXDM/t2apvqWUgXrHck0QwQ86Up
	 5DO2VJ/iEVyySYBaFHvLLEfb28nNQ7XJiKjUwnzi8PLCYlw/hWj9quHzjrApLhp9RS24h
	 s1wS9pbAanTXAB8Z6LT9U/4iQ86X1opO3DFEeB5EvlDrDLOOfixpPmrhLv40XG3ITLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568049;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=qM7fOx+Ag9w+2u9o6qnqpv296hROluuc/FOPnol4cIM=;
	b=GHqzZkMiiwcYhy6qU3ms/K+HtqPGGZ5Gg9KfoNhay/ICgFd1jKqUwijCJRwYgQusW+y4
	 d7jmjw1mTpjbMY7AgWq5qOwpGkQserTDU+8zkZ0NdTD46R2r/TM+bgT5B2ZxtjHwThqPr
	 RS4dfec0Z8EOERj3pucQ1LzbHhqBE7IWgpKnqiBkPv8P53xUXpMG6/Gqoua+6De9ljnoU
	 pgR2rBjUH6GbFp2JZSLdvUDrspmuCwhzarA/6JSMBWDs8JTLfwjppusrt1zpRTYG9JTb5
	 k4FCKiuJjR99+G+B7KR3f54762WxE8zhuhUm5yxo5YE33CujNRBo2ugWMLvzhh8ry4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Je6+ocgD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Je5OK4Dz;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4E606A339
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F4E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Je6+ocgD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Je5OK4Dz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 555A37A0515
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:54:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 19:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795568048; x=1795654448; bh=qM7fOx+Ag9
	w+2u9o6qnqpv296hROluuc/FOPnol4cIM=; b=Je6+ocgDpBZmEZ2DA7xAbIb8qq
	+zghf4qTkxCLRkttssHXIIPbrm3hP/yfPDnnAIBaitHMc+emFj12ur+ubAG/8IJ4
	xvYROC1clszwaegi5MYVseB+iOa/krgg+GLeDYODoonZRGD97yFKcB6rsSTRSxPO
	8+YIdjbeTxONJ4dSByy8nqGFsanbKwfZ6UNJhKWF3sNXGMUMgth6Kes4wTI0gz0t
	1H8V/1KCEdXh7DL74M4WmnBBUs+CEe+wmM0GlNGJDj0fwvgnMT6B9BqvAS+8dyEx
	FEvHDPisF48G3KhERjWUy8zgXgMzoMFjUenNM9JxKUJxwvEldpcrt7QEIk9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795568048; x=1795654448; bh=qM7fOx+Ag9w+2u9o6qnqpv296hROluuc/FO
	Pnol4cIM=; b=Je5OK4DzxHZr3rGMmom6fq2uZ3kypmHlAud39OEOenIiLDuKK02
	w3/HWYEyhnPV6AHQmy8ezwfi3G9hfndP29iTc9MdGKALs+cJR6XNEZkFvGgC0fUs
	q0EqYk3aJBanm9xLjuOYZiqwBSOf8Jf8MzQEXYh8w8XrZnK1ieVDBq8KVoQXw/wo
	8/5iYBrlU8tJzLtodBOx4zkgM5nZyg+rDQOaC87gYVpKvxf9GXw4usXh9uk9Q2of
	s5Ks18bPtDuKS+qlHA2mjuEJCA2cTNxYLH22PhX77enduB5vIWt02wuX9iILfros
	gUrDRx6N80R2ctli9JkyhmGvdngQibrpIJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795568048; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mIJPGPHofC5Xn63tMx/b9DXMDH7g0WoG31IFxQTvUqJxeux
	Zh8Pw4mrwa574VmkABk22/CkfwnSZv8NO102x1w4uoLvlmYTKXEbVy9s2iMXTFZC
	hyFXhFVaVoZAJ1pZ6QkZcNXYEvdD/km01EkuvmqXHoy63oXFmMS4o9R+b5tSBO3o
	bo9yyhjrVLjyezbgSdOZL8dFdDgkLa40FZmbqmw4T/dmSc/Hu+bXf5geyvNesgB5
	yvVtcaEYhScXrfNCgCX33oHB9mnTIeJ3P9HF0fKbyIGBt6yP2HvsVWO30B1RqK4f
	Glgke3GKHTqu56WjDnw9DJgpW8stOqDhq80CBMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:T1CR/lE+lfMR3IlC3Ae75OC3t4TX71HLnlJGkTS6xKY=:ukb79SRGQvv18H1L8ffrgvid6doqC3jOm9ntNXRwDWE=;
X-ME-Sender: <xms:rzEGawXh4sRqjFgpvkJHhZuBp8QLxfvRp2AcxhPpR4_vA4MihgL_dw>
    <xme:rzEGazpIyf_Y70pnElqBl6xggi5wNNYuF94PYE3r7mI2HP0T027fvVgSca1qgir-M
    W_XrgqfxgwuCHt-dNideEJZApJcmpjwaJl2JH-aNNUqM122y4DXMFo>
X-ME-Received: <xmr:rzEGa6manDSswZMlJaCl53qVhI2NakhQ4rjgRtw7j5rU1trbMyAfzZj-bOl5YXW4l5SKWL7tse24FiUin-2hTmO6jlkSkdSu4M6VIrY>
X-ME-Proxy-Cause: dmFkZTEPnxVkhRdJnXIvkJQVLPODhtUcy3X9FPNuYm6DB6jGA+NCB9BdO9rVl2fTFBLih1
    WLEY+t2d31f7TwvMKTPdLcdyU0EBgS79+4jzcSyQt18CY2VbO6cgsXXDZscB087U+adpI3
    690TamyYvkPUHu6on/jkV0o0SXGvmL0GyxJrgdjB5ZU0wcJw9jgc4hTJvTjyE2kiDd42NV
    V8exLpat82rkL3ms3KKeUoz1G/nOdDF9r/Bphsz1qwjlRhAOLmqtmrOf12Qa5zeYycrqlD
    w5sxSjLOXfLnebOzrH3DnKa5KFXYNLtqW9LW/BFJwaxqJ2puCZJhlqGdAUNri5U7V3XepD
    3616SvZbsM5q6+jmBGYCKNH2nxZ9kQWoiWpdDNixL6HTGJz12RbHMw73Ry2jV6sfEsUa0T
    VoSPBfIH5vXOGP4fAygKtTkDr/+LQADvw3a8IT7jYxJnLEYQBmJK6cbJWhMQv+a1tjRlXh
    UGVAU/WwEmN7qW0EO71iJ0m1birsYfEtdP3M0oTHaAZ4HeDMnbHVjPQEtO360TBnEN7kXx
    rsjyXbJ/EFsHu4ne/uYi2Ww42Ef3Wrmdhnrh8Md7AtWgGOAUXegMkyj7zFgbY1x/ak7A/5
    eVEJ2s20HwLt8j6BrPcq9Iw1zh9fhy/MpWNm8vDXOX/1HV5ABtDS+v6+KYwg
X-ME-Proxy: <xmx:rzEGa73NVrAz4yopEy-UbhTsgqMPeDKXIh8pImLXxB8iNlH1xv4SQg>
    <xmx:rzEGa_T1R8oYfZ_Zr3coT5ig-qAPp2DxcoTpvuMUqsyoBTw8CRse9w>
    <xmx:rzEGa8zuRP1aJe32DtNVSDluFvMfmnckF8DFPXKDo0_XC5L9t9yEHA>
    <xmx:rzEGa3BFuFN83610QOeYnFRIg4jDH4UuJ8g2YJkVjVefAKDF1Ugq8A>
    <xmx:sDEGa-1XAyXFSKhjTJQpFuSIvQOc4WtP_DGqfrOtN029x_PHvXFVuqFp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:54:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
In-Reply-To: <20261124172146.18330-3-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 24 Nov 2026 18:21:43 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-3-okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 16:54:06 -0800
Message-ID: <xmqqtsl5g28h.fsf@gitster.g>
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

> note_tree_find(), add_non_note(), load_subtree(), remove_note()
> and format_note() already have the notes tree, but still read
> objects and hash algorithms from the_repository.
>
> Read them from t->repo, the repository stored on the tree.

Hmph.

Some of these functions like remove_note() and prune_notes() use
default_notes_tree as a stand-in when NULL is passed to 't', and they
also assert t->initialized before accessing t->repo.  So it should be
safe to convert them to access t->repo instead of the_repository.

But others?  note_tree_find() calls note_tree_search() which by itself
does not touch 't' at all as far as I can tell (which means 't' can
safely be NULL for notes_tree_search() because it does not dereference
it to access t->repo).  The conversion in this step would cause them to
dereference t->repo without checking if t is not NULL or t->initialized
member.  If they are already dereferencing t in the existing code and
assuming t is initialized, then this conversion is safe.  Otherwise, I
am not sure if a mechanical the_repository -> t->repo replacement is
good here.

