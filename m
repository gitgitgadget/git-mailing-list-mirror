Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794654564;
	b=cPAPsyiTgWDfpbAZZ3FmD45dv9nqvxi8Hq5YIIcjqDe10o0NsZ6D4GrusmtPeHA7ydyf
	 1XqwEO6xMFzVA3x3ko03MTa6PHP3Jvjz4OF3yYXzZyYul1RjaJlzNrWWjitmiPKX63wqp
	 exD3a0l+V/9eo6nDr32RDhV3HyEWBys1vtTBP4U7RbRk56IeV2m4dKuRLgwrOQNVLvdhq
	 s9dws0SW3lf4RWVHHJZFoNedcf1Q8AiSqGMiWF75zWjgfdZuT+BYSLXUzGy5F1XhqtSoz
	 BjTKMq+Xl4ngPPjr56u+q8glSrBZnpUAVrV0xW7tcV19/Ut0zfgDa4PjU8TAbtGz3TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794654564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Ihv9dbdSroVNgQAtwAR0EQrYeG0bEAN3PZvQHvFUz2Q=;
	b=5P0IkKyf6kwpJ/NKLxpzP08dWpWi94VlJuT29H4+CqH5jjyG2L3IMJtN/0yXSJiwGVY9
	 zi1XsT4NdViDyhPV7R/iehG33Xe3CSrBfBKd2ndD/DRWfVegXPnH1P+QAwBye08rGwbq7
	 zH8dN/RKkvZW966uy7lSbGlAjZC7LduJnqfhw/IIQ4PCRWY5D/rGsVpQi+D8MRtY5MJhj
	 n7InS8yb9OxmAOjGl2XMCIj3E+5AOKJCkWzhSB6gqq7vdu4oJwjLY55kAJ5PKPUE80cVe
	 TPhXW0DQJkJEe+Ej6XwrbnXr0WO1RiomfLGnl3ywwCMZawUy0L+udz4yzj6biKMps4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCWc5X5u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE8606A89B
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 11:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7AE8606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCWc5X5u
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so2607877a12.2
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 03:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794654562; cv=none;
        d=google.com; s=arc-20260327;
        b=mDqFsG4Auoi1ddRXywscChsqkXxv+Yck0rHZzPOL4AXKEXhpCpyLQz+YPRuQPLgWYk
         eyV0z9r/Ii5RWBoFejBopiflsTjmT+yd7JSVkkIg0qElW2YyWWaPkaB0VUirmZbrZiax
         gEy4zLgCbTRJru505YnqfZ0Qy62PSoKbTGkUmlJiWf9wfhA31aFZxj0fk9n7k6T59ns+
         nzsRw4fqAwmd5a1DYBQ0FA2Gy/L0ysjfmCUm3Dselv4ucx9vG4fDKY6nSwFQL+kFM3yg
         wTG0/C2aW006jd28QlDyr3i/fha0kKendFJIjWYcs/VajMy0jMf8Svw/y2WZpk/Ce02x
         rfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ihv9dbdSroVNgQAtwAR0EQrYeG0bEAN3PZvQHvFUz2Q=;
        fh=qSQAxmaWUH9T19hgughFqJr+/1fZt7Uwat5X39jwO2Q=;
        b=g/tiaUqTDzJ8My4TTOPFNBtCC8YnJ61P3lQJz9LKpT87Dm6jDDEeAfb9VOj/mmhL2m
         pKnjO+TS0Gv38EKgAA9/6Nz8lNK9XRpaCIh8gqvkvnq402ygxSeOvjHu+lLdCQn4FvVn
         gOLUtQGB/iINAdkgZ88ctgXHq0S9+FUHaKTlzUtP3ggCMhH7AA7iixisEoEbAH54JQlD
         4cQQKJA45/8ZdspYxo3vH047X/IX0G6TIh1B/SWtd5f3orUdKC3YdtrGJVmkPElxK0Od
         RpPphzz1t6SKvR5oO21a/LQJL8EWFX7BZtzsGm5RRvFMcVGg7QWvKcA0pyEJdd5Uag5H
         8exA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794654562; x=1795259362; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ihv9dbdSroVNgQAtwAR0EQrYeG0bEAN3PZvQHvFUz2Q=;
        b=BCWc5X5uaezlCISwMdFeMn6uzT2bP3xp7tq8sruAhL1X9kVcSj0t3TS5GXYzknbCHq
         Bp8oADT0hUCsWGBtYSoNBifrPPiMavf1tUzagnbga9dm77pMA6cpIihA0ZnbvI6Vkzk3
         AIDR/WSf+dOltOguZZRbi9S6wbTjW2BaceOKtsumulV27BzzAv0lak5belw50vEFTQDo
         ZRLLpj6zTvtgZFQlxMHDxmkJxKW8rwDhhvVEcKTcJ+B6AX8rZ1MYyuzjb6yuFbauFFoY
         8kUEiYl+VMgKot4ugcO87EKDvCYWknA8QIriQpI7nI82BtVnMtmHQRVvcTyMlJI6WUjS
         b3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794654562; x=1795259362;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ihv9dbdSroVNgQAtwAR0EQrYeG0bEAN3PZvQHvFUz2Q=;
        b=lHMryoghaeAlowLYOZK5ipuXgCGGqFQJNkTD9IopIffigqcz1p9CYemaz0qHK9GEdJ
         UsfFTGt6QC9OF/WzKv3TdWcBxvONmQJNdSCGLJE/bloHIxDw50UDpUqDOkxjd2yqB05T
         4vXYxc2MMhM0V5OojHhyN3gnrFy/UcrWCRv8NzBgc0em/Cu5bqhwHXZWaWiiQ6ihHIFF
         X1p94kAHPNcPfdZFmRYJ5tY16edFQycHhVzGHzYk3XXaF4eGR6CYUG7QJb5oTbHkOcu7
         vJGHtqWT2tKCYrllDm8n2+OIuLygwW6Jz9g713JlEoOcPXXwTHCynGjWNgXushWVnJtT
         bHFA==
X-Gm-Message-State: APuU4Z+STKna+zBN80bJ32TJ9tHdQ/l54GZRL/vl9UMeRAo7vTtsFYQl
	aTz+CJsBG/QdQpfUqC5RA6FS/U7BDJkXpDmtPx4lijztIzD36UqcoVSzn6DhU9sBbRexGlA/DVp
	nZpS52JB6jfLxZ9yi+whqyu4v55Ud7U0=
X-Gm-Gg: AYBFou1YXDET/z9qhynwZSkeP49kml+17mfLDYPlLPj7BGfIg3L51GaO4SGUWFZzZME
	AbfzsHJ8gX8Ap0xRmo0t7auF/Pj+qjrWHzRJ8H57FSx1Re3Vl40zcCyXPhRDs7JBpnc7tjKP30U
	Rjs49BRbpnhbc+kUK5/Rz7Gx3kb+Bs2Qh9f8p84WfWg4Q3jS/FJHm9piAtQGk1kYHgeSOWJJjYc
	UZIbHLrMWn/ZwZT2FJn51TJgnNiv5V+37meblgqLBFRq7dAJC+fJLuA4CZVcrBPcJxMx7dqtZuF
	bsPuO3xrS0BLufm/wEwoMWyaQh//c2qKlBUpUHulAbbI+R0wAtjPY3BFYKW+GroVxSCIBhtRBAg
	P4cib6qflYZyeCNGvL0JF042dav0DrDfmJ23tlDSXb4TSpZDd2bEsxwnyzg==
X-Received: by 2002:a05:6402:5007:b0:6af:a64f:bd44 with SMTP id
 4fb4d7f45d1cf-6b7c0d2842emr4404498a12.45.1794654561851; Sat, 14 Nov 2026
 03:09:21 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnXuN6vjBD4_A7FsSHTvra_k7XCpZPdm=DSdH+r+mNgekA@mail.gmail.com>
 <20261111152753.99845-1-me@jaspermayone.com>
In-Reply-To: <20261111152753.99845-1-me@jaspermayone.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 14 Nov 2026 12:08:41 +0100
X-Gm-Features: AclHuK-2XulxWCuo3VUYmGSdM_Bs0xtrTMVQ6JMEflQxMeQnzU_v5RFT1a0uzI4
Message-ID: <CAHwyqnUjFybso5C44kjDpgFYgsct=u9F1gACQLYEwF6Mcn6Y4A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] branch: let --delete-integrated find branches
 merged onto changed files
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

> A test where the merge does not leave upstream unchanged would protect
> the behaviour that matters most here, which is to keep work that did
> not land. I am happy to send the tests if they help.

Yes, please send them over!

> With those points, the patch looks good to me.

Thanks!
