Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521586;
	b=0606tZfCi4vNtemzmanImhsFrbtkbC7mIVNEwxTJvO8oNHQXR0AMF9p+FArLIhB9lb0U
	 nkLQH8VxKcOHA3MedArQmkbuhChXlIk8kRkzyQ75J9V3PC2kKAWhBUzX9y0E//DBVYQ/c
	 5geaIf6pd4Of0y+scyDDz/UtJO0mmpG8QwM0gKdE1vadqcST3zeFnBNbQoLQH/TbQWgrI
	 LP2iDkVVG7n5P28Wn2POGZGcir3PirNfNCR2RRtMU5uW6kYbKr5IxMW6PAc7DBGETMOFk
	 jDVgaSC7R8U0jXvVW0Lb/VMW2TVs3myp2sHvCwXxhUDlO7k3cpVgxbnq44H1hbP6vXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jTBTrfOlCY61MhPF4tJ28kmNsBi8CVM7u3zOiWmLN1A=;
	b=PXxNwAsL+KrjWVwnAwD3npl4+y4Wo14fM1H7oDdy9I1bxcq6+l66BHl1iyd/8FH3QV71
	 mimvx2S8+cVwglvU+FOqVk1XigW1OlG3g5tiHHNx1tnAzKGNz7MbR4UW8bf0/Eq9TwHQ5
	 XzG9Icep8yK1iQ7gC/iM1xOBRN1Wel96vENhhdcRI4it0WbDnCoj6XD7Vd9AAigdtWRMO
	 F+EzPr+l70my3n+uVAjlngW9oITnik6c9xHFCLDTYInLTSA+Ngvfbi2pbKQlBn0qtvEGc
	 xkqDT4zmt9eNL3yFMEANgSfuLfX0q8Fo6siGURtFww9SQUTsBl/0E0AjCU0L3+T3M2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EekKgQa3;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C5606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588C5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EekKgQa3
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so8603325e9.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792521585; x=1793126385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTBTrfOlCY61MhPF4tJ28kmNsBi8CVM7u3zOiWmLN1A=;
        b=EekKgQa3z0y+p4teVt9sRtW2M+8s0XsLC/sU64GvXF1I5fou24cVmCtvZlZIRi09UX
         iwkLZVXaUP8FUDNPtjjDO2LlO0RH96G4GmvzpOV3NtNZMG14Rzzt+fHlHCiGhazcsiRg
         hKzwaZqoMzv9K1CEu6OB36b9HBb+GKpIO3pqAc92OZTTF/iYMAyjIlx7SdseTtsaU7OC
         RxRn3XEwoBa5oE2Ojv+2JmFSVvC+27XTfhxVEQdmjOcF04rCJIdLMXgvJFVr48g6X2vy
         7pTy5NyDTFriagxxCEMzrHbPg3r8g8YQXioVM9iqiULNSkumrY/YlfUs15p1FfSqMXd0
         Jnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521585; x=1793126385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTBTrfOlCY61MhPF4tJ28kmNsBi8CVM7u3zOiWmLN1A=;
        b=nWFcCshBfxFMwb5qjT9IDb7aqU2H84AbC2rS9qh/xUcNWTTqMR/ZEjs6E1S19SJKDM
         KNvPVTJXc8Mk24b1ObrPWnCMG4i4CfKmfnV0eMbKWlMYseQZXpBtTT2yyaguJeHdF080
         EnIEyXD+OcziRztSC27azc9hqtypdlRLQgRKMCKiMHtBWjs8OkxYGEv5BF4jRcp5uGrj
         b+inhiF1oPuZFV5J0khsWNiAv4I05MLJZ/SY1GJlCDjs1Vi36bAGzTMEVpeeIMoJPvip
         nlG3OQsRGlILcqPA/nLNGks/rIqAKXbwwzaNqr3I6OWhklC6iI1rmG7f/JgTRad0Luru
         7bTw==
X-Gm-Message-State: AFq9FYIl+jPkMkmWP8vjHGyFq+5VBtMkmQafrUTQ+5tJtz7lv7+4bPnq
	0/5bVzl73tL3OhD2c/UimTQzrziFAr0Q16Emol27jY79PMRj4uUrQ7II
X-Gm-Gg: AYBFou2PzehANQCc0JoZaH7YYI/NBgdYGFoHlZv4UEaTcuem20xT1QWDkomowcChuFE
	alIrSLpc1AHlR8cPSnkqbc0SbsH8oNx21aUvfy50JnOmoFmDImOy0e06++AQwp+I1Vrc6ORl4LN
	OrnvuiUoohNO5a/JJBql91yc/TepRXUhwcaW5RtqXAg9JMkGds4Eqv5pnmnSunJ9684J7VqpYxx
	PwkZAahXy3a+CO/2RCV4vXff82gbni7+vz64QHOUSFJgKc99dPlTK1XaqK7o1ZBpusQ/Q5HbaMH
	A5ucnn9q4rB8GRXKehObQ3wOrk2NtEDRASro5ImUUS+rTNKGzn5KbtfVMNXpict4vpz+oWNFQyr
	IjZdP9JdSIYwiYeaJHUWBxtXdrLrI4sPosh9yH4BL2oNW4VA76DOEpuE3y3FmDeOt0AtO7USPz6
	QDmhogqkr5bDX+tNGewRPhzYzC+MZiOf7jq9qRUv8SHGwAWrzbJZ2+lxhkAFdKzHPlc7nawRV7q
	l9ov6qBrHZcePTp82VCShdd
X-Received: by 2002:a05:600c:638e:b0:4a1:e489:f8a1 with SMTP id 5b1f17b1804b1-4a1e489fa67mr174799615e9.2.1792521584502;
        Tue, 20 Oct 2026 11:39:44 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc0aef8fsm6578835e9.0.2026.10.20.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:39:42 -0700 (PDT)
From: kerylefondji7@gmail.com
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v4 0/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Tue, 20 Oct 2026 19:39:07 +0100
Message-ID: <20261020183908.861-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqmrs92y4c.fsf@gitster.g>
References: <xmqqmrs92y4c.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keryle Fondji <kerylefondji7@gmail.com>

In v4:
- Fix code indentation by using tabs instead of spaces.
- Align Q_() arguments with spaces under the open parenthesis.
- Ensure line lengths remain strictly under 80 characters.

Thanks to reviewers for the feedback!

Keryle Fondji (1):
  archive-zip: refactor 'path too long' error message to use Q_()

 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.53.0

