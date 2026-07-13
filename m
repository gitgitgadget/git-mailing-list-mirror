Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F94252D8
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948671; cv=none; b=aB5Ly4Q9MdqRurjVOlazGI5GFNFtLM1o83oSI+PysFM+8KhzGakhXQda9rgVZpodPLFfcc8FG7fjIgEWKUo+GVtDbgMBGQ/IKQOboXzNBiKlIzhHLQcfehcNaUL82fJjN8e4Iaj1iZ1n5bUOQtEJZaZJQsBZNiZ2WZSokJPTge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948671; c=relaxed/simple;
	bh=B4Gh59G+hXOyaHLwf0jkd+HYbdEmkkWcboVQigCEaIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsyvoHeNkwQVujyVGA53I6f54p4lQt+/MnVo5m+fY8i79ZKHDiJG/iFq52zSKkGMxKjOsEP/STbJz8Fa4WKp1sufMtrWkp70f8NjmzW4WbtQPTOMMQ8G+RxjI468q7H1sYBKtmV8C/ALOLMWVu4hF10TbnPvKnvHD6dhIREAKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpP+2zyX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpP+2zyX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so19663055e9.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948668; x=1784553468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WooKh+Ol/Q9kKSqfu5hentt0JjDV2hMzY77+RKlOFxU=;
        b=KpP+2zyXGvyfKmrjyAluyLKwlJhzuBrPHZi0G05Lb4T+2vLqqKDsTw7pG93H4GczNi
         2cL81V5JvIdnNQp7y+sJy0veK/85/AKQob4xRDt5abcxcx7bXs7EV3q4Hrc75OFcy8+Y
         bGH4GZ/tWGKpsxkqcEtbe8wRulutQjromCXnL8A+63EM0ygG+CRZGOk7WrvQA+ap3IOx
         GIypVcbnoA9rb2k8wQzsRnKMHGuNQyNPsU3wKPHSZagCgTTGpTCSYR7go0qB0VU4ndvg
         ZrclfnUoOMiG02yAa4FzUs+9jMbdH+Qp4v428iu4JEBxt7mEJOi9dUWefufRn3lKQLkN
         zgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948668; x=1784553468;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WooKh+Ol/Q9kKSqfu5hentt0JjDV2hMzY77+RKlOFxU=;
        b=V+MMfYlggmKC22cjJx7tJtaEYQ78RpDdLJGaeGSQXtF2rKEQdbvplZpg9QKU4OMlM9
         5d1gZs9pMgsnbtXI60bGIhhnh6RTv7XjpMEXVwKx0RtUnFNybqbTZYmE4bBNjuJx6pUw
         xyxXbXcTcnPvg1YXMCDLjyUfvY296EmMY3VLulKIf56a0nZ8+3hfOzmc4hQTcn+5NtFM
         0yLzu9r1533nznocL3DRsVKk1clGfmy85dJ70iTgyEonWBVnfcQJ7aLprTM7qnX9KRX2
         w3biPVofXtHwzwSwMxrappFtA3Fz6RNoE8mkM8XsUe7xTOFYt8FkGtXE8gEAj3N+dgPe
         MPFQ==
X-Gm-Message-State: AOJu0Yzs6WQnXA9KowGv0ZHYJ+kOKDIfFZ7oeu4QK4YIurnsrAZNK036
	50tq0TagHLzOw4kqPcDK92vBSV1sMkIlOye/EZOl/FbGXJmvh78tBDoKhceO4w==
X-Gm-Gg: AfdE7cmTHf1cr0jDUJVSz4QjAFXDzrk6oT51DnNfMe+PqyfWOD4qRO9DMGEZZMPIKGU
	5KUMKGdUAo04/iq/boU5qbITw6NeX97DTPbRI1wCCTl594TXTgayX9qMPAi8z0WZBALrZnkH+NA
	m5Ma8OZYo+tRVDPA+1nmEZddP9ZtPjFp7sWOlQuen0ENYDqfNu3Oz2DRAKSASmL9SQP61cy+lFj
	NNU54bcaFAOh9PqAW5xpsPnq4ZfNbPT1vnWezdETjJPEqQITlB0s4ffxza3+JHqQ/exsJZN5pDQ
	aL3A+G5oaO0V44tWCoG+5yMnULw1umaJSxHxIosR4Z8StJv8gaSk+RAPegktPe1SnFes8jVpFl1
	i0AeYHaeTNsZEI/0cBMz8BHPodRCVH7S14gynEDS+lSEX3iE5mc1P3KfSClPzZSe3H94bZa2PXG
	hd2XZU0LZvUOESakFL
X-Received: by 2002:a05:600c:3e1a:b0:493:f7ae:c4e9 with SMTP id 5b1f17b1804b1-493f881d4b4mr93441575e9.19.1783948668052;
        Mon, 13 Jul 2026 06:17:48 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 06/10] sequencer: simplify handing of fixup with conflicts
Date: Mon, 13 Jul 2026 14:17:23 +0100
Message-ID: <26dc48951cea663080bacf7d8d4760528125cbf5.1783948637.git.phillip.wood@dunelm.org.uk>
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

Commit e032abd5a0 (rebase: fix rewritten list for failed pick,
2023-09-06) introduced an early return when res == -1, so if we enter
this conditional block then res is positive. After the last couple
of commits the only possible positive value is 1 so we can simplify
the code by removing the conditional call to intend_to_amend() and
call it error_with_patch() instead.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d0d2cc228c8..a70889a107e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3874,7 +3874,7 @@ static int error_failed_squash(struct repository *r,
 		return error(_("could not copy '%s' to '%s'"),
 			     rebase_path_message(),
 			     git_path_merge_msg(r));
-	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
+	return error_with_patch(r, commit, subject, subject_len, opts, 1, 1);
 }
 
 static int do_exec(struct repository *r, const char *command_line, int quiet)
@@ -4986,8 +4986,6 @@ static int pick_one_commit(struct repository *r,
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 	if (res && is_fixup(item->command)) {
-		if (res == 1)
-			intend_to_amend();
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
 	} else if (res && is_rebase_i(opts) && item->commit) {
-- 
2.54.0.200.gfd8d68259e3

