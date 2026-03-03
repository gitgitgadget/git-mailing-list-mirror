Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B399370D52
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560710; cv=none; b=ImPBZalTgRqC088Fq6rJvUmxmyo7sa3D56mhb38nMTHqvWMi30ydP1Db5Yux/2DQ6chWeiUBF4M+ra9MGzIbVz5hdKk6kKY1zmss17MTLmphFA4Ys+tTeX5rGFcivkbLl+LiiknF7vSpP0U4pyfzR7E/5L3OgA/ZRKpoLl1JVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560710; c=relaxed/simple;
	bh=r8HIWwkyXW4XY2f8Yt9C+2tW5Gyzcm0+/6ZyC/aketo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+9wsv2q8Uzs9rThjndrE43sHu2/OGLcnNsjwP0TKCCGK4Aaj8Qfi5oImwGbsOJHoHZmxKN9TwS2OTgxDVOejcLYJthAPjWw7TrTGniGZTdgBhl17Zzq4KcD+UMx54ZjXL++lts+gpsD+hrq0z45/+2yHcJoK/nX0bE7pb1mwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOSKO+K8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOSKO+K8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824b32875e7so2845285b3a.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560708; x=1773165508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abhdcGoEY2L2V4ywgynT5Fln4kC5vgT5JICMjVbD9hs=;
        b=aOSKO+K8eR+ejjRVYdhRs81+aB95wA0OPd6nNU5nBR3+GoVM1wqwRfv1E+SVBF3M/I
         o7q7xJMOrQkWhxtaz/wqJoJAS6uwSE8aim6hp/LI8asn3iSIDLrMSg3fq1ShsQ1S5hr6
         KVl6dJLPKIWD63elNDc7GXbfJWaEYTg+m4O2T/P9WjCceaaU9/UTV7pq3xNCCxsUAXBb
         mUXARyuACiXUjj44ojZzHYwsJV40ltCSYQxcilm8Ok0MqtUplsg2cKdjzzmd5HK21j2H
         haT26X8gix/rPfqIIlM2VypU6ivtp4KbrBDvk4lFFzMMyz5Awtyf++oiBR1uWbE4SAHo
         Lz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560708; x=1773165508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abhdcGoEY2L2V4ywgynT5Fln4kC5vgT5JICMjVbD9hs=;
        b=NDqJKkSFQjva6HrShQcY3DXQz6I6pam0XjLrR2LOPBdt/Eki68ebnauduZYy5uojQZ
         bXf4I2moHHyuesUfQw6dvrtpz+LOF3l2p3b9EpuQPjaOSA31WOPOWw1+zoLVwev4S9xt
         je7CraE/2XrpsxqP1l1xtz03y3zO3cfX/7grnDh5o1Aok7AI4A9Z3I8t2m/ELwNpwK+3
         vMTQ5euKL40P69WcjxXCnVXP9nO3hptOFFeGWe6vZnEnpzrjpSLHOo3JqvHD7zAkMiOn
         5hQcxIWrryGlhXbXrxlcGh2drEEtEiK4lUOUKb7wkVJ8WhpeEVIAJG43ckRWN6chZ6uk
         n85Q==
X-Gm-Message-State: AOJu0YxXTFcisfx+FswPYB7hWswxQzls8Kk5m2nio8gdMAjr48IWQUcR
	GdwQ3+DEapXMaJfAny9ThX9O1Sz5KzjGt7itEkvc6XcTYPt5vxPSx4koMrkJdDmj1cU9lg==
X-Gm-Gg: ATEYQzy7nqtZXO10GuB/UNq+/hYPahB7X/pObUf9ysPk8to681mEMPlQPp/GOy7JgN+
	q1PHY8wWatv7anOFGBnWfMfTgaALDl8m5YH8suEKAWws0gWWGqVz9wCqZZ5lWjhJOeJ+Gg+9Wa+
	h/OmiF6UcHQH/z9z4wyJZItliEonpBab/ActBXy94HaP8WmlQVEhKs7HWMd+Bg8HKa5ZQb1icFN
	Ay4onAcsGtR33o2HfzqG4x/r8JmQvUF6o4AJq5xsCtJsFaOmczSMYXCxgiFWHEYnOwgIexYTgIR
	YiHQZpTSoS+1D0M1NXknCXYxjmGR2eY0LW8HHs4R1sE3YsfjKNrC+vP7J+hf6f29C9i3LEqElu3
	nmCzeHrjX5XjHMYMS1wBv7b9cIictJPz+fUN8aGMwoXzUhdS+tndJNPR1Q4o+9Cj0WCLfdLh5p3
	q21tyTx9VzJKKBPSTTGs1iXro0Fxn/gnbL9dV+hxb1XP2nIYa4OzGUKb/XFBdsYng+hV5PKiXye
	w9f8h6Ye38rQ1TKFdn53JQaxuZvJshH/cXibTKzvirGLcL8sUyHuUVCDmjKCwYBkXd7
X-Received: by 2002:a05:6a00:368c:b0:7e8:43f5:bd4c with SMTP id d2e1a72fcca58-8274da2351amr16609001b3a.56.1772560708408;
        Tue, 03 Mar 2026 09:58:28 -0800 (PST)
Received: from ThinkPad-E14-Gen-6.. ([220.158.168.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a059e89sm16216764b3a.60.2026.03.03.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:58:28 -0800 (PST)
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Subject: [PATCH 1/2] t7412: fix typo 'submodue' in test_description
Date: Tue,  3 Mar 2026 23:27:49 +0530
Message-ID: <20260303175750.361563-1-ysinghcin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
---
 t/t7412-submodule-absorbgitdirs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 0490499573..41ee035e3c 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -2,7 +2,7 @@
 
 test_description='Test submodule absorbgitdirs
 
-This test verifies that `git submodue absorbgitdirs` moves a submodules git
+This test verifies that `git submodule absorbgitdirs` moves a submodules git
 directory into the superproject.
 '
 
-- 
2.53.0.290.g4805bb9930

