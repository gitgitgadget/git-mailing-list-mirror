Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318415;
	b=OaEeCke15s7ZbyTR3wCdM/Vno0BSW+WTJt5eBTsK6oz4bApcZBqlyjatk/Ammo17ESZL
	 id2dO3Y6YLnruTq6u9RKapLrDgsTMbPALcOqZkD80VYgot1tfdTYxdzuJBcPxL+T7sazt
	 jMbemnd1Pl+uZ5d4szOaRgaf01JZTXtSNJMGCSJ+m5eS6Efy6h3YzU+PYj03EUseaUfUC
	 3jTimTiP1Hm/B3NCuPQEkykjbouHPZ0rEC1LHNp08qukAcl+jLAe9mR6FeOVPHxBEKfkh
	 aVW4Bo+PGL2RMaSAsEfHYMasYIhMPqfbEB86Kw/n6asxehqqb6f89rJ+aRwUH7eRT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318415;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=jy5Y/OYgeXsJxTpGyQS11QWC+DKTzeiCDsiem+f7zaA=;
	b=0FgVPs7wgr2nnfHstBjM60pnJI44UPL5c3B8a7oi/7V+RhEG5Y3eNRp5y+/NZpc2nc/a
	 JPGbDpCIHW+4DLmFaWvUOLya6ZGxbsdDYfukxILOsAVg0i4b1BXx54ieFaJgQLjhrcv5k
	 sBWVDEe08gVLHpZgSegc9k5aGRp3VILGBuCVPXFa00FCrNTd+QS+kA7v5vDu3qlmCGo55
	 p1Ue0jPbMFSunwraush0hxQXn1l8LeJz0YNBPWaO81vUXvNv6XYZjYX2sR3BW7WwO7W2r
	 wgzEq4utg3VuKXL69NJdyoI545FkFHN9IB0BiBOiAQg7rxDLqUxv66MY7yhxY7O4WIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b="M4/oYEmu";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="iokkh/5t";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56E606A339
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA56E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=M4/oYEmu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iokkh/5t
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F05497A0056
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:46:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 08:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794318413;
	 x=1794404813; bh=jy5Y/OYgeXsJxTpGyQS11QWC+DKTzeiCDsiem+f7zaA=; b=
	M4/oYEmueeU9dJWKlQQWObovVSJAjqLNgbFrLkae8bDcki/antmOCJt1eqnQubTH
	lQvjaaIMGBTg/nSO4VV22tMhga99rQTg1SGesj8HQUO6YC4GVCI6K7S/N/S1zZMk
	zvOpXWMfto6el0sjmnPtugdDP+5kZOL5J5bfKFaC9MTYXSKi7j6a5xymIjrvMjGu
	+S3qoWTYJelBnKs43xmIMTX50L5azjKOMejiSbkip6V8mhfcCxvl4j7RzcIOpDiP
	ZPKRW8OsHxVZtlS9DcC1Jp6zbIGLZ+426+FSRkvbxTx9rR8tawVWEfE2Jsxs4XWu
	1m8Da+vB2SsRq7ntH+zKVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794318413; x=
	1794404813; bh=jy5Y/OYgeXsJxTpGyQS11QWC+DKTzeiCDsiem+f7zaA=; b=i
	okkh/5t6OB8xOJa/mKuHD8I9T5YA7BGZUctKnScvM5MD6rkzIBN01azX0To2V96E
	jFstikuoG7oD7sxXCoJrjxzsOjgITQMHewrNbIPM9jg0bJv6SoibDEw26JCK82QP
	RD3xaa1czY/fpxcs6yOGPTC3aHJjTi3ibc49ZxYlWUcXwCuhMsBUXXLlwYFPH+sL
	X8EWNsbCqk258a73dmAETNcMZEy55zXZg69J259Ie/npVKQjZiIi6lGv3EyID3EW
	R60AuLm/yA08ahq4psoBq5fgfaxk0hz8RaXmUiAOr6832tOaeLu49QSUNRzClvLj
	V6xzYeUTMqfLn3cVvqGxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794318413; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:cRnLfMvhrLlKbJOHTx0Mf+bKCo+2tySWK1eC2aRkge99yAQ
	+eGykVhqCX/AspXSuyiYkE8vocQ6dU86h2UD0SqmEwVs/7EBGe2HieLResXxxkjC
	AzYSY3GgbKFwnx4cc5b5d44I4Cf+o6RKGpC8Zu9A1XnKLDM2mI+X+RIjEdzjGaWY
	FY0AmRRVxUVzxlvMG3UZqfHyy0MbBe3/bqdSijDXsJ2r7uS5igNa4wte32ilfqIX
	1M0pVrbKotNm63Bgyen50BI6NcUoORAfXhAdhWW7YlXfE5PLj6GRkOUr4QGVRQpN
	jim6cxKqLSuD7FLwAMyUBwYd2v5V3McAjUPf6Jg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WU3omMe5QQo/NtTMm9ZqDkpCQWEGf9qXqAnW5SWtYWk=:IUFJXn0QeNsIq1Amk7TArEKkk/VZNj5cTuIpKK7C3x4=;
X-ME-Sender: <xms:TSDzao-0kZDfPu1A3VX_lJ-MqKDp0anbInM5sHEoihtqJAjIs3sZSQ>
    <xme:TSDzargupcdGryOJ39f7unntAnTBc8e5vR-K8TAoaUOn_0xoexTP2d_uP5zUFCiMO
    yL0qAynZmyt6EprgOFJKUT744ZAtGyrFaWV_g7_uWfYp9qsNtizB9s>
X-ME-Proxy-Cause: dmFkZTFzt7TS2vT90FpU+LtFc4lcSYazrsq+Z0LCWRLLscyNB8368RNsV8+hdzYoZ2ZWl4
    uhggWenV2Qt1iOhQs4E/SMqpAf/13cNCxdZLCYG44dqDGHcNoMez7QTaRZsm4Joj6kH06r
    kY8JCpyN8XdOhmY+4c/OCa4Vny6Uw1z8fIW5Wr6L2rkgrJ8iVO6zMAXgYvwLWOAUMxEml/
    XEVRzIkc2/cEA738YYNh/vm6Px7wGrvOaj6v8yrQquptMtJ1N7P27PLWfiZMpfln5s7s/v
    46/LWbG6LSUFCy12nQWJ9wxQHQ6GHbQy32cv7/F6hGv3FTxC+H5jdS1CemOJSMC/wLlKt0
    YceTvozDbG2/49/nVF+WNCT6BPm8Ibyg1CK9pVJS6KgtLGOmRHt/9sYTeq556r2zWQftC5
    5ktLNX3/wMwTYJ463rXCgggBN/Cq6JyfTLADddvCMZf4VONya/pcAxHq7jbPhASh7s5+eb
    xOpPFJUNPxjIZiDcCRKW63/i4CmeyBfpVjiSsYjb45vr9MzlhMRGzWjv42jLPoBBTzJvI7
    tg2/TzWk3znF7VccEugdnn3dvXAeYrLx/nnV/D7/RvzoTegdP3nwOoaaZJiwqniS8pGTx/
    uipMT+YFGU4ogHx5Xfr9hDs6FYqUfOu0Tr9zjhKG5VOglbAxZ3t6FWHd9hLg
X-ME-Proxy: <xmx:TSDzaniAmya4oB0UhvOBD7Mrtxp_fJ-5LPmQbPhOKw-tTMA4kF47Vw>
    <xmx:TSDzalit4inzpBuicCMN4rc5UwWansGEnKkXajeR6iOniC4yGlqIag>
    <xmx:TSDzanKbds_Hx0FLRYowdHH93t2JSU1RioLaUFK2RUT_hLHztIhzTQ>
    <xmx:TSDzakH1PBKwFPUrexAwu6cz7sBZ9vi3B7TF151PdV1Z1CTBpGu-Dw>
    <xmx:TSDzak2cFuT-azCQBN1X3Mdwqmnnyd1GPhOQM3RV8LNH6ifmxdDa8p0E>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04CEF780070; Tue, 10 Nov 2026 08:46:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AEuMsLfrft43
Date: Tue, 10 Nov 2026 08:46:32 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <10dcd7e2-657c-49f8-b8fc-0c29fa55e6fc@app.fastmail.com>
In-Reply-To: <xmqqo6bxvdbf.fsf@gitster.g>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
 <20261108023730.GA1242909@coredump.intra.peff.net>
 <xmqqa4nhwstl.fsf@gitster.g> <xmqqo6bxvdbf.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 9, 2026, at 5:40 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> On Thu, Nov 05, 2026 at 03:40:17PM +0000, Julia Evans via GitGitGadget wrote:
>>>
>>>> +[[name_only]]
>>>>  `--name-only`::
>>>>  	Show only the name of each changed file in the post-image tree.
>>>>  	The file names are often encoded in UTF-8.
>>>>  	For more information see the discussion about encoding in the linkgit:git-log[1]
>>>>  	manual page.
>>>
>>> Sadly this syntax seems to work with Asciidoctor, but not Asciidoc. The
>>> latter doesn't create the anchors, and then xmlto complaints that the
>>> result doesn't validate.
>>>
>>> Doing it like this works in both:
>>>
>>>   `--name-only`[[name_only]]::
>>> 	...
>>>
>>> but...yikes. It's pretty ugly. This of course tempts me in the direction
>>> of ditching python asciidoc support, but I'm not sure if you want to
>>> hold up your series for that.
>>
>> In any case, I'll queue another SQUASH??? commit on top of the topic
>> until v3 materiazlies to fix these issues we have accumulated so
>> far.

Thanks for this, I don't know how to apply a patch from an email but
I'll ask in the Discord to try to learn how. Same for the other changes.
