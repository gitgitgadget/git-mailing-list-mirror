Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58502382F38
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937966; cv=none; b=nH5vjVG01/Sm59ZY70wHErdT3vcsYO6LuaR4ZoyrRAicdI2XKx5xHyaqpCVjH/9jJ+VZZHYVtD/uyJKs42xRNM/2C3XB9RAS3IrnZes+N1nQPghvaObjNcgXbzk7FRmvWBa4egsFbAgHVg4Q3pgA7/LOZyqgq/paK6jXAx4uaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937966; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lIuu/FciXMXunOKlwHMzCpHT1FCDbmdza+VN4E9xSW4VrUuJTEIaLSz1acdwY9p+0uPtb9uCDIV09vB++BQVi75pu4V7oqdrYY0GQyHaEtOsbGr4r9XyhSO73iC6LsjGlZBzwGqTaN9l+xyxNUAfsRRsJYLRjdbW+7oQR/C6u2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK49J9gs; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK49J9gs"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-46a9ae3f857so1065123b6e.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937964; x=1775542764; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=bK49J9gs3bcikDVtqlqnd9W8b+DqWSvTjEFlYA+Zl1EUAh0pJI/PG6MVlfEzZJFRtW
         RMebjhP7DZHa7bIhe3gixGcxJ1ImANzjLgY8LeHZvqpCJGCEmZnJVByMaR7ilvpVnMe+
         YFAceYiLY84ue6U1Ib6QKqhduznsqo/oji5O4dRfTigNDMuMtkh+WUsr3SNfUIPRbJX1
         8qnBBXDsiayv5QGaezQvEvbvxBZtHtwmR61CY7duDhkKmfaA2dhgpuLlx0OJw34VGV0g
         W1esoG9oa9rui0oF8TvnsjxdAIUoqm7wpQVQQTodyTAm429+oep2Mn8z/KuOoYtiMnBS
         z0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937964; x=1775542764;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=iNGmYKys1CG0///LYjvFyA3ikQcdFrr90fm+S8XwL7x+zDGJjby2aW1WSC7BDzaM+H
         ecixCRQz5ifNSC0pLWurQb+n4N6l21A4R8v+IeKlrUhDR5NklnYPNPT9j2iYKQ6prl5M
         +GojJFTzEaRY7lH4FtlW9lB1Ojkvrzyx9oV9dwgdiCS3G42LTL8sN5cs+7TVJSP6yguO
         79lPeHAAfA/RX0K0gZOrEjzpBNNz+nQR4YnDmKfchwMOt/W0zAYQykS0mzVirJ2KdMap
         0cNe3sPLXjTfrZHeqGloMIPkQTrL91WrHwDP1TChfObh9PQ4eDmjybn0dkwM8DfhlMkY
         KotA==
X-Gm-Message-State: AOJu0YxtM4r4zMh0UVmdjlJxR1ChT7DzHyZZYAewYviPfUejsC76QKo5
	Aent2RSTiuyJzvfqv6w0BFldo2/HBQFJXWkw2lCR4XUlqklnhu1f1dgVbN1O7aHf
X-Gm-Gg: ATEYQzx3DlPzQ+jl0rD1CXkWoG84yMPpis8TWZ0k8q7t7j9knCSbGKwEqn1qRtLcVn7
	Uvgf3WYKH6tC6UaTJ3VIkh7JE4zOwvl7P+nR78c+oB9I7sIbd2wLX2gNWINW7zxcdm32oGFWdiZ
	BVQuoGqwVeR+kEXfPmNlkpfUe9qov9IBK03KvZ3xhzQqvQRobfEhctMRA67D+77iF5l3xy0pNBv
	zFwkSCa6Qj/+ZOVQEuV7QnHmjadKsyqbHimSCYkXWKjkyt2x4NZyyegAGprzIuzKL358BGarvoR
	yV3ORmeAxsPoCueh+YRmxeZkMr+O2sODHETotVtbPwKqxqDdItUka++ueYl1qKpG/MCHvU50OlB
	v48WvPMmEOWjGFWNmPYOoNDEd1xYKIN69Sy4SYnROKfdzZTrVnFbnirbStXTc6kSim/0OBEtnt8
	bvju9sWpRWdoIxg98/BaUSOhJYl9I=
X-Received: by 2002:a05:6808:1b11:b0:467:ca8:c397 with SMTP id 5614622812f47-46a8a39d909mr7457426b6e.4.1774937963845;
        Mon, 30 Mar 2026 23:19:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a864514sm7672780a34.26.2026.03.30.23.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:23 -0700 (PDT)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:06 +0000
Subject: [PATCH v12 01/13] fsmonitor: fix khash memory leak in
 do_handle_client
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `shown` kh_str_t was freed with kh_release_str() at a point in
the code only reachable in the non-trivial response path.  When the
client receives a trivial response, the code jumps to the `cleanup`
label, skipping the kh_release_str() call entirely and leaking the
hash table.

Fix this by initializing `shown` to NULL and moving the cleanup to the
`cleanup` label using kh_destroy_str(), which is safe to call on NULL.
This ensures the hash table is freed regardless of which code path is
taken.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 242c594646..bc4571938c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown;
+	kh_str_t *shown = NULL;
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
@@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		total_response_len += payload.len;
 	}
 
-	kh_release_str(shown);
-
 	pthread_mutex_lock(&state->main_lock);
 
 	if (token_data->client_ref_count > 0)
@@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
+	kh_destroy_str(shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);
-- 
gitgitgadget

