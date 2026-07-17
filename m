Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51642D760
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300740; cv=none; b=HRxeQwsL9698qCvlLShzEyI4ZGPGx2QvLITFgWN1KaQ+z7rRUbWCG/UYvONORqYKouJnNj51SNvVJz3tJxJMU3aS8hgVTmob3/H2UDN+Cso6Y8CGcLhImhESMD+FqR1v1eh8tmx9B35KC7T7Ip5WWqv0a3hY1kYioUoD+H70sZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300740; c=relaxed/simple;
	bh=ybf0XRPB6fGoYcQWEAjIRJsRXBy407C2wSdjBILB0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYFgeARJIPf1Y0qIU6IiDKm3Snd3+faKSAeNywLfBVtehouL5ycIvjhM7HoAbyz7CjQI604Skl6cB0KwFTukY+OGNgOSyH2IaNKVtot5Y1D1Rdz0HmHnQ486BIkuiu8PWf8QpwYKlCptzx7RdHoqiPCeex7U2Z8ZFoH9yfXVrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQwABrhI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQwABrhI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-475881b9a4bso4616816f8f.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300731; x=1784905531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=sQwABrhIdN4llehbASo41+7NdaklLjnKkMywrgjPI+ISYuORy81ojAAYuu3G9wriTW
         yvOD2zHMlBOz7qCbSsZ36576qkk+Hz2oDE2v4+T8NaswISCK1nFAiCpFhbgsWaFxdRp5
         qjfG4LV/4Yenn70fw0inrSR94yZfFhlGv/J4lx7ktvO8LnP64e0qeRisEMK4ssXCydeb
         AzlCaWXlInJIyYqsZ5bBWG2nT3SyKSyXbOs5n0XFEA/SwdGz89HijB2cqeiIrro9SJt4
         HDvJfYBENXPTFfRNsn7BI17s4H9p/gWPJO8nWmUQoclcZn4oaLICVGn8gMVmXc9qNuaw
         JI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300731; x=1784905531;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=eDiiZ1U7uroBwS+pitVLsuedeJG+TuOYXjxDVUgD4Xg2iCkf/6ROHEePuYdkYTV8Ji
         LQwVb67p7HoJtdXRBYkaGcWagTqWGJlNPocJVdJuF7pyv1Ihx/xbmK8PVMPAYdDfQ3xu
         XNyAdHbNS/1uzKBIYirferEPR6lEkpMHvYwdTu0ibmBe1uW8Zwoxkaau6iySnRj4UXLV
         mmUpysFhlqrJ1797Vo0GW+yEYUYVp4xa9rRyEo31Tp/n9ksErrjYsJ31RjuEgNDIh9Af
         ETROsmu2zyUbrOXY2bwwsWeMTjoNdd/qJYK9Kn4nBU6ScvhA7+wyZdf/z4AxQVt8QxEo
         ugrA==
X-Gm-Message-State: AOJu0YxPIxdzwqFcSKCO34JpIq74pC6MT4ho/YJ5VGIEhvlJAXZWPWDi
	xQbgNGpYsc5dVmCNweLyY+rbtOJxlmy+hgLHQ5IF5eHsFJIiq3X9d4k8Db3+ZOeU
X-Gm-Gg: AfdE7ckUqLx3OXmeMbhTbRSEnIu7p+Au4V5MZZ8Z9dluYu/1h2TAAivm90oGuujMOzV
	7ryGz/Hxsgozm1l16oPaUDSjSD34r1ynKdNf/aAvAmkX7ruW8KLtghqectTvjSQz+AyxuWwx75s
	g+efDQMoGiLi72iqfMq1o/o0QIZahX4MB6gNAgnW92uYfVObvNgx++VbHlDbMS9o/I2FzlNIwA0
	B9o+/yjeomGH1MOH9gxyxb6iqIXxY02tOu/8R4H6MJvMcx2Wk1s8fCOHNXqDN54xnR9872ogjh2
	UDYn0nycwx13C2s+F2nVYFbaYC1ih7HdGsF+pEO4Jw85iUIGzGB5E4fX7hx1F7RNb0dhp9JtEFv
	HJ57YyrBK6umhTu7Z6xSuvb8UDAI+e26mLYNlmdf6daVyOPql1Efda+0U4FPdxtOkL6LBFzRIIG
	3Tss28jcbZlIB4VhhOFMi9z81b0S67+DH6LZVI6PgTxB6oIVy0vFmEA1FHAgIoYCu/hS5fyJ8KU
	7rLH7j0XM/4AAH1Ch8FRegsvfnnahllPgGT29KK07wV35jdIAB3EzziJ3kvo9VtxOBPCKK4PwSb
	DD9tskx6CoCeXw812C0lWUeZJv3Hdspz
X-Received: by 2002:a05:600c:4f54:b0:495:4815:2c54 with SMTP id 5b1f17b1804b1-4954a41303amr35553065e9.34.1784300730509;
        Fri, 17 Jul 2026 08:05:30 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:30 -0700 (PDT)
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
Subject: [PATCH GSoC v19 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Fri, 17 Jul 2026 17:05:11 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-1-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
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
