Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588771;
	b=evYZ2Rvzd6sktZ/oBJ3yXBoY51tZKHRa8Hssh9nvukBBkgpsWoI77S+wPVnOogJNCN1i
	 JHnuXgcgUlqrn7DcAAUOdaaPwQL5S1BTVoHNA+14qcEe4L2MJ4r9rRf/ttVMGr8XFYy0s
	 jQfFMHUfXJ78oyAvGBudsKvNjobf16ktMEo9y2McFMtyN+s04MLnMd7JE1LtdH4wwSCwY
	 C+Ia18Hc+j5oMq9uu0OsZMemvwdoC1w1idBpH9pWcbALRo41yVGkFenOZcO+bxr5k8YXz
	 GeVnd+xHqQsXoIn2s/OdJPROFO5DMTjvg5PiNP2OhV3fePI/RkKVaEzfSceZjlC5e9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588771;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MEVkg6zjuZs9F3iaObStu5Ma9BUzjWJo0cbJRqE8Tr8=;
	b=rw2uTHAJL6VluYFjzgF3aI6CW1d+WncqAZtEfRVGau+iCxAoofO0391u1Jpv+2lM5iU6
	 yw+YENS1s7mRAZSZURsgXmHqBRIaG4NTDGLVf2mTTX5uQ33Qc7YtgaRaDThxzdfYFpcnf
	 HhnR/HPZaJ3aVkKUAl43R+ScbRzQWVNs4Umj1YqCHZjY+5BvTg/x2CLv/GSH653vs7R+O
	 h+LQUqx/GqCQZeu0KRdKHHhAdtygI1O9lCez3HDLTvkRSwGZKPpY1wDbJKZOxJnS+iRng
	 U+pgmCnNOk9HwvkvcrNCD3GUrRNSt/++EtqPAlU7cdVauRQIeRBKXubhJ4IyMbxx5Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D0gwVF71;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="c/TRtm1F";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACCF606A882
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 16:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACCF606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D0gwVF71;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c/TRtm1F
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2478E140003D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:52:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 13 Nov 2026 11:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794588769; x=1794675169; bh=MEVkg6zjuZ
	s9F3iaObStu5Ma9BUzjWJo0cbJRqE8Tr8=; b=D0gwVF71vsbeF7aGkDtCze1gzR
	yVLwDS0GeJf9zU2FOauNZIFcLxYE499QtUg1dL5Wibthwniv9rQagtVGN6HnUYQo
	JS3YcbFX6f+3Z+l6BFj0/naXmZ6Rl1Q3ofxsSiOZjRKJ1QMIjK3/4U4cX4LteVED
	TWP2I176YSHz3WCzgdUpKty27H4nTwouGQJWEpSj3/k21CZVEcCDBBqtSw62PIgV
	BwyFLTw7dWRmFCgz/fXla2msQfo5q4ohhEoSRA4+AR2bMqbeIydnoca9lsvQO32L
	XuSQnulAoXudAyufdTOFlcEcjw0bTeVeQ5RNjC2Wg1jG1tx0u+7IzbsxciuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794588769; x=1794675169; bh=MEVkg6zjuZs9F3iaObStu5Ma9BUzjWJo0cb
	JRqE8Tr8=; b=c/TRtm1F6in1ugNmJdZXF9MCFoTOOq46V6GzDQrXhgfyInDyf9H
	C6AcKWK2FyhNYnLNcJ9WZgCt9kfzSJpXoSkV/izXgDizAuw9rw9ApRsNEiAShvUW
	Wv0c53ujIF8/+FfukrxOmC4uTc2rSTqhCw7Bcnh+Lt4FTWpBeShmPZFZuaHLf6dn
	cTBz8J2Mu5N7CKMpE6fZZ0cZ+d+pV11UMIzDoDAF+dvCqvSNjeJ9WdkbthB6l+My
	9xC+mD0MO6ZCQ4amxTIVroprUle5ORIDqHfEiM46O5PZjSJ58kf2Qq2ZGQk02czX
	a9UpL154dmhWZe1thtvBgstinC4KIiC3n3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794588769; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OIGkUsjlXjynVq7AMbfxRyfnLoCCks0AsIq5zkQIiH6Q1ul
	L/KLEnRImPKyAm15NeA4+UkejyzcujYujCW9By0jrIyHCEWoHtdqp3NWn3JwOeRY
	FH3idDkqFevcg2RJh+3H5AIH7WXgSFjF/vDItXhWHwITmUkn4UCB7R5f27WDHGmk
	SaILRqcw00E/cz7fq8U2Or6XCEjTwDsnmWNkzO+lp/qkUk0pS5wh5y28T3VQksuM
	ZSSzLPqxwqshICZoqTKE/JBGB1U3FN6pEHjCtUUrljLm4Bg9cra6RFpzFvBA0SRV
	YgE5E7+HtCVM+ZaXoRl0KdrLK7RLx+VNqgXFBEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:54V/K664vraOy3GNW+hidfF5Zj0rJPAdYgHCa849qVw=:MvjsI3gSJJwDG9xG7ELzcGBnMML5A9CjG5/k5sjNFXM=;
X-ME-Sender: <xms:YUD3auG3ejFe5XQDTJLPJ-j5yZUet3xCXXRuzWPu1US8q5HVLcfvog>
    <xme:YUD3amNXDQ_Lmb7OiI4FMqUzOdNaEjOMNmi82ezu_YpZPCxuIWxBU4Gn_QlU8F1LH
    9qztn9DRYtP6WVtc0mfApctCU8-i6zX9YwordcXLDtuvsvt-yJ3>
X-ME-Received: <xmr:YUD3age6h3F3wGfM0XDyff65-ED4j0MkJZUEjWiLeyonhVb2-gnw_reQM_6cUmtijpJUYVPYVongjtMnL-zyJ8rL_P7XPPyGyRrE>
X-ME-Proxy-Cause: dmFkZTEbvleFrDYjUi/x9TTiED5CWsU4v0Yhtet9EqddaJ4z5r7RvD1CAJnpAOkMyuKQPS
    ebVeKmMfs6IxLesUcNMCn4VhzgFBpk7a1FthSkBCe9c3xCskJkda+/Eh9Lk7dgA8GjoNoB
    3Qa2OpzQMGynzFg68WZxQF4eiHJZAyu4IRlHwea1osAWWMgYfxNC0kKw/32yURlRKx3vFf
    9NSpuddnU4VEDcYQmP1oA6MSQ0MWgi42QDlcGoPEgx2gum6AU82i+VmTB4yrkvfMseNys7
    RaOBXWoPiNK7K+ZOZXoMbFnR6kyL8oTIh93G2O/lV//AocBgpEwSsYzuAZd3trIqzAPViM
    1PtS7ZR0xqc1OHKwQPFh5jrZkJOZE4P26zf61SJZ12HIbYO3x/nqXowcNAfU9KxSllievK
    GqBvXbp4EhArF7oaHLGtA6Xzap9NO6h+iVQhMbsNkselHOgRPqvJx4V14r8S3Xsd6EVLNW
    +8texvW5ujtjZqc5mfRDtIWz4g7iQ/0yTDXyOjrYBl1nfwMNdX3n/dsF6YwrhzbQcq+dPr
    xWZGca4TFc8pSk1UeATLbdpII8lmvreA3HvFXfWD9NJX0CS/K7yyfohQjs5R7TC3meEKi0
    iT850SA98FhsvR/FY339hyJ2ip97ehERu8Z3GeawC46wor14U2PAEkv7VY0g
X-ME-Proxy: <xmx:YUD3ajupAV5SiYfQuG7CQP57hJ14xXsnyL0EGJ3AMV-IUW7T98KzAA>
    <xmx:YUD3ahnNOeb0YpDoWfWMmRVkEXPRGNBgIjIH09z-ToYEj_5nvB6Qsg>
    <xmx:YUD3alwj6bncDkRIDZZoWWqA7zjTVAO5ZjhfPH3JmgzeHwGgtlvkYw>
    <xmx:YUD3ajP-EVVrt1yK13A3_um8ZgfgV8b4tVXQw-HGpSZIAuveqdnEqA>
    <xmx:YUD3auvxH6mlTjxJZA_VTPnN4SZoHQwbNbhfhbZ9SD-wA0KCia_DF5sV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 11:52:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] commit: remove padding from struct commit
In-Reply-To: <CAL71e4MZTKK3wmf4TM6DcZdc0-Bt91XaPTHy54rbYUmhNpWcbQ@mail.gmail.com>
	(Kristofer Karlsson's message of "Fri, 13 Nov 2026 16:41:41 +0100")
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
	<pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com>
	<29490124-5020-42a1-978f-0f5283ba9e11@gmail.com>
	<CAL71e4MZTKK3wmf4TM6DcZdc0-Bt91XaPTHy54rbYUmhNpWcbQ@mail.gmail.com>
Date: Fri, 13 Nov 2026 08:52:48 -0800
Message-ID: <xmqqbj7sfzbz.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> On Fri, 13 Nov 2026 at 15:57, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/13/2026 8:30 AM, Kristofer Karlsson via GitGitGadget wrote:
>> > From: Kristofer Karlsson <krka@spotify.com>
>>
>> >  struct commit {
>> > +     /*
>> > +      * Must be the first member, so that a "struct object *" can be
>> > +      * cast to a "struct commit *".
>> > +      */
>> >       struct object object;
>>
>> I think your comment is backwards: We cast a commit into an object
>> and it works. We can't cast an arbitrary object to a commit.

I had the exact reaction.  In our "cheap C inheritance" pattern
downcasting commit to object can be done unconditionally, but
upcasting needs to be done with out of band knowledge (because these
struct types do not have "type" signature).  So

    ... so that a "struct commit *" can be cast to a "struct object
    *".  The code casts in other direction only when the object is
    known to be a commit.
