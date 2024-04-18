Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0319DF7B
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477137; cv=none; b=Hvn9BMpDzHgo/rDumprGjZpK9rcEoIhleF9Wq9Btp6uxdR8WIYeIVCUHBWU3H+p9AD0ntkUUsyLDEQSmqPQWWX5WXH46d5r74Y4X+rVOsXk/wvkdykJhQgPABGu1vOWLmQmysB+sbgA05FBHZowhRVZL/4cQdG8V/T3SVcPReG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477137; c=relaxed/simple;
	bh=fJN+qBi0s5VNP9m8DpjehtGDSjxnFyZsPzew7s3noyY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZIv3IBGIEHPDxjgw653yuuYaeRDHHzWGfiTuKZEjv6lhchCG6olexGFpr6zrR4S7NhJmbxVexVrXjA6Vr4YVDEjwYTsfwGutJUQNiRspXHL5EL1FWD9CTDidkECRR7PgJ8VB7Iz3FhT7cLXh/ppceRNTMX6ZsxWPEsHZfqx7D7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al5ns0GN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al5ns0GN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34782453ffdso1308580f8f.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477133; x=1714081933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+wEyyaFAboVQkPPirt36lM7eyqSklJ9+eNmZA4zTo8=;
        b=al5ns0GN2OHgX+1YarMOXc5MbzFTMgxVllOPrhWpNMQKcfAOEULjahslCgHOLNRjS3
         Kq5d65IHw8wBrZwRccwy3C2jbhAXXewUa0eSGUPDyfI1trwSTpIdSQ9xWgZUO80Q/i8V
         zutexH4XfvfsH8L7NucxJbTq66XZ+gXk4hbIRRa+mWB0xZazhzi5VACAphkS+yuz/stZ
         lItTVnbu5u+HeCgU1KK1nTu43iLfwzYlzi0jcQnXyVPYXbGMzXdvYEdOLRC4A0XUhMeH
         Tk+zdvRoiUlKUyuBZi2VCtrxXJhzMVNilJWRzv0FflRtrV6uo5O32hFeZvRnVPaCEipL
         o4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477133; x=1714081933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+wEyyaFAboVQkPPirt36lM7eyqSklJ9+eNmZA4zTo8=;
        b=IoIkkjR9kH69ygA2+AhE1CT5P2UVd7I7W/xcPxXGLDL/MaW0XliUHOqCW1VXG5A/rD
         s7aLPCOIQU8CucQuTjBjQJYjCCwY8Eo0cbPzE9KS12wpjpkp8alRp83KcdT5EwG/LfY7
         JHAU4XoSvNl26q8oV6FH84YIRliDeB/lf96jepOY5x1Q84ng1w2hycEvrfy0OL1NIfoW
         1qddv9+4KHDHjIBVBRb93UL7Y7Mgn1ig7cbpFEmukyXPqBv7vnJnVlsj3f8GucKlLbaZ
         WUqKWTDRe7Qk9WefSsABsAAxVj6+VUZHiO2rAeP6fwFilJHmnO9LqbwUYhSoAJcZDTEN
         Xg/Q==
X-Gm-Message-State: AOJu0YwifleRW6GrKKEBvyzr+CpS+HSlCeU1w8+jA4W1C9kyOhoaIz19
	/zPFFdch6aY4lXIGPNs9scGy9sCHoO8y1dLTGBQvtW9o0cgGjzWRZaIk0g==
X-Google-Smtp-Source: AGHT+IH5ISbHAbAP7GejloAjHzDNPaOHIsdVbD+fFINq8F00LpZLpgenfTWOY99VuS2kunZvaXjsAg==
X-Received: by 2002:a5d:460f:0:b0:349:cc8c:56ed with SMTP id t15-20020a5d460f000000b00349cc8c56edmr129619wrq.6.1713477133505;
        Thu, 18 Apr 2024 14:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d6da6000000b00346ab3c372bsm2814619wrs.73.2024.04.18.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:12 -0700 (PDT)
Message-Id: <ef031e3004739fabe2ed07e33cd5b23451429f8f.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:52:04 +0000
Subject: [PATCH v6 7/8] SubmittingPatches: add heading for format-patch and
 send-email
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index dd248513a50..ef3985459a4 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -430,6 +430,8 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
+==== `format-patch` and `send-email`
+
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

