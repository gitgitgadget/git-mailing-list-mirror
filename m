Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474955;
	b=sLsnHmqmdXoAdydpf00dv+IHJm+Gi1edvyFIq2PgsokwzXMqB//9rP2f/Lt0r8vLEq/3
	 p3rKvtv1AV/5dQ2Bj10uEV0F+wu5S9iACHTtoPi4sQQsC2VnCVXvuAGW4I/1ae68BNrdE
	 lOGYPACtdclIdgNlI7i4z/3AClOeqJ1QsncQhQPv/PWix1dm93ToYQMziYjvBlT529cXE
	 kAD+KIWwPkETERjD/aYUiINYgomhBIt6MtzeEuArwcZ2UhtUTli1h2T3xz95bZxoYR8Z0
	 9VmNfZGEs9DkCB4VfvbT/VFysDFcgnvKgk/o+gZX3wfMNh0WYr4T/jmZZEENQUbBzxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1tEJQNf35IgOuih7jfuh3o8Oros5NtAhKvmmp4nNmqI=;
	b=s8BQdfGhtltge9hiYXRrzB5TdUQV2iodoqsEQNhuI1P6B3T8WE2tbRJeTTLFCYJ6ndCU
	 4XJ3PIfkEIvioBwMTpYS33CIw3tkPRTRT4uk90c1CaMu9k0UjMNdvJVR6nEyDNImtDYKw
	 d+i7/5egO61ReK7bSu42Dg9BvobaIN+AyVCck2e81yUFl3IR33tBbONEYoEp/PTaySLwn
	 soro8PDxjK2VrNBQN5RFp8nUvOZBtqx9k9X1LoLraBrrnN0SZWegBTqUKbStCXo1uFllD
	 /XNlKj/y76ys6CJx+sKohryLfzIIFGA4rgPf9kzaC/FgHyVVnSsoBVRwPMFxn0WTKpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wZ/Zuc6c";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11286606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 23:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11286606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZ/Zuc6c
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f02ee04378so30444755ad.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795474954; x=1796079754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1tEJQNf35IgOuih7jfuh3o8Oros5NtAhKvmmp4nNmqI=;
        b=wZ/Zuc6c9Ux9cpDfg/A4pbbtbdmHLSGwxfRVc6GYIVHGF4hQqpkGJLa+JNkery9N+s
         kItNbgLRP5edrPIVoc7Ul2Mjw2VT7cUucYSO6tvvVSG7HdHt0WtGv6aZadlYLqD634Fa
         e86bFeUyF6aVC0262u0KX/4PXwALUbf73Q3EXjgAJLn7G8PNUu/i8WqvLsRA28I7JtNC
         n1X3U4yj+fNpj0jZwTTXqwE7zcFkmIgvFmcA+beRKRrpr3qasrwqCyxxbfyIucbFGH5S
         tNSixG55q3cH3vWs+4R8cH2Q+SJawgv3BzXdkWb/+zXFBvy4/UK4ovUGzVlBgjVwbD7H
         6Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474954; x=1796079754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1tEJQNf35IgOuih7jfuh3o8Oros5NtAhKvmmp4nNmqI=;
        b=b2pn/KA4b5iGpqWLAznQXv0IrmmvsHP8W9XrZTPswZppiztN/oJP/JNO/nYmJEBKkH
         z5iGo1H17fP8iVZbXXSaj1vThZiDLHr3upGlBEHdq4/9iXvVCLfYZ3cLkLgCGrye3bxv
         uytn4UmKtngvVUkpfWNReR329+gAM0LN3z/yptScEWou8T4u34bWD7VExJo+eUmVBQxz
         FBEcQK+mnvO4uEBXMr0drRmo95qUsALDYX9q4DQA9lJa+xCOC2H6/yeEOWR8As5to76J
         Lh5dYfSdJ1fA7r+4djtH+26G/nEaimciDtNETp6yDc5faVGZspqm82g7ICh0T+tYAV/9
         d2+w==
X-Gm-Message-State: APuU4Z+ITfWogK5B6JbUsbWM4tvwNBnlYzTYc5FHqJrl8OFoEdRbCbS6
	Aad7UiGAozxuo8WPidq61ImaSsZkqXPvjBgr72nrHis9Evr0ED6wMhBA
X-Gm-Gg: AZFdTZdUQwNd5LL+NKcUqgsSYAQpzNESGTB7kLwdjncmPhQqmgTGvB/HEdHj5+76+Ru
	w8h/rtBCG+772gk8UMyr8wQAQ7UYdktIim1H1+S6o8sum9Eo+ekfSUEK3yqMG9jCDHrWCqQAQN+
	IW1kHm+2aOLXFOdXPyKPueAsCYl0+enMbQv9pLW63XT0bKRODs5o3Oc/+oDopg6eKjGEkwcAUpP
	Y3/gNuP9STbld47ttSUjcJeMc6xEQ7TnkbX1bgWCeuzfVJ6kiraBuZycXbiuqc46XGK001RBgNR
	1WwUB509FxixfDIPOrHgULUlQ7M+oL50etgq9Xt4WXmEHPu+gt5U5PArLKE3kVunuBedTXktbIg
	ZLgQYZITmEaD+pjZfdeu5LD4JA7eL/OjCzKp8QuwNrn84sVFhqAXS0pm+nulM/S8AD4HMMLtrbI
	VYbwhhwVAqlaXjRVJtzHTINvScVEEY0ndTq5bbzAib/hkfFWrtM3z2FxmYSftRTtARBLMPWdxGc
	YBEyJ+uA5aSTwSXQB3JifK1Hw4x0V1QeFCxLCYT8JIjf67Bp+f9ynj1VcW3T0S2F4LEcUtwU6jH
	FE1ggUn2Ebhrr2ZWWd2kiEls8OySFCmkH5BByC+Pnyvpk6BAnaimw4r7ecdiAH1j6fO5kMMVeLr
	+R02QoYJCeCJp2zhvhJ6E0w==
X-Received: by 2002:a17:902:f645:b0:2ef:f662:6bb9 with SMTP id d9443c01a7336-2f03efb0131mr140573735ad.5.1795474954225;
        Mon, 23 Nov 2026 15:02:34 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0457fd68dsm52213525ad.39.2026.11.23.15.02.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 15:02:33 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] object-name: use Q_() for the reflog entry count
Date: Tue, 24 Nov 2026 04:32:29 +0530
Message-ID: <20261123230229.4545-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqa4o2z9ra.fsf@gitster.g>
References: <20261024152931.440-1-aniketgupta3001@gmail.com> <xmqqa4o2z9ra.fsf@gitster.g>
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

> Your v2 must be a reply to your v1 message.

Apologies. I resent it as a reply to v1 right after:
https://lore.kernel.org/git/20261025061222.382-1-aniketgupta3001@gmail.com/
