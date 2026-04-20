Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F838238A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679947; cv=none; b=unXwlEGr0ZInBp4JR2fKf4xJH9TTmeth2Wf2oLlDJ0tYgmHFoJrqqQ5/dSlILAeHNT4+Vj0b9fTraD1rIX6SGzJBs8GqtZJlDDA/vAOcWPzojn3d2CVHGIXDmBwIojVbwJu1SdooV7qgi7XP3XlXsMrpYtwCyVV0TEk4WFWyb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679947; c=relaxed/simple;
	bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYjnYcx6+8QWll9xs1+gfWdmRXNYwM768U7+x1sVHk0/7VBSnlYBWAWceC7IS/q5N8KbCgJai3uvKA1MKuMSCVSGm60RgwMInKFPbGK9G9Ome5DP02GHB7ptI7i420JmNflZY29LQxFpGprfU33Rmcm05MYrsMbn14XvHzUlzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7IwTS1q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7IwTS1q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so5859105e9.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679942; x=1777284742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=b7IwTS1qTitNjOxuEYEdBraCppq5eid63gGekJfVj85UzQqMxWhMkWEdJsTFxlOJg8
         Zdxq86cRxCuxYeyTRJVJ8wcKCpITFhrd/Kjxnjx0+elOoJQLRtqfM5lS8BOpdMPun2li
         txcJAkHQLIoCqPbgjEuIjL8PULDEYv/2eMeJMf8n4OwUUrDCweBECGcOvPy+AbscR6b7
         bMawkj8udl1vz4A3+XV9Kqa7SXNR1QoBasahSBJicu9AhUhm/Lq45ApOFUAh/0J/+jzW
         FznCZw61FCcjhpO/d2weI+HQpZP/rMUwE5FgQqG1TYnDi1ixpPUiCfp6BFz2SwR8DtSy
         lubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679942; x=1777284742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=nOKTzqcj4g1zuQQTLdpW5lT/QvdZiRoZe3fgjVceIuJhcQXFL5Iz8z5iuYVrewpXgg
         we1MtwCQRxMeAr0eD2FVBF1tFUJVUDzzPmdWtcLNFwnmaT8l8N4J3T9OaCFG8Q1uY2p2
         lXsB7xtygBOmOAwIvU+zkKVtBtwAjXeGr1yb4Ch46OKLJdYWRN51/KtwGTeK/wEoINJF
         84Z9WA0E8ed9UoCegTcc2vZFS9AvGqFqx5w6QSdU/4qc4oSzXKvXyuJGcUzJlUkfDsyg
         Bdf8A3LFuvFA/0LAh19nsi2ZN4Dz+ziKuYFrtXaXetCvPdKOx9IPhZMnVTR2r6DNKic4
         3iUA==
X-Gm-Message-State: AOJu0YyGE/p7WIrjDk0vRXiRRudVRke/Q8j53dPpOFikkuIc+LK72G/W
	xfyQJxsUCUtNrftMpppplWXV5C5QhIcQ/ds75Flq8Se+7g4ICFiF63JmyNeong==
X-Gm-Gg: AeBDiev0kST2oru2YGMPyJ8ZpX5LLjkxBNWDjpesE65fN+dQefK59Sb7k/fj93Qvksm
	K34nb7dfrpm13ZX7bha7+vpIr4s8nEXu23n5yHTDWp7QHcpBZ/q4mWxRIqbmr4oCTsraUboz2Wd
	CLtqnDT7PfwYdWjnuj+V9T2omsPd71ujueW3LkR37OxpWhX0gW67M5RGs4HgTDvR44BmTN9zzbj
	B7vNOvzmUvCaLlrnHs43ObQH5SXLvN0tDrOaY8KMfZmfkQc2tpxPjNGRma7Xfqo/mpKlgJOi1RZ
	BrDwyP108iqOJBwkd7eBkHy1S+1Q8RYNka8AAZHJxZ/7sgBZZ8eIH71zCkmCMJgGBhjycSoomur
	2LDPjWLpnnGwhv977QRXQeie9++VaVnyNOWXl6kmn1iIRsO5gaQz3+gltj6guL3w+aBKUhshsZQ
	Gs3hN0u5xdtWkvkXfuGmDvVKHMglfANjZ7PBZSY5s=
X-Received: by 2002:a05:6000:40df:b0:43d:7af0:3a93 with SMTP id ffacd0b85a97d-43fe3e14f29mr19296676f8f.34.1776679942240;
        Mon, 20 Apr 2026 03:12:22 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:11:59 +0200
Subject: [PATCH 1/8] refs: remove unused typedef
 'ref_transaction_commit_fn'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-1-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl+/+BuuXgTLA4Pwzoe9L5Cii2DSfUjjeVa
 +4Obg6zu+AOgYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fv/AAoJED7VnySO
 Rox/jB0L/AgFzBvdloyDs5FKdD+cG5Hp43xVPIspQnJNBKYnAKudlcRdSBtXwetY1AWyNgkRv1d
 PdZ520zWeD685eOAfPYhZbiuIw4QID1LHIYhcinw6dLJ/xvsosmbonl+qvm13ICt7YYaIRjHU7D
 +X77Qquif9ZoPyK3f9KwZf6OvbuGB7wqdPGqIovkYWm33xwEPu8KFzPFq81PTitpf6uj68kwtrs
 +JuUUd8j7RdKeRUY/qKVaPa/9BQjqCixyNDesh4xDbxvd1eoUjjRVJlPgd2/MYAB/jPhfIPx5Lw
 mK1uJ+njfpJy+qy+2HfdzZhGtVyEBY8XTU1uPnqdswRrDK0270NtPZOVxDTLcMHNfOiQUE+wNfu
 jNwsv4BWeOhwk81KWResHB6Cnd3pfG1JTn+uDFN9mZWU7A3QepwkmHHkYw97HI232Um8WfoG4WG
 RO0Dqi1K/bpDwtW9Tf/YCQ2UzymPeKUGPnJ1fjyBwj1BSoiuabjyj4ZW3ywuBsRaUgOXpEzCKW7
 Hk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The typedef 'ref_transaction_commit_fn' is not used anywhere in our
code, let's remove it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/refs-internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d79e35fd26..2d963cc4f4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -421,10 +421,6 @@ typedef int ref_transaction_abort_fn(struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err);
 
-typedef int ref_transaction_commit_fn(struct ref_store *refs,
-				      struct ref_transaction *transaction,
-				      struct strbuf *err);
-
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct refs_optimize_opts *opts);
 

-- 
2.53.GIT

