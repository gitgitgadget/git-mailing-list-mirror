Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636254;
	b=b0imhgNzaTbKEJLt7Bo1FrgNnblOCd2YL5L8knQwGRsBt1MrFPv0DLvO5MAUITwIPzE+
	 EdKtqAjGoLOqpdAFA33+k0BSYgjjzeG1SfNTra6OR5U4uU9PY+C2JP/giHle2UxDzqJP1
	 orqMZcLCahBXy0b1DPWnvXmxv3MCOW1jWdWUGc5lyCKbtacWaLEGFkp8ceNg8oTIjS4By
	 mqbWKMbuGsiS6XOZ3m8MDhBsEud8dMfDHjCvqXcW1eO7B5nV+fj5nK6nsY4oc+/AtPDvn
	 mZ2Q9SJrHYd/jrfcctkMECi/of0svNQwAr7c9oQn2xKqpeKpDtOqjKab3ig8eCth5gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636254;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=O1yK6210ltBr7cLShNsm94/Xgz7/J171rX0DGAQuWUk=;
	b=X27+UHQ0CiHkIykLO8DVSK3Wx12elfof87qQhSY5DgvVRyLvLzw0fxRwXBy4pctmk6FC
	 en21yygYu4Vd23DwR2jzKIJQjpUFX1aviKWd03sgfjdF88Fyn9rlatjTZ698dLkbpOxhK
	 XKN0/KZzoIgMAYPtr6S4zL2fybg/XvHbfUZ9wlcqx4r+s1FxnER4dMXhOZSig2BqpQjzI
	 LKNrSELUrYKABIXphPyIXzU6lBMvNxsW91fTID7/wNHnuBSqIn3FwRWc3yI1amf8tf3Gs
	 3Lti4gShqVSOhPm55dOWh6vd7rwVR/vKSn4K09slhUSQcpZgDw1/lHUKlFwxscWBsKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e1471Fak;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="fa/Dlsf4";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4D60716CE
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C4D60716CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e1471Fak;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fa/Dlsf4
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 278CD1D00115
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:17:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Nov 2026 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793636252; x=1793722652; bh=O1yK6210lt
	Br7cLShNsm94/Xgz7/J171rX0DGAQuWUk=; b=e1471FakPAAL6vGTWEi+0JJMAI
	t0xijzwi8TohIFRg2/vqkowTMgTYlCS5HzjFmIz5bM/jdCEgbZCAM5fFV0L8cw49
	QKJNZxTnhHBf802wKa9f0ZlRDZ2BrQJf4mB+ek5UB6NkIJFtbVmnMxrlaQubLU+u
	LQIZwE9C99d1U39sC6TH1TeJD/IZbrpQ8g5Ifp0HJ+DYorSt6I+UAWRQnfdDfl0Y
	j1zSp4ruLn+shpZ/xP7BisKr+gp6XX9GOfv7Js0c3OpScEOE1MY13yBnqb/BsZHU
	t7uafz+lkSKlvIIFUaW7Wr73ENkOrhYkuwpAYRtSl/9FNQLCGRDzZkPyp+aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793636252; x=1793722652; bh=O1yK6210ltBr7cLShNsm94/Xgz7/J171rX0
	DGAQuWUk=; b=fa/Dlsf4yiJcLK+W+yfRrBOvUmTPYfCytqVlKdIel1otKxPOiLd
	lW2O8ZzFN9xTfbyJyecGAKh0tql9JjGcKwakfQLy8WfIaL5aRuoZqwCd9oTQ5mKT
	DWAf5Typ9fFYw2iVO2ioZ/e2Ky0IST804MGxp65RMlAVRycDTXKR2bKtvtbXgrcV
	ko1tkhL2DlI5s1A5CCPJnU22I6FtQ22NTNjeGhiCKp9bodTsfwulrT6gTY1+8OUW
	kkw5c6lZtji7D+XE390inEz8JgEbdYxMGZAQGF87wPaUGWIJMorG6fqLcRFBYR6d
	l1ZkdVCqx93l5ZegJdp+prw2tm1QgeXG/sg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793636252; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EwFdKcIEhL1FzvKv+Sef+wlo6+i9/3C73s+mJZBzM0KvPV0
	HjGJ1wDm/JE761vGtKeT/b8Ny1eWiLdPJPlDVmmoH994tP6iM4OPDgqVTnbhs33P
	ujlmA9hub3l/4kxP1+9F0E0WeNxq/MkWJYmjF53eKG6ufjPxu1bpabWq4gKyBLSu
	lt1FcCQt0CdRn3Cn2grgxOsBd0lQyuS7wZ/PC9M85P25/jTEwJwnCtt5ri8dRkYV
	MkCANMfYY9linAMQQr0ncATpXOISchKs7IwL2ZDWxFRdqJQWiAYIeNMmq1pyJIXw
	1ss0AJziQm65cHP4g0u3chweSuMQLOL6k6nuJKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IpH6vtpx3r43Os+Z+hLYBZKQ+xQQJsaYpo47ESJMNcg=:+GBfM3Oysx2SGzAbNwAtX4mLjVCAqf8/EMgXS46S6bY=;
X-ME-Sender: <xms:nLfoaitqMhIACo8r_DJ8N7IRsIql9PwCCDj9nP90hSMlfdXUsLi-9A>
    <xme:nLfoaueWrJcsOlT16aVVUMnAEVseaiMuztsP9hWbINjn2k6_WZmP3z_LPxvdz-vxp
    -4C1NRsG-Zdilc0yQzhQd9bQyjIhCK7L6GGEbJswb-7B1jAKcMmNA>
X-ME-Received: <xmr:nLfoaizY7YAnmDpjyBCK7vb8DFVHh816IuH8U9IFBRMyeBic09LPTLISlCC3dP6MY5gBqjITcNR-FjVlKbOkuBBI9qhSP55S6_eI>
X-ME-Proxy-Cause: dmFkZTEYzXIorekTFdlsh5dWKLvL0ufF7yggC3IMHxbJKu+TV7QM58xVX5takU2ESiTx/i
    p2WbltDKmFhJik9n8MrvcRTaGdr90fneTy4/EepdeQnTZWv/QSQ1fhb6n0l3OSeMWDGG1Y
    4B/V8E2pMpOtHKA18O3bb9GCfSE/LrBVGNRPy//6yyJEauycWIVUev46OFm2kNvyJrN/7/
    NhVv5Zrq779q6MgvDp79xsff9rj4lURykE1MdVzBIMe0WMbQpMpN80nuOOWNDtZLyxYkwT
    DfSjAtscMfuTHtDYe94q0PvyuxhjCndJ32a9AJrjownHfs7TIZ3i8f/hhNYrtVOSWQU3Ov
    cMoWZKfN6QvcdMGv67lqMMBzIfNsOD8KYZK8ed5rtfziy8wJFl8J0C6A7kE8kVKmkleJRp
    0fztklpNVetG5+0zPv8x9e7YrqpGE/tyKegvUpvzkX1u2yjSiJmLpr02lZyVC/EPNpmOzp
    RuoZjnIpztpaH+Vp0l8UxYIZM3vj/KKpFi4Cb540NNjYBEdqpWUXSkQ56X5DXccoHf46WP
    2gYX6lMHBFxImZTwvMP0h4DJkXMmKaslIArCCi1/hJ5j4iA8YE/R79Huro7eziub5qul+3
    s7+qH6mMCLbb/yS9EV65JPitS7xkPLjd2nyG3dQXl4RXgnuZfA9CFRZ+j+Wg
X-ME-Proxy: <xmx:nLfoasGgLN9iD9PBmWerYMnHJR0Uwtfp-3Mw1fQFTcgIYS4VPwAwkg>
    <xmx:nLfoauwNm1virAO5DJMBIuPYvNrzMOW6Afx3DZbSGyvHweK_M2gWQQ>
    <xmx:nLfoaltDrRs-iuXraGEC336P7CkJWd7W_D-kHgUBt6scq20s3Ls2qA>
    <xmx:nLfoaj2DGP2lfUxjDUvsQ9ioaA4b4vqwORB68z4km-C1c0qiO04t1A>
    <xmx:nLfoamRtlFJGkDQOxBHJOlsuTsfrN9aak6bRVED5m_pBAlXdRypX03du>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 11:17:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Ejecting things more aggressively out of 'seen'?
In-Reply-To: <auhfD1ryB-7JwOYl@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Nov 2026 10:59:43 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
	<xmqqbjbpptzr.fsf@gitster.g>
	<47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
	<xmqq1p93ofjx.fsf@gitster.g> <auhfD1ryB-7JwOYl@pks.im>
Date: Mon, 02 Nov 2026 08:17:31 -0800
Message-ID: <xmqqv76fjjhg.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> One state that confuses newcomers quite often is "Will merge to 'next'?"
> with a question mark at the end. If we were to document these we shuld
> probably also document that state.

Hmph, really?  Just like the subject of this e-mail message, a
trailing question mark is my way of saying "I am planning to do
this, but if you think it is a bad idea, please stop me with an
explanation why I shouldn't".

>>  - A topic goes into the "Waiting for response" state once reviewed,
>>    where it remains until the author responds.  After staying in
>>    this state for a month or so, it is demoted to the "Stalled"
>>    state, and eventually dropped.
>> 
>> We should probably have a rule that says "a topic that did not get
>> reviewed for N weeks is ejected from 'seen'".
>
> I think that's reasonable. Becoming a bit more aggressive there doesn't
> make too much of a difference anyway -- if a topic gets evicted from
> "seen" and then later on regains interest then it can still be included
> into "seen" again.
>
> By gut feeling I'd use the same rule as for "Waiting for response".

An obvious alternative is to queue only topics for which I can, by
judging reviews on the list, at least say "Will merge to 'next'?"
with enough confidence.  It would reduce the size of 'seen' and the
friction felt by contributors when their topic is once queued on
'seen' and later ejected unceremoniously through no fault of their
own, other than their topic being forgettable or uninspiring to
others.

I do not know which one is better: educating contributors that their
topics being uninspiring to others is something they should not feel
bad about and giving our reviewers easier access to these candidate
topics, or being strict and mechanical and queuing only topics that
some human reviewers with a certain level of reputation have looked
at and have not just shown interest in, but have said are ready.

I can do either.  It is less emotional stress for me to do the
latter.  Between hitting 'seen' and then later being discarded, and
not getting any response or reaction at all, I am not sure which one
our contributors find more acceptable.
