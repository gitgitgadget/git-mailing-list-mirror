Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BC378D74
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411427; cv=none; b=qrGv5LfKkHEXkKW9HtBa0ljLbeGh4xnaSDDDi+3yWFoTJjTd8aQTkQep8g5frhp6Igg42jcVCvQtiBnZz+NeTqEd5vbELZx84izABx3B3COylob4D0tsFvB9CfloylFLzk7WEylq3FF8NZIQH06ZPh/soVOSh3p/QQpgkrrRAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411427; c=relaxed/simple;
	bh=7R5lPx1h9vPMbKIqpPhCO21OWUdtq1b/9pV8dY/N2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc2ZHW6fG+u+DZNty4ulT7tqsF9PFBs3MVpXAknHMuOMBHVXnMabF9jvX8clTWFukRq82Iwc2jXViGRB3t+FgnKFv+1ttzkw/HU+AGl3wqz8GhUXpy7aBi6VbD408yCRROvjDDIKX4QmFpK0N4piSC+7DYM9L90Lr3PJqxmasQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4IDZblh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4IDZblh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c733f15aso77398825e9.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411424; x=1785016224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WWvImKuevgwQO7wSsxmfyADqWZ9fs366ywo6QqDaRc=;
        b=G4IDZblhN9mkBMNLH1dhCjaHezG5NRXNAM4FgRe6eiYsCDZJc/SfJ6xG7JY/DeqVEX
         BRvbWfiHmglIi9COp6ldYpW0iurfFtk1hGTWfn7tYcPxzcdnmSufTFVWbp6XKpvWqTBx
         G95OjJT2MCwbGH9AXabG2AovNevWzwui2diy4fRpVV4IiDDPGhbTa/iFmRKYOLk2plaP
         wOcNZzDEtSRx+wizwr1bKMczNW1W6D+yky51zxwhMog06jFy1GGMH1OjmelACMb71xWF
         d6XA4bQ2+R1XFFBChuSZnyqyy+pKlQXk78ZeR4rD0S97RI1leUwpc9uuEVP314FJKsFj
         Pj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411424; x=1785016224;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WWvImKuevgwQO7wSsxmfyADqWZ9fs366ywo6QqDaRc=;
        b=a2/Xm9znqWwuyCTaXbr1cki8u28G3Qmk4XSsBI4NZnDvolqkzhu8c95KuqTuDLrm/7
         MAf1WW36dsyQQYZjSGLdNsnGQjXheDMACBYTZ60zQADQ7gqz0ST5qm76ijhNdVArQ8mb
         iaAT3C38NSRp8H2zPbpT6YutcHC3hemA6wUA70R9ZfEFMl+7A/QAHisAGUFCiTBWhuk3
         ajbF9WiqK5Y0QCalI5oVytE28mYpjlCjnd7VR3werFbtLfNYvnyisUdBOTO+hU74Ul2O
         kI7I4Qlcnp3VHXQOm3v6kMw2uwnOP1jAs+NWmtafytNUZGr9+9ygF7CQcdMd9nvp3DYg
         ku6w==
X-Gm-Message-State: AOJu0YwEkE+pPJAF2eq+CUtfVNrZ3jLneDvfSe805Z8zzBaj25HqU1hF
	nWjzT091Q2tBrUfn46Y7I6axo6eZNdG3VaOW4f1KjqmAydKQziq9Q7JoZokt92EN
X-Gm-Gg: AfdE7clIM4j5XTudC3tilvA5voY+gCvH4jxre/nxTwcdO8fgE1y0lbEKQ2a81THppPx
	5ASJhPw2g8nqY/YXYTJgJrgsMo16YVkrAxIePzugyZ67rFDZP2PKaMsgbxuQ21AI2FDjvXtg30a
	hv/7mT7b97zu2G4B6smJV8JkXvsXKCXO7xQvD/ElenTCyuzWJZ+t1a37wP4ldQa6CWOiF49Es0o
	zQkvnj1jw/59uX19zFgq06+0OGrT6RtULtkONVuaroyCZ1A9J2YHX9K6+IJPYLtGONvlwCskgSX
	nH1ML6sbhVXcbnKBRcKdyxuQXgfNWAiA/gshvyvDSyV8wFKzyN5xt3+x4UfzFKD+mSBEKzgygwB
	SsjiMzc87lPVW4iXvZ6yw9dwjGF0e4XQn3YaennmtRE0T5ru5K8fL7ZLsdEwHCRu542tkTB3oM2
	bPhPvbRvWUjoUI81G0pm0K9GLsKJK1za1GSo8WGIruVhEZr5+YYgUzDPzDjqodxywuBZptjua1I
	U+UmfDUjS9i+kNTQ2M2XMuovaaEzxdojUB/ZlCfuBolabOaaoYQ9W6ivX3gLaC05a/P3ud5Cu3+
	gd45IsYJyO9TMCmfirefi3myHW/xVizh9IuGFBvQhH0=
X-Received: by 2002:a05:600c:630d:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-4954a3d6565mr79745225e9.4.1784411424282;
        Sat, 18 Jul 2026 14:50:24 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:23 -0700 (PDT)
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
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 10/13] serve: advertise object-info feature
Date: Sat, 18 Jul 2026 23:49:59 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-10-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This allows a client
to decide whether to query the server for object-info or fetch as a
fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
