Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177153CF1FD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913700; cv=none; b=S1s+BGKEILGs1AV0OcBz8NutonGXLlDAGxPhxeX/0wHVQw8jAtxducXisfsXe6S3sBRYhXPCD3sBYb4InbLZhKTRsQq0rOd0Lh8PF9gfptv79/WXQH0TCtYlzgcIkOL8Z74I0WBkKkFJvmaY+D0PGM4PpkyfKPx90NJtZiLn3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913700; c=relaxed/simple;
	bh=f62EsdEPNQVwUF5wYtG52yVBWaV+IstMQ7Ww8cGc7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmhd/Zu4SzXG2ggiGXEWlbp+BU6bQgo4K/4cghYkgSiToi5J0fWAahxqJOr5iuYjpOIiIPoG4WVComQJEI31/562f6zSOAtdAYzOeOFySW0Uoil84hhliOp+Nbrl1u78gsdanLTj7GcZ9rMeG2puXgvbZjN0tZryk4VFgtSJY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWmPDD+T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWmPDD+T"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so44283785e9.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913697; x=1781518497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3v/SfigXrEZaFnqWWaSZ2dI2i2jGUaGemExufyYqqU=;
        b=jWmPDD+TzEbACQLSzYBTlm+37xMy6sGaD9wmJ63BsUK+STRyfgVFZPFzPv/3xzCEBg
         GVbGYSE2I1hf6/xNVwXVdh31+DzaeBRPufxJSvZTF5tuX7RLv+FbiJxfaFoSewRzGI0U
         RjhwwzME7H6MyZz25jUEQ6lxV+cDhKKRLO01krv3vv+igRp58OuktZXoKOg4aehFWnyg
         fZ6hDLa2qc6kqqSCKJmvuI8B6QfPqzcXMM9zM8bRayTPxD3o7WEeU+b4GQKolRmh9Ma4
         uowb+W0dk46j6NwTuRseio2HvuYbHhyk8qqDg2q96WmH1CwJIe8lNtWl1npByEwwHP5n
         SpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913697; x=1781518497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3v/SfigXrEZaFnqWWaSZ2dI2i2jGUaGemExufyYqqU=;
        b=bHZcfo5Cr39P2BKp6OdKNMx6ACMAqt9mAHJdsw3mjzNmJAB2I0bdtPmx7btO7k3DXg
         8b7s6fHgpekO95OxSIviji8kk0PlDZpNUCUXj7Wm401l7L3x0dJLxJ2tIx6aXZwQTxko
         W83A57ew4M2baEI9D5QjjJaLElVMQieD+VS0HHol2nWz7FhI8rnTcw+6KAKtxG8X50ci
         G207t9lJ3TY2HAcpRQ00CTd2lso2TwMcMHNLHRFel95C1IxDnwMA77t8zslaiJd9/ar4
         7vCu+kKBb6uYxYIbLbbLrnZv1jttkk4eBPz5/wTjI0ImaeaChJoATLULWhASJ9/RemEK
         8VSA==
X-Forwarded-Encrypted: i=1; AFNElJ/ANyGxLegffD9hJ2xWGfaSQTEYcVF0wwfrRXcXnlfQ/2Jtu73iXOncqmTOFewfzvdzjNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+km72uekvqJiHvvhaEw+8rBsiu0IxH6d3ePioImrVGM52DteP
	QdLSD8mQQIF2tVTH8zvKoy2yM9VSzeuI8TyJkgPmzfqLLNxmpmmTOGjH
X-Gm-Gg: Acq92OERPhaXtgcDEc7T/88L3C0QgQAqEk7pOPwCOBKOmwuSV3vwZFMJsqHvh54si6P
	igXH7Q4b4Dgx9VtOuvq6E6IdXgAgSBMBM7IWlRczbAEm91OiF5E8Xo8y9dQXSzUwlPL7iTtxzFM
	OERJlx/WpB4NpyeycUHRuX3qYkVEYNETJWEnL5odwEZkIEKugzaqYODJFWAVwyup5gLdB1vzjnm
	S4btO5VqYcyQAhiIlV63U75QP4HjTRXjB6qYByKlICbRe7B5NaoA+0AON8MDlWqV+wkD+fB6mDB
	AFmyljlCmXU7+FAU+MOeM4EjQ3gCriz2V+GBTseKwjuZJB3XLzf3oMGDFhecwC3/Ao/X38Ucs0H
	aYWfzGUejD53HQhsBIrunDl1QO/AQ7Q8nhgHniiI6DTzSK/Fj97whqOGFdCwP7cPp43n39fBika
	tHSGyL97Xo3CZXYs16q47eilr4kheDTs0DWO1Xy9dpT2ap5PMXd6jRLmYF+JjwQyOchLdXLKaCN
	wlOY5i2MWcpeYAMg4SxT71dDXvCpO6yvJN+9Q0DuRKVtUZ5z0Oesj8IzyG0BL3pcwF7mYdt9KNs
	WF3Yxwv0B7x7fU+BJI6hSLfFiUUqNwfu6rSSYvjPQ0jM8otGNMEQgc4M9TWdxnqUXw==
X-Received: by 2002:a05:600d:4453:10b0:490:c2a3:3301 with SMTP id 5b1f17b1804b1-490c2a33392mr166302155e9.34.1780913697419;
        Mon, 08 Jun 2026 03:14:57 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:57 -0700 (PDT)
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
Subject: [PATCH GSoC RFC v12 08/12] serve: advertise object-info feature
Date: Mon,  8 Jun 2026 12:14:31 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-8-5338b766e658@gmail.com>
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

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

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
