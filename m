Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDC276028
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871559; cv=none; b=KVxS1oUMevB/Wo6vj3a0NEJt0EC3ScRbVH7I0WrBUq0ofWRcRQT2jSYbDWN/bSDCt/BHEB1rTGa8a4p5LeA12lPR/a6q80R00Wy0Xa6XhA29u8RAzA0vGvamflyvQEDKFSn5PGPGEaSTYzHI33gW7BZi7kiDB1WWtMgU1MKJbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871559; c=relaxed/simple;
	bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=al4LOoUzUVUCmgVNw1biZeRWE5QVMdQsokWtxR6ArdJ8TxWnZ/j9n42Jq2kua38zC62XSpq/MIdiultkdk+KoUcWpL6JMKp3p/f13u8WISiH1Jr2ma+yPm+NkvaZxQgBfGlWiK86poaw4PEquKYmqEWvgZvJ1rx7ynBXhCl7WC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB+oD1KG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB+oD1KG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so3421418a12.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871556; x=1759476356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=OB+oD1KGYwdj1Z+wahaahoyYwfmsnjfen4vlkgjcBgxHmuNuhiZYiOWEvLfRnEIE2S
         jpadf7QNmoDJp33HK19P9GLSdE6nQv9fZxoiVqhRJ2M/VgDGjePM+ArKecFpZK0wpeCx
         BNPQjc3cT0HzSKzWCS4RrkuwvHjxMyo/wM+IvIZdxbDSBBSr11aiVblneQx1F+arbqyB
         yEFcDpqBu2o6pXPt3WKNPCvLUmQe0kPhXBWCMTNmd1xX59FNQA+klofK0tCREIaofQIs
         TxiCqciHdL7aa7rPyi7gnHEIKbdE+JK1TB6CPyrbw7KZlp3amRKbgZNlr37KOcEB4gmY
         BlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871556; x=1759476356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=md6FdkPBxO2jKDv27IE7UdkND1gUZvdNmaWV/0BCpEOj+HSanZt9kycXp8E7TXhU3m
         nsGCERuU3f5QwmDzDdXrUCYVNwft0FLqXj9r4IvERhNDKj0bTLheMNe/Pv0xpFjBh77r
         TKhFGa+rYIXDxObpY9pnRPKjLzlDCjsCGEj8EunErAr0TUaQ1YMquEE5UEFvrNNsOlRT
         EfLG/P3GWEABkaYgV3rt1tiNQI12ZUPeR1EcP4g9HgEec641uELmWL2xCC97CaXjNqte
         e94kpCzcAY+zVDHe6pE4Yme7G2/bQHikrSeud3IVq5UauOPlIsNTXx9iFwpFZFy3ox/e
         vYNg==
X-Gm-Message-State: AOJu0YwpkA4/N3t4BSuFeJmB4360MXHi9OqMVknJf0ElyBEa5eGpY1U1
	oB5LVALMLMizedKnquFa99oMPghPlfNxOTdea37QHmSuCjNtiU0uou0s
X-Gm-Gg: ASbGncsFT3N8tsQOtbGh3Fhrfchyt1JdR+nWDAJrRqw203YpLfjdBT5u9NrrCW0sNnG
	xHc3HeACN6QGnAfsmvhc+Gqypc9hC1MB+UpA0Apsi2hDl+dayAX6YRxrU+oBGKQiHkbGuCt0Yhm
	W5x1ADzo/bACqpNhaakHY4UQQRhvs4h7dlADLgum7T2SptBAk6sSYtkkhzOyF8t8owxt5XH+Cfs
	VhDxYiA6khT8dUGETgIZNTJO71ixJ8aLIIYcp8DYEI6K4LOir6OY5pxW7pfvPzGOZjecZxudK6I
	kMGDSGRbQlqDE3WNZ3FmYtH9bVf066nevgQk5qZFw7AJDvjEsImF7yNKMC754lf0Zx9Jrz9/eJk
	mlc+fwERGIpKxL5pMf9D3vVkMyV+c
X-Google-Smtp-Source: AGHT+IGHMYvQHwL2X763Fr5z45edE51YUzd6OMxiXzIIsosjR4yiiQCxmr8ymiZYW1NhfevzZz5pXQ==
X-Received: by 2002:aa7:da45:0:b0:62f:97ab:6062 with SMTP id 4fb4d7f45d1cf-6349fa942c5mr4009844a12.32.1758871555796;
        Fri, 26 Sep 2025 00:25:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:45 +0200
Subject: [PATCH v4 2/7] refs: move consistency check msg to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-2-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWP/8VystZwchsUAvecVBdYHArTJOqKYtHf
 hxk2m6sc3/8UIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1j//AAoJED7VnySO
 Rox/TO4MAJvqgrapRRXEZ4f3lT1nuhrOwAq2MyTAiwGeVAcqnclayWY5rL10mIUmh1hMfMNDxLT
 hNktE/byXSPtXP3VxGVAgadX5vh6fb8YY1Sq5c26TFFUjsMhTrb06TWZfRkN/7mzZ7LXeTy6YxL
 ETt3BVym9RTmRdQAW0wZPdaNHUzCczRx9ldmqxly3HfpgW/fyYsgG1sXH+JOnsXR+RiVeBup05Q
 Bbfl+4s7oOrreS9/TaFMps2F4OzcdLw4uzni1kOidM63L6xfXVY/aqGODZtaQ4EyxeDLWNVD0uV
 7fDKWZCjy0t+RlEz42N6GXrdz3dyFonFpAs0xXw2z5hMbveJXbKTJseN/RuRtyYXGZnFEZoK76a
 JqrdFOM8Q5rzmDbfbUF1S1U5yfLn9P/kLvmtQzbv7s1eOFyDHDG7L+X+E+5G49Qv2MlU409YZNj
 bf4ZV2DxwPugzJedAsgcjLEWr0ZAFZaREgtxwoV42Tu+tKe2sylHdoh6zMjK/SSkAiymfJMZRN6
 lU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The files-backend prints a message before the consistency checks run.
Move this to the generic layer so both the files and reftable backend
can benefit from this message.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 4 ++++
 refs/files-backend.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4ff55cf24f..4a7c394226 100644
--- a/refs.c
+++ b/refs.c
@@ -32,6 +32,7 @@
 #include "commit.h"
 #include "wildmatch.h"
 #include "ident.h"
+#include "fsck.h"
 
 /*
  * List of all available backends
@@ -323,6 +324,9 @@ int check_refname_format(const char *refname, int flags)
 int refs_fsck(struct ref_store *refs, struct fsck_options *o,
 	      struct worktree *wt)
 {
+	if (o->verbose)
+		fprintf_ln(stderr, _("Checking references consistency"));
+
 	return refs->be->fsck(refs, o, wt);
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d4fb033417..603b1343d8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3906,8 +3906,6 @@ static int files_fsck_refs(struct ref_store *ref_store,
 		NULL,
 	};
 
-	if (o->verbose)
-		fprintf_ln(stderr, _("Checking references consistency"));
 	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
 }
 

-- 
2.51.0

