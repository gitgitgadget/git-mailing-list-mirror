Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E52698BF
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648703; cv=none; b=pUFUGEhtEHb1oAE+w7eIUsjQCGXtYwZby4jdnmjJoGtVIQFyWU2cNLNUCtOKRMwBAa0HH1Sj5Nr39luEZttUqoi2yiEh/b8oP0OHxzKDSKu7S2YX6T41tV4t8Rc1YtyaqwMk99TTLGEgIZVNxIN06NT9yuUWXruvcBnL+n4Ugl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648703; c=relaxed/simple;
	bh=4lF+1cCG6iy/1LLrBfjT44ivFg/F0b8LJNnwsyr8u1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCv4NztkmLcVT5HVCZy+fx3Rb1wyEzTdwwsFZTuSE5YkytCeHItYaKewpNL5xgsXyYChm8yDcatDfXTRa2lyNQzUrz1YWL6U1nc4VC2jFDOPwKRd8YNhQIy352f8wxp6aDeMGX77Y5kdnPITNCSFC3mo2KVkYyFv+HlAfSqOzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Pay7ZM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Pay7ZM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso38888405e9.1
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747648698; x=1748253498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mNAJFRLpah00O7PEs98ETjfxr2Da774b3mdG8PISbQ=;
        b=B7Pay7ZMEqBx1B83Jm9LFprm302f2E3GHrN/adCXJmvJDt6VPYOPoHW3al1ToeMmSi
         prY+gFno4wHr1wRaixsBX0Fw1PA6DqHvnbSVuNudoJDxLbADWcKogTDlq3C3U/x+YGpZ
         tf7+VN9Tx+UIupaYXoUv3BJCLVKB7K7mvSe9c/n7WlJuavJBfSFp1MAClKRR+DbXERgZ
         r6L+Y1PgQNzzdyHbPdEFr/P73R5UC+KjDaUX+52nGYPh2HVBKyUX+pWk/IWLBI7ibwTF
         Kr61rFAM30IFt+ap/BBUy+Xc7k6RUFArA1+WilZb98MXI1cMJ4H3e/idP01v9GZ+Y4Md
         1VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648698; x=1748253498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mNAJFRLpah00O7PEs98ETjfxr2Da774b3mdG8PISbQ=;
        b=sCUe9SH0Is9boF3opBY0jiWvz9fs/V5OcXEAGBffjBSXjstN/QF5Hxx3LUw6fGRxhR
         HlXK212ZqXuNHdJ+WoWZLodBtdcJDxyN2nDaQzj/4K7jaLo4I92BfoAML4N7BOBZi0Vs
         azA2SOGRhlHV85fgedwIgf2Ck3FPCkJluzAVJW4de/HXdptdNCTxn8O7JwNr1perNY7a
         fCe69W9ku2/R+Z/JeMe1HNJDDreiIXDf3S5tOrRWdXLzWgMXbT6HO6AxnkWE83iJzJv+
         sWRkK2U3QVPnC4uQPiPaT77/7Z2HOUUIBziPO0+m2orLmpRVSmIh/1HL9l8vgl54fGcn
         zMvg==
X-Gm-Message-State: AOJu0YxUSl/EdKckY7SRfm0Dm3Z9v/c9/FEe2bEX7Pnlbd49Sjd2a7W4
	JwBYaoz51zY7UWutluaD5PXh86Jyav7aX1E+yphtxBQ1o479eAFyL2N7
X-Gm-Gg: ASbGncutnEj02KWS62VjopHwxZVREIjOeBlT0JmuxZj54OIpJIFc0oWecVBYeBxNMNv
	uzNto5pGNyvI8YzFlMsnb6I413GdAyraFi+faDWTzo53P9Q6nevkb3unq7Z40zxglZaUlbFxrHS
	08KjsAMYHllAidRcRUuzmgGDNxDmR1xGelvLYu6p6+rril7v5luKfoE8Zz1dg4FGbnZaCfzsOm6
	FRMu9yWc+lOB8z55VVM6UF9Csawc4biXxpQiCnTDJjY60UegjeD7htSPeIK38AxzxpIWYHpqIHW
	PXAzFf2+HaH5uM/Ttxke6a/ce74k/oxk7ks=
X-Google-Smtp-Source: AGHT+IH+1MoYAKcyJgK600wvZ9DJqyWMKQFcZDU8vaHPBXWXYC85Hc6myo4IHe3PhnTOoPz7CuKrgg==
X-Received: by 2002:a05:600c:4753:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-442fefef18amr90934385e9.14.1747648698030;
        Mon, 19 May 2025 02:58:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b2fc:6161:a86b:8382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm152811285e9.13.2025.05.19.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 19 May 2025 11:58:08 +0200
Subject: [PATCH v3 3/4] send-pack: fix memory leak around duplicate refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-3-6cdfd4f769b9@gmail.com>
References: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
In-Reply-To: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 gitster@pobox.com, peff@peff.net
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4lF+1cCG6iy/1LLrBfjT44ivFg/F0b8LJNnwsyr8u1g=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgrALVF/fxmA41UigDXXPxWXMJdnQTqx3si/
 opQaQ9ybt5Rz4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoKwC1AAoJED7VnySO
 Rox/p8gMAI5ZzAyWJ8f2dPRP1HbjkWO0GAoIBWl4nMCPF+fE2wuZd0BvuVpHY0Pfz3S8RHpXHBU
 S6RBQBxcZbV05EjWEhRwehk93kLk9DiRfImh7l/MqItjdcb2eKRCaruh/SZywVEPkMk0LJ47it0
 +RTWWod7TBC5s1FDcG3ey7veWI0sNtnIHomTVwEn6qkUT1f4OGO0gd+EeLY6OQ99tGPglGTeJhU
 fG+zA5rk2AmYVbBou31I8iCsCywXz68ENnRJDOitQmUkHQYEYW4GvRn8V4W3E6Wc/+pIYy2jgSB
 oLvYLkRjSebRH5kRn+l34cEXB9yZZJ0YfBjFTWmNJBdblZgzdmIhkFFmFXQt4f8Qw+X761eRSvz
 W1oUyALi5ui/OiilHTzkly/eSIjGcNvqTMZqFX/gT7ymKPiMRv2nepyeEz7M9V6423Hmedd/G8v
 4HNRrsQKhn/h/D10aCPLgriIXO1SMUT92jdrsb6AsogtfP2qTW0jNjycXQ8LdpxV0uxKosbSmr4
 0w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-send-pack(1)' allows users to push objects to a remote
repository and explicitly list the references to be pushed. The status
of each reference pushed is captured into a list mapped by refname.

If a reference fails to be updated, its error message is captured in the
`ref->remote_status` field. While the command allows duplicate ref
inputs, the list doesn't accommodate this behavior as a particular
refname is linked to a single `struct ref*` element. So if the user
inputs a reference twice like:

  git send-pack remote.git A:foo B:foo

where the user is trying to update the same reference 'foo' twice and
the reference fails to be updated, we first fill `ref->remote_status`
with error message for the input 'A:foo' then we override the same field
with the error message for 'B:foo'. This override happens without first
free'ing the previous value. Fix this leak.

The current tests already incorporate the above example, but in the test
'A:foo' succeeds while 'B:foo' fails, meaning that the memory leak isn't
triggered. Add a new test with multiple duplicates.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 send-pack.c                | 7 +++++++
 t/t5408-send-pack-stdin.sh | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 5005689cb5..4cd41a64ce 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -260,6 +260,13 @@ static int receive_status(struct repository *r,
 				refname);
 			continue;
 		}
+
+		/*
+		 * Clients sending duplicate refs can cause the same value
+		 * to be overridden, causing a memory leak.
+		 */
+		free(hint->remote_status);
+
 		if (!strcmp(head, "ng")) {
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			if (p)
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 526a675045..45fb20179b 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -73,6 +73,12 @@ test_expect_success 'cmdline refs written in order' '
 	verify_push A foo
 '
 
+test_expect_success 'cmdline refs with multiple duplicates' '
+	clear_remote &&
+	test_must_fail git send-pack remote.git A:foo B:foo C:foo &&
+	verify_push A foo
+'
+
 test_expect_success '--stdin refs come after cmdline' '
 	clear_remote &&
 	echo A:foo >input &&

-- 
2.49.0

