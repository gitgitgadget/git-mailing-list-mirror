Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7009146005
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446086; cv=none; b=PPrT7bdaCh6K0xWe3C5w0vEyhjUpyNeyAeN8Tp4exPEZ5Le7eJ3t+O72RUNWSBkh0ZaWWPhtbjG/7Wvig3JuODKTcJ8QE1JHTFZIzrXxzIiBCjfHuCuKNUd5TzY3y3+xLTvnqnbppP8Xf7ojYjwUpCd9aeso/paZd594IGOupbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446086; c=relaxed/simple;
	bh=rkbYOeKhdwY7rqFxx80XwEwnMsa6eLA2NetHCN1poQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZapLC8vUsGKqk+3jC5130ftxlz7UW4y/+lUQHHfzGdhhoFjK5+ncz2jznd+d3ctsVRwvCXAktjgnOmE5znJa/3OOvo8yF0NH7ClFYGgwrhVTj7t2Q5mLd+vX0AUpmXQ+voSxOXVeMVC7ZRRRcQRV8ioCznkkLe8iImB3YbBW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcGGndu6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcGGndu6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-349c4505058so583461f8f.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446083; x=1714050883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kCOFTHk9OLWOT5my2MTw8V0w0oC6hE+y+576LTdSmOo=;
        b=GcGGndu6gigVuwZQGQ6wWLAvTusxthSsQ0+VliAmdn5D/MQcUylIcuhMm79mQ6v7Vb
         Rxn2zoVOa/suuor5fDV1ZyaYJUsyjZaZxe+XVZTJBzWfPsehXszCWOYjAaRTuUJziFzv
         1uzRBDh1+HUmHevUXb5ZnKq1nQ6nJhOWD+nW68A1q1i3iDgErvdlUE2BaO4uZJni1svm
         al8mFHnY1rBnCqpiro8/ZriYEA9k4x9wTyZVoRQvy8xpS3KzD86AVIKuA3y+n0fup/A1
         kac/aeON1hKmpAS+Dq8GvxGA6nGQ269RXA195HCVhznFVMUuSOBPXtqDobOdDpiENJIF
         aksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446083; x=1714050883;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCOFTHk9OLWOT5my2MTw8V0w0oC6hE+y+576LTdSmOo=;
        b=lv8X9yo7EP1oIVZtigAWAo+Dtqf5fEiROf5+/M+o0q6JdnkNdPYD7aOMLg3dAm4WI2
         02ExWnHkuBnrl9RuwQK4bZj7g0DRAGBdmvyAKF/D62bcOICyfqXCHVhKN9jShxkxmydd
         JfZfYho3RgeCdmkxsa0IZXvdYTAJgC4kJMuWddD86dITOUfYnQeuiApDyP1D1iKUAoas
         FYnN4Bma3RmijZxyHHxM5lmQoiF29N3tvZnl/2jlDAXtT690kUXkdSFj2JSptWzBvKip
         gLI/A69O9KPHAsojU6+yf9PqyBjIi9u77/3jBqqAy2fGFArciZQ5Z8wnblqICA4+EiDF
         Gr3w==
X-Gm-Message-State: AOJu0Ywa4wSyjIkrV84HITDTmdLFghoPvwFwuVcFC/X4rtgRRfT7oA6O
	5jeuN45NbbEbvUk/loXI93TmJvFFIKC84xatq1pua4nBFv9aW9cVp3Tmng==
X-Google-Smtp-Source: AGHT+IEnuomCPp0d/8iJqxp8T3NntnVdtTu4kdbzf01RUx/HNgKJtM6DNBQAECABU2otHuFhd75nvQ==
X-Received: by 2002:adf:e9c3:0:b0:343:f662:18f8 with SMTP id l3-20020adfe9c3000000b00343f66218f8mr1772122wrn.63.1713446083036;
        Thu, 18 Apr 2024 06:14:43 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm2682748wmo.34.2024.04.18.06.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:14:42 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: David Bimmler <david.bimmler@isovalent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/5] sequencer: always free "struct replay_opts"
Date: Thu, 18 Apr 2024 14:14:05 +0100
Message-ID: <9d96300b1c8ce3ab88affa571b2e29cd5b52160d.1713445918.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.44.0.661.ge68cfcc6c2f
In-Reply-To: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

sequencer_post_commit_cleanup() initializes an instance of "struct
replay_opts" but does not call replay_opts_release(). Currently this
does not leak memory because the code paths called don't allocate any of
the struct members. That will change in the next commit so add call to
replay_opts_release() to prevent a memory leak in "git commit" that
breaks all of the leak free tests.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f49a871ac06..e4146b4cdfa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2823,12 +2823,14 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 			NULL, REF_NO_DEREF);
 
 	if (!need_cleanup)
-		return;
+		goto out;
 
 	if (!have_finished_the_last_pick())
-		return;
+		goto out;
 
 	sequencer_remove_state(&opts);
+out:
+	replay_opts_release(&opts);
 }
 
 static void todo_list_write_total_nr(struct todo_list *todo_list)
-- 
2.44.0.661.ge68cfcc6c2f

