Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542464D8CE
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258193; cv=none; b=Y9CJFFnv+TvbKq0D5uN6uHCUEDigsQaEhot8SEmze1/grpr9I2se3UDjsoDMVLeFUrcRJLVruAbmIjDL7XzMr+SnpZNPkKYQsBakWahL34b+ol4/wAepautBeeeLidjmVaJ5qj9efRHd4aQJPD7vdX0qgcepJENMmjmx6x6QbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258193; c=relaxed/simple;
	bh=kqmUWOxk9b0aZnvvZdEuo/nkqdT4fj+avBXu5mvGF3k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=tJDFEhL+/k/5r0BE7e+4gy1rlRIACm/+7PXtD2QqCFTzysltFbHMRKrxZAqL4dYAHnYkY2Mbb6brfR+pP1RBkBid7tDpwRJOuh6ZH3VLXj+ktpBB0NtIA99cL4E+DObcuAPlPe+5guExQXOn1YFw8xiT5k7Mv/WFY3bo2b8fswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLhxn77W; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLhxn77W"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a35a00502so28400696d6.0
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766258191; x=1766862991; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aODOKBVR1ipHuUJ0svvrV5KvIK0Y2vxaxLbNlawIIuU=;
        b=dLhxn77W8oXdy2zrMRaZeJEYxsfZPp6IRpOPNjWyrIHbQRYu6lidqNNOKTiqKSj0kL
         gVpV77uhaL/A45cW/iahZLXomsnhWfO0RblLvg7TpajHbHmyuwd9RyX+EM/rzUtyiWNa
         z6ID+NZ7bqoAdSM/JQOfWUjagNWsiNkhnbaTten7muH045UseJYPr1+H/8KXRtJ/jfUC
         pe8F9gPxt8qQWNKtbLDLco1lYesmAZtm0fN2xioSdca1uIY0JbsOkJP0eMYcI99QZ44z
         ikd9oi7szPM9YyqAhMwHGwsCjNhlqZ9Jsg0wrZ/MxfAypXY6qi7o2A231SPa0oNfVjAl
         qR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766258191; x=1766862991;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aODOKBVR1ipHuUJ0svvrV5KvIK0Y2vxaxLbNlawIIuU=;
        b=G7xlkUFlI8/Vdio3O517RAXZ866mp3QJ4dRLDXyysBl034xQB09wDPEEzt8+v5oGBd
         q5LRK+ONVkjmLX2kMHwlae0E/D/kEohkbyYsFPBpnF7Qk+WnOiAgXjPvYkYWd7H3Xx9u
         EHlubZ4wgLUhs6Ci3CN4pT4vbhu76i9AmKdLu1R6hZMHeEmo+R0sa+vcsa33Z87ueuDC
         0f3fNtrFnNIK5PKBy0Nzvgp0yN+FR/QqqPAW5DKyOb3U6Jnw8pElcN2w+xjW4PLvdEBq
         nk5A8jXr/yfsCqcU8+0CtpDTsYPri6rpLhG9hOkBZvNUKggxtPXe+0JKOitUSUQ2ATx2
         gdUw==
X-Gm-Message-State: AOJu0YyT09kGs8Wl9l67FV/OuZt27zsPdPHPOHhc7jD6bFxHi+eecVXh
	pReWjoMUcxFSVuGOZzemt107bw/NGyze3Mgc6aOp0tfxwD/OHHBfqIuuXodGSw==
X-Gm-Gg: AY/fxX4VBj+Fc1ifn7yaFUPjkZPIXGzCkyG86zufu/aBp00NSssAWYlfQJ43/Z9b9dp
	RyJUjvG0gZPy9+F9mnscKfdcOzTpdGSNdDe9689bZh/HO5lMHUMqH94aZRehmshorSJ8mPE7l9z
	R/r7NdUjZ/qP6JG6SB4Wh0gXgkTFNHIZmJCxnjQ6/6+pDYK7UeFvy9pqULUCh20KdRdHKZHLQNN
	Ws1XUOFjM4G8mBSd5wl8GsmROHL1RV48oNg073THjmiC/vj+h98IEv2t2lgPK2jG+Q2ds38YIeI
	kn9gGPnlJsXjx/cV6wZqOBcZtBweo/XQOOlZaNdb89AGrXJP/1vNKW5wb16eAHWyMP8y9Y1s11g
	dSu/fbAiqFzKtuUsmEDETHtW/6elvdOJlx2ZsAeG572PLqw3b/KT+KqCOsoew/OaCzfFG0altqN
	C/os6YzPcLh1K35Q==
X-Google-Smtp-Source: AGHT+IEPVCEx2kiK5EKzcjU9hp32OH99jW020Ei0g7zlqYxaluQ80fC2K3QW6imxRc77TBzrOOFU4A==
X-Received: by 2002:a05:6214:610c:b0:88a:30aa:6c01 with SMTP id 6a1803df08f44-88d843346a7mr82170336d6.57.1766258190791;
        Sat, 20 Dec 2025 11:16:30 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aeef5sm47105316d6.27.2025.12.20.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 11:16:30 -0800 (PST)
Message-Id: <d470451c92b195f2b25f584722573bed1b54a154.1766258187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
References: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 19:16:23 +0000
Subject: [PATCH 1/5] doc: fix t0450-txt-doc-vs-help to select only first
 synopsis block
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

In case there are multiple synopsis blocks (declared with [synopsis]
or [verse] style) in the same file, the previous implementation was
incorrectly picking up text from all the blocks until the first empty
line. This commit modifies the sed command to stop processing upon
encountering the first empty line after the first block declaration,
thereby ensuring that only the intended block is captured.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 t/t0450-txt-doc-vs-help.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index e12e18f97f..822b0d55a5 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -56,7 +56,7 @@ adoc_to_synopsis () {
 	b2t="$(builtin_to_adoc "$builtin")" &&
 	sed -n \
 		-E '/^\[(verse|synopsis)\]$/,/^$/ {
-			/^$/d;
+			/^$/q;
 			/^\[(verse|synopsis)\]$/d;
 			s/\{litdd\}/--/g;
 			s/'\''(git[ a-z-]*)'\''/\1/g;
-- 
gitgitgadget

