Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792654497;
	b=r1V6VOIhOPU9a5ZVZpsYNyrpFFfgdd8D505vmzCBlbtYNUFJE8vtj5uj4IwmTffmQvtf
	 EH+sr3IbFRiAfaZ89WN0fpew/oxAYvteHVB/M1pn2O1Y8UL0FXlpDE45h5ccof8SOfBLP
	 xy/pzIOUsw3iDE4PYoyIretN7j4pG9LKYl6WfBBhHYtSNi76y07pi/pZHXhr59zo8cSeo
	 PhIPzCS78vtmMpOaeTuEhlC080KT2Op1u+i8E+52PXAgQR5QuX2FmUfr8w+XnGnt8EYTM
	 vHDlS0Z1Mzvz+csCr3Ys7bvFnwSSsCoKKcup8JweEwrY4MdYVnVJ1vohEev2TTqC+fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jMKg02mRFgIj7e2qgtW7u/27/Pg5EJ8ynPxSReV8AtM=;
	b=S4eFZZAjCyArBAs/cZhTWTuZrFPWLAk9WYjAlK96O3e34Re85+y8BDNebPYsXJmKp3mt
	 RaOJFKGtaLeflSFp8FvhfJYRhssq7hzZs29D7VxmTfI/7lPH0WWYztgb8vRCQEqeLLLsH
	 CAFOVivL0RBWmlhWBFObE4+Hih9gRPAtZW8DH18EdJJ/Zjn947FomwZ0GXP85nN564Qdc
	 hj0G+1lCl2zA3guBJTn4UyZW7jOP1oYb9pVmWOhDM35r0CK4glzshlJJSmgtdxKYxVOQ6
	 lLfJqoZSMIJX2DILxfGcYjjdJ+oKsKHRpLw9wjUjVD4JZmroAgLnBU2yaRp9m9j7XlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W0wVVhDE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F4606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387F4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W0wVVhDE
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c263415982eso205662966b.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 00:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792654495; cv=none;
        d=google.com; s=arc-20260327;
        b=eC3Pji5kuV5fU3YIXZHYrSjxsup1cPUVmc2OyxohD6A3kaISC0Y2MIG9cVbZNwLy4s
         qd53+DQWIywya+GpRLZ05Ky+dAHWCfbUjfd5obO6qlnsv4BbKHmKyeHKZU73IgmHvtgb
         LXT7IZunbcB61tTWuJZ9xadeD4nmUl9qpd1ynGol5qj5PZz/GK3z9EP93sn0cMHTzLLx
         PBSv05srCo6B6FKP+EgBgfzlOo0WmArf7oR3Ta8NhTh+ozfNK6DNwecKdUQKHOyZZBmW
         E22DN7O2lXxfTPFDl8G1Q786P70+OGVu2bJCjPdTbB+cHbmS2vK/rKvCEKzuVaeXDlNs
         1L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jMKg02mRFgIj7e2qgtW7u/27/Pg5EJ8ynPxSReV8AtM=;
        fh=JXIpQgBVun+ctsGSYUnU8qCVjz4VkXrPEukwcg2j8M8=;
        b=is+sHPN867NKBYfSFuYTGecJBu319vHAPgPDFRzJmIfumJwQTkUYIEkah4+6bMuwqZ
         9ui+nT+aulRnQBsXHLHR9E16dC366khhvcg/B8WXMYGwbwS9u98P8YgU4cOCmrF+6MXF
         2iAjMi07zpiQ+vqeInv3OSRQI0TiPwvqngxtd6pNbidCG4vsGY9WCHb3Equ28aIGMde3
         0DvhZLFcJSylZE1ThQfdIBkPP9aHdv8gfh6CfyenLWRdvEprP/Dv3HgM9DZEu29gzVXm
         xMskzXnWAX9XwffVYG9DEmsqinoyhvHAj0xT0ySsRGkYSQPoRoBc2K9BkR5aBDC34/2b
         F2ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792654495; x=1793259295; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMKg02mRFgIj7e2qgtW7u/27/Pg5EJ8ynPxSReV8AtM=;
        b=W0wVVhDEMVpqfW+E9O9nLqC3sH1O+/x2iKI1BwJ5URn4wV3WcGCB8DpI4u3FVgje1Y
         vwLCttuHQMi2tC4oU+/aDQ26ovL0MWqhw3gfPOLUWsY+84Sp8twteki89lP5JXPL7hxf
         qgQKZCXJf2R1j5QC3R7CKpcEcTfQdaVj6vJiocVc6Ak1qeBzWwbWQ6XEIkVrtaVpbUNp
         GY5l9Gi1e2MKLowk20qCRaKzsTlk3yPKtMLXjI6JnvHgWCbte3cqhewzJC1MspRry4/B
         VXkriX5tNLKchbQw7zc10edMNr8s15Oc1OEI1Fih2BOfbS/Ap6JdgZn5sYVAw0pXPaFx
         61VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654495; x=1793259295;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jMKg02mRFgIj7e2qgtW7u/27/Pg5EJ8ynPxSReV8AtM=;
        b=ut33BypNRuEKzanQiWOz2hhjVMD2Nfp+ZKXz8Z2k+yLWMavU1DC3qVED6HJmyGLqEs
         j7oKnYOd+IHlSkmjfPFlFIP/WcdTBnM3EmCpdkt19rH8Vve/TmKfnde91lsGrUpwNVEQ
         UbS4IylDyTc45/iDc8dCLu/7DPwCAfwJ2oEaKVBn8rnhwdG5IiXqXhM952qlGW0KcN0E
         A0qv55ZveKqyow9q8pxOTCkTTvzWKb6OcUWi6MNMqIH7XDuXkMJ9OH2srxYAVYE14Sij
         p0e2dIF7ltu+H33ZLrEy5F8HnkVYSDW1aTC4x6Q4wh024/l3sfcSdxlj9SUXecByy4if
         8dNA==
X-Gm-Message-State: AFq9FYJNi0znHWHu4WFiy8xcO2zpKb1zMTehXIDX1qm5hPykQQRemDhP
	4TDx11UI1Ljciwgdtvl3ZZ6niwSSCvpwQSSnbhz1NTj5yMmfSxi0w9H53W9my2YAzz/bRnBxrAJ
	H1ADjZPph5j5V7dNguxbVZ5OPUKiaMHs=
X-Gm-Gg: AYBFou1jt1QY8XwqTW/Hvtnyjg+rLC/wCs5DWNEobY2EPJ9MZ6QJ7UqjBqiHTlxXKuA
	z2Ni7vSSH5YDaiCvA2uhPYD3EWOhZT4N4amMRqRXoGxDyvc6klJkEzg4ZLbf8JLsGogUvtfv+0y
	EtGbuVV8e5CYGBMNZqUkl/ug1nlw74K+LDjnsFkQJGNhlv3Teeyg90ycCst37MirG0vp00OGIb3
	vp7U2FwjMy3k+LLtNjDqOkO/lPe01ui9dOHO+z5cRdV1cYFsBjwl8i9WR4WCzeVa4OOeKhSo/JT
	HGnjoPLhDvwet4KL28Sn+m0etskyyF9APjvooxvvxhgGK8RiFBEnAP5NWFhF6oZFUGeBzbPx0wF
	wY7rE/NTzJFwlqaO2Bu90e1PklczjR0DLFC5azWf0VwihRmsRG72jM88i3/v0W2X4fW7aKQ==
X-Received: by 2002:a17:907:d78a:b0:c40:80eb:c543 with SMTP id
 a640c23a62f3a-c46791748b3mr378243666b.4.1792654495591; Thu, 22 Oct 2026
 00:34:55 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2259.git.1792125111461.gitgitgadget@gmail.com>
In-Reply-To: <pull.2259.git.1792125111461.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 22 Oct 2026 08:34:43 +0100
X-Gm-Features: AclHuK_OUQr5z2phyFVOkp1HGpzUkt1l-zddoqyfRCwTxkKugZRQ0NnH1pzYegY
Message-ID: <CAPSxiM_gCkW3gvgF-ebK64bUS5za9CQgTFLAn-PnHS12o4afbA@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] t2403: modernize test for directory existence
To: Shashank S via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Shashank S <shashu8660@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> --
> gitgitgadget

Looks good to me.

Thanks
