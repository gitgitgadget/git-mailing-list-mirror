Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3D1F582A
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255626; cv=none; b=WfiVo5XuZYCtkHgwms/EuZw1CrwvJRlAZlpVqZe8W88KUXa/NpkStscI87l2rVjIlxt5DmXyL+GQ9o0SrUK1TeT/tgWINOKSu66B4oyjEElkrj3o6dVy0hc0zdlMEYvYVsIGtci6Wd5Er0hrAND9RDmYg8gdzq1XY+ElO6IA1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255626; c=relaxed/simple;
	bh=q/gcZZZa/QP5Cjz/a0LcGYL+6De3petWiNjVH3gr+ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVNZnUVpYFl6C9eITztblUkxX4nNsdWsRSQhjr/81aJHNnCWjQD2K0ZZYahW6890ObEkAyyF/kbDlqqPes5d7tlpyQpCwbaXOXQYOdBlfttpciK5Ihr+zPqmC86BZBSCw/pNgWdljwPSLpxV4K8BrQ4XO9NEoUhZgtdKNCHyUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8sU+ks0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8sU+ks0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so14008965e9.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255622; x=1748860422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ8FPghasBfj4AT0ZAOgURMbadEFYLYDVR096cMJmuQ=;
        b=l8sU+ks0A7y/tPBtIqUGvRoiEzynv0RB+XjUpCFdnwFfyGR4Q3mODDFy3xX7gsQNTu
         qmVKHh2BnzashiYFtUSSUxxT/dzcjFlowL6s1nw+zobK3mQEyV/oFzCa4XWsSw9FtmyT
         L4+jeUrEteQbP9ujBU2aUzpAqGIvtZprEHo5UKz/oak63VLhGFVnBQQ+GUd9bpxM1AKX
         5WuWAXuLhXD1QT5Cl58/OtslWIavI7S5jgWHTkXlUeeyb7U4lgEYr0GdYdWPcQy9lyO4
         BCukEqvtqr2cypVj/fd+VYrnZn1aphnsIu/l/8wDyHieievvSw2dVHCu8aVPc/iZcYnW
         BHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255622; x=1748860422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ8FPghasBfj4AT0ZAOgURMbadEFYLYDVR096cMJmuQ=;
        b=WJFFLhheK56hW8+aMNOHill/jcmFlgTW9LB6BV2UwjbPO5KrvjqbhfOGi4dD5hPUt/
         PczMUZWnmS8vTIkcL/aJ9emDSymtiE9xJeDPCBSIDzNG+3hnRR+1SXvwOqH2SD52E2DO
         dP4v69+DWpOhLWhQl/TyPfFJU5LsXnsWLJdnVvl1XXWiKGf6lKlbHjGjfp/oRGTmhFC5
         EPK3vEoH9ENUy7HPlrw4VN3Qa3O7XhMbBnnEWvUdOZ2rnNpkTQHByP3tjU9HjJVHJ4Ca
         eTGAySeuPsEgZWOpgA/4AwkrAZXZ2lV8Cyxw3Bfwi4Ma4uVkOqxybVBqCFjWxNZJrIjx
         XZlA==
X-Gm-Message-State: AOJu0YwIh6CRVTOX2Tt+S5Tz+G8HrtXsPDva4kWRx0e3dPrVlIET9DMS
	TRBiuHhSXIlVLnD/PdQHikYarEmQXA28VE7yXbX7uOCidKuycmzty7heKTT1BH4w
X-Gm-Gg: ASbGncuioiiJVLbltDpTw6fsTK2rEot8S0hTqiN7L9zK5nsKsaQ4tdpIXVvlHF7N7pb
	9rrUTjATVa6BDfwbD9ei3D4aCLluPHSdmyg6vzafyalNomFQxgQjv63T9rMI38KSLB6Zajwp0R8
	EReVWDNbG29nVWNTa1a6Dzpgtv+NjzZuK/8kHbxWgnqlKc1aCzmPLydQ4mVCaMhx2aTzIadfX/R
	DVMvkBXUkdDWNtjziz5dB1+7vMb9mkkmjhOJfGAtpld4FCQUygSNwET1QjKT0b94eyB4AH+cWNQ
	84gZC624Qn/4EAMLNUAzs2RegL/vUcbzJiaUxQ5u6aYsMezduDjU2WUatPRS0MnF9nx1gNhuKcE
	229rIKXqIsj0O5jM/PZz2ZwPaU4ZPVDTr+BZVrRNDgnunH2g=
X-Google-Smtp-Source: AGHT+IFeIRrOGx5chO+icvXG60zrIA/zpaypZhsn+1/z/JJPRDl/dVkRDfffFPLkstjxYqeoJXtkpw==
X-Received: by 2002:a05:600c:848e:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-44c7bda05dcmr81337405e9.10.1748255621537;
        Mon, 26 May 2025 03:33:41 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/6] gpg-interface: extract hash algorithm from signature status output
Date: Mon, 26 May 2025 12:33:12 +0200
Message-ID: <20250526103314.1542316-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using GPG/GPGSM to verify OpenPGP/X.509 signatures, the
verification result (good/bad/etc.), signer, and key fingerprint are
extracted from the output, but not the specific hash algorithm (e.g.,
"sha1", "sha256") reported by GPG as having been used for the
signature itself.

Let's improve the `gpg-interface` parsing logic to capture this
information.

This information can be useful for Git commands or external tools
that process signature information. For example, it could be used
when displaying signature verification results to users or when
working with various signature formats in tools like fast-export and
fast-import.

GPG provides the hash algorithm ID used for the signature within
its machine-readable status output, specifically in the fields
following the `VALIDSIG` and `ERRSIG` keywords, as documented in
GnuPG's `doc/DETAILS`.

The implementation follows RFC 4880 (OpenPGP Message Format) section
9.4 for the mapping between hash algorithm IDs and their
corresponding names.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h |  4 +++
 2 files changed, 78 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index e7af82d123..15687ede43 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -153,6 +153,7 @@ void signature_check_clear(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->key);
 	FREE_AND_NULL(sigc->fingerprint);
 	FREE_AND_NULL(sigc->primary_key_fingerprint);
+	FREE_AND_NULL(sigc->sig_algo);
 }
 
 /* An exclusive status -- only one of them can appear in output */
@@ -221,6 +222,65 @@ static int parse_gpg_trust_level(const char *level,
 	return 1;
 }
 
+/* See RFC 4880: OpenPGP Message Format, section 9.4. Hash Algorithms */
+static struct sigcheck_gpg_hash_algo {
+	const char *id;
+	const char *name;
+} sigcheck_gpg_hash_algo[] = {
+	{ "1", "md5" },       /* deprecated */
+	{ "2", "sha1" },      /* mandatory */
+	{ "3", "ripemd160" },
+	{ "8", "sha256" },
+	{ "9", "sha384" },
+	{ "10", "sha512" },
+	{ "11", "sha224" },
+};
+
+static const char *lookup_gpg_hash_algo(const char *algo_id)
+{
+	if (!algo_id)
+		return NULL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(sigcheck_gpg_hash_algo); i++) {
+		if (!strcmp(sigcheck_gpg_hash_algo[i].id, algo_id))
+			return sigcheck_gpg_hash_algo[i].name;
+	}
+
+	return NULL;
+}
+
+static char *extract_gpg_hash_algo(const char *args_start,
+				   const char *line_end,
+				   int field_index)
+{
+	const char *p = args_start;
+	int current_field = 0;
+	char *result = NULL;
+
+	while (p < line_end && current_field < field_index) {
+		/* Skip to the end of the current field */
+		while (p < line_end && *p != ' ')
+			p++;
+		/* Skip spaces to get to the start of the next field */
+		while (p < line_end && *p == ' ') {
+			p++;
+			current_field++;
+		}
+	}
+
+	if (p < line_end && current_field == field_index) {
+		/* Found start of the target field */
+		const char *algo_id_end = strchrnul(p, ' ');
+		char *algo_id = xmemdupz(p, algo_id_end - p);
+		const char *hash_algo = lookup_gpg_hash_algo(algo_id);
+		if (hash_algo)
+			result = xstrdup(hash_algo);
+		free(algo_id);
+	}
+
+	return result;
+}
+
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
@@ -242,6 +302,18 @@ static void parse_gpg_output(struct signature_check *sigc)
 		/* Iterate over all search strings */
 		for (size_t i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
+
+				/* Do we have hash algorithm? */
+				if (!sigc->sig_algo) {
+					const char *line_end = strchrnul(line, '\n');
+					if (!strcmp(sigcheck_gpg_status[i].check, "VALIDSIG "))
+						/* Hash algorithm is the 8th field in VALIDSIG */
+						sigc->sig_algo = extract_gpg_hash_algo(line, line_end, 7);
+					else if (!strcmp(sigcheck_gpg_status[i].check, "ERRSIG "))
+						/* Hash algorithm is the 3rd field in ERRSIG */
+						sigc->sig_algo = extract_gpg_hash_algo(line, line_end, 2);
+				}
+
 				/*
 				 * GOODSIG, BADSIG etc. can occur only once for
 				 * each signature.  Therefore, if we had more
@@ -323,6 +395,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 			}
 		}
 	}
+
 	return;
 
 error:
@@ -332,6 +405,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->fingerprint);
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
+	FREE_AND_NULL(sigc->sig_algo);
 }
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
diff --git a/gpg-interface.h b/gpg-interface.h
index 9a32dd6ce8..2b7701ca2c 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -42,6 +42,10 @@ struct signature_check {
 	char *key;
 	char *fingerprint;
 	char *primary_key_fingerprint;
+
+	/* hash algo for GPG/GPGSM, key type for SSH */
+	char *sig_algo;
+
 	enum signature_trust_level trust_level;
 };
 
-- 
2.49.0.609.g63c55177e5

