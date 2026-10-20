Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520860;
	b=l+j6zc9rxrV4VHVBMnSCVp2+b6Jwmn3mrnIWbauNWhCCjCuOWRV1QOvquYKIisWfhbK4
	 x0munyn0oVxZC6QiCfzO7jEZZN6NYrXmKvvpJ+aHn1guUdmNAI+Jca2E47SQniFnr39/5
	 hA/9EajqTqzaUjnh2grI4Bu/OuS5fgUZUsil4uiJYuuaejC/PpArbndz+ykBWspnruRbm
	 svdXxiTMi3zU4NQTcVgb6RfNBqXx0cEXxUWFLFrDF7EYoc2bFAj9Se+ghDupCyD5LnnX8
	 zBx7krU2B9tKelJSQRfZgE3zrfCQMHOCRHlbzHf9a1PvkUZjh3MZEedBVHvJNWxb0Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520860;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=66RlDV+rxXi9eRkdEH8B2SEckKwAlClGFMPXG6x+OhA=;
	b=QZKXx9Plmh+s7WQIxbxTrbbhc9qg7pRqIq+8xr0wb78KNPblEXt22I3tmdkaobXeVf7W
	 l+3qJGZ5NlzM7J6A4AiPn1Xj0rlkGO+gd1GJ6WljL8nNw/iM6NXkyx/0IvNz/Jcqhwjcg
	 r3flAhhWfwCNw8cAdb/DBSgoNiTPDg0upRLejRVh7Dpazwr6tSXzQ4EvFCOaZIB5eFpcX
	 5diSEMRDCCvH+dHoPruHlVX8mv2YaK8SkfMA0ind175Pt2jcElLjIrcfVm8BP5imAEeqU
	 dqV4yBSXpD1I2q0UJ3R46zhTPJzbDD6lt/uD6xK9zi4ZURvBpY07m79CoR331d3DrGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="E2Qxc/wo";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tUpM13ja;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C105606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C105606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=E2Qxc/wo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tUpM13ja
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 91D57EC0208
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:27:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 14:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792520859; x=1792607259; bh=66RlDV+rxX
	i9eRkdEH8B2SEckKwAlClGFMPXG6x+OhA=; b=E2Qxc/woekEQhbTWU82fMmWnDh
	px6rndhUxkfVML87s4yQtDNKuKzRdLb1TMcf1NLzqEkLIacN7eCMZ5KbgYERPmQ+
	jJC70uVpmhFNfcZjaxHxA+HW2mSiL7saloZBNfqGzcXAcOoKLg7Utc0ARW0fWBRJ
	sdsr855wJDT3jpf1hu+WO2wMvIwPQvAFr+uQYfs4OYONjzITbmUP3Bur/IjbxEDK
	KP1sfwNH+uKWmzOCKRh9oLbSSKy1G4xwXnlPFnPZK+Jsruvy2WS96BrhuKacUdwX
	rmTHYf76pwjG3UNF08ZDb1m71j3ANCCX+bEZ6WwRtqzhbrgr+jBlIhXiz5jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792520859; x=1792607259; bh=66RlDV+rxXi9eRkdEH8B2SEckKwAlClGFMP
	XG6x+OhA=; b=tUpM13jahE9qPIXHJovmbijCb1IgMgcAUOt1ulWONLXWol6ZTbu
	GBlvcDX6EL67CmUdYsgNu/KAfIKa+Tf41VCVMBSdaZ/cUeqR6v1qjdzmrpqWIUk+
	B6mik01sRcUcP/KC90OZGqNi5O0QvR4xrKIhIm49LLLmbXaDk+e+21Q7sKm/DiZN
	5HnKxyninxcvrlit7WOweuevQUu30U3Lect1sM//D5FRP1HPRafaaSkJ6TQuUn6j
	2JGynk4mB16D9MNf9c2quUlldf6ZuUd2HeIh66NMUJKCANsgs+So5poVarta5jwb
	JmJWzZb1NJvK4u3wuBUR6yLGbp8plqTJvdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792520859; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:X04s9xvSEYPoCGH7/4pXXdC5iFM3G6jVfA/kV8bJd7/+LNd
	7Aq3Ysx43a3B8Vp8OFfUf+gPQxudzyk9bvobPitljgD/eJcQOeFEJ5urFixjGSGn
	FSPbDRnJvngyAASag/8+hBstyU8jMJWMbBi0s1ZTDfEe6ZWxYz0g2QVV7UfSwYhc
	Zajz6qS91cmv2RmDeLNsu18hRzO5+bYqEwpWTteqpLYugMApHbVP/tgrrWzOx5Yh
	cp/CdkWJY5/IRsyGze5fw9rDhX1ZLMWdKMXsyqwKSao3Vv+oZMjD7XYRVERA5tXy
	kh/KpoPIyqApL95rdwejL+mt2IUE5SblcJ+hm7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kGvdRUFL0NkmfyApZdPnS/OlKwHKju+Qe/LdpCsLpUY=:5hngzTAToy242F+3vFzgt0IaitLxVaDE8y4Ii6RFk1M=;
X-ME-Sender: <xms:m7LXahxcCRTpzNqXSk9A7hYCbIyOgTfegD4rHvune--0LXq-h4S4Ow>
    <xme:m7LXaoQgvIUmvUFPGqzbYSgpPShQ4iVCcwCwjPhBlxCxiu2teN8UbpSo6KGaW3-ww
    Z0tQjOctbRQkIDewBEOYMsNY04e_jhoSndpqr0-pYmmmnjYEXNwR7A>
X-ME-Received: <xmr:m7LXagV-6tWOO2UOEwRS8Xmr6dDUrXDzXKE2cfjIydOu_l_5u3jmMoDivoj6M3hjtn0p-Fpn2bp-CJ2CexvTmznMhp8vKVTxgZpB>
X-ME-Proxy-Cause: dmFkZTEpq6/2k3LehrfbIWx+BU2dGFu7uzADDHI4rLcnVQdn5jJploKfjyT629lulRbShk
    mlXxEzjjqa9610NJg6Qi2c6NTjwdfoZfCkf4vdcV0v6wF1C6urnauwk2YFaiibcGtFvt3W
    2mBpsKvRpDS0TxJ8OqtwnpFiRu7PT05P7i8vB7rgAj2XSxKB5genb0g0IIiVHnLVQWl4dQ
    p0YlKzJk4KQZCbrw3NfzgnrHLX/EkLQFYGO+IahrMF/sVW1OQzFUH3QeDKB7kxMFcT86mX
    soSw0v1z8I2S4EPzmJLj546+eCv9Xwy4ybyuKj6I1alwU2fXSCdr9mH5sb9bCdeaSyWzr5
    FbwTTd0x1BobrrRf7qhJonWkuk9mDKefMCIPIdwcCSiNHEad+dcuZ+BqdBlzlQ8R/4g6HV
    KlR0V8U8h1dK8Htff71BW4AHVMLUGOmkNWQhvX/02Go/H7+zAO6VHc2vY1td7UguvFfDvW
    Jpg/AjDGVFgXCzUcTU0S/ujk9BClqnJp2b95hDzN7HyTfjR/jLTx7cFkr8ekJcRvwJff0E
    zzIl8B1YdhXjH5Ier0QY3w60YyX9znHjw/6C49rlWVmMfWqGK6IADWVCO0BDlDo7a51PYN
    6XG6eo3pn09BSxayTgR/62cwbx8wcDpU3eTSfZJMU0IHoZUhFpLzJJ97K11Q
X-ME-Proxy: <xmx:m7LXaiY0zB0dUbkUKBF-Y7Xj01Z4sjdrNCOrGeTc9S7U5GYB8iiN2w>
    <xmx:m7LXau2NFdsvG-4E9h-pVOxfHHpjF28wvYFBtpB9eZ4JZTdvsbhb-g>
    <xmx:m7LXasipwlCzoEhy0v7YSkgJRoThTFuAGTjhKfoG0haem_5D0etlxA>
    <xmx:m7LXaqYNt8P23UfD3CqUUMj3IDd_Y2of4pv8wgJ4kopsLj0ZSdUR0w>
    <xmx:m7LXan18MKTBlH1yO4kQPAloRDXLpBs43Q8RuhE-LpBWShXlA2UlEHfF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 14:27:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca> (Julia Evans's
	message of "Tue, 20 Oct 2026 13:59:28 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
Date: Tue, 20 Oct 2026 11:27:37 -0700
Message-ID: <xmqqh5igw7l2.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

>> The goal is well described, and overall the tutorial is well-paced
>> and avoids common beginner traps.  Since Ben has covered the text
>> fairly well, the remainder of this message has just some leftover
>> nitpicks.

My local build of 'seen' just saw these:

gittutorial.adoc:124: section delimiter not preceded by an empty line
gittutorial.adoc:487: section delimiter not preceded by an empty line

I haven't checked what these two lines contain yet.

Thanks.
