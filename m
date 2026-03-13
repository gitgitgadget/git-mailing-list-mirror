Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068738C2DD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410281; cv=none; b=aAiI1NysJAZf7VlQbK1kuvrb905bL626KU8XSEbKu+qYJYPNmqQj9wo+1l2SvyPFegzd9JeJ3lR5RLIl6GwB80ty3XPvlIMcr5IaQaKw1Dl+8dEPrtc9/Xd9OcOrC1tLtphPcnHoXlsx1ckrFvQBGecpLNb/ZxGH/3MGmna8LlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410281; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+zW/h9AoUyILs7KQ1UeplzaYVSZM+xiBawxx7sbeSCT7HR9XK7JH6xi4nXhrzdcimIUJnuqthEk376sAkH3iJ/Ox/ulqk/T2XosVViNZBxrLqBf0MNBq/ZAljPHmpDYYA6+sE10wQJ/amKm3UWguj3HDblN7Y6bFdmx8W916BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZYQqBL+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZYQqBL+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8296d553142so1045776b3a.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773410279; x=1774015079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=PZYQqBL+fseJZX3tJJYbM0VjwlAqy/vyzZA8ptE4bJtE7yS95cTNZJZBU8Fub+xkf7
         PWKcble5Vc4YROA3PhoXgG020jvr6KzVqRpvzoX7oW6GqZaZrj1iVynx+DKo5i+RdzHC
         UatF/JQVe+yG+G+hSZf9SFFU0mzBL5/NIVeeHJaZobGjfb0ZvUdCIbaDFCrpDbs0Twja
         5Zt5UB6F3hEdwUlo0AvzSOfgwTv6C6BgxT4+mVmSD9TNDoWA/l/qhanHoiBTuJVxygsF
         m2FaOisGU9udw6rtT/HxQVQCax9sdUWdjOGgBL9FS4NeiTtOIitnNqsiM/FP9JJE+W2S
         3A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410279; x=1774015079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=OBXedPTUVX5O9I8lBCClK2hdSloAR75SqE8gkDEQhcnw2GgalooOAoSIK2fdGyV/0Y
         SUzTWpRmWEs0U3UAR0AQUv5jXIkjGrly+Oo2xaRRzdzjxWYIPJ6ClROlQsIAEee9ty5k
         pc9QuX3jGBH2abK7DLWvU8RJUl6U5YHT1TM5oE8M89Q+FVIsgbmmpxe3sLAWnvmhuEyZ
         pOrmt2voOPfCkesOSWVcWbRO4HyNXWoERYrPYlxeTH3JcfAXrM8/qzJ16H5SymYGw5i6
         4iEVgp8iLQ5ARskMKOGsna8CibyzuIB3NGk8D+UMlJxiWqxCRMwNb6JGroG4uDmGZl/o
         AWHw==
X-Gm-Message-State: AOJu0Ywgeohhk1Yz0D/IxOk6OyfyX96bz4Fc2VnX/9gMDrYUqx5V9h6c
	ywVGvCKmy6kTyBn535oh+jhaAgTf/IcfxeBhozV085v2f/rHmjG4vXqdU0wfisKo
X-Gm-Gg: ATEYQzwTLeANm0h7K9TJNo+PyulmbBhA08Z3bgSHjYxEWoZR0SFRUTYxN0sIzsMPxL6
	eB92ewIXN/N7iRaCQqWA1D2GX1bEm3OHEqmaCF2aBSt2jxp5ItY8o7DUOsvVql9s9BRG5MQtwfb
	zFowFag0Czs2XTB+XVvY4YzjxuuNk+PtDw3fYEJJwNLA/CZgW0ta5bxWeL74PT0dfSBy6bcsPQc
	6bEUKYRexM7b840KS/ds44IXIkD+hcYum5KBX4VHhaqVW8RoaWhnz8h4Jls2tXrWj5QJaYemxn8
	AEzXeXB6B2/WwKqmVXaOlzSFeyDOKszYEqpy0pYyGYvBEaU7lvPK75smt5gVtiNJQvuP9vklvzX
	xJer94jl0hrAbq5DxDHTWYC7XZDBYhJdJaJ70ykDkaMrxCVkPve9c76n+xVUoQRP0SSzcpxD6v9
	GwlDXPfUy200J5aJnrWCa8Tf+WEIhOZA==
X-Received: by 2002:a05:6a00:439a:b0:81f:9c54:65df with SMTP id d2e1a72fcca58-82a199184b3mr2717383b3a.50.1773410278764;
        Fri, 13 Mar 2026 06:57:58 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072612e2sm8100041b3a.21.2026.03.13.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:57:58 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:28:36 +0530
Message-ID: <20260313135836.563264-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

