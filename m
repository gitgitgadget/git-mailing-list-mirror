Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E15205AC6
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367480; cv=none; b=qGcV0JheZbri2hSdFy54GX1wl09f4mI72ulBw1Hg3zPlP6gNDoYSBWJpXhqoTO+2jCwA+Fs1rfwXHRMPg9E6SvS1CE5qPqhWw7iuaaefrRMdGx1Fxijx3HPGeS85nYSXegM96mqqTLDJcQtiaWdE6wLrqhBLUHs6Dcd+IJWprPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367480; c=relaxed/simple;
	bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeUieSbsIKBCMQggNCzXi3smLnrlOEKMZ711R8AiudWmLoMNieuriOo3rwgIvjUohVxBUF8NiMhDLMMXyDnY37lzlgwZ1kHAD3OoJlsmuLT+8jvz1lNKtePiuB18u/k9F6WaOTGb7BJm0JPvzEOebn76KqsuYpCnWW4dhOF10Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn9k65Ow; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn9k65Ow"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso7263757a12.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367476; x=1734972276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=Wn9k65OwMRrFkSigBtHR22QQ26YeucvrPZ2YafpvlIfFLW8S592xPF+1+f9eMf6kw1
         9dLpXNt1drUDzKfsMQLcJIAWnOO9iRGf7nTHkGEc/Q5rb9s7e7C4NrdhqUj6c9Wn1l81
         P2XbND1m/HX0zPaPoYjiwNs2Rzfr4Wbczo0cvU3m9sr1oV1kV7ncN6e3gAnNu+zy9QX1
         HrOLl8k3BvAA71+cMzszjY8/p4xNvD/arzLA/4eITHkrysoTSr9NUZrHU2BT1EkvrQpw
         cT2tTswSmhNr30Xun4G3b684RiVbs+6Tf9n++ms3r+P/x+ARnsdSqRAUZy2hMnWNhvwx
         Q8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367476; x=1734972276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUvb5dIPp19cc7hdfTanzPMDqohb3VapJTcypa4CDlg=;
        b=DTPbCb0MVSGEOoj2S6Jmv3cJ4AcG2BwanQuFcvmKnZQXJz9GFAh75OU+CD7gcGHcsb
         Eguk3MUIOvcjjfT4sA86H0x7aE3SvccFMuTQNhCR05Q0PWS8httwF0gaZ4+9zQy293Et
         sOrMXKvjWMeTXl8Q/dJLfXnjD5z+hIgPUTfP93/cohEsj5KEewTCuDAX7D7sB5O3VLOb
         cVw5j3cqq83cKB47bEwAwxMcWumqGi69MwK2MOBlShUX1RLR+snQxD7ZCs1m+tfnNEHN
         PMlbkA9geeB+PEI9ANgE8Vk+keLyZ4F0DO5TryxKmBhRQlO5Ve11tqiQbMCQcfQiIsLf
         vCyw==
X-Gm-Message-State: AOJu0Yxl7bXFyOK9RCtSm6ZX5NzwiOlpeJbM1L+TgwNNGHVFI7byOaSt
	Jl/8SxlCRacU1NdMs6NJCQwdIyH+9afyvm4yo+gsa4t9Wam6kATjRQ3Pieka
X-Gm-Gg: ASbGncvFEKWk9I0hsE79/Zp3UVib4CIgpTxGR0A5G2N4CAJb2YaSsBhkOHqasNHIQZy
	f3qz1LlTdiqw6zr5oKRquMs+IBSAUq+wjS9cSUr0wbwLVpRG6XGb0bB48bVs/GZL9/QJCFsBE/6
	fMJdEDcUa++7zS7T+V3MmlCV1sU1zyeJaNIbhCLy21xFo67UjZWwzN2xLnWa3vPRhBM424iz/3h
	LLkY146FQDuh0ANpWS0HQhq9QZYk/aYHqfs/vnzfhCwzLWFRf001CI+JuY=
X-Google-Smtp-Source: AGHT+IGN9fflX82RNxXubu41UsdcYCiJ8+RmCwW0GhyLSkTP83PlOuhjdhNAJTDao//ZEbXYsFEn4A==
X-Received: by 2002:a17:907:3e12:b0:aa6:ac19:b579 with SMTP id a640c23a62f3a-aab779af3bfmr1105046366b.26.1734367476191;
        Mon, 16 Dec 2024 08:44:36 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:27 +0100
Subject: [PATCH v4 2/8] refs: add `index` field to `struct ref_udpate`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-2-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB9h00v4zfs7q+FeZZk33xlgGFW2QmXAcKQGj56BkwY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwkuWgX4RyG+aajJ1c18One0gFB1bAdPnfk
 8m/trihzBGJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 f0CGC/4xkK3ctoLg19Dr+R/qWVPkqKZP48H15BTlLv6dpBDk5ixtrsa6M2L/30B51up0pa+QV5J
 b3m/SeMg1Jl3glPXslQ4g0kd8rvO0O8gIXvKxwlGh+ULav1G8alPe1/7gXt6Ew6len4WLN2Zb0t
 WsRFttvv8BBjCj5wF0e/vfB+0L9eC2KLwcuG1Dv/SopgyYH/brd+W7NsWttdsy1OpNqqEOlWQaP
 LnwOl19u+Xl4H5U2FGl/rhB2IpOqsxekdReeVazWR//qJka6JOnarcWK6wbujqSjEJ9HOAy1rqJ
 W/hdZWBpx3Fiswrsd498MtEsV5CPhgvP8VFOAWhKQ/DYv1WSNrEv7krzVft2JdSXFEIhtLt/3n4
 GKks/vdfB0vciqpnaNd+d0CvYnyqobmQuajalwmbJBn122A4A3zvqs/6JJ1zmfAFOEi045HS10g
 u92l+y4M7rPatQs+6OOuItzLYlobGBSWaP+fe1nCdtwiLPM+hc8rZBda4FA0MhMSszrpc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend, sorts its updates by refname before applying them,
this ensures that the references are stored sorted. When migrating
reflogs from one backend to another, the order of the reflogs must be
maintained. Add a new `index` field to the `ref_update` struct to
facilitate this.

This field is used in the reftable backend's sort comparison function
`transaction_update_cmp`, to ensure that indexed fields maintain their
order.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/refs-internal.h    |  7 +++++++
 refs/reftable-backend.c | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0fd95cdacd99e4a728c22f5286f6b3f0f360c110..f5c733d099f0c6f1076a25f4f77d9d5eb345ec87 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -115,6 +115,13 @@ struct ref_update {
 	char *msg;
 	char *committer_info;
 
+	/*
+	 * The index overrides the default sort algorithm. This is needed
+	 * when migrating reflogs and we want to ensure we carry over the
+	 * same order.
+	 */
+	unsigned int index;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e882602487c66261d586a94101bb1b4e9a2ed60e..c008f20be719fec3af6a8f81c821cb9c263764d7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1279,8 +1279,17 @@ static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
 
 static int transaction_update_cmp(const void *a, const void *b)
 {
-	return strcmp(((struct reftable_transaction_update *)a)->update->refname,
-		      ((struct reftable_transaction_update *)b)->update->refname);
+	struct reftable_transaction_update *update_a = (struct reftable_transaction_update *)a;
+	struct reftable_transaction_update *update_b = (struct reftable_transaction_update *)b;
+
+	/*
+	 * If there is an index set, it should take preference (default is 0).
+	 * This ensures that updates with indexes are sorted amongst themselves.
+	 */
+	if (update_a->update->index || update_b->update->index)
+		return update_a->update->index - update_b->update->index;
+
+	return strcmp(update_a->update->refname, update_b->update->refname);
 }
 
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)

-- 
2.47.1

