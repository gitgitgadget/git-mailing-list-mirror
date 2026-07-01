Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A119481237
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908338; cv=none; b=qRMJq15hNZaDyIGTKQQugXi1j2QvKDH7nvXB2UKLNRdpQtWhr4t764YZ3NDKJpsqVhunOFkodrbvqcyMkiYmABX+omhKbt1fIqZtAhVrmBtJiGNN17lKd3WKJMmHdQXIaVNYBw/HncdaINstWgDWIUyWbAVBuDkdXuv2Z+BO/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908338; c=relaxed/simple;
	bh=YK+sLZhY9Yt5SptTFmJhe9KBUuUL7eVUNpAmeCz7620=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1EjEMAEZi7sU0KKsQ/hI1XwYKCj75KwKLvOt0Izi5ew+p+eSGrFnlAieNvHRSfnG7p2H5XgA5N48lzKCzzeTy812Ai4rhTmmokcFtx+xIUfvEHx0dhGNGNyA2MxOd9yLYAMNn3HUgjmMSfc8xcQ3qq1hzqXrXVgEsDEA7Vd2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhpGVpDY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhpGVpDY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so5271425e9.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908335; x=1783513135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o9B3IWXvZobMseU6K0dSG9k21c5uTXgi68gds3z9Gs=;
        b=nhpGVpDYc7l8f4MtjeDXqhlHaxZ6hh39xLtNxgqOuAoxfiWvy5ZXS5oMNxNIayPAGC
         BRAL711GfEAfb/EhO7IHr4wZPnT5wt4ehsy6BowBsNGXKKG2a1mruWCL+5p5dqO0lK7a
         maTrD77cngsAvQI94Q5V0v/9SnX9qvv9V7ILfL8+r4AoTK0395YNdOBW5/Fw9e846pyr
         zmTNIMNjheNt1yRg+xvylgEWTXjcY8ZFt8PNC80iXAvgBemtwYbw2UrHe9Q1bYg6kWya
         w1EFsXjHW5Auz4Ehzr/q+PkFHxk3OY2PLNn2bqd1dp3B/FbAz40dCB23gr8JrUb8V8Qh
         Nimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908335; x=1783513135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5o9B3IWXvZobMseU6K0dSG9k21c5uTXgi68gds3z9Gs=;
        b=A0MrReW6jk1R1w8MtWcJoJUmQ3m6WSmOTPp1RsAzwveSf+LjEE7C0zDkPfiaPbJ9l6
         iV8XW2NVAQx7joBafXd2rjDLPNMJ9ZoAwdGl57pxCD60ZxruQPos06UcJwnUQgjQRoMP
         YsqSxG/zXgzXi6G3nkuK5t4vvacs1Ft4NseE1d3l0+eSABcrUa2SvZ4qLAaWLSbTmCBg
         gCy4xsIK6FYFUJqVFo7P39E2lMprbxlC5KK9HqzGbKQ+f6js+Svx1Lj1ooaRtIJu4h6a
         J4VhMNjJwu3pL7+rDM3VqaxIovNr8YuRhy7BuPFFY0t+4KP0SDXYwnWbhfGtI/XW9Atn
         V2Nw==
X-Gm-Message-State: AOJu0YzfVwuSDwd0TEQE7Ea8s2vO9LIJ5jpYSrqrmC9DIZUiL8XEY+5a
	E+Xy2kTqJQqSK9zURlfwelG8ZIeNcdxGYSbwetXZV3/B4rEjwi6no9VS0GbojLeP
X-Gm-Gg: AfdE7cl6dgYlsHzX+rYibVFnJFOzX2o2cerqB+5DmG46FqGbud5fs7NnHPABNcO0THM
	/oHCBMI7wshR8dNidWSbKyzTdFc+B3c0cjaKHD/HPUk7Nc5F7Rc/niE7uXAGOm5MqmcyBwGuWL9
	+s/6NrWyGpv4Wq2m8EfaJEsUHDZDEF0u/2zBNhhxiZaMznJcDWnr/Tc7nEPa5rNON5JCJIpNVFp
	DEKek15fy40zjzSmPOD7ntAASHEG6b1F/aFWZUazvuF7sjsUFPomiOagdU3aPXhS5adt13GubHb
	jD8xThAefa50NzhnQV2VHILLNHz5idOsiPUQ3sMEUosPcjb2Dm3pPnPFQ+qhvD6l5VbVJZWkQIQ
	7VNaKr4QAgJAS1TfAYDZz7aZqNLPGPnNaa34LgKZaxayYUV3lqGIohr2ABZLYWkcxo3S3pNKAK5
	FZAgKI4KbJGpFWmlV97OzyUBK6IXuclDqhz0i5ghxV+KEc3nWGBBLTEPflfI4iOBsChbs/EmJJ/
	S6l+pGF+iupDkp+GNtD5E1GheyDXa1vrjpA0Nh7o+HgC1kQC+8A+mk8EG6yUpB/ZdN2HTlN9fLZ
	lbGvS/9En/L4wuHlbz8iY6ZguseE/e7hW0uLIitk7jrVcFwiTvJLqDwnSfZ0LQhT5qlX6uadJQz
	+Y7YIKTfN/g==
X-Received: by 2002:a05:600c:4187:b0:493:bdd3:4313 with SMTP id 5b1f17b1804b1-493c3cd4ad6mr3636405e9.8.1782908335525;
        Wed, 01 Jul 2026 05:18:55 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:55 -0700 (PDT)
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
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v15 05/13] fetch-pack: drop static `advertise_sid` variable
Date: Wed,  1 Jul 2026 14:18:39 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-5-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

`write_fetch_command_and_capabilities()` is moved to `connect.c` in a
subsequent commit. To prepare for that, drop the static variable usage
of `advertise_sid`. Currently `advertise_sid` is used in two places:

1. In function `do_fetch_pack()`:
        if (!server_supports("session_id"))
               advertise_sid = 0;
2. In function `fetch_pack_config()`:
        repo_config_get_bool("transfer.advertisesid", &advertise_sid);

Since `do_fetch_pack()` is only relevant for protocol v1, it can be
ignored because `write_fetch_command_and_capabilities()` is only used in
protocol v2.

About 2, call `repo_config_get_bool()` directly inside of the function.

While at it, change `hash_algo`'s type to match `hash_algo_by_name()`'s
actual return type (`unsigned int`) and make it `const`.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f13951d154..ad07603755 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1380,6 +1380,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 						 const struct string_list *server_options)
 {
 	const char *hash_name;
+	int advertise_sid;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	ensure_server_supports_v2("fetch");
 	packet_buf_write(req_buf, "command=fetch");
@@ -1395,7 +1398,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
