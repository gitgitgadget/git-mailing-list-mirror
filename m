Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBE24E4AF
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513428; cv=pass; b=cTXdTO0Ns+mNHhaDcARzEVksHoXUgO6pwzqDuPbwDmB7YU6Kuk6RWg0DMJPzzrd+a4gQTqmFT/Xi9uMfiPHl4mtShWqmwMRSSeSduEehy2d3eT3/aUWk93ZzX+hltH071b/77f3fK8MliauVDMDbbroXNoBhp1zl/4erLs+E6yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513428; c=relaxed/simple;
	bh=5C3QyFYJ08uUA4Spewxo+4gpJueMhLmVInJ83p4sLZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csvhoSlByz08IAfsemjfhFVHS7fPFVaAJey0aK9mLSycdyAwYwNZW6gfgRDzK701hvGHUT9ma9JA+ZcHl4NWjjTX6xRDTyBDkCHO5U3c0TxH5QplkxfMw7q3lJ04OeJTJzsfrt4vXvGr1cywVf7xzkjW3ACSeK2iFJX6QBtf5B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3OdmMb1; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3OdmMb1"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7991db3dc98so30965787b3.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 11:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773513426; cv=none;
        d=google.com; s=arc-20240605;
        b=RAbKzOiVA9EUywywoSB8ADjtUpDWoZjDFkI39UAo74DGodtmGNWTleuqlbU8R8+HsI
         8ezsC2cBFn+NDRT2K+in56ONHwTtLHauzQ6xvPy0WlhPYoJLVFjjtXzwPPQB2UnEGryZ
         wdKhfiNQXU2pRTQI8btZLq/q15bETwQiv6e1pkSvrWsQFKkV2pZ593yOXAASaTcsVrVA
         BJ4eqWfL9bgKw10pazWRJJMqG0mkaTwJTdr8kle1FioekVmDNg69Ehpxt95ZwiM9y1nQ
         BvX1PQ0hsbmrORVR11627FnEA4Y46yEznCxODwKGeUQzxy9T/CtUwYqmTIzXL0tcr+Fy
         Qrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5C3QyFYJ08uUA4Spewxo+4gpJueMhLmVInJ83p4sLZ8=;
        fh=yUG/s/avjwDCts4YjWvEcNOOvondS9iBGAKxkOGQ1xQ=;
        b=GQ+Gd8Z0cZI09ilsPiJfw7TMTaqj54RtT8ogd9DBhbiaJtq2tXi6D8EXQpLTTEipIj
         lkEc9LFfTbabU9nZxQa0pKAHJwlEGC9BG2YFGTYL/8ldrPpQ8e3VFsy41rgbkrsnJpF9
         cl8TOBNHDw1y/0H/h8YptUGODZfX4Xc8IgwoT1fiXucdKWsrZwmcc3b6sAzczUPFiUDH
         KTuxMbcLU9uJJCe99IglJknPZAcXBpBECGuRBVQaiMGsCxU9pczcwwjo7q3qluVcywMk
         /Ek64XQZ+fUMIbcNJqNGi/hwVhFJ45O84uh6ZK8gDZOENKwYdLjcpYdhaIWtA0ZwFkxr
         ROWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773513426; x=1774118226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5C3QyFYJ08uUA4Spewxo+4gpJueMhLmVInJ83p4sLZ8=;
        b=e3OdmMb1Ut8bTMViyHYetrTAI7JtduINpe2HLbqhbB5eYOQeKHNktyZCyZCvapH3fX
         oJ0xJAWmSQw9bLKZ6vcirgrG4FzB0YzKnsxngheW7D4T0idn6yBz77ABojGUxrK7i7Tb
         ncsi0a/Kkkrc56wS3yIG/jTF+ZD4+J6KakKVG/Qm8tZ7+Mv/k/1k2jv1lb19YciZJwB0
         tR64hPbk6sIjWLy+lcUuP60zjTHz+J/LM+MkHgwHsm1nRzvGWLtNTRY/rXqLLtUgTnIq
         MzfeEDMQ3zPOA4cbL8WmLJWF86P/8L71Ckd8BqYX6f9vLqKpDOPh60xgFsA/pR01WAmX
         MKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773513426; x=1774118226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C3QyFYJ08uUA4Spewxo+4gpJueMhLmVInJ83p4sLZ8=;
        b=IvlR0oml7fNeDVyEUD8d6WhNvHcxOrhlXeRd51bcEJeH2Bs+pzgbJ3BJRckeKkCQhl
         4nTBkzCw6iPajyxv5c4IMr2rJd0DGxFhnhRse+oYDBDU7af1EPXH84+5FKkk8p8uhEbP
         +502q2vvnkZsq9DWqOexOnI7DHbHOTCABOQmh77CjcijagnW5xjWfGVOgzPTBxXXlrJs
         HTd6a1kDEIJd/UZUmK66sAzPV0+zK8XpigVG5w7n5H0KLHZJ8H8lktj138LTWp6t2l6q
         e0ZQZJgaied1yUzwvESLAd4UzuyfaP+XlP7sm/ISzvux6tZQD+MNCYIZglOgjArBCz1X
         UgNA==
X-Gm-Message-State: AOJu0YwET7AOQTRPef5RsOgHM1vP+6Q5o6aUEgAPVo45zfJRUwY8kLld
	LixYsL5DYregbO3Qi4uxxgNhEe12NQrtJ5vVn1mmn34inBEe3tH+kg3iAV68hxIH9QMyCXp/OIA
	bbBRAm8Y7kziDWT6Vl4iInYQoqvDsgAg=
X-Gm-Gg: ATEYQzzxAE7HKu6XflvmJ7RjV7SHmgOYdIhJM+1qiN8WRlNo2TC9bdwwYRZ6LThZGL4
	J5sEGE7KsjPXDUwUTwrws6l8cr0d6tEkaOpmQrCdYdqTE1xuoUsGTIdg1DxLD54SfEjqNdBVbfJ
	GVfVXlC7cDQEMfdjNI//P5v40IaNND5eTT0Z9iK5bob43PGQI0D0K5/x7X82dzIzJbI6caV8ArN
	GMalZmDrYwx14aR/I3CUpxX+MEz8Wray5kAF6Uq/IZhwi6A9UuU3ihwRsYAn9fsJgvCKZDpzmCC
	zTVQxcjjEruEagisEP2PAaEYk6N6w36n3/Lbdvx31eSe0l5pp7Tlq+8K1dsPqw7AAjslqg5kTjY
	QT4UoVRt57IMiTPc2nUcW5lfoX3xL2HWsUQ==
X-Received: by 2002:a05:690c:385:b0:794:f36a:c8f with SMTP id
 00721157ae682-79a1c1832a8mr76833107b3.32.1773513426269; Sat, 14 Mar 2026
 11:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi8YGA@mail.gmail.com>
 <CAN5EUNSK9Lk-ME3nCFSG=Whkcm-0hvF5Npyj8MaXucKLkmM=Sw@mail.gmail.com> <CAP8UFD22BtMAJLA0a6pqYRNp55iAWoi7y=_qYdrJUJYxPSz6-A@mail.gmail.com>
In-Reply-To: <CAP8UFD22BtMAJLA0a6pqYRNp55iAWoi7y=_qYdrJUJYxPSz6-A@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sat, 14 Mar 2026 19:36:52 +0100
X-Gm-Features: AaiRm52S1PYHM6LU_ZaI3jk50wBY19BrbB6O4IpuFOMlpGO03kCODvfT7LPLfAY
Message-ID: <CAN5EUNR2Ti7TSrFw2_RAi3mtMtJY_Ed4vpDo3SwA_F701pJHcA@mail.gmail.com>
Subject: Re: [GSoC] Introduction Pablo Sabater
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Christian!
No worries, yes, for now my patches are all accepted by Junio, and
I've got feedback from Chandra for the proposal v1.
I've just sent a v2 for the proposal!
https://lore.kernel.org/git/CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com/

While I wait I'll seek for more things or patches to do.

Thanks,
Pablo
