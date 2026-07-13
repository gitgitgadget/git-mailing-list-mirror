Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154E422529
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948668; cv=none; b=qteKfkMdX4EEJCDNDRWE5Vk5D/2P9KzpcIVKifp4VBTat6+NGnCuBdWZz2zKTg1yrb0bOgvVD9ojpnR1erww9Ko50iX9L88/wGUUAFR2yDyr/tr5OSyR3LxARk/Z/riiVB0YNBySLaosefOD93xU3RCIs9wsDxGWncB+OjUDkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948668; c=relaxed/simple;
	bh=mM9CfmoTFeMVBum3cXetYtfPu6HA6HQwGqVMlWZaIyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnGtRDkfvZezi6A71oflzZy2EXV8skuiTttLgbzZkZvnIoDTCR150jMIx+Le8wlZkvFEjjD841jT+yivyKuJ7RoKOFCvyKM2tzkB8VzD4FbOnntZomRSnx0KKXdDKd/ZjiOIvN/zgDAAwUjBY6Z+Py3pVgoRii2MpoSf6Yd8MMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqXVlEl/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqXVlEl/"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-475881b9a4bso3133433f8f.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948664; x=1784553464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aACL7BSbEb9namQivHiPGIPwBcqSR61+bMhGbPVzFew=;
        b=RqXVlEl/Xc4tmDO8xIMmoPQvJHGsKecayqW9Z8MMDp1i0hv/DxlkmfE8lD5USwBrF+
         2AibU1i/4NwJtULtri2GKvGmB5edreZlOZJ1twmCX3h1Ywy5n3zaMiz0jyti+bJIgkW3
         WLzWJK3gdQcTujqz4kMiJhWBmJEFaCH+b3kH3yUIeQfDsHFDvLHvZCDbZ+ciQAttgPfc
         WoHNZdMuVmRmtccWhx8IyHB+ZFJncplUgyffb/HPNlmhDhSvR66Ezi9zKHUxZlaiQJd2
         OSFv7bhAUq9rD88t8g+MlerlR/ve1sQ+TXPiW3cHHYkr1pLjJpJyo/tPhKVysaL/+dof
         fbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948665; x=1784553465;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aACL7BSbEb9namQivHiPGIPwBcqSR61+bMhGbPVzFew=;
        b=IP0ySOjEYGqGsL2B70844nWwHq4QCYcnkti9q01aKW2+e5Lz7EthkJfwO949aUvV9b
         I7iAkIGauZoYDrLLWdNSq1KzNNDh4KX28HmwzKeVCc9AmguwDWrmYL9KWvi+EsPousU6
         8oDDvPrf8zkzxMPy6UNBNbsUez6k9Fzx9RuHOr2nQOMPrfgPt+SrVg38E+WqKvrV5Xhj
         Z+ZDvs8S+naSDFG7hXGB18DX0GIKEJhImbBXWvmiEefmljpti9dj4IJfnnO8QhmYOAQ4
         UtVk28Z2cYPX2tzV1xbchOVpQttMCMoboU0QYTJhKJgHg39edgpDGhpjjZDv2Ih+Pqkb
         PUiQ==
X-Gm-Message-State: AOJu0YxY1JfA65d+GfleF2KS6OSEjcp6Vn1uM0OPKpORWIds+pw9omN0
	hqqmBnhZ1cy2ClrkcBwrtajq87Sn+oaPGb51QS+CbooFjzPE1ncg1sL+pRMVUA==
X-Gm-Gg: AfdE7cmFjJTH8+BRL9ke/l/6+TVW3RbH29i6L6PJCkQtzgumrEjjWkx8fzroGuUwX1i
	0CXl1RbkfxDsZIP+ciN79feGo1Uji3izfhPSNmlQwVDr96ZwLgEqB0WezS8H9Zh/lWXWgOS/KWR
	KnTQBY8hV61xP60aos6yX+tuoJ3VUARGuh/955+kVAZc6vMpROlT/P/iJzrU2PpsAIf3VwONsvC
	sX+ubicLxBMtEd++ErM+A2oyRTkWiCVnPMQrpyRingzkDqSAhCU/Yn8nK6fFBIPKHrJSYQCJC69
	XGsHdTxVSxGQmy+15T5yw6GARGEDlInDRxVR4cWrg1Db0mFXBYELbiZVjn6u9I+qVZHDbL47S6b
	LNAjmyf8X2EAwquxklI2kLWzZtjPGfQ7UKo0qecUdjb6n1NoSn7D4StolMuoqJWK+yuCl2ZwpcP
	LG79BWBDNMRSNLqR4q
X-Received: by 2002:a05:600c:1d0e:b0:492:68bc:3237 with SMTP id 5b1f17b1804b1-493f88333c0mr90165965e9.32.1783948664459;
        Mon, 13 Jul 2026 06:17:44 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 02/10] sequencer: move definition of is_final_fixup()
Date: Mon, 13 Jul 2026 14:17:19 +0100
Message-ID: <02670f57e7d81d4ff7341fecff3ef04b9fdc0102.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move this function earlier in the file in preparation for adding a
new caller in a later commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066a..32a09b6e87d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4627,21 +4627,6 @@ static int do_update_refs(struct repository *r, int quiet)
 	strbuf_release(&update_msg);
 	strbuf_release(&error_msg);
 	return res;
-}
-
-static int is_final_fixup(struct todo_list *todo_list)
-{
-	int i = todo_list->current;
-
-	if (!is_fixup(todo_list->items[i].command))
-		return 0;
-
-	while (++i < todo_list->nr)
-		if (is_fixup(todo_list->items[i].command))
-			return 0;
-		else if (!is_noop(todo_list->items[i].command))
-			break;
-	return 1;
 }
 
 static enum todo_command peek_command(struct todo_list *todo_list, int offset)
@@ -4925,6 +4910,21 @@ static int reread_todo_if_changed(struct repository *r,
 	strbuf_release(&buf);
 
 	return 0;
+}
+
+static int is_final_fixup(struct todo_list *todo_list)
+{
+	int i = todo_list->current;
+
+	if (!is_fixup(todo_list->items[i].command))
+		return 0;
+
+	while (++i < todo_list->nr)
+		if (is_fixup(todo_list->items[i].command))
+			return 0;
+		else if (!is_noop(todo_list->items[i].command))
+			break;
+	return 1;
 }
 
 static const char rescheduled_advice[] =
-- 
2.54.0.200.gfd8d68259e3

