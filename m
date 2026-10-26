Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026075;
	b=E5LjXB5Xw7lnmu7rLUlWopYpJYyL6Y+YX6s+kfsEsm1xjXqgrQG4xze/TEAtT0+31j7a
	 Yp8AtZW9BqMVYMlMQqJi226THuHIVaHA4yjrsf0CkEbenxkd1rOnOmjGopM6hs0DnBnIa
	 LKQJm5IZ4+afB4YJnSuUO3rdF2SFyySui/9zeA+h3KxZxeJpF0nqnc++sZ6KZM/PRJ7kQ
	 GT4lgijNM1QDu2Eyb02CZ9X8AmMzo9eOJ3TVn63QeDHJ8dQ64lGGPa8bbBRA9d6+2/uF7
	 eCTKfYoUGie07ISWaXMSqhL5BbxJQAmOdv+qTHJI+62DVwznorHLTbtupxGSHJlRa9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026075;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=z73pyQe0Z1wLPIDglmtTdWDcVWHaAELS9AMAbQ1XkUQ=;
	b=dced6exASNVfTklumtRcLQ9ePcF2ABFYetFYQeOLPypLMEtJZVCQlNxg2cmIdL0LZ9lY
	 27HjoBKMuW5hStCwwNctMWfYbi8yUpWqukk0RIp3tWSz68NMfKChGqwKGLYeUTeZDDGU8
	 /nayL9doPRvIDCbEyBrcJNu6+nJl3ybmeusbNz+RTLBuJQ79RJo0/wXYPb7iBh829go+8
	 mJ7ZpykIeSFGHKcy1pHzqlgl7CroWhtLarXbDXc329wZNUZ2h4YvRbxyOwFb12th3RyJF
	 6IfI0bhiYJcsmF240YOSHAijXDt9QFLs/TtUZbjonyUEuC7ZLNEtwA6N1p0w3GBbDWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=IJr79zr+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=awu+b6Gi;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EB606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB4EB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=IJr79zr+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=awu+b6Gi
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2ABD11400A46
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:47:54 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 10:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793026074;
	 x=1793112474; bh=z73pyQe0Z1wLPIDglmtTdWDcVWHaAELS9AMAbQ1XkUQ=; b=
	IJr79zr+UjCzL5srM5F9jLl3BnDNU6a5tgr+K+5+ffxDNVuO8JpW2QQaMIK6VRKh
	oD+Dffg6aiEU1jX4OT3uOAw919h1kNsqjyWgenlhJz1ZnWpalrBnpSmrpGEV4X/I
	gVZwZgFjR6cke68snpzHeDyf8U2MKLJw50SNTt2RdkA0/WohFPw+02OutSz+vMoZ
	DNQON9b9HMYiBXlaFSUd6n2/AqANRsPEnR+lF1PJM/P2mFzmfzIass4FvuyFY/0O
	LHTYwnwPirIKbi1AujDGeCUzasm1IjetLGXtzkrERin6YWfe39dGrGRw1ONrpaLn
	qXiYNml1GqvverYN/d85fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793026074; x=
	1793112474; bh=z73pyQe0Z1wLPIDglmtTdWDcVWHaAELS9AMAbQ1XkUQ=; b=a
	wu+b6GiooTn6diMInCfA7CjLHrZrBKVY7FwCL4+7PVHf4UX3fogkAPLeZIslS8Gd
	FAFdRyIRim4Vb1FP4W8B8O/g7uAHljxYpifmPx1G8pHB+Gv0gFjQ7ujqPVmWxL6o
	ezpQ3Zkqp3PeWTKA8G107ZksGDSuxEbHJdtN8z6jHnZvW57xoND2HIIbtYxjm1T+
	qrScX+hJwCchIs9gNbZhKA/kD3yjP+c3jO/yrPcWiZnGXMDvy0vJPZ/1nEeDlz4y
	fbcQoB+n0VAHCWZeK8tC6so2tG8F0A+lUKih1bQcRptTrAiMCt8mURFY/6Bdp7sc
	V+vtjW3+1kTnoEqREu0tg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793026074; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J26oWjwS0O8e9NZyDsS9UVJMrzW+IuahN4wBle0CQY6hBNH
	DKvkVUdHliWy7/MTpusE/JO2zeFrVYbSw8yY00Bgu40ngSH4STL5yYC6OxT+Js+4
	7oEeYNFHxRJREquQVk1Dx8qMZ8HiP9trYxo0ALwA2BNEP2Ld3zNEf4WXMxsDf01f
	n3x9QMZWITDoZHaxkLIRtEgLwk/tw3ieuKuog/IwtMCuvWEtpDFUu27QxVaPh4LC
	olDSSY7sCvZtfRBc3LGjrl0FQy1VCOPAErbOv9+wO1tP5n4i1FUBsLtnvu0C90ss
	edy5ZcdeJZB/0rFN6IZw3VNRx+Gck3mIFJrnqfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QB278tUo6IkjxSWKdAGJXJCT0cUKk3xUhAV4LcxORrY=:dX+mf+ddHjUy9mA2wfbkDzpjQhKki3RPp3eXlaLgroY=;
X-ME-Sender: <xms:GWjfand5h8Eb64Fm77BFlJOu4RqeAMZL3ooL5h5nDCh7vtz-cl-5HQ>
    <xme:GWjfaoB1EiXsEgnmnU0pLhK30x-DfjEAEZrielH5XV9Mjqlns1aCHCpusV3Qe-bEV
    gKcOKNvi9TxBN6mPc1kUwniopujy4F9jsjJVpL_xijSxvRdYz3rMk9b>
X-ME-Proxy-Cause: dmFkZTFcqOgfvKNg4XN1YAmTDYT2uoNZ6mGWXyCxaCGQk6YuMEt8aP0ZibNXtqRpfiP22Z
    /nncQhj54x730eWhApICl/loO4eGZxdzj0uNxQwWDmli3aHTKY7kmA3XvnJPBEK+Q20oIC
    pCD3wiW2LGSM3CNjozt4VHhMsYRDTOKdNt7KF36FamSaskELhXZyWdnAq2hdUPTZStsfpL
    TLWINVHSJrcRoZWYq/PEH1hv+xv1hQR5mEeStqyxFiez34a5mza3+nyihQPKr9Zi/DUkce
    WXfSWMhrsEFNqVL/ACPvQ02Oo6k3QRY1wQpX8f9kbyQXrCKUoUujldLKfG7po/w5XJ8DWp
    zhrudM1xb83SnVxrKBHyHBazqkjDai8qJ0eAsvZ88V077+f2CORLSuqqGxKzZ5RBG6uyhB
    cPYG91kNXJpcnHYq5Qs9Y/N/g5XFb9I+nv+FmShgvODAa+yeNED1ALWcIHpkpIxlLweia9
    mC4AAIC8td36BusZ90ar08AUL8Iuoqpd2Tq/5hFd2ofnsms3AlxVLxV8vUU7kK9EZ/XZCM
    68sFEoK5Vn6E4e7BtWnaS2LcIEFkwHs4D3O7xgxQn9ygAB+ob0b+BtFyoCpSg07Vx4Mu2/
    zNRB417SlIO4QZDDCeZn4jYAijFWZJlEES8Oggl1bgp2dCBbEc/XFzgccc1w
X-ME-Proxy: <xmx:GWjfapKtZBLqhp1srO-413G78lqOLELVdCLoQ60SaoDsNzkvyHDeRg>
    <xmx:GWjfaueCVMuu2deFHCYyjXpBkroVEyo_Rnz4doP4dpN_U97sFH8GKQ>
    <xmx:GWjfao8VAeaJ373JNwqL9DRHmLzYkOvXT5cAQSdagLGWygBTcrNuNQ>
    <xmx:GWjfarrG2FggjCRK4IDsk6jcWXkKT7yaoIF2NeAaWKe1iAkH3_5ZqA>
    <xmx:GmjfasmnZnKSY81txjwWrEuie5cFI0X4_k8qg5CfhnjYIuuYk2HJ2Tme>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD71278273B; Mon, 26 Oct 2026 10:47:53 -0400 (EDT)
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
X-ThreadId: AndINfi0Ib6w
Date: Mon, 26 Oct 2026 10:47:33 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>, "Jeff King" <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <d330a5ba-cefd-4a4e-aef5-972a931d4d8c@app.fastmail.com>
In-Reply-To: <xmqqmrs0v87w.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
 <486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
 <xmqqtsmc44c1.fsf@gitster.g>
 <2564bcc2-2f78-4ea2-9b6f-c033e95983d8@app.fastmail.com>
 <xmqqmrs0v87w.fsf@gitster.g>
Subject: Re: [PATCH v4 1/6] doc: add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Oct 26, 2026, at 10:37 AM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>> So, let's rewrite the reason a bit more tightly.
>>>
>>>     since one side removed `banana` while the other side did not
>>>     touch, and the same happend to `cherry`, it makes sense to
>>>     remove both from the list ...
>>
>> I tried to edit this (like below) but only ended up removing "probably".
>> But "probably" was there for a reason, since this is a made up example
>> and in the real world you would really need to apply some judgement
>> to know what the right thing to do is. I left it as is.
>>
>> -side removed `banana` and one side removed `cherry`, it would probably
>> -make sense to remove both from the list, like this:
>> +side removed `banana` and one side removed `cherry`, it makes sense
>> +to remove both from the list, like this:
>
> Are we talking past each other?  I did not mean "probably" was not
> tight enough, and probably is probably a good thing to have there.
>
> The value I wanted to bring on the table was to point out that the
> changes are not just "one side did something", but "one side did
> something where the other side had no opinion on (hence it didn't do
> anything)".  It is the basis of how 3-way merge works and helps to
> resolve the example for removal of both.

Oh, I see.  This is such a simple example that IMO trying to explain
in more detail exactly "why" the resolution is correct risks confusing
people. My goal with saying "one side removed 'banana'" is just
to give an example of how to read what the merge conflict above is
saying, since the syntax might be new to people.
