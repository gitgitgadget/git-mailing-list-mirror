Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342168;
	b=pO56Pp4x6JqdNnyI6RPGKMI1Ww7/77yztuku5JjE3dd+odpwXCRnrdBR9j7Q9AnTTRwX
	 wePe0Q6RDYz/GRglGDcvIDBAF9aNhHvaLi7UFsspLm1JeBUt8UeoZ1WiyE1ObIW+1p4Wj
	 /4dJCez0Y0jwxo8WfFewdHJ89e+yxLPG2A+TwBxdqw2RT8bRK2auYkx6peoPYqP5wfy0p
	 Fovpk3xfv4VhrNvGzQ0bMLuufbLPoBu13k+D7qXilD/otEPeG0GEeO3Pv6J7bXGRkQcma
	 FrGyDVhqqCMdNSPPqXya+qm3WnaIQer601PwdFc5hVhvHzybb4cKSP41oK2SY5A48jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342168;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=jx3fdG58cwTLk0WWq4Ont8I+Hyi5O6YW8lg3lHhpbeQ=;
	b=jU/BGOX/rzM9l20FdVAEld26Mn/i20Dli5NS2TrsX4sacbItSt4Mjx+fgaVvxnmDq057
	 pNo/4+ax10TFOzhypj1UOS08IRNnTW8pLDxQkz0swy2NXGvRoGK5m4o1L8e7vJdWmEncX
	 Y7Rlp0tvV+YnmjmW2j4i6cLPsxQFtg7LQjvxBrMv5RoYTwS8Vetp+fd607KtaRl93HMC7
	 uiOIIRCjzEl2HcfHx0l8aiasdKabwfpCDDm8BZ2BTbc1+E5xIXkxtQhw94hrm83Tq7JfU
	 5Uk4RYpB1lrUuH7LWZpjda3Oducki+pC/mrL3zrUEgcpm1WUlczCBDR0BqrNppuvy6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b="FRMcw/9Y";
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD4606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FAD4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=FRMcw/9Y
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=goXnkH9zc41KAlBlVOSfcVMqnS+c7QP+vUR7KDz2qu4=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793342163; v=1; x=1793946963;
 b=FRMcw/9YHQ7oAv2BpUkK/t9SEyVt1+RwLWD3VnZrCMbmPrINQ2ahwTgQV7zu0y41wX4MFQoo
 uz61S2tTlXiFiwwzmjBGds654UhNw3Rr55ZI9dD/fcERJHZeg0gj1A82x6pQBsZMd7Ss3v3MqJf
 4YardjVCbBXKk7Q0lFv2UYLM=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 685d01edf1c908da;
	Fri, 30 Oct 2026 06:36:01 +0000
X-Mizu-Trace-ID: 685d01edf1c908da
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Weijie Yuan <wy@wyuan.org>, Tuomas Ahola <taahol@utu.fi>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
 git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <atysi3EHNTCUpvrT@wyuan.org>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g> <20261024111856.8s8qu%taahol@utu.fi>
 <atysi3EHNTCUpvrT@wyuan.org>
Date: Fri, 30 Oct 2026 07:35:45 +0100
Message-ID: <87ik2jzoe6.fsf@dev.null.iotcl.com.invalid>
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

Weijie Yuan <wy@wyuan.org> writes:

> Although I could selfishly say that I'd like to have a vote, since I
> might just meet the threshold in Junio's example, I'm rather afraid that
> I'm not qualified enough and don't have the kind of foresight like Junio
> and Peff have to justify having an equal say in Git's direction.

Well the voting system should allow you to "abstain" when you are
allowed to vote but do not wish to cast a vote.

On the other hand, I don't think topics on which Junio would have a
strong opinion about will be opened up to voting. Voting should be used
in situations where opinions are spread.

-- 
Laters,
Toon
