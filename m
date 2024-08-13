Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A251A00E0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560312; cv=none; b=OiVrA7C665PFuobInUXwT+0vaNZNakuOy7Lqg3mdEKU2a9NFlgkc5SAcQ/fVfJ0vM7lKyD6LIcM/WhZ1g6U4T6NAesTXRhIz4tDtQ7JZAUC3eFQVFpaJMptrOQVGBeEt2c3Un4EeeXdQzIF2DHwm/LYWvKzKfQJwW8I/MycU9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560312; c=relaxed/simple;
	bh=/VfPayIC6UL3j30y/3DMYX6vAZWvR+O6NaYZtUEr51o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSjiSXIxrtevkvAHmJQH3GInDoDUeQD3jte9jvnFlxZr8tUn9ylvbTDhL99q7IYCLXMWRwzqfA6gXJKEjr7X1c3Oz/O6kk7TZCWhUO3bPQzHm28dZXhruAU7t02KBs3NkNQXuHk46m6qaZVYIZ0EbkzN/1n/5m430A2ZXJ6mF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scre8Jxh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scre8Jxh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fed72d23a7so42310925ad.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560310; x=1724165110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDHzTIL1Y1piKl8VKW7PtejRsYdJEdO8EEiK0rwt4lU=;
        b=Scre8JxhjNnZZqCPPplowZ47sbh+s+WWTjltLuR0qTm7qN/Mxid7MvhgGbz7SP7ZLH
         i9NfMzFNqSU8e+hy3erYZa84xLkyPLx1addEn2WQa7xPzuHIP+hfVMTgW0EDuzH/D3X2
         jvpYFZ1f1Chl6mCpHqFw2kc8UJRG7iw5yS+HVzHVf1ET7pb7auhCJRwC188j1IToSxc5
         F+V+ET5VhK2WdI+b15KxNrrGtVCdNOLH/hXuY4EBfvL0G6ix2aRvyLcSmhafpJl0RA3o
         Fz507L2ppEfY7FcZct5HksaG26IOyBg49gQe+/XIBC3CeFZF9lC997rS++vyquJzhm+u
         OEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560310; x=1724165110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDHzTIL1Y1piKl8VKW7PtejRsYdJEdO8EEiK0rwt4lU=;
        b=ZTS6GNSlvL8JZlsIpArRVs1+jXd8XIcrwBh2fafeLbXGXujtp+WDZNRw+ItZCvGRCh
         AVNigLcOGSKYBkuHNq44WvYa6uYuhOFBiFiYUH2WRv+srho1D98kFzZl0CVGZPDFe2j1
         Il1ux/wTTJFXq84B5lqeeNWUSLFp6qRA04uAUp7npRJD4DNlbJhTSfZ4drCGFwjQqxta
         ZvkqJ3ZKMnDca46JIuKYtgsMhJvUQxkA1xLC9if240xuFmcu0to8sqyI5oBDfgmVk47b
         6PqVwiaz7z23Zrvt4pkeDMqwwQN4L7nJe7AV4BGkRdhsbkhwnlBUZm/GvqbQT7jN/xAm
         BiSA==
X-Gm-Message-State: AOJu0Yzzl3eG+OAm/3gnFWUrQj/9pveRA02ujD+F5SXHTJfs9oCzTcuE
	8qWni9ovIChQyqgyqLB9cDtDEzQiH7EPUCYtEkT3UMKI5CL4OdSknPr+5z/uQH4=
X-Google-Smtp-Source: AGHT+IG3qtTerlpyoIUqP9Cp367kNsRwi+yRtx+sCC5iiCPnmkT0cqIDKDbasQZ7i7XDZQCXz7VKbg==
X-Received: by 2002:a17:902:dad2:b0:1fd:9238:40f with SMTP id d9443c01a7336-201ca13ec08mr45260055ad.22.1723560309818;
        Tue, 13 Aug 2024 07:45:09 -0700 (PDT)
Received: from Ubuntu.. ([27.61.226.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd14b1c8sm14388805ad.78.2024.08.13.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:45:09 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/4] t-reftable-readwrite: use 'for' in place of infinite 'while' loops
Date: Tue, 13 Aug 2024 20:04:49 +0530
Message-ID: <20240813144440.4602-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240813144440.4602-1-chandrapratap3519@gmail.com>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a for loop with an empty conditional statement is more concise
and easier to read than an infinite 'while' loop in instances
where we need a loop variable. Hence, replace such instances of a
'while' loop with the equivalent 'for' loop.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 8e546b0dd6..9a05dde9d6 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -269,15 +269,13 @@ static void t_log_write_read(void)
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
-	i = 0;
-	while (1) {
+	for (i = 0; ; i++) {
 		int err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
 		check(!err);
 		check_str(names[i], log.refname);
 		check_int(i, ==, log.update_index);
-		i++;
 		reftable_log_record_release(&log);
 	}
 
@@ -375,7 +373,7 @@ static void t_table_read_write_sequential(void)
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
-	while (1) {
+	for (j = 0; ; j++) {
 		struct reftable_ref_record ref = { 0 };
 		int r = reftable_iterator_next_ref(&it, &ref);
 		check_int(r, >=, 0);
@@ -383,8 +381,6 @@ static void t_table_read_write_sequential(void)
 			break;
 		check_str(names[j], ref.refname);
 		check_int(update_index, ==, ref.update_index);
-
-		j++;
 		reftable_ref_record_release(&ref);
 	}
 	check_int(j, ==, N);
@@ -590,15 +586,13 @@ static void t_table_refs_for(int indexed)
 	err = reftable_reader_refs_for(&rd, &it, want_hash);
 	check(!err);
 
-	j = 0;
-	while (1) {
+	for (j = 0; ; j++) {
 		int err = reftable_iterator_next_ref(&it, &ref);
 		check_int(err, >=, 0);
 		if (err > 0)
 			break;
 		check_int(j, <, want_names_len);
 		check_str(ref.refname, want_names[j]);
-		j++;
 		reftable_ref_record_release(&ref);
 	}
 	check_int(j, ==, want_names_len);
-- 
2.45.GIT

