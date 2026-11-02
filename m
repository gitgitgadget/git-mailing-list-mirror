Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604678;
	b=4w2NeAQfc9mcm+/g0dJg85s093KRmMjfEVfHd4iTUtyN/M+ayNEJcH1K9bqPrkHEdnq9
	 Xee1o9SS1NUEM9PLnHYvShHL+oZy5dQmLIiwOLjtPWGvDXCx6z+qjwLrsEyC/kE9j0T4e
	 KDRx09B5NuB4Y6o2uJDtiVjqv7oBiZuJl2rwPxLAJIke3cYwR+n1+qnDW91BpECeW+gkj
	 MHrBna5RZcXd9nofdLZS8g3DYK7Dmb8Joa2QsR5xzJK5J+/BU8os9HICvCLO89t80PO4t
	 WZohYsHnNOOatm1B49LwjFVZSqpLztRyz9Fa460UXLLAM4bZZazuj55XFlQNDsJM6zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604678;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TkTZYzTMFpJ5WYtNoPSGKB/WrVgG3dFElchCLhwNR+Q=;
	b=3N8yvqKrDo9qlxswkFQcLEuJV6YHGCSgTE0XMpnDqNgDl8LafyQEKzdBb0z61+FJrgbb
	 GqcdMOJAaURoX2nFJ5/W3U2brPZBbaFwrrBp3NsoYZ/tFCUiJirZbTSZpPiIPlDVZ6+6g
	 ooKphGwuWkMFNyaXRLbyYXimK8WTSAMS/bNnD1my6KgWMs8lxjdUwOJ4n0JW2v3TbAJAW
	 VcBFeUkKlRJUoBZzHh/oNXR+WmOONcVzxQ2+LfnK0Dj1L6/BDp5YMlY0SCvTMpRQiPD5N
	 4iGozzQfvbX3YGJnjhUIWMi2LVj1iHohjzTzvS8wlJdUmYLePwX8Z1+UaAJB/DssIuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CJ5d3D1W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="yu/us4J6";
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3D606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 07:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E3D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CJ5d3D1W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yu/us4J6
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E0CC11D00064
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 02:31:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 02:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793604676; x=1793691076; bh=TkTZYzTMFp
	J5WYtNoPSGKB/WrVgG3dFElchCLhwNR+Q=; b=CJ5d3D1WidVdMxZA2xrCzEf78B
	TqqZKmw9eivPy+biKNw47UGRs/SFZZhaNir4q1IhXs+aWVpLkV94MwznHlWbbJyq
	ENw4JFW5B65ky1BUNHGXCs/6xThWjJd37Jnso4uzUzQ2jV1clsPiMiMhKMwH8psq
	laJJSiw6FRBHYdmN+cnzsa51JmoaDLltZoCUPdyAJkbtyPDQe3TUtwQgEg9BxN62
	9mIT/1mrmKfWV3qRYJSeqDFCPPG71aMleYOeiFVK6aggpajKKndk77Hm1/UXdCZi
	r05WR28zAOBw3i5OrJjnp/VsQAXvyO74rJxe4TVclTVvj6uQH+qL4sxB92Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793604676; x=1793691076; bh=TkTZYzTMFpJ5WYtNoPSGKB/WrVgG3dFElch
	CLhwNR+Q=; b=yu/us4J63BUXPNh6GB/IRL3O7/J3tHdG0OAuBSYF9NI1dG+jYYf
	xshVBXC4TYehTDIOoQTVqmXl75K+8gKmRY1dRP8Ad1IEjI9lF3cECU3xVw1Rc/i+
	LdlZRJdPqkhFmhO1i5pUj8O7LbqwgX9b/6F/ySft0RWaboJ7XYhBFQv+fokwufBD
	IsRYfCRymHT6cdTwOczzKB3b+INdsdiHgTXtfnd9irQCwPQk7a++4gO5TOtSHqA1
	iQXUaH8jANccB6LUXoDzWj7knCbJrwnvEPbM3nHxlI5SWSOzeQaHhPOLnrAz/PN1
	EtwqmxxUv8SADCVnV5zEIMy//Im4chfZQKw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793604676; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZmEoD48Fnh5oABvOTFlpZZI/gd5AU8wBqayuievl9HdVnBS
	8QNJfLZ5TEBfx12dt3mghz10ZIBZ9PrpwtDRdz9pJUHdf1IAJ9qUwSdZERe7CQI1
	pMJJpWoQr/+gsN+aiPRmkgHueDWfh44ubecnQwMHNaUGVq7RhNCVmxjjmm2hiHuc
	uOh4N68zEsnNADAIoYv1r2GAXXyDNOubT39qxA7mQn1rnJ0firXl9jBEIWGOE96y
	wupm7IWbaKanFExJr0WsYK8TWIF/8EYj3+SfZce4pmfccA+2tjCzFNwdPyPWvigI
	H30lttXJy5Hkub8OGWEb1H8OYa5NWYwrzNIxpVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yKnvpmtfGUW0gDznfvel+dK6Lfn/iMnfYe7jW0mlteU=:Bv7+yc670gV7jH4d/ZQy2+cpZg+hNHxsfZ5vdYAevSY=;
X-ME-Sender: <xms:RDzoanlTVjkvGL0CG8ePgpQ7OZQNWU4qJc9OOCNnT_cXTNCqpAqB9w>
    <xme:RDzoaiQ4HozF8GJSliqrNxdLu2gNzj8RYS4XUi4VOTEgZtyTzQSeZ39vJkSrgNPCQ
    hqnHPnryDwebBttz4WuFIgRoYQ31XzFpfhchugS_jR4mBfXLYXiPKE>
X-ME-Received: <xmr:RDzoarBH_PyV1aBaIUQACQyiGOKvfn3RzvtmLMsLV822QT0EycVznG-kQH2mk-4DjPSCGYYVbmVG8h7pAHxLZFU4JmhwYGNEehEB>
X-ME-Proxy-Cause: dmFkZTE6WN3fKNgUI8H10qi7EFbN+zDeLAbmKArdkFvEd0d0m42XwqhHCv1UtUNzvJqFTP
    DkqNmGIpSfCQ91H1MepwChVhBw/OmGuSK7vD6S87rZWPJ94mBj8FSILzILxxtu2eW0vXwu
    UWEyBvnH7gdynAteY/78LaLh8+L5TrfoS/RRA3ukPFOjNrVC7cEFDKyaj+Hsr6827dYX6e
    Nczt9OkYbKK2LYmG+KLHe9Ekts8W8cn+GVpFKhfcuhqLHjfXGBGM9AGgAEzfRc2dASeFPb
    DLQOX4lGJXMNjVixaINZ2y7FLDlOHX1rNQ0B1Am0n320IuziPf3YE8XX1pKm58BdlxZAAW
    NlWxVpIImcOXLL52xXoMqVuVZRIUG6bXnETFN1cdG9OKJ5chsNHkFkoTzLGFp8I5PNiMdL
    ze7+2cmvzl2DJpUKSk7fvwejLrzA0+XA6MnlB4atLtQ1ppSJ7DR7GQDaWo3JgS7Kg96uSp
    B1rJiy+cN7DXiivqAxxHVOubbCTMiYDFe46M19Swo4lUzaqBpCsJLfgehphj+BAuly7av4
    3FemgjcGySRhnUnD2A3gZMlWVMop5YCrKjVGZlmoCv1/Al8eVRyuqXwogNXxVxloPKVC/n
    cZona2frJeVBFIRzFcGPQENI5DZL7v84xPZ9CFf1FkHubo/JGyOMR+Vivqhg
X-ME-Proxy: <xmx:RDzoapQp3f4KJvFNab5zYx8FH8kAqVuCJls68GiAbMzvy5SvPe4Abg>
    <xmx:RDzoaponV07w-XykKtAkpbrbn_pwn-g2lE5kIqcuMFAbzLXl0CrLiQ>
    <xmx:RDzoary5OcFB9NAsUIHkxmXsWKPmpZhgu8as-teVcLwXD27Lsx03Iw>
    <xmx:RDzoauIGltHxNpjhOJaerKDLdbMU7hyeROu_bPfNOBRSuZvCdFLDsw>
    <xmx:RDzoamT3kUYEAUWs2AP8ztAlWrljc_X9z-eRfEiJoU7T9qndo2pXtatX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 02:31:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Ejecting things more aggressively out of 'seen'?
In-Reply-To: <47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com> (Phillip Wood's
	message of "Wed, 5 Aug 2026 14:10:39 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
	<xmqqbjbpptzr.fsf@gitster.g>
	<47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
Date: Sun, 01 Nov 2026 23:31:14 -0800
Message-ID: <xmqq1p93ofjx.fsf@gitster.g>
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

> On 29/07/2026 18:48, Junio C Hamano wrote:
>> 
>> Perhaps the sensible thing for me to do is to stop taking any new
>> topics into 'seen', even if I've spotted them, until I see somebody
>> give them a real review.
>> 
>> Otherwise, it becomes too tempting for me to jump in, give them a
>> superficial read after seeing them linger in the "What's Cooking"
>> draft in the "Needs review" state for too long, and, believing I've
>> seen enough, mark them for 'next'.  If I don't queue a patch that
>> nobody seems to have read carefully, I won't succumb to such
>> temptation.
>
> Maybe, though I do find having the patches in seen makes it easier to do 
> an in-depth review as it means I don't have to apply them myself.

I have operated in "aggressively accept many things into 'seen'"
mode for some time since this exchange.  We ended up with many
"Needs review" topics, which nobody was interested in, sitting in
'seen' for weeks.  Having these and other topics in 'seen' may have
helped other topics get reviewed, which might have been missed by
you and others if they were not in my tree in a readily available
form.  Thus, it is not entirely fair to declare this a failed
experiment.

Still, we need to decide, and better yet, establish a policy on, how
to deal with topics that remain unreviewed even after lingering in
'seen' for quite some time.

A mechanically applicable set of policies makes it easier to manage
a large volume of topics.  Some of these are currently written down,
while others may have been guessed by those who read a few "What's
cooking" reports in a row:

 - A topic that has spent a week in 'next' graduates to 'master',
   unless there is a strong reason to do otherwise.

 - A topic marked as "Will merge to 'next'" is merged 60 hours after
   such a label is applied (in other words, people can stop me if
   they act soon enough).

 - A topic goes into the "Waiting for response" state once reviewed,
   where it remains until the author responds.  After staying in
   this state for a month or so, it is demoted to the "Stalled"
   state, and eventually dropped.

We should probably have a rule that says "a topic that did not get
reviewed for N weeks is ejected from 'seen'".

Tonight, I am sending a notice for each topic that has been in that
state for more than a month (the oldest one dating back to mid-July).

