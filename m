Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A047B410
	for <git@vger.kernel.org>; Wed, 27 May 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905921; cv=none; b=T5vLXoItAujyKx0NWzyHh1ccdDhvrgkAxrmW3Icc3GHzW6ZBXP+Rq6A85Q2BdcJK1dV+DHfHJ46ywj2BS7m19PV5KO74ZckXZcxuBKRLP+zR356UpkeBH/MTSea9z8D4fRd8iHShVaPUWmHXtLE7QFl2/7HwpozixtBYCqZUY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905921; c=relaxed/simple;
	bh=THm8P41Ee3HvaURXjJx1sdCQfeOn/JP7a4lK7kd12Es=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gX+jOmG7vl/UrMmibHtcnlANDSXBtGkkedVDAIjjk2PVuolF8NVnGGXr4zJyWOZXTK+jBL+inrtRu/8kPBIMht8cDEdSROBIWzmTlmiJrV97UW1iRCWQM3vDNSNQ4W/4vOfk6cYEk/M9fcZQjy7iMSZlKSDp5lOfMgbc5McCJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rY6+8Ovk; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY6+8Ovk"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13621cca8f5so894737c88.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 11:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905920; x=1780510720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxIq0bCmCj2FAfOB+DcGyf8oyAhb4ftzcRGEcZumrz4=;
        b=rY6+8Ovk1G39uOVJOedB3uWqn8pejmwSIv8xZDiS2IXV3e1PMwDB4284Bg2gehlb0C
         Gap7NumFikrhrDKAgO1yFaCSQUipp2/cx4/mi2++rS42gUW0FXHlV2ndj+v0Q0TlLDfs
         tKuf32HOaFZRlSlo5iilA4CYWOOxLevQiStZWm35wVJglE3cZhagJtl3mBgKtyMmTF0/
         xBwYap6OEBOeUSbqtIijzkhA8nJA0QgHw6kdJnlulS9odAn74YNzlvnRJoDsSqsFmg0w
         HgyhlekJh0k8DZa9kEj2bB+tmr7CBKkVLRRk+dVTABYxMXVvefcUIKHwJnUBRDmshd5a
         9WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905920; x=1780510720;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxIq0bCmCj2FAfOB+DcGyf8oyAhb4ftzcRGEcZumrz4=;
        b=i01fkf2aJMrIQT8XbvT8EBfu59PTJilIdGL70BTS8vc0AwQovEnBaAyYOF05obTXpy
         5p7LgJHLdEYa8I1beDuDMlP4q3GovYgai09Siw4e2cZdfTlRxqU0iG/aQopHZUuE7nBK
         BuCt80ou+h3m1H9ri44ddq43IGnQuX0rhOe0oDuhehNA0ESsvcgRW6nf6cNRM5SmAszW
         rOWxBslui5sCg+uCEwnEX0RpyoOZ8tXjGxl0LJxtviE2bY0VYjq1ZrxHW2cMG8M0VBx1
         +b7gerf8qqrx7y02n8xJZUh10JXYrYWWIjqdVcPoI2OH9PA8ZrB5jic0QOG5RtoBPk3B
         1NrA==
X-Gm-Message-State: AOJu0YzNvg9aPJXNkffQBJm8kzBi1T3ZnGxRI2LRlgNZYhxxUxBz1KmK
	JlOo9tzUK6O0VM0mgh1IG94RyOBlu9Wj6xJgOH7Kpo6AbSmpZI55JORHTH0/Zvyg
X-Gm-Gg: Acq92OH8UOONSxxBp1FOHvSD4vpr2FExsrVKBLFmKHQJfqnkwtUu1tlwDLkBMI9i6n5
	3hH2uFRhDCHMiD4bZZV47m795ZUQQpeFlgJfofwQdio1OzxCbaKx+R9/7i1VcLgOGV7DxlHN8qH
	ZMH5qR3riek5sdUIqMLNKafk83PR1Ad78XEgjF7qdpA02ARRxeijCXBeoTXMX7d9Wwsl16DtM6N
	R1S17Ld/WVW+peVSJ10DYqYjF7fN+xkXFCz8PSD5vMC1H6HtzzC4L/99gdYh5W745NbfoKWFXm1
	auTpvysC8c/VjTFSqBY9NobxPhmBongV74zaYPRR+i821fxK9K/ErOyDxeItuC8VmepdvWSZ8Xs
	P/5p3gM9WmffJ8ToH+kwgn1/kvN1qIds7ZUCheNvyMzXS9a/nxwwJlFsCnGXlZnLOgzk2XiwZEb
	g0OYLIuQPQRjp7JiOYy7n0DtiHIzHik2IJMgrgmrHb7Fwn8aGOrw==
X-Received: by 2002:a05:7022:511:b0:12d:ceaf:ffcc with SMTP id a92af1059eb24-1365f812d65mr8739856c88.5.1779905919296;
        Wed, 27 May 2026 11:18:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm13974816c88.3.2026.05.27.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:18:38 -0700 (PDT)
Message-Id: <e3127357169cd8264abca3d9379a0a4071a18b5b.1779905911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
	<pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 18:18:31 +0000
Subject: [PATCH v2 3/3] daemon: guard NULL REMOTE_PORT in execute() logging
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

REMOTE_ADDR and REMOTE_PORT are both set by the same code path in
handle(), so neither should be NULL independently. However, the
existing code checks REMOTE_ADDR before the loginfo() call but not
REMOTE_PORT. If REMOTE_PORT were unset, NULL would be passed to
printf's %s, which is undefined behavior.

Add a fallback string for the NULL case, matching the existing
REMOTE_ADDR guard for consistency.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 103c08d868..78cca8673f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -753,7 +753,7 @@ static int execute(void)
 	struct strvec env = STRVEC_INIT;
 
 	if (addr)
-		loginfo("Connection from %s:%s", addr, port);
+		loginfo("Connection from %s:%s", addr, port ? port : "?");
 
 	set_keep_alive(0);
 	alarm(init_timeout ? init_timeout : timeout);
-- 
gitgitgadget
