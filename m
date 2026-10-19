Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792433136;
	b=zgsSthV7GEHk56Nfv4lHLPebKhXYQRqr8aW0or9RDfYqDrmSoVYTdqPvfny1AqcYEx7o
	 n3p2/JQFO+UFzp3Orlll+Stgf9NzAYAqmoQxtVK6+t+ufnmV2FhhQC6n/2oRk4ldod+Et
	 VV6UHkM4m6j7XqEtTFm6sPgDDTe/vDA4eeJrd8P4OuXQDvejqnMoo5FAk8buQrAd1ldXR
	 h0XN1ecKPh8J5ei1PgpNrT8OdZ/DZ6yN9RSBHvmokJxaorp0retM33H5pebBzht829YAy
	 wqR4kdgPq0Ws4HMBF7A2UGoY7XyFjXDA6OzMMvj+GFeKzwKpBtG/Ht1Yh/9djI1OoOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HLOGgrEE170jSsl8PMWgaowcFW4jxjSeFtLFDEKesKA=;
	b=150gIbM8m6Wn6SBXq31bc4X5iYDEm62UZCeUz9lZZNX4I1n16ZWOH8NI0qGYkRqmIfYH
	 u366TKdWu29zBB3Yr9Pyd9927dTdE1gY8nAEPY2XeenmQ8/66WxES/xRSpqwuNxEQ++Yq
	 ekqeYgor5Op0j79ElnRKibNnxsBN4pTNiF/urarg7R4X/w3NtFLsdu/GqrqXvjAslpX1H
	 mINjbdcLXMM0HkNC/r5SA893FBU7R+bHIs4HyLyoK8PUjdWKv18t9Z9BI/b8svubJANBM
	 Fa9lYncwiT4HLweCw0ek23f23tkVwjwgbAgzJ5zgDyA2EPRpaVL+sVXNZqaArAHYVZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DyAsNOzQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE04606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE04606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DyAsNOzQ
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso3438962a12.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792433134; cv=none;
        d=google.com; s=arc-20260327;
        b=LwNzMD8rcGc5O/Ixw9GTd4R8Xxxv6/fvnfmGgXlvvnBdAgcLPQL/lJ1qcaWGk3tIpw
         iM8K6B0OMyjhEgPELBAr3u3xXwXLwHdrbjKmdq7RquuN5j9txdmEjuOBGqAelCobsVTF
         igV9d1fGBPzvrLORY/E+iEl2eVY7uPooLZifgJVJfXtA5GfZrrvuxAox3JbL7BX9711i
         oAM88T5KDe8wtjxejgzunnwn7mj/9rfmSw1g3eDj7QtCpNtrSDi+YqQh4ToRhzN7ZItV
         B1zvLHwmUjAqZX1EjOOTczNPPo039/YjYgoduozGiPZyeaIPv7pUtl+RZOJtRPybMXQ+
         r+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HLOGgrEE170jSsl8PMWgaowcFW4jxjSeFtLFDEKesKA=;
        fh=SrC7A5QswLg9AbKluWDDi2Rn7wAkpYqrHItEoDLuVKQ=;
        b=pJBjgS8n7xW911lgrMfYD/GrKmcu68gS1O4BjueFvmEctnrcD2wrFZqjEGl4HZnnPz
         8z8Zq2cc4SUUWMSXHOclqElubOXMUnNkp/WvvbyFju+qDH/oDnOZ3FY5sznhyRDKpPRH
         cdX3YCsVLfcJ3B05UCzoNCsfesKRjBv+XXFVbCAFcDxUAZZhXrlt8mZzd3b1iMVlG1cY
         qxtYXLHBFqVjvyPFioD50ChPVk5Fec9UmR2vanoiLJEK2XnHVAvZVDO85WLAk+kqDb8N
         wTuO4vQbvi7zw4WwaOOvXPnImNz1ZBAHX0APPT5wIoc5nqj3AxB9VQd1nzvT8oPrl5bP
         LRhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792433134; x=1793037934; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HLOGgrEE170jSsl8PMWgaowcFW4jxjSeFtLFDEKesKA=;
        b=DyAsNOzQ0NwJuVPfJSNiIpnBb4kphfrwi1D1IfKF72hI8Y9A2A3iMRwGKaFCaBh7ei
         BDCggbanH5m+ZrIk2+d1l/GwX7ZQ0KlysnhK682gul2v6rt1YQx83mcxkFiBo8QXgqXR
         HxxCnFeJUn4tG5OBoEveZqO8MFWOpkfLRe5Zmulnv5dhlYeoQ0O2sbJ1Q6Vb6bxk/jPo
         AVLtc+ej+caV1Yax/i/9U7hzRCPoxp+F6ftROa7llVXY/Vpfnpi0K+nu2u/tcgAnBZ1D
         bL0nM5c98sZFQRXMaY0yRIeE6sCEJaYTYpUfdSXAtnwqhfpKLH6jrur0uadyz1y8TrRF
         45Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433134; x=1793037934;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HLOGgrEE170jSsl8PMWgaowcFW4jxjSeFtLFDEKesKA=;
        b=Sbw+GufJyyj5kmJE845Zv925qNr/aARNZV/afkrAOueBT8ZJUPNRvZQGcLkOpEZ8/w
         aTjm5ewsybRKrX4eA+TyxVeVd4OVLtd7lQ1zSIOKM/r0uAKHX1bT1gsP+nHdp/6P0SeS
         IxKyYNCYnvf5Qrze8dXF8IlKiRuC6MFL8e86fjIrI9wx+H+ZYcOH4PQJT8JHxvKQjIxp
         VeMob38LLjltiMn+vQc6GeobLY4cVavxA9q6Pp7hn7YOlU3EtogJ2bkqBhBe5D82rUj1
         GXiP53LikI3bu9rDF4SquVzyUcz9qxvNWELt8cDQKTSe3FQe9srBfnNdnQUO5ZupEuG8
         +0Ag==
X-Gm-Message-State: AFq9FYLDWI29YIzyEe6hKBxgG+EjBNBE8GvTMKAgH0ispPAPSJ2ahyYd
	TXf09NxetEaZI3gehchukXbDKDIKtIwMnZKZTJ4n4B9jQwzcdATs6wI5C4w1jOKLTWdtvrxncOg
	KauFSsDfTm+FXxXVZhC+vwL+/dHI8FL4=
X-Gm-Gg: AYBFou0mUyozr7HufWD91nRk4+DbJzu76gNS8DpBdFcFzfvQUgfF1qWNyTcBVLN1qrd
	Fvu4QT/M5uWrKN4Ge4F/i7y2vedYxgip3Nb0fNXbaPgS3Psvvh6p9nWDxANq8mF/Y0DlkA1dLIq
	Vjbah5pMWDDLyxvfIPcc/ExuCCt6+uffqv5nP2rO9UG0h7h+P5e+Z0rWCKqpE6qVLXy21DKgmKk
	w9EZabhVV7nkeqY3nei/ZpJU2CASWJgZrGPiEj7h6YpQXB0sCaDz54NT2UHiUq08apxy4d6annw
	i7iIxgvz6+AUFhV4dcqn4JJGyFt9WnW5NdrTw7i57TcpFqx0ECa0Ono=
X-Received: by 2002:a05:6402:3605:b0:6b1:ef16:1855 with SMTP id
 4fb4d7f45d1cf-6b3a818ebdcmr5504954a12.18.1792433134149; Mon, 19 Oct 2026
 11:05:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
In-Reply-To: <20261019175722.5223-1-gitter.spiros@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 19 Oct 2026 20:04:56 +0200
X-Gm-Features: AclHuK_jVMOOFgsH7dchAiMMye0zgNm4IJzMBa7Wmmf0LGEYU0pcIFVfupfVYGo
Message-ID: <CAHwyqnW4TjE_g9dEqAYdVdgM1dg3246hzsCVwsUBLzzLz5_U_w@mail.gmail.com>
Subject: Re: [PATCH] status: reword message for a missing upstream branch
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Elia!

Is this a duplicate, seems you sent out the same thing here already?
https://lore.kernel.org/git/20261009134004.188952-1-gitter.spiros@gmail.com/


Harald
