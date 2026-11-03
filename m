Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695787;
	b=u9k1RTH6yJVrl5ZqKgbKJ6d4pUlPpPLghzIp9EIpboHcWgQuV7Sk48KogonlPPHN+GgW
	 XZuPeMZAnQClhZvYv9lcmerNDiwiudXdQQIHxJpXY+RTN91rV9jMx3u0fD+kfym2rtsF1
	 9VcClF+KlGjQnrKdVp1sVultnuw4ARhy4F+HsG6LZCAg2UjRzdM0UlV6DUNmPmtclWB1j
	 DTkkcvuJkY1wHyF8AsmfYBuQp1VEoKUVc+gnChrFKxJMKFC6+h3hAd7Cq/Mjh1kWvKuR3
	 zexaMlPkV3O0v6Eqm79d31hxoLdknFJXjMDyzSgrisGjp55dw6vw5lrx5KSOhntD7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Itdb9hfNkDz6r3G+/UN1msnVDpEsNrOoiNHnIPMsMx0=;
	b=s16MeILZzrZPxJEJREbHS2gUytUCsQdSzhfCzPuuSmQuRuCGxqM1+TKo2a7DySPJ9Msp
	 KrqzzlWOc+WoKp3vFP/7QFQmpSjiP3xHr5EWUVkXshJbq+jy8/sSVdUrSTkNa3lyqTeNU
	 UQP5dfVL4BDCWoX+rRpz9eszHaQKtNzoRZ7x15IiJ8dm6lLM5YVUi0O5p1DdhnpGZYZF9
	 fayq2xn01iLL4MPcHygkiWcNOpeASEOTyqjd0pgwH4Buquqzafd0RLmjTQEfMCyLFWwZ/
	 SqrrtCRNi+85zSUvpIyzJd9RmawiGtV8cL7SCHwJuNIpsjfYD2QehOF4lxmZNHWQu0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HuT6VCR3;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF5606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75AF5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HuT6VCR3
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4ced671398so82534666b.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 00:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695786; x=1794300586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Itdb9hfNkDz6r3G+/UN1msnVDpEsNrOoiNHnIPMsMx0=;
        b=HuT6VCR3RIdWlYOV7m1UlDRVK5rZmvDw3C/Q6wH3Ledxi5IwqpxDPJO3mil2Mz+DBW
         jtS1sDzRk1crafoEL1gaZEufUGtCnsaQxp+RiIOPF4TzpDSEUgk/OWNYRnHnoviZTO4p
         T8eSUlcrlvEliv6MbWybU4MOelqty2rqCG/elrEPLKQ/O7EZtm2himBbshw4DIX4GBo2
         393MwIP/c0t1Eb8qhmGeOid8H47lFvqw/yHbp2q1ajcqbX1d0JJflmpPjROEheQ2BEK3
         XM+i6vkg7/Tege7fm1kCo95gRE9cM5alYkkW592qu9H4ukiTocQ8FPBVio5ZZjFl1x88
         CmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695786; x=1794300586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Itdb9hfNkDz6r3G+/UN1msnVDpEsNrOoiNHnIPMsMx0=;
        b=cUl23sJ0GobzhPRP/erijD2ZwMS2JxaOeuy7sv4JCLKdLXd3xhi0v009+vlCLBMORj
         9bgBCKX81kyQsGrcO+QkCoynIRJraESve7XZ9XZ+8zxkCyHO+2DSctWH6vnnYIFyfWJn
         G2SwvuPXaHDpYq2MOVNU+Ej3nOTaw9WG9Tkjhkv317zuV2FhjWO0BwJiqLnyi20JIDgi
         iDeDdfpqtnkYrs+WQixS1q76xDl341Cp7/0PfwheXuuMTGc/Fh4uU105goiKWRpplRzA
         Jx/XqNgmIm/Skyvg6DW+6MFXJFSnTO2u1EoqfAOouBlta5XZVwVPatsvPbvg/mPfYPNo
         Yw3Q==
X-Gm-Message-State: APuU4Z/w0gn3M3+s3+E35Cbj/rqPF9BOu1YNHH78BZTsOiXHIZF7dhux
	06UrHR5U5/+aK6y36OEaLwtD8opZM5mhl2wS4jVxXQCQk4t9AVZAGlgMBTjSTSTgiBo=
X-Gm-Gg: AYBFou2SfSleFuKaUXPkxtROyZ5TIayK9PM0cpGhzGZ9lTJKI8+MEY0c7mk5/N9RM2X
	fJ3Y+g4H25L3M06+CQOM9/Ww3z/6YGpAR7BTcMnAZ1kvRuAfTyp+y17VsZzClVVRkirPbtR2Ekm
	Fq1tR8mWyLebuLs6RP/aO+A3pDbN+6exY+bQAX7xAPrd4puMHUjnprH0J9oLI/AV2GgeMShyreg
	2TY1bAxQZ8AahAFiM0XXlz23kpYuycFjNaPdlub6fP12G2JfdoOkB0aujGbFMdvnoSxer9Zlb3B
	qhaXKPbdFjbOKOzV9UPn68xCTFBjeh8vknNPKd+jn8egDpy8NpYANSvSP62QWqHR/yGkQDWpG4r
	DAyIG5DVzJUtw5KfjWVpyY82S4l0pGbJMvgGj7LOCWXWw7cJcr4vNW3myBZvB+ySv6sZyGkpK+J
	K53adO3u5fLWqtnBiUcoUtRxmun0gm2COPwIaIkz8p6GfjUaCOy/6IcgBX/EFyL+Pm+tubFWcw7
	0diavkaDB9VKAPaPR0nqRUxu45tWZLGKFpmSBOcK2JEEbW7nq3Tl6GKxx1CmiG+YHFl6BWij93F
	xntl4UvXG9wQe62ZMAT83AvfpAylGZIxr1j1ZVYfHE9biBsTiU1oyTGMMWPamdJ6oiTEdfSfNmf
	TISdvZZ9eQ5LKCsVIo+wzwSuMzgVPEHlhv/mV3lTd464kiooucLj7JWhfFQq4Z+CfwXCjcmJN0t
	zXeSs8/zyuw1xpTsdlH2NDI6HeUciN
X-Received: by 2002:a17:907:7253:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c4ca7aa5303mr1014438066b.42.1793695785701;
        Tue, 03 Nov 2026 00:49:45 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cec15a904sm64611766b.70.2026.11.03.00.49.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:49:45 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2 1/2] notes-utils: use the passed repository for notes refs
Date: Tue,  3 Nov 2026 09:49:29 +0100
Message-ID: <20261103084930.15532-2-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103084930.15532-1-okhuomonajayi54@gmail.com>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
 <20261103084930.15532-1-okhuomonajayi54@gmail.com>
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

create_notes_commit() and commit_notes() receive a repository,
but read and update the notes ref in the_repository.

Use the repository they are given.

Keep USE_THE_REPOSITORY_VARIABLE because
init_copy_notes_for_rewrite() still uses the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..d4606bc576 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -26,7 +26,7 @@ void create_notes_commit(struct repository *r,
 	if (!parents) {
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
-		if (!refs_read_ref(get_main_ref_store(the_repository), t->ref, &parent_oid)) {
+		if (!refs_read_ref(get_main_ref_store(r), t->ref, &parent_oid)) {
 			struct commit *parent = lookup_commit(r, &parent_oid);
 			if (repo_parse_commit(r, parent))
 				die("Failed to find/parse commit %s", t->ref);
@@ -61,7 +61,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 
 	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insertstr(&buf, 0, "notes: ");
-	refs_update_ref(get_main_ref_store(the_repository), buf.buf,
+	refs_update_ref(get_main_ref_store(r), buf.buf,
 			t->update_ref, &commit_oid, NULL, 0,
 			UPDATE_REFS_DIE_ON_ERR);
 
-- 
2.56.0

