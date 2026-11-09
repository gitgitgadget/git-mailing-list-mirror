Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260938;
	b=21lOhTJrUzKxzW0tUlKMwfIHs3bud8Urv+WTZMixTH5aPtyugb1pu+yRfBaXuOAkN6W6
	 9hE26/Gd9GLgt3MwIlHlBXBKfTsOZtttXIC2HFniQbhslBgeBBVBMkzINzWnP6Vlxc21Y
	 8wsiMiyfS5YUHV08C/Szh0hO3Y95umh3U5phhbrBLxZp8nnebQUPAP+/TGV3LQgwdh9cI
	 h/AzPpYfaXMZVuARpiL2AhMjxdf3sM7nSP+eDM0Nv2LjrLROPcfITExvw6V7zB+PJO2ri
	 PeEdKfd/EOMkB+SiSO5bZn+9TTPQ7wci29OkldRZ2byLeliK/ZT/rloSUQDwtJ+nsUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260938;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=zoHloxqrm7Ns2wi+YnzbEgr/nB4nHBo80uFlZm3otHM=;
	b=LnYkwdIYoBBZk1lYyS7HuybA1/ICwjgEkwPE5+V7IRB6CarInPJY110UXa6aJxTSw20t
	 6DWCxs2JTLGiCePtG/49mmaCSfJzvEId3RyS0dGOObFO4Ouzn3AX5MjpiDNDO9//LTLAa
	 LLPtkNJSZ4VyMm/S4O63dtOC/H1I069QHJPDu5G5kY5a9Kni+UFq76YmrEi43hMSVb5vp
	 3RxSXobETDTOmHOM0AX8mkuvHASxAQplRQCPEf44wRaWAvzB3WVyfbRyVHwEWUlNUdM6r
	 VFtqkAZ+VyV8Vcg4w9TIt1vVxHs4EWUl5NrfVD7lSOIclUhKAcAYozDLBT61k7xOLdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=viHjYSNV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c22u6K9H;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AC606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 21:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 709AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=viHjYSNV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c22u6K9H
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DD9014001E5
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:48:56 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 16:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794260936;
	 x=1794347336; bh=zoHloxqrm7Ns2wi+YnzbEgr/nB4nHBo80uFlZm3otHM=; b=
	viHjYSNVfmI/RfpRDSWSocRAoFFNQalwIbdYwsyAzDwnCySjV3QWipBU+G8PDExH
	7tp/jMtPShz8Vlxr7gAIOwQ1O9CD5qbb4USKw6MCguGaC3dTUSFEyW2HypI3Y4p6
	nSyX4dApszUIzMD7zeYYliB37zYPa9dVzNHO1I2Y8yU1CZ8wTOzacp3KA9kboMqG
	wt9RPuV/Y2128JpTTClvzK5xq0guQY2HYo0aguRyS3hVzQYk8GANcEdBnh20vyOA
	liBbKrS6lZbqSighoO0UvJhbB1VmaMD1r9UH07vXOaAxeRM4NOfIhqIBh5gnOkYg
	sI9ghW9kd8dd2S1fUWaOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794260936; x=
	1794347336; bh=zoHloxqrm7Ns2wi+YnzbEgr/nB4nHBo80uFlZm3otHM=; b=c
	22u6K9HBcSNpIR+VxMIkmS6D8jKh/cVG0BIVD509qK0XFpk21oHqkthSmiliKBmV
	ixz9dklTPHioX/5Jf2zMF1lNIhJvxQdlQ6qn8S1k8hKZkXuhsb4thGteNtWfRbeZ
	s+z1Rrckd4LSmSBZvTgLNRVTgK3BaEUwDFRpO8SJ0D0+UPoVlJo44iInP6cphyk3
	wvM+BPbZUY3N6l7YvK3gZ5E1Fe47lafQeVKiJ2vvh4NEzKoA6xXBvphrVxpcA9Ns
	PYv1GgEMYo7Z4H90RBi2uhlon52LR/0r52L6fhOVZfuCm71K9vtgVjMfN94qIIdt
	nm5mC56y7yebWWMMgQ8sw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794260936; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Iv88PU9uKNHEDWgdKzq2gzL6jLTICn3KVmZcjncTiPjjma3
	+e9G9byRBZAR94CyLxi49n0pRgNjHW2qsoV3trsmn7dXToj9hXmq//o4b+QJoXau
	0Z2YnjXD878Ybal5Y7zk95KCd9+qPPHtKjuuoTH5l7IWvDF/1sYtc5DMRQ43GRtG
	90lFydj4I2AUhTRp7j/gwACM3DtP9wd9KOzDedQVPSnjiOH8rpCqyObeE80wR+qM
	bXfNfw3EiiX0Pg1hKa+BBP8GWglbpQd2MfwF6GF0D+rRqNU19LvY8Hg8YqKNffU8
	r94CyCGNpTtlupTjBtYKvG35/A+Y0iLP43wZrww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:s1qy5a6wgSV/srN69DBc/XEQqAKNnb7WvBuFq0RjRP8=:WsYQ7nbXYwsv0QbD/bY9P6koGQ5bF0FH2HcRRtnRcQ8=;
X-ME-Sender: <xms:yD_yao2yjQ_jPeqRxtGDEmJiTHWSfeGT6dGaoxusrcbj96e2_VXYjw>
    <xme:yD_yat6HSqmNFmHH_D0JNXeYlB7jL2wUuF43PXqBJT2gJJFhu1F1q3H9VXqtMV6Uq
    6D4B77-UModlkaxeeg8BVUBS-_yG-PfxTKm-7j93JTSC2sLJ3FOhIE>
X-ME-Proxy-Cause: dmFkZTF5inzkh/0DU8fSE+Xe+SRaxjt4jRQWiMo/yRMhS0evqoU7lNoxL2vbyX9Sl+Q3RV
    P/3f/X7bB1ZHKk6vBgpP31JaS3mF64tOS4X73QU0aRTs2AYSnXuvPkFozwzBAPvyJhrYHD
    SQGUOSkKsX8dtz0ckE4FOrLcQ7meGnSFVhfD4OKces/ZMdtQSujsSrCJKBO4dSczYpi4rr
    6h+1cuhglnNl1chqwjOmMsTGJ31iVmsT9a+HWLScGcGiMsS1ky1LerVUGWGgux6NQD/MNX
    j2Y2ZsSyVKJ3/9Y5imH4i3POsuoj8TdCemYKNoPKYw3+5gUIlllwQkEs6o24Hx1Ba7VyQZ
    gUOD9hQPWbAChhMVBoDt6g5CKgYcByI27Cd8y0LdFjw61YVkuXegKj4B7rVtodTxjkboCq
    CDh5+/azCWpn7VdrjL6GUhoudLPLYZeAo9SblTeZIhVMqGRSaWbjB7OsUzGat5G8eUJEDv
    HWJCmsv8RvcxkJTAbBgNGJYWnzR5T2PRFFb0suHQe6cOsSB7WsXNLcQ8FxWHy6B4X/WHXk
    IV2FJ5bsOjbBTWNnLwmoK9IvDwNtUOJGijEruJ5QZlP6ZhXNU+S58JpD9iBgJds+VLdBoW
    V9RxE6rzQF/cMQh5ANkm5zUZZKR+sSYFgABpti1YJagY22yrsu5G+gT4+ukA
X-ME-Proxy: <xmx:yD_yaqbIPFhX8Cj5oNitrJxb3HndQuI5HAXasonuqyKxb9tFQUwAdQ>
    <xmx:yD_yau68z6A9NrXoWDwuL926Im_lCpEffYSN2m3is_WmzEwfqe8tIg>
    <xmx:yD_yalACr-AI_x45RHq7EjN2aXFlkhlCuKGex99Fj6Y5zC3rv0ilXA>
    <xmx:yD_yasc1VGwDJCmWjynyzQ3D3U-pju-Vv1TqczwLhL0nBdNTyUu0nw>
    <xmx:yD_yaqs1zN-EBJR4JakePE05QH26bITkvIvyugjac1ny9QzpcFkCSGWw>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52D41782738; Mon,  9 Nov 2026 16:48:56 -0500 (EST)
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
X-ThreadId: A1sfaQj8oK1o
Date: Mon, 09 Nov 2026 16:48:36 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <f7d4600b-909f-4dd7-94da-d525649a9546@app.fastmail.com>
In-Reply-To: <xmqq7bio6jb4.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <xmqq7bio6jb4.fsf@gitster.g>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Nov 7, 2026, at 11:25 PM, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>> +`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
>> +
>> +1. A branch, which is your current branch.
>> +2. A commit ID, when you don't have a current branch.
>> +   This is called "detached HEAD state".
>> +
>> +It can sometimes be useful for `HEAD` to be a commit ID, because
>> +it lets you easily check out an old version of your project. For
>> +example, a data scientist could use this to run an old version of a
>> +data pipeline or a programmer could use this to figure out when a bug
>> +was introduced.
>> ...
>> There are some quotes which use the "it's the parent of the next
>> commit" mental model, though, so we could include a comment on that?
>
> "From which your current changes started" is exactly that.  HEAD is
> where you started from (and can come back to, if you get lost after
> botching your working tree state).  Your next commit is built on top
> of it, and then that new commit becomes your current commit.
>
> This is why it is useful for users to realize that HEAD is simply
> where you started from, regardless of where you are going.

I think it's reasonable to try to explain that in both cases
there's something in common.

Here's an idea for how to do that:
  
  In Git, you can always use `HEAD` to refer to the current commit.
  But `HEAD` isn't just your current commit: it's also where Git
  stores the name of your current branch. `HEAD` can either be:
  
  1. A branch, which is your current branch.
     The current commit is the latest commit on that branch.
  2. A commit ID, when you don't have a current branch.
     This is called "detached HEAD state".
  
  It can sometimes be useful for `HEAD` to be a commit ID, because...

>> The second paragraphs differ a bit, with Junio's containing some bits
>> about clobbering extant branches and not needing temporary branches. I
>> think we could work something in there, like
>> ...
>>     this to figure out when a bug was introduced. By detaching
>>     `HEAD`, you don't need to worry about clobbering an existing
>>     branch or creating a temporary branch.
>>
>> ? I suppose we could also be more explicit ("build, run, and
>> experiment"), if we wanted, but this is a good example to start from.
>
> I assume you mean the last two lines?  I do appreciate that addition.
>
> However, we should avoid saying "useful for HEAD to be a commit ID".
> Being a commit ID is not the notable characteristic of a detached
> HEAD; the fact that it directly refers to a commit is what gives us
> these useful features.  Recording a hexadecimal commit object name
> (instead of a refname of a branch) is a mere implementation detail
> of that direct reference.

Saying "it's a commit ID" is a simple way to say that it directly refers
to a commit in a small number of words. I'm not sure what your goal is
here, do you think that statement is somehow misleading to users?
