Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F3A5E8F
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436805; cv=pass; b=eQWqNVSRFZK4MfEdN9Zo7b48Hgi2x/kjpVV1m35mfmiAdRxRaQNd3rEk0pc4o96MSEDmp/7Jrdmgj7XYaxUHrSnhguCFiDnHgloo42QwiuEfjSaHPcfv29dgXBJZKvc+JMuxWpVfrzD6W5J9PqARzOSC5wUX4msYul/wfgyLQ20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436805; c=relaxed/simple;
	bh=wbemqoSNg/k1YBdtU2i2nxgHN5/Wlq1LsA+d/IK0f7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9MV3GBuAKbufzjFW5PnfnZ23H+/fwaUeQkK4d36qFSVlZIr13av8/eqPFPJVlPXgjk45p/klOSmYUD3H0W8hEjMi6xwBr0dxEgLMESwsbuOnWMKYtILFlPUmz+R+azbWuslfBFgQgr7pjYNKQFQrYh22b1mH2l9LVSUwkhXG8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1HDASDJ; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1HDASDJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bda62f13d90so539562166b.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 01:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779436803; cv=none;
        d=google.com; s=arc-20240605;
        b=Ho6zMfO8OnEZvASAGgkRPTQrB5UhUip9Pib7O3uk/p4BOMCeDHNOVOjqiaepVtePix
         YTAAqTYbd19AqFOLnpwKmCVuDxsG3zsWfAoz3LgvnSaiTprsgUk7YEMFKhFYEUUGx1QM
         ci6VF9p39w7IX3ttxYQYh8BdsrOlN19Z6U0540+eoakmdTWqBoZvjaE99agvMh4NI+Jb
         nWLrseekHMqpnWSBKRInFspBmIiqIMDdi2zB6YMKhxBiv3N6w3w3D8OYYI91jOs/Bm1Y
         eL8twuvi1CF8HD1xG/A3pOnVREgetyoGsc0P6+NbgZGfX3MHzGytbEQoQf/gjb2gihnB
         ht/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2Q9Dph7o7iWoEfvSG/Q+VJEqMtiuueyCe1Dw8hdRkq4=;
        fh=r9bswpu2QmxqJ592GtkblVp7bS4aSA54Y9HS4aU3cOg=;
        b=FLCfINH02Gn634Ni7X9ijcXCi7IzvFDEVv5GEPYDylukDU9OESXQn0TbhfiEqC/BtE
         WKsSxRF4Kk5lDpXZ8EYXr6azrKELzxzP6WZFPbyfVz17ShPUdNXShdidOMWqD01ddI1k
         uAsM2lY3/ONw6EA4KXsvZoIirV38hJQzQm3wWyrakFtIZWE3JNK95t01ker9oD0AZJm+
         RN6Q4FUTvu6TiCWiYV2wJh2pL91749ehkf9w0pwcilATm2R7dMbMMmTPNLgKlWJyEkUR
         AWGf2CNxaPS+4H0BiTXpWjLrcvC45eryjzO889Jlu3HxYt3r8AN5OOedB3HkHRG6u/3v
         VlhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779436803; x=1780041603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q9Dph7o7iWoEfvSG/Q+VJEqMtiuueyCe1Dw8hdRkq4=;
        b=W1HDASDJRQ0IHT5gpit0cWRGKl6xumlmnKXrsB52rv8oGRK6wdDztFkdJANbkIXxip
         hr9yPO70wX3G6oPlTu4mNYMaSunOISM/5X6IdESiUwEqSHQZz7+jRiatUl9XKpKJIhkB
         RoMhA8Tu8NnBk62BHXCWmZjcgIjlZJ7e1HwWx6rBUd+uK2Ir0o0rMjdOpyMN1/HREtjR
         xUQuU6VNggQOOZ+6bsds5v3/AUWBPfI2HG6L9Vr6OVUxiqEH44/ahaJ3QwR2wxc+AloU
         +nd2huSKNnUtKOUsarEh8PCmL3WBFe4q3ZiZbc+x4qWVGC0G/6W24SLyQQNXI9My75Sf
         zh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779436803; x=1780041603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q9Dph7o7iWoEfvSG/Q+VJEqMtiuueyCe1Dw8hdRkq4=;
        b=cLkBJ7Z8K/5GVf3UUH0j4vz6BQoUvLPnojqG9IJPMg2uCJlAjfX1DszrnchvkCGW1x
         pfRJv46n8EjN+VRp1NBsS3Yc6Fi3oxxnPEc0uKjmtlHBxV71VWPXL9vLj73V0eKkED2k
         GZLqejXEirx2lQMmYAUM2itQKBz1QAUeCt80yKXvJmsqDzs645RO08Qf9M4HE1TJ0zyi
         RpbSmpojO3PntnouFMrttsZRFam+n/TYZ2RugszdIoS9ezKFRU9un7HAhaKrknOg6AjW
         8VSLiKDAUzl5/oNMWfdZl+6iEQScoNT4C9NqdUtPrGdjPkmLJdd7X7ZlMb9ddIfO9ipm
         N4dQ==
X-Forwarded-Encrypted: i=1; AFNElJ85+Yw6YcKsH+8dc9OWzwiyDlfgcbRkiNuQIEtFV9+qnVfShZd8eb87qkLkZJ+O12rSfSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p4R/9jmlMZSEDn/DczVQcAH1BqSSGR9pVeEe41MRcXXDpLEI
	byyKu8mtShy4PEWjQag6g96Hsz2rM5DtbeyXe9bCCQSI0VIXdSCoVLwk2F1gjaSKaOG8gfH9cWV
	lR0xVt07NsPu0LBLtIIqI+I8nydmmOoM=
X-Gm-Gg: Acq92OGRCpX5UHtQQRq2xASiiNvYmjRzToK91pqgC6AASBX8D6STVVWEdhCnaem3y/+
	48Mj6IuoSstDHMl6zg2utIz5lQ6NzijZpG2W4D/lyFk4LmeQTsVqbKN5WMlhhx2z8G4kF/6Nqxn
	rp2SpR7F7SiHCU9wsNBoowkCvGiJwvcjuMYwo3nY+C1oEVperrZinQUmIJIO12cMsuixFn5MZaG
	0af/rUuUxLBt3BDsC82TeiQgUeEGuUlA56mbbO2M5/aITyuMoPNkkiXnEZ+eJJfN/GZ6T3qej5d
	rvcrXX5G5SaRmYL7TQ==
X-Received: by 2002:a17:906:eec4:b0:bd5:18e8:1ae4 with SMTP id
 a640c23a62f3a-bdd263c9536mr176230766b.34.1779436802839; Fri, 22 May 2026
 01:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com> <718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
 <xmqq8q9cw40a.fsf@gitster.g> <xmqq1pf4w3x5.fsf@gitster.g>
In-Reply-To: <xmqq1pf4w3x5.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 22 May 2026 09:59:26 +0200
X-Gm-Features: AVHnY4IisCswzo41mZm5DUUh0U2BzotJjbCt4PuiGhwnvv6gRHpmmbIpMnQWL78
Message-ID: <CAHwyqnXVnFOeKRXQHHZMLbj_WL55A5gPxof=VFhZxDeXTT8kqw@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] branch: add --prune-merged <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Please discard this version.  I had unnecessary draft comments that
> I used as reference in it.

I'm taking this to mean starting over from v9 and implementing the
'origin/*' idea again from there. Correct?


Harald
