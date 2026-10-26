Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018193;
	b=xgX41bm2tro0GCqQF7C7Jlfa9xqo/u+KL+2d1F42KjUaE1XQEs7JeT/KgO1C7KnDPJ34
	 49gWBzDLQV85MUWwm1CtrNykNTumhJ2xVQ+S+6N0IazCmzY0mdStrgTG9wdPtGp7Kou1b
	 aPUuTau2IAKjy7wMY4WDXm81teVjmchgSYvc662pVvnhhjk2gOJ/6WYlcaN+jS6lmP3ep
	 J5kb8uLBFH6G7OETj9dgf5FBer+hZn4yTgau+Azb9m2cJtXRXcXM8yQw4vYctyqn/+Xq7
	 BEtx+gFaPCIWHdfk7IXUQ9LSDSvvQyfty+AF9/0e+eScHxLpUmXihE0Ob95VqwFfa+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018193;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=hiuU819+isgEzBu3/deR1N8J45ZMvCr/d+bRFOQZw/4=;
	b=lIN8/u62muPGz9mWidPl37Wb+a3CzyrYRVhCkL/g3jr4hpKoFkR936r6EveNSqWlEWeL
	 9XthOrFeIsUPOsRSntzlWg2HWONtjyZuZtNyVlJEH+aevTYEjR4I/6MwQaZYFu6c35pjr
	 gBDdeXtmM3ruFcIABVobX2wyW020mgnQJfgtYSPjKH6kdNN7BB7HWfaDxh3NRfMbExHTO
	 dwdqvTJfWxbzHDvpPPFpluQl5KZ6W0X/09L07oNrNWOUMLL0LIVdz/12bZeMt2mba1t1o
	 JpX4l6fxsqMhP8EuT6aK3rT7YtvpLMZ7ZN7VSqJ1vG1OJmjfVu3Rb9hQp40zyiJZEnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=Xnf0CvvB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wsK27jHj;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C53606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=Xnf0CvvB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wsK27jHj
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 846B214008F7
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:36:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 08:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793018191;
	 x=1793104591; bh=hiuU819+isgEzBu3/deR1N8J45ZMvCr/d+bRFOQZw/4=; b=
	Xnf0CvvBpOUAp/H6UMVajXTWM82WB7pGGezWHgcfPcZ+Rz8VQ4hJN9+aFOJ3z0Vf
	g2N7D3mxuwZOsxOZzulnYzss2FYa5geeKpjAOE8trAuiArPJoMUwB4FfW2Mk7S0J
	IK4+LQnAAQYy0nwTZt1L4N5Rgl30u5R5+fYw7R1QO0Nv0eKaofa7bCKO6JJdKf5h
	lzWXfn7whm134Ts2BDAPbMKZ9x4eN5IC/6mJxxRqW0gpgdwPtIUSlTOsEgFMSOI7
	XUqs2qGlN1RdbB4mT4QyhqAVQ7ONZ/sjgq4V8ZyANsr7YXEKmEqvIpShLUrlRFus
	M0obbI8fAe0aVv5AWSZdiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793018191; x=
	1793104591; bh=hiuU819+isgEzBu3/deR1N8J45ZMvCr/d+bRFOQZw/4=; b=w
	sK27jHjP9p5YB/0KSzsvK4BDFIWC1+jHdiLpexg517v0l/tVwGe040nqvR1Vm/Mh
	DhACVRHILerRQ/H9Vuu3CZiLOhiJci379h94fyZLH0eMIPAc+5KWm+BlGdXCb6k+
	Pyf9YxzPccTtRijg1lIG6ieFnNrNSyANzduSu0aghXtfi4UIpwxZ4B3TkRAtp/tr
	FxBtWx404BFYk4Xxl1p3ztA2w9lJiBIE1W+mEYofaghDznamZttrP/rVujN6asD8
	pw8bXZdcWyZvYMqzELs4ZMZKBFsnVCRbMTQJZap/Fv0p6UpL7snU++0pDVuho6xL
	H8F5WDdlkYbDX3V0oRB7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793018191; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QKV50EbuEROPNyR5+02WCycEQ308Xw2y82O/PlHd8NU3NHr
	Bl1gFVQBb8fEEzoRYbM7ExWHdDKEXufl1Nt+19mQJLYpy7JouHfeTqBGRGBMzp7S
	N65sKgl0HqiQ3IR0abQjppu2va4hmTUvABb9wb6Oo8T5xX1a0b5HXT0rXdczAVPt
	AEZy/y8POBoO+zNhpBupwdFCncEbeEZuSw98sdBBmt/CKmDnJLE7P7RkRni/yWyO
	OvkqmN7m+8756bJknGbTgp6Q4b0m8XviLTB7TQPrYZNLsmM7Mq9iZ2G+9M3aqr88
	WgWvkuf3YkgyQrYhPs4iBFDM71MNo/ineq6aryA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:niIYgoKD+uXWsTbT1sc775B98e/iQf57pLtl+8HZnhs=:ofou+wupLcm8divuwogEEEaDxK1FaaofZBjWAvFGpQA=;
X-ME-Sender: <xms:T0nfanfVqQKjYm5Albf5MxBmCb203rFlKN7u3Y6BobpsueCMZHU3lA>
    <xme:T0nfaoChW49oZTkx9u3uqQRxqVBzBUqNphUwB29u12wnED5dyNf6a0IYcgdkygG8h
    P2B-1f6l85zVcScqG1-N1Efor4V3gGKWmF5M5cNt-n6yvWhXnQDxgwK>
X-ME-Proxy-Cause: dmFkZTEz9wLAOlMqO4b9HKsmO2mk4oVe/AxLzxlrfSolnfYQZH1vp4AaVniONttZ5dD1Jr
    POcI2duR/erQE9OFZm2PDt0PKO3k+DcHkoCVV8zFsadKJqeGU/f535H/rbNSL3S5FN5WpT
    kCXs7/bdbS0MZDLag/mIplO3Q5PpSwGTB3aHFK9tGXtpm4K3G86o/PAb+4xU1MxSMoUAI3
    aeDxRo2eopBf5tF7OOwU5lWymnabcbkV348AVlC5KPUwDdVUqjIcWBgd4bCIctqIXr2sL4
    y9Ci5t6CWjSX1ljFksMNXcb6WARolBkfIEB74NaK20lShHj+7TB7r+lDNu/NpcFkj042O6
    HNTfGKva/5iL8364hTIeEnWiWplqHA54oatMDaexaGMqGujOwdVhBPhOdney4M+Vr3iSGm
    gYELOSV/Infb9crd5aOuDl3cZtaY4r0BDNfznOyxfpnmp795vsAnlFwmMmuE0JUSCe3rPk
    WNC67BDfafJWfgWlAhwLpiKgcWEVv296oAiiLgN45iMTsYWIymJBMYBoBdbfkEg3XnqVem
    oF6znIlhHH+zfMKwu0+o60G1Mwk44K+z/2FRsJSQZyXfBbKpKGNCFQqY6MtYO6QXvJFmGb
    bymtzo56UMmR9hyn2fuB6AMg+7CKVOdvdhXVMkca40Iht1jVhIFD9VqocBLw
X-ME-Proxy: <xmx:T0nfapKJFHXwcWOa0c_Caf4tKBp24GugFi0aFUSdsd17kvVUSh0MzQ>
    <xmx:T0nfaucu3Z9-a2dD1AVcoI60_Zv1RLienWyWdKssEeT4zRSK2p09oQ>
    <xmx:T0nfao9Rur6DWyaAAtSFZ3L6R6-_t0kGcf9aumXiDqABA7Tg2DkIdA>
    <xmx:T0nfarpSn1tw1zeMgkU5xnHzXBHqMw5SgvKzbKE1ibIS90s3vcYHFg>
    <xmx:T0nfasnTxx5HTTLFFSBf1Gd4MzVJm5K6CoGSnrKpHef8ouL7v1hM3QBB>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45291782738; Mon, 26 Oct 2026 08:36:31 -0400 (EDT)
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
Date: Mon, 26 Oct 2026 08:35:47 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <2564bcc2-2f78-4ea2-9b6f-c033e95983d8@app.fastmail.com>
In-Reply-To: <xmqqtsmc44c1.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
 <486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
 <xmqqtsmc44c1.fsf@gitster.g>
Subject: Re: [PATCH v4 1/6] doc: add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 23, 2026, at 3:14 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Things to potentially improve in future docs revisions:
>>
>> - The explanation of zdiff3 is unsatisfying. It would be good if we
>>   could have a clear example of a case where zdiff3 is helpful and a
>>   case where it's harmful, and if we could give a better sense for
>>   the reasons why users are actually choosing zdiff3 over diff3
>>   (or the reverse) in real life.
>
> Is this a stale comment?  I think you reduced this to just a side
> note that says `shoter but ambiguous`, which is probably good
> enough.

It's not, but I'll delete it anyway because I don't think it's adding much.

>> +[[diff3]]
>> +DIFF3
>> +-----
>> +
>> +By default, Git doesn't include the original code when formatting
>> +a merge conflict. To include the original code, you can set the
>> +configuration option `merge.conflictstyle` to `diff3`.
>> +This extra context can make it much easier to understand what's
>> +happening in a merge conflict.
>> +
>> +Here's an example of what a merge conflict would look like when using
>> +`diff3`. There's an extra section (between `|||||||` and `=======`)
>> +with the original code.
>> +
>> +----
>> +FRUITS = [
>> +    "apple",
>> +<<<<<<< HEAD
>> +    "cherry",
>> +    "mango",
>> +||||||| 1c22e48
>> +	"banana",
>> +	"cherry",
>
> These two should be indented with spaces the same way as all the
> other lines in this list.

Will fix, thanks.

>> +    "mangoooo",
>> +=======
>> +    "banana",
>> +    "mango",
>> +>>>>>>> add-fruit
>> +    "orange",
>> +]
>> +----
>> +
>> +With this view, you can see that both sides fixed a spelling
>> +mistake in "mango", and each removed one fruit to the list.
>
> ", and each removed one from the list", I think.

Thanks, will fix.

>> +This makes it more clear how to resolve the merge conflict: since one
>> +side removed `banana` and one side removed `cherry`, it would probably
>> +make sense to remove both from the list, like this:
>
> The reason why removal becomes the correct resolution is not just
> one side removed, but the fact that the other side did not touch
> what was removed by one side.  The "indifference by the other" is
> what makes one's removal the preferred action by the semantics of
> 3-way merge.
>
> So, let's rewrite the reason a bit more tightly.
>
>     since one side removed `banana` while the other side did not
>     touch, and the same happend to `cherry`, it makes sense to
>     remove both from the list ...

I tried to edit this (like below) but only ended up removing "probably".
But "probably" was there for a reason, since this is a made up example
and in the real world you would really need to apply some judgement
to know what the right thing to do is. I left it as is.

-side removed `banana` and one side removed `cherry`, it would probably
-make sense to remove both from the list, like this:
+side removed `banana` and one side removed `cherry`, it makes sense
+to remove both from the list, like this:

> or somethig like that.
>
> Other than that, I did not see anything questionable in the 6
> patches.
