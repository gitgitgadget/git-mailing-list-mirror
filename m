Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F364AA4
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998436; cv=none; b=Pwd6nMOcDEFrNSM8zrlmyMPVkqDMEP8JFft5xa1ts8Cyh+RjFAz9ceUbnHKExwPaAROSfqKU2NYf3Qcjmx9iRh/VeHNu+MDTb5ail9CSJCeLlilP84PZNDKLX5fueMgZ62SJzhXBGYVpqjdqHjzphsCQKE1VChN2bxCVwbM1Rqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998436; c=relaxed/simple;
	bh=oic+UclaAJKhUop65wosxkOZA4IdRcL63aGnepezip8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H04wBocbj+Dya+mu4MqSLgSdLMDHpPUQGPS/s0rUr4iiZF+vTh9kJNlJDQ9g0dz1UHHzrXhaPaUQhMe+hMIkhTZJCY0icFIDxUFxJiQhKVXM5uGWTLNdmNYaZLE0jskE2f2Ogxa9lK8iVxWIwaFHg5OeqjsCbOIEirnnt/DhCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXDTo37O; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXDTo37O"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ee4f241f42so428376a34.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785998434; x=1786603234; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bb1KHQX7nbMO8pNXbDEyQ/gd0cN90OEn0E7ne8rYEug=;
        b=nXDTo37Oy3dqoeRqZxaTy9WoXlk/aICDuqrFWdRU9AT8j8arwNwm/8Z5aWurWPP/bY
         ITgthGPSfiqkXAZr25BDHLNCLPSNNXxSOmDtzm2q0KD6uPhvX4wdz+19LgTuXPr88UkV
         piMISQUsc7mQ+V7+gnkyMea++97sGWjGm6KoeJdYiRwxvfpb/FzCja9A6v9p5N5GYz7O
         ehg8qtpQ3KQBoVyb2YU1temzOuwM7k1Evcne6ufjB3c7i4NPyUExXda/FTJqeDWtDFFh
         DteG+kOzknGEOhdf3w/KGQy3sAksZfzlE0R+TkFbGqc6x+6nb60E3Kv6emm0E11gi/+U
         6vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998434; x=1786603234;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bb1KHQX7nbMO8pNXbDEyQ/gd0cN90OEn0E7ne8rYEug=;
        b=ZL1YTxE8oF2s25qg8bqFPkXeULERxDRHfIdX43+fREho1ajU0wyb8wLYUZcci3yxNH
         0oos+A2S41XkbZQXQvRIaRsHYGiWGOCvKznnuRbvSyXLBf7OZhR9mQfbTmlasx4meQY7
         MqO6/fJi+o+6xcnJkeTfdYHA8/WX6jaWiLztNxLHKqzy3V/GMI5jEsGDVJz+JWVL7itj
         /6QOYcCrHnmYpLz4hhR8NcLBjaCbBhhh/Ff7h16jNemVja5FtUmUmhJf3NCONs40DX+x
         qvgNCV2CsgamIU0whPKRTxzkMSU9rlMSpy+YViR75xat78vHc2gV1ZlrUeCLXO1UoPZf
         jN9w==
X-Gm-Message-State: AOJu0YwtwPVgX1K5vK6f/6NL73tOkAeueb10aNvrUl4lNlXGeBMC6PGV
	H7DsZV+oyxE1bsFi4W28LDtZWnJ30y+edyAw/0bGgaBj/5LctfkaGAs1rGm3AXI6
X-Gm-Gg: AR+sD10fsSuSQCtsOcwo/XbnfcTjLgVmpBFD4j1jp+dAVAEIgKSaLqxrj2JUicDReS+
	u4REtpgf8q9jnwKw8/JMGbi2b5shOj4yEw9uNVpCHrN8scwoVvCDhe1c93HWAzXfobpY2oCV6rL
	Ee4O6N4wmk+pH5DeXfTHQkW1uKwcBeuUvRXhY5BzTBISMNqzzjVjVDEn2Uk69WuKXispbuAPAWX
	yPbWjKVIJajjGivBURx0Ik5KVkYKp+2LspSknGHULWAYzms1ffRUOrsFlQMBEFYAHaQ3AeXWuDU
	CFEesZv56DEMfS99RhGPEdriQayWBl8FaiB9SUdw2H4AluMlkbwmmAsmnbp9RZW2Dn4UZoYdJvU
	swmGjaI8BV09K2PVbJHVDPKxJI1VTjcmY1u/uXVW4j5S9wgRZ+fEhiBCXltyxO2sKDVVpOk/w/D
	MjCKY7OhdRDsVW/XIRorweQzEIkYMyohFIL1BY7U1yoq/2jpUAY59bjkNuhdy07eIYSUgUykgMk
	H4=
X-Received: by 2002:a05:6820:c91:b0:6aa:e482:3ee3 with SMTP id 006d021491bc7-6b016c9eed1mr969028eaf.8.1785998433745;
        Wed, 05 Aug 2026 23:40:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93a39ef1sm4822911eaf.0.2026.08.05.23.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:32 -0700 (PDT)
Message-Id: <ce417701a8b5cc0c3e0c0bfb235a75d4f8ac6877.1785998419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 06:40:17 +0000
Subject: [PATCH 4/5] gitk: use more natural language for labels of color
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

The labels used to be clickable buttons. These would have looked funny
if they carried long texts. For this reason, abbreviations and "nerdy"
texts were used to keep them short. Since these labels are now static
text, bring them closer to natural language.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 877b2ad27f..9e735d91bf 100755
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
                     [mc "Diff: old lines"] \
                     [mc "diff old lines"] \
         diffoldbg   diffbgcolors 0 \
-                    [mc "Diff: old lines bg"] \
+                    [mc "Diff: old lines background"] \
                     [mc "diff old lines bg"] \
         diffnew     diffcolors 1 \
                     [mc "Diff: new lines"] \
                     [mc "diff new lines"] \
         diffnewbg   diffbgcolors 1 \
-                    [mc "Diff: new lines bg"] \
+                    [mc "Diff: new lines background"] \
                     [mc "diff new lines bg"] \
         hunksep     diffcolors 2 \
-                    [mc "Diff: hunk header"] \
+                    [mc "Diff: hunk headers"] \
                     [mc "diff hunk header"] \
         markbg      markbgcolor {} \
-                    [mc "Marked line bg"] \
+                    [mc "Marked lines background"] \
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

