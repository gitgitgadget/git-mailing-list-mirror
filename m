Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCAB67E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545511; cv=none; b=hC8L2RQZaHozK6LgNODnNco4q0b0cW8Vsi+LFOPz72Y/S/ChdCRAlJZ7X5H4JnML0QSDnHM+mrN+OZloj87Qykc+p+npXWVxpZTrRDB5FvVXH0BSFIhZ/kI+xAjUxYiOSbRhCDQ+s2UZbuIHSUksEIeI5cq7GHvAzoloYYfaV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545511; c=relaxed/simple;
	bh=vgstxf+DOHPTabKemse2DMyinWCAo7RZGGTuD1e6IIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mweCKzzFNvDD4Ec9e8B5oL0OhHDM0sqUfknh7E9qHeQnGjICKVM8Y6CgaqHPQ1+iLMadoT/QfgjlTjE43GHmPsIrZVypeM/0PbNpdphc2GF8X+QaPpUtMopGQXTxnk7DrgG7Ez9WOTcGkoV5chwWukY4buMn15VYKftEolPmSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name; spf=none smtp.mailfrom=mayhew.name; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kH6Yr1RZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mayhew.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kH6Yr1RZ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 831241140208;
	Wed, 13 Nov 2024 19:51:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 13 Nov 2024 19:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731545508; x=
	1731631908; bh=PPfRjR6f7FFdyq39f+Ob9eIHSVlcekccccNub3hu0Bc=; b=k
	H6Yr1RZ0U+32nVcQFbkw//ueR1C/U8aCzs5rS4AQz/X+yxSyye8hBGCyyNhXTFUj
	vW1RHo7CgfNB+NXdyKqTtEJJA8lA7D0k1uVo8sjs05pv0ZNwVukWi7QxUvSmIdVg
	dkZPkr9mmu+LJYT/3DJXZhjaw1OtlyIjfO9rIIN+1lyQXFE9epW9aFHkbZsZ0Ku3
	VLaJhIwaQPq++y8hN8FTHVk0uIJ/dvvCA4p/HU8zCJK0XHxFYVB8kVqTz/VGnCxc
	+xTuoDMi6VobIIy0Itf1FTpsfG3dG1rKJCB323dWBH93kitahA7yDaIIFXu4nPCe
	emsd15Jc/1v8y9fOUpHCQ==
X-ME-Sender: <xms:pEk1Z9QX2IG_AesE0OCnOSQ5nbNpAnHZxpRLk7DDakZCK0ABQ5DDtw>
    <xme:pEk1Z2y50IVmCNQFSglOGrg2C6R7mwE4PEmUvWdMqSE0dFjjGyuIoR-vxYPCIVAu5
    k4-qvLfTFJ5zY5ebfg>
X-ME-Received: <xmr:pEk1Zy1TZg-_ICZFWNv9rK247J4hMMFQ5Y8k_yj4QVpOZt25EipL2jClHV7d6jbTrY_rnZYc_6T44jwiSYdLXn6RgMu-yrYDqIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomheppfgvihhlucforgihhhgvficuoehnvghilhesmhgrhihhvgifrdhnrghmvg
    eqnecuggftrfgrthhtvghrnhepgefggfdtveetudekjedvudegjefhheeihffffffgtdfh
    udfgfeekkeefgfevleffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepnhgvihhlsehmrgihhhgvfidrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomh
X-ME-Proxy: <xmx:pEk1Z1BEq3WDpA3qlCj3kTcN0uvyen5XKwJt5KMZ6_33SLPPI9AC-w>
    <xmx:pEk1Z2i6T4_JX83Zlapx7S9WDL2hIcDUZF3mTtKRalOZE0TzJgi5GQ>
    <xmx:pEk1Z5pqMi94AKMOBeGSnwzsNKZ_umxsta_wcwBjL-fGzhVQTuCvsA>
    <xmx:pEk1ZxhR06iCY2ayZdmzO9q0bN8DENOP2TrKRjZvI9JfEZdxtApX-g>
    <xmx:pEk1Z-fqBPgMhphkGvbmBnZ39Eq1a5hyC_sVuvvYI9E1obC1KYjnEiIz>
Feedback-ID: ibb8947ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:51:47 -0500 (EST)
Message-ID: <c2f97b19-19e6-485d-91c8-24c261aedebe@mayhew.name>
Date: Wed, 13 Nov 2024 17:51:46 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
 <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
 <xmqq5xoqahbx.fsf@gitster.g>
 <20241114001003.GA1140565@coredump.intra.peff.net>
From: Neil Mayhew <neil@mayhew.name>
Content-Language: en-GB
Autocrypt: addr=neil@mayhew.name;
 keydata= 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
In-Reply-To: <20241114001003.GA1140565@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13 Nov 24 17:10, Jeff King wrote:

My previous message crossed with Jeff's, and he already addressed most 
of what I was saying.

 >  2. All of the people who are going to clone your repo, who might need
 >     to follow special instructions.
 >
 >     The only reason this hasn't been a huge pain in practice is that
 >     almost nobody turns on transfer.fsckObjects in the first place. In
 >     theory the people who do turn it on know enough to examine the
 >     objects themselves and decide if it's OK. I don't know how true that
 >     is in practice, though (and certainly it would be nice to turn this
 >     feature on by default, but I do worry about people getting caught up
 >     in exactly these kind of historical messes).

This is what happened in our situation. The person had 
transfer.fsckObjects enabled but didn't realize that this was the cause 
of the error. They assumed that the repo's *current* submodule 
configuration was corrupt and was somehow causing the clone to fail even 
though they tried explicitly turning off submodule recursion.

 > We did add the gitmoduleUrl check to help with malicious URLs. But it
 > was always an extra layer of defense over the real fix, which was in the
 > credential code. It's _possible_ that a newly discovered vulnerability
 > will be protected by the existing fsck check, but I'm a little skeptical
 > about its security value at this point (especially because hardly
 > anybody runs it locally, and protection on the hosting sites isn't that
 > hard to work around).

I also think it's surprising to have fsck check the *content* of blobs 
rather than just the relationships between them, and to give a blob 
named .gitmodules special treatment. It goes against the philosophy of 
"do one thing well". I feel that there should be a separate tool for 
checking repos for security vulnerabilities, and it could be given 
additional capabilities (such as checking the configuration as well as 
the objects).

 > So if it's causing people real pain in practice, I think there could be
 > an argument for downgrading the check to a warning. I don't have a
 > strong feeling that we _should_ do that, only that I don't personally
 > reject it immediately as an option.

Perhaps there could be some additional warnings in the documentation for 
transfer.fsckObjects to make people aware of the potential costs of 
using it, particularly the existence of legacy issues in established 
repos that would prevent cloning unless some of the fsck.<msg-id> values 
are set to warn. The documentation currently just says "see 
fsck.<msg-id>" and in my case, despite being fairly familiar with git, 
that didn't give me enough to go on while investigating this.

It might also help to give some guidance on how to track down the object 
name(s) that fsck lists, for example by using git log --raw --all 
--find-object=<NAME>. This would help a user to make a more informed 
decision on how to handle such a situation if it arises. In our case, 
once we did this it was quickly obvious that the problem was a 
historical error that had since been fixed rather than a current problem.
