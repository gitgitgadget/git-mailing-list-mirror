Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEC3BB9FD
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910173; cv=none; b=TtlS1amYbA6eoQACnfdRwfUvyhrSazVoa16Y32xAG6jsGl5Vx3ga1/4qvV9kb04tvB09bPuFokTOzFN1KAVFBs9ZjsIoIypCyz2qKhph3Q++ITVmgLilvBREWd0aDoFLCME8DepT+PsPNNh8UaRzOy2KdgnHvyC1ukHm3CiGPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910173; c=relaxed/simple;
	bh=7Os9vQBl6mOMMJ+R/BsHiLIjizwDIUx+43wkf6TXBo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQVyonvY9YZ2M35OGFN7lT7w48207f2xL4Slo6iMOYAzvwzhYnSqiu3iwPwsI/GH3pp3roZ7risT7rxqEqcgD1Uz+nbflnGwh9qtZjAWR45zUZx7mQK/KtFasX8vXyxzzVp28nKtjpPu0lq1loniO0TlIxPLGolMpF25Xm6dtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibtis46L; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibtis46L"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso4600961a12.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910170; x=1792514970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdrSAIXvj0W4F2k+3UbNsZ7yOLUDhJoFbKD/s+HNG5g=;
        b=ibtis46L8FkXBZ7jJFa3XNN73IUXMf60eh5cG4jKOd4Q5nLS3rlad8flI5kvFeHOEF
         KzTomuj9gGLYtXWYUluVpWP/D3DRI7bGuHH26Pk53SdA3msQEjy3gaG20Aziro/vdU79
         22jH91r/LYKyGgfdierZA7msMLkLxxDMxBmLJcj/UH368PESW9BUUkIA8rMVKP7QLeZm
         XGA21TofgH7xdhcWR+eU3O0qqnWXFKeYCxsTAltVL3/Up3K3jj3iHduNb9riBxeYdC07
         DxGZnZ6Fq3jFYucINOCUlCi9L1Y1CYdLVR1vhqf3AEG1MIk4H6NPIIUCXVLLTtv/0OuG
         JVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910170; x=1792514970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdrSAIXvj0W4F2k+3UbNsZ7yOLUDhJoFbKD/s+HNG5g=;
        b=BDslVwZri/iGl5gD5BVXYnIUYztc5jsI8u8pr76K+V6x0utMQXNTdJVeOW9l1Sd+ZZ
         fOKUXORI55daGZR0u3ung3Yi3Fy+N5sNZn8QOpFC4X9mfl1oOJASbZxhnjNPgUrZPzvd
         DIP38PU/m5DbohAGkQ7Wu8nEBMLUBdjL3ovMNtoMT/wVyKP+IIwFMGpl/gJ8d9CTb1j0
         mh3Bj35AGXHhQVK9sLMN74/J0MF0ilEX4uxk753j+fdod/VgW6ThBcR4lQpS2dTNo33X
         oADHhLo7qORLPf1LqfCxXwVqMr+/lN/97oLfeziAadqGqFwTlAiz7bFHAOUBqoRp4Jfh
         1yuQ==
X-Gm-Message-State: AFq9FYIuKofIG3uXEkc/4RZqV59HdeyKGSkgqaCJkpXFI97Tn4xPKgph
	Al4wHFxfZdb7B2MEpJQWWnomn5b8jTor4+hGz+3zT58LPT+L93dyJE5XgEtmsCN+d4Z/KQ==
X-Gm-Gg: AYBFou0cLRW89/GggXtHAAZnNOZ+SoTpFr9NDcLNNQVGvT7UN+ciYgz6KZNuVr4dbHa
	bGCmbdbuY85PwWkKAzOaQVR5gAd6aSrImpyei1eb6VmflqEcOuRTNnmTfAv+92lasjvY4tyXuLW
	nIqGC3pirp0GKggxz9E/cVazIgLTZuQtwt3gEWmkSqvHui0hNF57Atq0GOE9qf9EDbYjW2SNltu
	aHpLlcPocFdVkXtXWb/aRMhBeOyDWjwSFOMgVVs9A3wyO1D/uRt5Js0SBnAJwGm+SmICtsd4jUj
	+iD/1Y5V+/QYWo/53nuQPsOwOAGlJjyrEcUbLXmdggS6IhVrV5L7SCG5vm2vcsCW3i6ZzQwM+pk
	5xySQ8jhUPHGeQqVRiX01+xQRAYC5gDKKh/OljrPd8o6bPRlffpQ0uZjhGFbt2zRVwtsYwuwAym
	RCE7H5HrcbAZG49bqS3oG5KSty/80vjAiVtIVQ4bQARUONj896GLJdMruHgLH8VlAgL5E+fy6s+
	PjxzBduLni4g9akhgIWSg9GRn83QRG+Jz5hLmY1My08YtUzOq62tH6flkLMvPpejbD6y5vVeywL
	lXme6Brwk+z1
X-Received: by 2002:a05:6402:3241:b0:6b1:c025:41f3 with SMTP id 4fb4d7f45d1cf-6b1c0254836mr4212519a12.26.1791910170357;
        Tue, 13 Oct 2026 09:49:30 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203863520sm66359a12.15.2026.10.13.09.49.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 09:49:29 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] delta-islands: use Q_() for island count
Date: Tue, 13 Oct 2026 17:49:22 +0100
Message-ID: <20261013164922.93099-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
References: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The progress message "Marked %d islands, done." is marked for
translation with _(), which gives translators a single form for
every count. It reads wrongly when only one island is marked, and
languages with more than two plural forms cannot translate it
correctly.

Use Q_() with a singular and a plural form so the right one is
picked from island_counter.

Found with:

    git grep '[^Q]_("[^"]*%[id]' -- '*.c'

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 delta-islands.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/delta-islands.c b/delta-islands.c
index e71a7e1c05..c1c0f992f5 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -496,7 +496,9 @@ void load_delta_islands(struct repository *r, int progress)
 	free_remote_islands(ild.remote_islands);
 
 	if (progress)
-		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
+		fprintf(stderr, Q_("Marked %d island, done.\n",
+				   "Marked %d islands, done.\n", island_counter),
+			island_counter);
 }
 
 void propagate_island_marks(struct repository *r, struct commit *commit)
-- 
2.54.0

