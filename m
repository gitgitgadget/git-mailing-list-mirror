Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C44A2617
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104931; cv=pass; b=EnpifSpKgc65/vYwYOmzJm7XUTRs0zN7YyNZIPYjgrItCg9Huha6h0tlTfgB61L+b4tjTtR/wKovLdWsihFvSHdJJnqwspeL31d2zivv6qHhOtnHb7nzdLVbxPFZ35uIWyN/uaR7KVa5YMQoCSzpT19ovsfRAiW6DFLx3vNswH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104931; c=relaxed/simple;
	bh=zPStDCBAHhAfYWZMJoeANvvUBhDlsF2kkEfjzP5id9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owpNMTL9aCq8w27jVuK9U9UhGYKKXfSoaQbwlGHVY55vjRhE6RbgrXhpZ90xl7MK4bY/WUxycdXRYeK+zar7da5ZwJGgguCkkvYIsIGTTPbN3YdExvn4D9opXi/CHOqy7AdttfT6PURMG+W0gN1x73LPzmx+gbpf5yROrkXZRLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1PopzNe; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1PopzNe"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so1453581fa.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790104928; cv=none;
        d=google.com; s=arc-20260327;
        b=nqdEn/hlGJBKtJ4f57Ze2u7P91G5dTKnIJsr3QjsN96FNxD83B943JzcBpa41SBi0E
         SSGzzblw5IVCEFfogOnI7pSwWePnRZqQ1EjAiCoC2ps4S43oEyvYxWfQZbex4A0wvqNy
         k27PLm80HZl24vubgJBmL/tLx9/jICCu7OjeohmfU/QHz4ULvI4zebpDvLvlPRMb4xng
         AxtrTrqt9iqv2atibNKOm4A+6s8mrZLNGpOL8QkfCJVTr5RMZe6GANQl4RhM7jEvBqMo
         5Lqvp17cJ6Be9cTbsOKcv8yPo8QVPQtD7LOt4ZQZtqg6Wt2fkYHpztB3M5sZvs+6ULsW
         ZGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y8+kDE1tTLlNm0ssPrVkRH3dWT8AnUjHekUOcP2INdQ=;
        fh=jP6GnpT96CS5LDUFNHoKuqDubThNTnMLb4lp7T4VQJM=;
        b=jQm4UN/KjAaiwsN4F+l+Q9oSEBhVFi6h6yJDbPM74Ps7+PclMKNXnsSvAe2wwXTrMX
         ENg1ri6MicfyzGwfYrZSPvNEnK87hpnFDLzz7QIBFO3XEQ3yZBT8Qnf5FKEPa0p3EyXi
         dD1dMZTRdB/w3aRDwLRCHAs5bpzf9E+M/LK/Pe13pylD7gl0DEacntFKJj/JBeMzq5At
         bObeQvrxM2y2A5oRDgLnwu/a8ReEzt6dm/MlL4tnczsIRl0om8UEya5sqITEhMrq/1n6
         ctDPptJfOq6m3JZL8ANgfdEDZzKWCaQ02ISbac2NaRSeeW4SVW+LQL816BSmhAID6VBh
         UIpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790104928; x=1790709728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y8+kDE1tTLlNm0ssPrVkRH3dWT8AnUjHekUOcP2INdQ=;
        b=n1PopzNe43lQN2PPOvOGngXP5yWfpeBOybWAWvNOQD1aenN+x0RhhysXAsTOox8lXF
         K9bhysZ+jJ0MSq2eRUeA6Fbc2JgVt5sUPZmZW2nWihragfFnRpkBSyiI6iSOCsCWzZRC
         dInnQYUSrAy1XiIgZNhSZ6OtZ2voDnaQ0lGEX3qz855ErbAgqlgGP2lCVDf6U9pxjwhj
         +neKV1g4U1+5j1CT6RkOCliasQT8/Og30e++6+pX3G+j8g/itOFOU67AGMDL1wLSVa1I
         JuOnZE5ruBzkgrfeL3aYZ8PP0cZ2dlFGd9btf/Wh75S81Lex6AwY9cVdkrI6dfNn8Kc1
         Bvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790104928; x=1790709728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y8+kDE1tTLlNm0ssPrVkRH3dWT8AnUjHekUOcP2INdQ=;
        b=1myYpohYu9qtFpos5A9v3NjAlWf8mdAu+jV+asi55O/Bii8BV56893L/mqieX3SOSG
         O5MrGUfja3QcxwF3V9x3q4Q8gRH8yCSkIL8vWcANku64pl1ODjWYIfx22mInq48XWTme
         6+cQD9VtmF/CWTilUF1V3CAv1I8Ue333KwbK7RuU+mFkhBsBQ8SOPPEIxNefyewe9tOY
         o4PWnqD7ZDa6TurJ4dTxqGyFR9TV5sFmHJHSs6IRHyNIB2sJDNM0ZL7lA7+hICSrYFas
         jgoztMnr0rZdvdMxycVxn8K2/Z1MFQJBo7ZEbv2btwgTyztjD9vwHLDLke1l7Vi1/wH5
         9HPA==
X-Gm-Message-State: AFuF++kts0f5s1ZTGE0iW2S5fywjTQ7oxADu8Zc7DwHvNbLf3ReNK5Lw
	BGOctWWBroKXj32VJTWpfRsHwDdJixMqoe0cZmsC3AQfoY7CzC9qJZjvcbMOBJ2Zk1Itop4fMqa
	yHLbeF2WRJBQMavJYSodyosZL9+pQsvo=
X-Gm-Gg: AYBFou0m5Vb2uxNm0HFF6pZ5S7TeVxwq1JFMe/i86bqhrNNhIFjRSAxi5PdssBOtHAA
	c0plcpkW1Xcysvd8XAgQwKWdjRvEe7aGpBcGrpfaHuxZ+972qykVwHGfIwUABAudFZwxrMyqEom
	QAgGaf/nUP2S0G0Y+xhvhgV25qbPVGEaQyT15oo8HwbfrsEZyOpp/O7Rdj7c8Z9+8Fk3LU9Xlfa
	/ozKwkzbQJ9oo4w+KrlIYajl6lzBnPstuZGmwtKSdAH4vC83eIVMSE4II+To/qDgOYR7iGOV5NO
	gOpuqbGouzW/SpZAoPDPxK/Cgbuu13zREysZdxxo4tNOrvbqygxovQm5G1C5uufirfjYlc5gBUE
	fJi2Cp76n7ajNJl8F/5bca9KibBAYhL1DubTTk/8L9uKZXMRoXG+4w6hA5V/nDHW0jYoL9uw=
X-Received: by 2002:a05:651c:222c:b0:3a1:4b92:76b0 with SMTP id
 38308e7fff4ca-3a630615fc3mr516441fa.5.1790104927858; Tue, 22 Sep 2026
 12:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
 <cover.1790079917.git.maciej.ciemborowicz@gmail.com> <3315d5f47ad7d8bcdbeda90b161606507c7040ea.1790079917.git.maciej.ciemborowicz@gmail.com>
 <xmqqjyoddsjy.fsf@gitster.g>
In-Reply-To: <xmqqjyoddsjy.fsf@gitster.g>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Tue, 22 Sep 2026 21:21:56 +0200
X-Gm-Features: AcwNN1VmTygyIRgAkTPLIhTBUUzEV6OLP_yfI-KGZ_XhfN2mxk1t6PBXk8WF6ik
Message-ID: <CACQ=SRGf=cKQooiSQD+ZsG8tCAdHkCrxoW5vyPSnT=UMjSajmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 8:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> I think there was a comment by another reviewer on the previous
> round around this area, which was never answered.  In general, it is
> a polite thing to respond to review messages and see that your
> response is acknowledged before you send an updated patch.

I'm very sorry, I didn't check my email before submitting the patch.
I'll take a look at this. By the way, I expected the review process to
be tough, but I'm starting to wonder if I'll ever get through it :).
You mentioned earlier that you could prepare a patch. Is that offer
still on the table?

Cheers,
Maciej Ciemborowicz
