Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39762931C2
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109150; cv=none; b=p0s4Kdm2w0CYWuDhZhtTAou/mP1LSTwkJyGzvzKq71lklG1n9spi2VurKKcC+60YZHoarMzvrY6iKOi9j/MpWNfE9Cjfyn0Ws45TIw4QoYqKi7RLaqdbxxNJQWstompSN0WDhrTpiyfFomJC4iiu4gb5L9IS82QEdju76swfhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109150; c=relaxed/simple;
	bh=ybf0XRPB6fGoYcQWEAjIRJsRXBy407C2wSdjBILB0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj+0QipENh5WVeHBZmnL/3UD+w9Jv769SlAMN+GUtI/KY5dEh1JIcekwB1yCO02jdzLqpZhWsEkVexoXHu2ydWkDPnElwcQgc2jp9HI+VKVmAIAwNtexJOf4/unQGq/wbSu8d1VO7k7aW0+9fMvF5IZZ1pcF8LDQ9rmXsL9HhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCvq3VeQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCvq3VeQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f365afc5aso1954041f8f.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109147; x=1784713947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=NCvq3VeQG0hbyKnB/CEqk6fK/oZQKCsJ6Xgn5YVZcZMqfTKZoUESAxPf6mXLGWul02
         KjncWMN+c/FTkD16DVEhCNQ9mE5SfjILO97gs7m+92koXuqyuCeFrjVachDUbBEl9fck
         2EnFu4izDHnXIoN/gyncpei/fTF6X1pBhZUxdsurUWqcI2MGcv4koRQAM1IqVAU2VcT0
         ZlgEZgcNp23MFwB8HRpQstRWJmhB0Wy03IApSIXsuc5VM4veRpKDBI9M+NEGqfHiWDOq
         mojgN0c7j23OatQjaHKTlEtnRc+rISh/VUtW/YUk5TX7FpMpY33yKEzUrwDzHpwoO7TL
         IJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109147; x=1784713947;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=CMTfFh4T9eX0S210dUxECn8ZNYAe2AEZs6oUDZ3tUq0Ky2VWc09XQ/0oMft0s+vnDH
         UuxGSTykxiP/jeST4tuZoJYvCzKE+UVmZA43KW9aIv6dy0JcobhGIdBtRfrUxMPJG9Mr
         jQJzI92l5ENdbQ1hh/vWEjpUBsdiWMpLvJwcr6MxhHCA9VvUBdzpYQJDUJeiChK6yxBH
         ZCiY78ddeVi3oZzQSZGFqytTor6IgvFt54oZI+4PoGA4VL1yhKPSdTsbSaJvcwEkALEd
         MhM4SkAc6DBWfpEJgBwTHDqDU8urd9BX480OzRNsfMy0NeA6XJ60y5I79tfT8JrWAeN0
         U19A==
X-Gm-Message-State: AOJu0Yw9ldeLgXkASDjZxEqBI0aWljS3qvbHqxGTWWYW/+VtgeuvImCh
	EL0J1CdjfXsua0eIUE1HwoP2CfmsjmRJ01d48xvbHGFJLZp9Dx7Amqibu43nV8fT
X-Gm-Gg: AfdE7ckqF/JUspAYJHN32mNMywv/tKXUolKWijS98dvbVeCgzQE6RTcs28pJsXXtElM
	yD0S3O+i0OOlxGseOXGqXkz/F3LQ0gNGaJ0M3Knp64/3M05bMuO2WnU7pOBvauBAyE31eO31+1q
	WuCNfy28uILPd5ujwGvD4Cy3ByJr1juZs5vozCcRo++YcCCMV4J8uRzeTIkswc86c8wCwlh+oEk
	/sda5eqGixzEB9RniBYBVV/1+yzIoomlGLIqmkVW8mbMRX2n8Mw+37rsivFK3uUYbnjX9/52+f6
	mqperRLOCLro+Cc0x0TcxBcAzvFI2bOpEC4PmVT/T7RAbny57ATplZNfwKx2UVcGi9EhKjNPzeL
	Y81QN7FzvyL1RQLQ4TLdfNIixc908SBoBqfsIKlgtrk3K1A07cPN2EvWJpy1xPpthGrd2gpvXz8
	svh1dSwreFLdedPLy6ju2r+XW0qoC3qfubpkAbCqRs2/Q8ssWMNhnQ5gNxhXrd06skNqW5d4uVp
	AztmZIwNIq5XgK8Gim2v/P8Km5xkUSo5I1tVO6P1D2WwF1Wd7lBL8GHQORxs+BxaUrklapLNaSA
	T03TBgcPwajHamYxP0A2ONQEtvynT6DTx1kCMmmWl5ZXE/2XjMLa2UQwjv4yHdOrv7iinKla15h
	FWaeKIxba2fqbIy3EZ2g7
X-Received: by 2002:a05:6000:1788:b0:47f:2bce:6f38 with SMTP id ffacd0b85a97d-47f488b281emr7120679f8f.28.1784109146865;
        Wed, 15 Jul 2026 02:52:26 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:26 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v18 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Wed, 15 Jul 2026 11:52:09 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-1-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper) block
[1]. When the transport is disconnected without the helper being fully
started, data->name allocated in transport_helper_init()
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
index 80f90eb7ba..f195070788 100644
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
