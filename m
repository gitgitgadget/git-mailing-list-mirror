Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30E3CD8B0
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913693; cv=none; b=NGqxFZXXiR3cp5NvxgNTqxsjV5gcK1++FKDiwdR+V7L55cK3BCsD+iORLMUUlF6XTABtxgs7ad0SAK2tOMHS+Qr0FREcKnJE1BAqbK/ZySB+upS08ucM6Efc9WTBqww1C78dybNY4HiS8Xkm5UfiPsEnxO3akAOeHjQIvy6THaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913693; c=relaxed/simple;
	bh=yi8qzduqaLUmF+gpxHpA9+ZddY5lWZdTzF9er4U7fbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3LwKEEK6K99s9Lm7c9j7c9O5EWrT12nSeavODY4oBpFsT0SJpqCxhcRsiR8f0vmndtIyRERxnDCSyzgzDhFrvqDVWtMzDRKPdfdWn4ppJJN9IsqlvN4lVNEf7X8iIoewOg7kGnUyvaIKp84jkY432uKo40dYO8EGLV4R4ijAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfAjRREm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfAjRREm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3e03939so33937605e9.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913690; x=1781518490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu8fB2VVxB73Igf19dWaECngQxCXUNrKsdj3qZMUUUw=;
        b=VfAjRREm3gj3TFWi3bJcQ2QrBWw74WxAs4MqmnO1TBG1hoJ5uUuE8CZEfAMXqdoLct
         ddpDmTZCwdtWdxdSfUq9eH8zfRvdRkNl+GMgQMR/eEEWDamCcRyR7pKAyAjlqyViUr/7
         viRhiTOUvmg7VsvIt74P0evnW3p8vCY1lHMVGSpRfSdlFNkbOlHbGftfyYtZn+Z1SGF7
         trLouk1fBJeaXI0QGw5orM0N6jHuhFbFWSwLSxj441U7rKtNKGNa8QX3yt6+oeJC5BBa
         S4E7TY017vlboaHI20t6PiPQKcY+HS7VxLdiKFP07ewATKwKRAcpW7j3TtK3/HrmsWCV
         pAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913690; x=1781518490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mu8fB2VVxB73Igf19dWaECngQxCXUNrKsdj3qZMUUUw=;
        b=gOp4pnyiV10ZtYJmBcy5lbqn/RbWWbABtw3lJC4QYrS2lLsS0xFj3sIDDN3fB5h91G
         b8mgbVqCrGVzOw+npDXNsaolWL8YrXndK/5amqxkj1snCIKQnJmX4l5NCQjaDSwFOpM5
         m6HqPnxbw1kGVQVNYePKJIXs7p+87/9nBNYeN/UboJjqQMLE9lusc2ktxGcDmOLgqylP
         gPQoetYM7xhUsas72mADvp78dtZ2CZyc6040vo9pjz3r9M3wc6Zdw0LtVGl8V+Ph8lZw
         7X65yJ+GdTsHSlsWSeLO92bWX9HIPShb1eBjWdcNPnpjiL17fdKOfeXj8YPTbc/Lm4VZ
         8hyg==
X-Forwarded-Encrypted: i=1; AFNElJ9DGzx/TrRUa99JU1ek4FBindw3/RqqeQFB21qH8t6sxpBEACdgHSQ/EqRtKUT/Ms9qHgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UNBTNFHxpYIPNOZ2sjGLW8tw4ub+/YfH8s4Ifg1D0RtF1aEh
	NGc8QLIWuhzko9OMbjTCiXNq3LliKk685/32PIkHm7V25d65Ly4MCQQfjBfeHvj8
X-Gm-Gg: Acq92OEDjHk0XvKwvtFnqRRXP2ucUr7SS8Cctrais5UDLxPA7gdTeH2/ITSiOIarJkn
	0tqAJ22U9GedrbeCSNmSBU5v9bm5ExI7rCme1Ielw2R/iLucUFOZxOO4rjnLM/0C+gv2yJP1T2F
	I5AEnbww3tt3x+/xeJ+EtH4D1LeMaTOYJaWCFzru05WD4dKkIClK9FAwsVhTifBR9O9Ys/NE3m/
	fLJALXxH0PJ9tcNOg3SL/9gD8wIvLwJJVNOb0TKDHgGzg1P761OAJYB8X+kY3q3Ql3qFXipPnJV
	SpJJUlO7hG5/S0xU6IH8dwT5X7PdXJbgYzQErX1PJNGbbYtyx+ks+4E/Ta6do2gf6nNbD4KbIiA
	kw7iV7D3/QOoz7tH5Cl1xKT8ImzJDMKTRMThDJTtF3cm27Y8jfZTgMsyu6/ljdbR8DBvtfnoDRN
	LYBs2ULTdPI3G5m4yd9DZGXiXuyY/SQlDnaKnoHD63yBw+GgwatrxJbKvTQEiZ3goyry6/QI7Sq
	JmCdpfTuPdh90gIF5TVbXjofbvvcIrTw9UQdzy7REy7NM5eVPI5A1KhJgM16b7xm+JYtINUzkb7
	yJEbFeaMggFtrqd41Jyx7AYMUPS+W1pQgqi0OOaIVo3VT8XXcCkN6PNbK1XTOk5dUQ==
X-Received: by 2002:a05:600c:6096:b0:490:c1cb:48f4 with SMTP id 5b1f17b1804b1-490c2d038e8mr187429735e9.12.1780913689858;
        Mon, 08 Jun 2026 03:14:49 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:49 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 01/12] transport-helper: fix memory leak of helper on disconnect
Date: Mon,  8 Jun 2026 12:14:24 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-1-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper)
block [1]. When the transport is disconnected without the helper
being fully started, data->name allocated in transport_helper_init()
is never freed.

Move FREE_AND_NULL(data->name) outside the conditional block so it's
always freed on disconnect.

[1]: https://lore.kernel.org/git/05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im/

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 04d55572a9..20a6ea8f81 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -266,9 +266,9 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		FREE_AND_NULL(data->name);
 		FREE_AND_NULL(data->helper);
 	}
+	FREE_AND_NULL(data->name);
 	return res;
 }
 

-- 
2.54.0
