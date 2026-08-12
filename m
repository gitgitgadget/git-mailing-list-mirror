Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364444CAE4
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540596; cv=none; b=bOEeOEMhRcoxmxUBhDe8U+CfZnD0KgYKAVj5Fk6SU9psrZ69gOmIDBjQlcSWgwkfe0pHmVuyBdEXDpK0u61IUZzYCYfbLQal1ZB962esZpxXkflpNmDCtiAh5x/fLZsKY9PxRLDqw1IyF37Ph/XN/8Qy5PMzmYbq5RQhdVY+pFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540596; c=relaxed/simple;
	bh=stA1OzEumHxuAT/wimaSHYO0stLotcoIHk2QohsENLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c3GN2mvCUzilJaDDK70+L62cVd+y/Z5PMnlsoZbqz2NNmJU8g6pBVwzQQEupuLz8DCakBzaRI5FioxIAJbNfu5rasEC+kMhy5dJyn6o2lvFDqiYuUJSMQZpUbuWCwnu6Z19TocpANN3NsAqLxcbdRbKl8NSHsXKv44MII74r0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSKARoyn; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSKARoyn"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ec49608332so381329a34.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540593; x=1787145393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SSHaRlRyFCA8aemdLn1XJomszM4UwA8cWOvq6RUCiR8=;
        b=CSKARoynt1dX/PdPlmHkmivake0S2AXRnP8K1xkLM726L1slWIgrcVTz9tG7uHRz7X
         MltAMqqvfR1wr+B1fQPgGzg8f/eTE1SPXC1koI3jSVzY7Ic9jvc05jg655yVE7H5pNOM
         BxdoGpihmjD9zTd17jT/YZlD6a79Q6+0HzGCCfenukp8okznuxsO4+tZBGXBvWvqYROE
         y269FO1yIx/Y0ugCPG7fAmerSJ2t1ggidbCyfzZThSHojboiARVAuGNN/vh//s2zjdS5
         ZN89Rn4rh6JoxlBvSWmL0akxWjJBorX+LJrcxepsEzl49SAqehMgxwvnX0nxidSwHNTU
         bIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540593; x=1787145393;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSHaRlRyFCA8aemdLn1XJomszM4UwA8cWOvq6RUCiR8=;
        b=dNNk6Dbd7uXDgm30l0QCbO6+9L0Ra27zTbtG07A9xMBJrIWsoX/P8Y3B9T+uFZuPed
         aX0NX5R84mFlZzg7SfRKkhMCMyCA+HmV9Cj4p6cT40SCiQU4tDRCEBzuEiBh9jRSArZL
         BFWgqPicC3J2+HwOMAVkZorsu0fVnU8Sl/H6Nq0yRfquucicNClk7H3BkioZJBMQaASs
         TnlXw8Xh4kehb6cU31DYnshgi6Px99nVICZFUJaPBp3LPB/PQApNDXpuhE+12AekH5mG
         dOZ2L/Q6L46hL4yKYbZy+UWAvvIn3fKG4hWnHf9nMvUsV+m9x5PYNOQZC+e2kpJ6dxym
         ARbw==
X-Gm-Message-State: AOJu0YxDEl48RcjP1ghQFB+wTsJaEXt8Ts/zadWWpJvSGv1b3k7petMw
	tD3rjEkYZPQZedzeGeUysAGDEj4Oqt0eUSrtpznCg3LXIoSZ4gatJObM7p53gg==
X-Gm-Gg: AR+sD10yDVTHkTP0ujCchxS8Wm24h9TPbusmdRf1PWL1azjpgcJqx6L2dFMw4IlQlfy
	Xg4xU9FsuBO0itMdpoh/7aWeXJ5wvQ0muZQH6DjKuWXQHOdLx4EXuyQZpGzVVksp3AF19jyFrZ6
	SY3XhqHa9AT6jla+bABpMDVX9ezyt32EUGCRD3BdkTdNo3TFGQ0pKY4rETmZTo0o42NQAhWLn3+
	JmcXHGes/f2lXeDoOYYX2+7rVTyIHrQ5A5nfTXYZxRV2jsuZHiWzpSRMoK37JKZrloh1GDI5iV1
	u08bawtRlUSl9UAglKDihRdf7BnywBLckk9NHS7Qdfc/wikDJwBrL76eYqwJGYf4bVe4KDP2JbU
	U/hflfAXC3MFzut/xxhheA7MRzwU7/fVDwIvslHaCDGXzDXKynpUpkAcKB8e67bGe+4r3+ETnfa
	qr5j/80/SZU6mcrjr1sJKSwD0io6pEg5NUOBtliphBlx/5KUI8SoFqQ2FffPFL4Tg=
X-Received: by 2002:a05:6830:7185:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-7f3b74a373emr4138965a34.0.1786540593334;
        Wed, 12 Aug 2026 06:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b31c8569sm2827462a34.1.2026.08.12.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:32 -0700 (PDT)
Message-Id: <45d5b05281cd4f3f43290d128d631a47975225f3.1786540582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:19 +0000
Subject: [PATCH v2 4/6] gitk: use more natural language for labels of color
 preferences
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
Cc: mark <mlevedahl@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

The labels used to be clickable buttons. These would have looked funny
if they carried long texts. For this reason, jargon and abbreviations
were used to keep them short. Since there is no button frame around the
labels anymore, the texts can become longer without becoming ugly.
Bring them closer to natural language.

Remove the prefix "Diff" from labels, because the remaining texts are
sufficiently unambiguous that they are about diff text.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index afc7c2d39d..c0ab55845b 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11838,31 +11838,31 @@ proc prefspage_colors {notebook} {
                     [mc "Background"] \
                     [mc "background"] \
         fg          fgcolor {} \
-                    [mc "Foreground"] \
+                    [mc "Main text"] \
                     [mc "foreground"] \
         diffold     diffcolors 0 \
-                    [mc "Diff: old lines"] \
+                    [mc "Old line text"] \
                     [mc "diff old lines"] \
         diffoldbg   diffbgcolors 0 \
-                    [mc "Diff: old lines bg"] \
+                    [mc "Old line background"] \
                     [mc "diff old lines bg"] \
         diffnew     diffcolors 1 \
-                    [mc "Diff: new lines"] \
+                    [mc "New line text"] \
                     [mc "diff new lines"] \
         diffnewbg   diffbgcolors 1 \
-                    [mc "Diff: new lines bg"] \
+                    [mc "New line background"] \
                     [mc "diff new lines bg"] \
         hunksep     diffcolors 2 \
-                    [mc "Diff: hunk header"] \
+                    [mc "Hunk header text"] \
                     [mc "diff hunk header"] \
         markbg      markbgcolor {} \
-                    [mc "Marked line bg"] \
+                    [mc "Marked line background"] \
                     [mc "marked line background"] \
         selbg       selectbgcolor {} \
-                    [mc "Select bg"] \
+                    [mc "Selected text background"] \
                     [mc "background"] \
         linkfg      linkfgcolor {} \
-                    [mc "Link"] \
+                    [mc "Link text"] \
                     [mc "link"] \
     ]
 
-- 
gitgitgadget

