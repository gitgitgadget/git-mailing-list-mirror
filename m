Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05B346FA2
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711366; cv=none; b=nSIcOBKjOw7v8bYCW3ajK9lZgxu0wET8HT0AsQp65dnph4EEK/23FCFuaeDhpgKVS/51PwgPD1xKVTX8GZ1X5JfuBcncvEHhP4qxHkEOlVi2hPp4XegyjRcisqcFm71rWuWgz8unCmvTN/u9POrTDrN1mJrFl//IcBIgnBN+3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711366; c=relaxed/simple;
	bh=Fbm3gdVD7W71XZTHraKRnQYu427yVwxKC3ZULz2IkfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWc9W3Yz8VqqISGvF6I6nyaovCxDP/cus5tsQ/nF/E7DuBuZEQLoYmSry+UGhbrVD/JeJ6OlwMvjEtXbYiFQ5YBA8ZQFUXJkruloxooYwYkyMzvk+LJq471oZG10hNFf9xwZSBF829Sjc6FW3jLuPZa82uizn6UA7BKpl9hCe3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyuShfFn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyuShfFn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a9d08644so1649876b3a.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711364; x=1775316164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgN3tMfLpkY0N9Sy5YUd6Ea1Nlae1KD+Tdy494XZ0R8=;
        b=NyuShfFntErNOVVGUibk+w887W8jqs9I553ZPzQGCnGBN9awqUTk1sPk/EamYiAKWf
         mNnN5ks3jZEJT/w3Hg5hlqJxhlM/rr6F7MHUqNNq2OOwpJPyqe3csxIvaTdZpXOJ0CJC
         0LgMyOnF39kiOr/HOam1RGSYf9GxgdNFOs2V7jrjM2xPJugX+kP0PDY+k8Eb5z92yWDL
         iNRcwdDcU7jwPInuQVNfPRvXLJofrExFmJL7iaEuKdh6xIBvyISu5yvv53H8qRr5cbnJ
         IisVGcZfO6uL30QeWCnx/Ivo1my8i6pVVvWHTNC5WdjI2OTA6a1cGiaoQ+Z/0LifShQX
         kgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711364; x=1775316164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IgN3tMfLpkY0N9Sy5YUd6Ea1Nlae1KD+Tdy494XZ0R8=;
        b=UB+iIofEnymSUSZ4ntyLedZ8tqg3qE8SCzF4J4z/nXoQXw4P1FdmXi7QoDWb+29j5S
         hVE8tKQe5dRpLkf45cFBN9AUQOH/UI0+S1Sby3PSnyQOV7SQ/m9OcXZGIp+RNNLIJMSp
         VnVJ7WqBPxPyYe/tA2v8mdccy2JG7IstK9L/ewGfX8MsL0fqGhE524Rk5K2pTIfKnYSM
         G4nmwDrxB2BPdkM1tOb6U9o7xgpdP9HznBQQNz5KRe3YwLsuIpYDPwOx8qVFObN6aToB
         PwuElXnKP5X0lQR9FzBaunNqlbanJVrMKtPjVar6lC+EJ+pfohGf6RSu+bXXsP27+gEz
         hfvQ==
X-Gm-Message-State: AOJu0YzWulj+E/OrNQA9oWociPcWqHb2nwtM0kKMJluoLoKPtmzU6dJV
	lkkNJDK7jq5cNHazl11VBZb3JN49TC42y5zI/1rId49V/2Hhj2eg8I95/vgmsQ==
X-Gm-Gg: ATEYQzyVc2bHfHVH7N2CkdyFnpIa3KRnzlnMPnwTJEZ9hjU03lcVk0KoHTa6ywVBNDk
	17VkeZBUe2fT1to17+X2FM8ojytcbIpH/VyAKKJnPJXBEf+e343XMEP5wv3nXfBRRLsla2lN/QQ
	h+9qaUk7chdyOOxKK4S/xRuISj2siTcMx0I0LkWGlxUVtjvLs3WJSjLJ8Bzczzag8dz2mTe1HWx
	JCufkgBfAv9RQQ598QnLDn9wz/iObmn3Vd0TDkEvfEhXMIzl1B1ZZtK07g4l9Ui+oTUhpYzc3RV
	mdQQaC1uzaOG/jEE6O0GAOhSAWRlMn7Viq2HHiV5l3dO900Gyok4HGpaCEdS26D2fkxwdl+nkwx
	0l8jALa1eU35Yzl7+QZRJkZK6VKbxiTPBFFd4DO1KL9KX8ysXfi92qKF0hkUto/aTqYybD4dheH
	YUJVrKnCJsl0hE05zNDz24poxQKV5EMi6dwIDXsa+FFyvCWIyLAcdI
X-Received: by 2002:a05:6a00:c82:b0:82c:249d:d84f with SMTP id d2e1a72fcca58-82c96031848mr6486932b3a.37.1774711364051;
        Sat, 28 Mar 2026 08:22:44 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:1b3c:5de4:c8b:1b79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d3a71sm2707074b3a.30.2026.03.28.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:22:43 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	dan@dandrake.org,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] doc: gitignore: clarify pattern base for info/exclude and core.excludesFile
Date: Sat, 28 Mar 2026 20:51:58 +0530
Message-ID: <20260328152233.1140327-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqwlyxkzyy.fsf@gitster.g>
References: <xmqqwlyxkzyy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern format section describes how patterns are interpreted
relative to the location of a .gitignore file, but does not mention
the behavior for exclude sources outside the working tree.

Clarify that patterns from $GIT_DIR/info/exclude and core.excludesFile
are treated as if they are specified at the root of the working tree,
so a leading '/' anchors matches at the repository root.

Reported-by: Dan Drake <dan@dandrake.org>
Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 Documentation/gitignore.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index 9fccab4ae8..a3d24e5c34 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -96,6 +96,11 @@ PATTERN FORMAT
    particular `.gitignore` file itself. Otherwise the pattern may also
    match at any level below the `.gitignore` level.
 
+ - Patterns read from exclude sources that are outside the working tree,
+   such as $GIT_DIR/info/exclude and core.excludesFile, are treated as if
+   they are specified at the root of the working tree, i.e. a leading "/"
+   in such patterns anchors the match at the root of the repository.
+
  - If there is a separator at the end of the pattern then the pattern
    will only match directories, otherwise the pattern can match both
    files and directories.
-- 
2.53.0
