Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792805911;
	b=ljLm6NCMsKUnQsaGxTbxnMsSPaDd3gXqPfFDq0YKsO3vl2tCHmv8mQC4barNV/iLTnmM
	 ftlKCDOhntHKcxzIQcRflfdh1CHb7/QbVpQMkLpugn7AHdOFfECogKV+ioUOzdyfUS8pg
	 MHAqj7cMji680yS9bpnqbh50SvFROY+wDZrHVTSCcEFzwtx0dMe00JOaE+R0+VcUgHWag
	 Dt9If/Mit98XBEEJGKpa9NMBCFCE2OWWlTWZ7IRQEtEpVqT8XO9n/9QzNvSNwi8D4JyOe
	 9E84Pr43kfHLgu5rUa5u3fcV0/ptolDPJJtrAh4yuc5Q9mfyzIQmEpe16PgEmGoFggw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792805911;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2/ff2fO4iSx4AXk74LJNbVHHs3XtceOCUItbFQH1p0Q=;
	b=HKGeSklT2OO4YQMmY3pkE7jOZYNSCgO+9U2NmBVQjgDpt3pVeuldddev7OpeCDAwd69w
	 LhYryCbVrxhJeHjQYroB9trvj/1cfPujyN6dbT/3OcQrsFvugfr4NncgcgTkN9XNKgkYr
	 lbZ3yuNxh03EpnTKz9wsS519eDNzWrOZAboXZDK3vtaoAYXA0UJ6P1o+OPf2IkNJU5Q34
	 ovRsTZb+TKcJIShZ3fxkRO2UaZvEpRI8ObsFn18K3zewOy8PG3HzjBb45QSRTHclHxZXW
	 OAXAhtXV98XKiRod8jMnDq4j9ySWhl7oJUZa1PXRxD0ldgEc1xPI8cZqhAm8xHCsT5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QVPQq0Zb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=anlkYzL0;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53800606A31F
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 01:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53800606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QVPQq0Zb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=anlkYzL0
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 935B2EC006C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:38:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 21:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792805910; x=1792892310; bh=2/ff2fO4iS
	x4AXk74LJNbVHHs3XtceOCUItbFQH1p0Q=; b=QVPQq0Zb7hpywajAg4Y/RNklFU
	9Q0h5NLAh2jy3Ieb12c2sn1G5TDOK39iMMmCihWrFyuBNjX+j13UgLC+1ldbrlEa
	rFXQtS3gUy8hhzR1LEFlL1jQrsJfJMRC7jN+PHSag7zkaizUQBMjewhV94oD9FZL
	UH2FBAR5nm/NPOgdY6D9f34hIZVXXvuMjyJoMCYCTG7ugN9UEFqPokApRBejr5tr
	St1qiNeMHR/PE0hrQTpJgTNc00Sz1rFHLQBdwyeJBs246DU6P5Y1Dov6+WkV7dug
	Glocp8OCY2T9L+bXjtOwBHuYa+iI2geBVR0vDEaJModBN3ROA3K5H/j23uMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792805910; x=1792892310; bh=2/ff2fO4iSx4AXk74LJNbVHHs3XtceOCUIt
	bFQH1p0Q=; b=anlkYzL0h/psu00bOL4MUGNUdmVJfLzRgXJslWBYJe1ycJ4i5Xt
	rOSi7TYon6zWW9oqKZ66fOmOwhSn8g0XREGsIcA2S5MGg6o/3pf8Pu6dLXE9N74c
	iwPDxq1+P/F2gd+9BXGzbxMB1v5btPUV1cp4xGLkHpI/Vdehr288li0kwm+c4zyz
	TnVL+VFwX3K58CIqd3xTtYQRxK4lvmqYOeelcjME54JFuqLQRSE8xgd8TuLzEwI8
	gnNFtxZAxpYEmMcn5APIjNxoTYbdPq9erLxshRvJmeIouXbBWcipIc3b3yp0kayx
	9Uj9/TO/giKUmIHKIhsJW0K/DaEQd8bmTuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792805910; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fvzXSK9tokkBp74L+aO3y9XbZ66Ewr4ncuPj0WUEkImooaj
	x7nvUZqqSIEG1m/Uord+ck26jAr+hUZPy0DcPwOUzK+46SUrUc4SqnDW19eVKepp
	oBQjYDrRDVEtvxHqOPDEdPQFBoKzow1bMaWxezlys09gz0nicKNVY8JDSyaXc7WQ
	su3FKGGYcff3UpRBjKcd+zBm3wsWo5oCtQHTRAKArBBoVqHfQnZwXYhkFz7QSWp+
	LINMZGXp1WbtvUfSAfgg06JP4IhE15n20pQYUtL8DZdz6wpXkeZzxU27TvAN0YV+
	kkcxctcc0ozoEr9NtFkAXa/erbxNxvQ2yRoXMVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4lZ0W2oxE5pCb5TFp+t2KjM/SO9U+YdC0HTrYvM6ngQ=:GWNAoX+ar9bx/W8GwJvtweLZ1aFAIX+Kuvqabmj4u/Y=;
X-ME-Sender: <xms:Fgzcah96F1P9-F3w4hHorijASc7hGznKFZgqvXha2jHcNW4lQxDhWA>
    <xme:FgzcasuZeVI47mAtFjmTTnnxJ6PEx-ttolVTA1I1l_IV9i8eV9zdNWrj4isFbw02A
    oCuMkoebOacwDkxnffU6yOPUdQ5xJEXKZK0x7UEXThD3HxddI3p6g>
X-ME-Received: <xmr:FgzcakDrAJ1yhR7jX9ihTrSY3RD88cu_6cGeFJ3-arjXuDB8-gkwuI-7ClpcMch6VsjY5CHB69bdBKxcI9u4BOJ-HxVRDO7EIpOq>
X-ME-Proxy-Cause: dmFkZTFlxHQ6lEEivxhbrOdGE/BbwbfUVq2emVApiMoRpRxFpHCDblb3XtgalwDNx+jqih
    HHGyj1idXzbAYkMvCzESbZn6ZnRY/BJGBvFEskyg7TK2/2K8CmTyAsxbfVkrfkOJzuo04H
    vEXvVckmtjEm05VYJ/K9Y63QncGXtbuApSeD9y46hvI7Tv7XX8fmhVQ2/wUAApOOZis1Kc
    MUq9/yVBv4yVRXGy+OOxQVeoI8hUomPAu4Qqz+eH7RxFq0CMlekiDazHw3fbJUeqDOect/
    Cy8PdA7aFCDJgWgLlimES9tvSJjQyxmZ7+4s7UOgOMgzGFzDEgV8LanJ2IdhbuL+LMY6lX
    95V8r7foqOryri2sfDHkG6G54U7UM23wQaljMaX9i3fyzXpSUHg4gR3dcbYxBj0xHAZQCt
    OonCsKHNzos58QQaltqxqRHdRfeFL4fu7P5xZGIyRsHKOF6N2pvXB7RtRJdkVGKZYN4Q4N
    k5payFzGHs8bqIj4w3+crd1rKj4dYaBcJYq7opGtLw4K26FdkN/I39YSgSpkUSsyjXAkp5
    ZLCH0eFWCm0Lyy9PyMq0M4d60dnFQZRGic240VKzIwRMU4DgLNcr5RAB6fH94bpPSWbV+F
    FrLL3ZwE+39xavGo/wSXr0xZGWBziRBpMQCh7yMbF5Z5ZaBnmopgDxu9xsMQ
X-ME-Proxy: <xmx:FgzcakW43-TKVqy-u5GFqxhTdIqvOJByRr6nZKok_-0UoFrL97MEpA>
    <xmx:FgzcaiCprNXGB1b1K09oXZETk0lTvALXAtv4-e2opwWP-IpNHis1GQ>
    <xmx:Fgzcan8QjRKyGIkKXu83FF04hD_zlL_r3Y1u-d9QVnrkkMLdzoQdwg>
    <xmx:FgzcapEz4YHhCKaogu3mJROcKK8nqmbgNKFnoYyAt6JGv9-COwvxzQ>
    <xmx:FgzcanihgnbGRI9p6ibcfcOPV4Q1Ux8s1Uq45E6BB5Huki_HbQ0tBqS0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 21:38:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ci: pin actions in the main workflow to full commit IDs
In-Reply-To: <atv8gYf8Le1WHTA0@com-79390> (Taylor Blau's message of "Fri, 23
	Oct 2026 19:32:02 -0500")
References: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
	<xmqqbj8k3xcy.fsf@gitster.g> <atv8gYf8Le1WHTA0@com-79390>
Date: Fri, 23 Oct 2026 18:38:28 -0700
Message-ID: <xmqqzew327zf.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> I think that we could reword the commit message to explain that benefit
> more clearly, but I do think this is the right policy.

Together with Ben Knoble's comments, I very much appreciate your
pushing back.  I agree that a different justification would be a
good way to go.

Thanks.
