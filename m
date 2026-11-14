Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682098;
	b=SmI5Y543Ejdh8VxS4x9+K80KtMdqlqJCK5aELUNj2xniAKXIzj3WCVEw8HzqWAsBpq4l
	 9Il/BaFoaz1j1lG6ZOGvGdZjnG0Scp5zWI4hBAxD5KQZBt5cyMKDc1nAV6MSacngZXfRa
	 K7iU/s5AjcLtE5k1HWIw68XIlnO6vihWJNZHS2pIV6hRVcNLfAJYNnP/R78Ma7TC0UG4w
	 tqTaR/41ZYo12xyGLlyqLvoL89Gs9nlrMyJXhIPQ+mHX/83Fo7cK/3oOSK4+oli3S+nZ9
	 KFYL0h5AX8VV/od31XhLRIz128nRUIYvQ6PXuaAK8zYbzKt0F9EX1rgDjKSxy4Cs9qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wJeD6WjT2Jh3rxkcUj1K4xIZFxeuj17LydVuBLNyvzg=;
	b=f5ZV9ubwN3dmxG40K3BzrLM5WNrxN5Krwdo359JsZUlmaBxsVyhavAK4f3T724sDYUpe
	 TO6KRL/GFAetXh/jFNUUn9Cgnn5pr3aDWwiNrwSrY5SoTBaSnW13CDgGC9ZqOKtS/MKtv
	 D0BCBHTwMvCTbUFexXtO0DrXwSiuBvQOQ14ZT1a3lc3CYnCwB4hMfqpMevFT7zvvfKgFS
	 UcnnjCXCcojrzWr9m/Fx1JPqmMUNzExLGt/QMY0wEOa2oyzYbBzjTTIO30QcR9XqPpYgh
	 +dgFza0//y9gg/Lwc1rQaeDG7yYdGZyri7QRE6thMK+UcPVoLa9qLKhQsMKhPs6ymrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pwNnJz8k;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9E606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F9E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pwNnJz8k
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb61185057so5163335e9.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682096; x=1795286896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJeD6WjT2Jh3rxkcUj1K4xIZFxeuj17LydVuBLNyvzg=;
        b=pwNnJz8kRZ/CIs/G2OXlbuUw/rWJEWeY5Yv/THw+rkr1gsn3xmOSLwY9JvUMueeZTk
         PWHbbg6NC2O30i/nwf3SejQlhdcE3QqTACIowTxufNIQ/ENxXjNDWJhzkOg04sdj/qJz
         VPr6zYoT5RbAa6q/pU4jGQv/u4nj8vi8dvtXEQ1MhUHzSIQi+QCUo0/70qTjxPjG1vla
         Eilw/I0PJA1+kK4FTPA4EvutjdaPQcdV/bGoahsvsxSfqBSiH3p9GocVarLJcodYDh7L
         z62sXGyHhuhEKSI5IISAaDgd83lqpGcZAyvhoGes3vKBRPA3HwFF6ZyQH3V/K8+QnUqC
         vJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682096; x=1795286896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJeD6WjT2Jh3rxkcUj1K4xIZFxeuj17LydVuBLNyvzg=;
        b=pTq7BIW6pgbo5grB1HT2rqT/ECk2cSInuuGaCbUpCqlglPfZ0fJ52dKU5d6RDu+4/F
         QtUXQf+Hk8DuSSqqNrd/YNzGedE7y23U1QWO7vw1szv2+ybU98C54TaoU/vh8SJQZHOA
         FLC/VR8QTpd2ccvTLh5T3xSq5UVPFO4VEhgiTirn90gRbI8rZmEo4XzwiOgjgBUPgogw
         LPj5afsDiHiR8wli7HNBGCxQ3m/ehJ2OMOJ6RVHzwl3AmhGD+EdC+T62S/PjVeM8+1tr
         uXYGKCBB8pmAZyHRLve9SK6RYDmVu3qIfsnUB8VTCvj9P7ZbEOWMd8N2sbxxZvK1E2PY
         HSAg==
X-Gm-Message-State: APuU4Z8PyJ3ySmrHQHd6wHLiedYbz9d7rJBsJulkk79cYMT2DZNpkWbj
	BTh3Ux4nmcAWrXaU+SKvPQ/U8UX+FwL0G6tVKiuw4C6k59MR+xPN8KMuO+QpnNK+1XI=
X-Gm-Gg: AYBFou2ok7Ia+t5VZ5nyZ/7wHgGsYUAGi0S2X/iRQ6xeNb7SwMReF0PHR0nVQLKA3/+
	Sjo7Fiw1g+y4iB1yUO03x3Fw0y0HKTKOt5s81YXSnrNkISg1izQ7+aFiflY3Em+XUchBkzcb9ig
	9LWKMuCLbul903sQ7tH3koDAmIHefSmBS+I1RrIdNC9kXy5iQV20EAnBrKbxoLjjlZL6QPji4Sa
	I0fpsdZ5bmAzNmiHz6F0HUvUa4q2V0d/jNJRPkIV8dPRpiDJQdo3Df8G/Lv5ry6yT59n7yGt5tX
	ZbT41yiUsSnEeXi7IPFD4X+5uKe1myWRDzyew91g8ToJHcD0x44Cr7NShTUkSm1XlHAoQrppzM4
	bGtqaLgJ8AVgIF4JAEp1BkkkS2spDaHG/wOdFwgoyCOsdSMaSNtkaTcfmgjjn/dJ/qLvoDyEbwf
	ECnLMYEA5+QSs80ukL6fTGCHMlRT/gKIaOy9F/f9shxpNAt1Rhxhteu/EAnUojr1vPTnUdv4i3m
	34rQDS8MSWlt087FspQRATm69fxWqzPPXZtyM7L+mRb/ar5aQQUL7QB9Du0LatT5qAAFFPDvWyy
	MLaHwMNkGbVjq1d3i2qe0DbbXylIa+/BuOGFTYZ7XTTrU6tBpWqesz2p25jaRwAVvG2ThEX7HSE
	d3AOETNrV7IbMEMj9li2qw8woz64ZP91J9FJmuXgTao/270Dgm85lriD4H/JRSRn8pKAyOjRH5I
	dIHfy8eKfneA9WRnFLsu4wwlV866qajd3z
X-Received: by 2002:a05:600c:630f:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4bb55aa6babmr121443215e9.35.1794682095978;
        Sat, 14 Nov 2026 10:48:15 -0800 (PST)
Received: from localhost.localdomain ([212.88.111.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e3fsm128620355e9.5.2026.11.14.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:48:15 -0800 (PST)
From: Wasswa Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	Wasswa Edson <edsonwasswa54@gmail.com>
Subject: [PATCH v2 1/3] credential: make -h output and SYNOPSIS agree
Date: Sat, 14 Nov 2026 21:47:50 +0300
Message-ID: <20261114184752.1417-2-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261114184752.1417-1-edsonwasswa54@gmail.com>
References: <20261104202228.24642-1-edsonwasswa54@gmail.com>
 <20261114184752.1417-1-edsonwasswa54@gmail.com>
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

The usage string of "git credential" does not mention the
"capability" subcommand, even though it is documented and
implemented. The SYNOPSIS in its documentation does list it, but
is written as a plain literal block instead of using [verse], so
t0450 cannot extract it, and "credential" has been listed as a
known mismatch between the "-h" output and the documentation.

Add "capability" to the usage string, mark the SYNOPSIS as
[verse], and drop "credential" from the list of known mismatches.

Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
---
 Documentation/git-credential.adoc | 3 +--
 builtin/credential.c              | 2 +-
 t/t0450/adoc-help-mismatches      | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-credential.adoc b/Documentation/git-credential.adoc
index e41493292f..e12d429f43 100644
--- a/Documentation/git-credential.adoc
+++ b/Documentation/git-credential.adoc
@@ -7,9 +7,8 @@ git-credential - Retrieve and store user credentials
 
 SYNOPSIS
 --------
-------------------
+[verse]
 'git credential' (fill|approve|reject|capability)
-------------------
 
 DESCRIPTION
 -----------
diff --git a/builtin/credential.c b/builtin/credential.c
index a295c80b36..72e7b2af4e 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -7,7 +7,7 @@
 #include "config.h"
 
 static const char usage_msg[] =
-	"git credential (fill|approve|reject)";
+	"git credential (fill|approve|reject|capability)";
 
 int cmd_credential(int argc,
 		   const char **argv,
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index baf3b1d809..939e47bf3a 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -9,7 +9,6 @@ checkout
 checkout-index
 clone
 column
-credential
 credential-cache
 credential-store
 fetch-pack
-- 
2.53.0

