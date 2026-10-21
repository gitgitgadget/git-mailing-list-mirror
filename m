Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599727;
	b=CPEUX1UzuhmyoBRBnTw9BteUlyqamar7CoXfjz394Zc5UUmaG1b64Glxge52XQRQORtt
	 i3JnYBTWr3uWLxk+oG338TSlT1XMOqrDzh5oqS4+HsEE9BwAH/QwYmR+1nxQz8LkLei3y
	 VMxWrErQJxe0Td5KY5VhIhrXdNXvt8Mhi9AaI3kf01/A2pNpF+62MT8TP0Z3EsPv79YJE
	 olBNQUZFjQ47a7Q3q2RsfYrGYEtihCJs92y8BedEu7WJDwWxGvLbzaErjSPVpdEreCpV4
	 cknOkb9rFRGV6tL0I8BMr64PRor3x/cmgA8fxa8RVBHIhpWBVFpnf6jITbWpNZcY77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599727;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1QiSPY5w8W7BtoH2sk2j+JZCW58mXv9snTAjLOsLy9c=;
	b=aNvFSJTZ14FdRQGkz8qnOx+0bn+9nz5S7D7sWRinw/t6fDtV9wXoFBTtSmqf3YbCCMXq
	 uxTyLBVYDuVs/rY/bXaqnKOkMwoG4vkZ3LWGh1j2cuhTSH1BrqPXU6FTXYMO94HXu9wFm
	 ZwAEkh1+e+PSqgAnPrlSVQXj4H1qG13e7K+fPCYsY8PMzxXQog6r+gO/k7pFRWvfBZvK/
	 cho8Rtroqrv3elcCshhSAlmCeQMzMYs1VykYTL3mwahKEHk4xIHxSxSKqg/cJuGbou5Yt
	 tESfPj6pGTOBFPNwaPXHqTFVAjslefothC53Ez+skRNzQEM4F3DaLRxIKnSyRoFckQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mszOppNB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=V6gdCxdU;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD468606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD468606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mszOppNB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=V6gdCxdU
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D57617A0054
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:22:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 21 Oct 2026 12:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792599725; x=1792686125; bh=1QiSPY5w8W
	7BtoH2sk2j+JZCW58mXv9snTAjLOsLy9c=; b=mszOppNB49zb8nKKl+3lZr56G9
	vMSoZVpmCwb4/aaLYsUbDPCveKXGnGA7dpCtzb6vMw1K+BE0qjnXdNOqPDLPhzTH
	YmF79qBgJpgyttTjsimFv9Th23/v3dshue+UIDkwzoG3mPSVdFzamtDEpM0II1Vw
	7CC4j84aUlb9XW8F2Kan7KGn3rMEz/7yMAlT3mnfyM8ukajZ2+Pzr28ZQ15bXOkD
	AAqctO+gtBzKkW0UIkc6KPjGC/4Ymk0WS7umN3Tl2AXv4VMTwJsS9QAQfGaGc4Dw
	nKJ1AFJC/tihGG+uA5gQhEVzjyKqQVeUCR7MCh/GAJCYmAKtDDBscH+xLUVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792599725; x=1792686125; bh=1QiSPY5w8W7BtoH2sk2j+JZCW58mXv9snTA
	jLOsLy9c=; b=V6gdCxdUHJmw6E92zjk5UrqvZ9foN3+mx5iS9N4QQ+GLIMzGbKk
	a7cfM+kDAu8vAvazfn0ggHlA6NYBuGmDS8RubceMle5CYTwfdVA52V2Wp6jLwkqu
	bo7U1TnKtiVDxI0EFZXVM/MY4o9nzzpDTX5HGT3dxUbMuKrEWeiBe1HzY8v/X0qq
	aJwF3WpfhyOkSBcE2KfhmcaHrPY+EigLYLOpIUuLFKmZrVmh3eugoTI+w3qpVMpT
	+LXJO7Squ78uZI/euBi1lgFkU+5AtD08RYg3TYqRxe17CJxWk97c/wSCG4YvSk2z
	ky54OBm7LczcwQ8BuMgZwXVRTCGlAj6HwVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792599725; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:I9Vq1Pb3suV5LAjLhmcfH+ugCL15P5Pt4NQJh+D/A/mOLI7
	gFjFqRtcTArmkBO0DvalejoAbhzS7b8tqM1b4LlYss7b/B8a5lPpSh/cLU1VGmc3
	DgaejKVfDFolG9VPoAmDyyP09w4EC5rSBWtyN2W9kgv1RftYqbDRvsTxhgaGUnZ1
	4OB0jDNfXI9p3Q/eXa5IvNR+zoij1O0JjKet0CDTnxsilgZ150AhB3rSkhOoxcX8
	VdWQNRLEyob3IEvQmu6vx2TK0tFCzvWS/yz1snGY1cJbRx8/vXKNRvN0pBO4TTq/
	xa9c5G2w0wRLvLmDyiYV2YjFhfr/thkZ5aZCXGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UyHLjlpfHLwyfDbP0mY/r8RGlEc1lnxy+2KxelS5PV8=:CwGGvqY7Rj0BB9wRCvpUrhbcpNmYF39qFfr6OBUkCoA=;
X-ME-Sender: <xms:rebYavhDrZsAqJMDapGYHy-wDPNTC5UdxbfDkVhFsxEwO0an-6AWuQ>
    <xme:rebYaje4SF4q1HWdl1Mlo_R1UQSRQiPVRNTcfgp7GyoPlFQ1Lwp98rnwhA453eimC
    Vb576JgTo2tzXGOGpa79ED9ZEC-zVVdB-QzMqj35fLmEBHHVrntY80>
X-ME-Received: <xmr:rebYasfhqTOaaMafS2UgaNnZwpJZaQI55791q8k-RlW1KctEvez3Y8LRN_ooZyueObws_LFQickp69Mqfv8RJgckXNci5ZyAfuf7>
X-ME-Proxy-Cause: dmFkZTE7t/4Zsget9VKVoqQo6RUw4wlZbtWfaxNJrk3fsGwIcDP0WXKl/igPtx91uNPxxh
    WbQG8GeCdExcItcnaObEj1AYuTooqWTtJN+q/2RvIGwYHUD9aBtZnHxj5MrVdLimbTiDVP
    oGdPDjas1npO4cvSvyIWXXJzFrWTA5kp6s5OifWw0OLAVW9B8t2HZvZ72dF65Yu3KUlUCA
    +h3Vj62CIjFE/m4Ru5yz+6sHyGVLaXBtDbypVBoeWO14EhYFr2LV88mvresiGWfDgiHM+i
    yaKBRaaxuz6Qnb4f0sgj0UK3uoNkA2ZmegSgAgdUulg7n1Im2wLRi9WuyYjReXKWMeD7M5
    77HKoFB+SBTTL93xlwuT1q5LkztB6DTYK1sywY9faeCjxzl/8P/0nB+Q2w5dwDDM+NEan3
    HqtsHlg2bIA0Ua6cUvKYDVrkZY4MM/1VJPYEtKuU8I9qiY+4mGEbH5juygdaeSsssyzdAN
    SobH+7O7eceqgKUdilikEnqx24rOr21fTrsj4A6vGM7nxdHQM5H7FSEHJPqwTHFdeSL66X
    AQE12Z1vCIawyjVoTjILzhraZsJW/oqCdarY/JQpbEkbdmdJ4d0IzGjpixBjiz+6FkCcSc
    uPqYXSJT4/n3d+8DHd5MYSKt4fh06hDLWk7Q5LxktmOTsAmgWOoU4SChy6eA
X-ME-Proxy: <xmx:rebYal9vbD4KCcF6I5PI6hpvAXWfLbiSyf-n9x31MEBZlf69OYlTuQ>
    <xmx:rebYaglBMHiuAP2-MB6Z5qzqeQKkLeEj6ezsmtKcOVpCwSyXoXR8MA>
    <xmx:rebYav9H11P6kz9it1v5PPWtpmKBxWfskwtZI9mq1IFU91YbWdsHlQ>
    <xmx:rebYamnLPwynWwoVSSHb_XDiVYlChzy71FCEyjYW8ousHdb1_sltqg>
    <xmx:rebYarmNL8aUEVdTQIFg_NmoHh2yg08epnLLuTuv1w6SOLyz7lRMAuR4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 12:22:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MyFirstContribution: clarify that "reviewing" is
 a discussion
In-Reply-To: <ath8r6RX0u2Uq4x_@pks.im> (Patrick Steinhardt's message of "Wed,
	21 Oct 2026 10:49:51 +0200")
References: <xmqqa4o94e0r.fsf@gitster.g>
	<20261020232242.2217109-1-gitster@pobox.com>
	<20261020232242.2217109-3-gitster@pobox.com> <ath8r6RX0u2Uq4x_@pks.im>
Date: Wed, 21 Oct 2026 09:22:03 -0700
Message-ID: <xmqqecdjqb10.fsf@gitster.g>
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

>>  [[reviewing]]
>>  === Responding to Reviews
>>  
>> -After a few days, you will hopefully receive a reply to your patchset with some
>> -comments. Woohoo! Now you can get back to work.
>> -
>> -It's good manners to reply to each comment in the mailing list discussion
>> -instead of letting the next version of your patch be your only response. Tell
>> -the reviewer whether you plan to make the suggested change, keep the original,
>> -or pursue a different approach.
>
> This is a sentence we lose in the rewrite, but I'd say that it may be
> useful information to retain.

Hmph, "communicate your plan" certainly is half lost.  An early
section ("now-what") advises to communicate "I'll do it differently,
disregard this iteration" to avoid wasting reviewers' time, and the
rewritten "reviewing" section somewhat hints to communicate other
kind of plans with "your reasoning" in

    Do not start coding, much less send the next version of your patch,
    until you have finished discussing the current round of reviews with
    your reviewers.  This saves time for both you and your reviewers.
    They can respond to your reasoning before you spend time preparing a
    version they might reject, and they will not have to inspect your
    'v2' to check if you addressed their concerns.

but it would be better to be more explicit how "your reasoning"
should be presented, I guess.  How about inserting "so that both
sides know what to expect in the next round" to clarify what "finish
discussing" entails?

    Do not start coding, let alone send the next version of your
    patch, until you have finished discussing the current one so
    both sides know what to expect.  This saves time for everyone.
    Reviewers can respond to your explanation before you spend time
    preparing a patch they might reject, and they will not have to
    inspect 'v2' only to find their concerns unaddressed.

Thanks.
