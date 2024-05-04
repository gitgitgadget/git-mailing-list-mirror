Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42246AF
	for <git@vger.kernel.org>; Sat,  4 May 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714802226; cv=none; b=OZbyFphmXvbUPt6ZrrkShyrreCxxD1PPnBgqde48FSe+JjK//FR4de7AltJTUJnO49OXr34kvQwUA7IcVswbZuJZWVpphaGBC/V4W5Q3LRYVk99HM35fFwhnIa9xqL0pYwvpUpZZkz7laUGmc7/wfhhe+WzdBqRHmy1RaHOc2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714802226; c=relaxed/simple;
	bh=wjvaWucS6ROxyWwrXBTHmZzJu70ba6RAEzDc5TdAw04=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=N4bnBz01qlvwRXpHcH5WY4ITvdyei7cbx3Gu1YXtSdWAd/42VfbeiBieW+55CCSz9qC46ckcJfIJtmpW9u1U5dcxx70itKUdXwGhPF3lIJTQtWvsy0xNTGVHnFApzoz19XuufJMsnIhMpAV5L7Dpv0Vp1UYCo8ssUJFTH5IAdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXoLZIx+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXoLZIx+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so2743015e9.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714802223; x=1715407023; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNA6tqrHbdjyen7MwT3yPXT5xJmoSPepNFlbvNQOYps=;
        b=TXoLZIx+7EoouPv2keYJUO13oEmEQNVOXn/xgdNY+Rbh0wWfSmituRefjhk6m5qcil
         PqVgn8b/rt0dAUdg52sMhKJKrewZGcTsm6vVpF4VWImBrd8LS3mA3D6kWoar5hp1LmKu
         MB63rCVWjX6RTJVAoKuLf++HG/5QpzAKme7jcG+GcGurLNP62QjMOLTkmgPGi29eGX4l
         ts+GB+Jo16FfWzvwfq6bJY1UtAkz/VzqWQCamuaPeL6s1OLsQYZADcE2F3h+Jykmg34p
         qrdikOdAfyzeEwUfp3rcczDlV42Gj1AXv9afNYDU9OODn5Qq4IKhNVr6qou8l9P6kkub
         0L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714802223; x=1715407023;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNA6tqrHbdjyen7MwT3yPXT5xJmoSPepNFlbvNQOYps=;
        b=RTQW99Y1iUq4pVmemNV0zck2whbTRtHdBLeG2aU7wfZnii4MZpwp4WvshJIn930Cu2
         +0fT+1ioJAzmNY0Hvu9L6utFW8PnqRdUVY7e9mtD9OWjoriK1CjklRoVn6azNYUGVhYn
         DSq9Gyvb3JB1Xih4+Ms/OdXmeXFDE+O7Ltnm27EPs75t+lb2N4JuY2aaeATaOQm59TZA
         QWa4uiRslecADTJ/esu1A6kvzFTYaFAid+7UafLxaWOmV/Ymmj6+yTPth8KOqE8LYwi+
         1U716dQIwZu5sK34j5ZFiU0blLc2DBo6GtNyZwlf8SQQL87ounEjhNiagxwrO6tAHRUT
         8YfA==
X-Gm-Message-State: AOJu0YwVXVX9Xk1zxGWLOoo43uv2eFjhE93fRar6liPV09pc2ncO3G3P
	wfpktPP/gSI1g04g0GhBYc3HdWxPpo42V5prenRHMM6XlBrGoDwpIJSaug==
X-Google-Smtp-Source: AGHT+IHzELDnN1bMgbKD6I6bbgwkAi+g2aQAOkSBXQ1JsmKOPreJeVUJPyKFtaLnMqHcyFef/yOY7Q==
X-Received: by 2002:a05:600c:19cc:b0:41c:15d:98ac with SMTP id u12-20020a05600c19cc00b0041c015d98acmr3548420wmq.11.1714802222826;
        Fri, 03 May 2024 22:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05600c1f1700b0041bfb176a87sm11849172wmb.27.2024.05.03.22.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 22:57:02 -0700 (PDT)
Message-Id: <pull.1668.git.git.1714802221671.gitgitgadget@gmail.com>
From: "Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 May 2024 05:57:01 +0000
Subject: [PATCH] Bug fix: ensure P4 "err" is displayed when exception is
 raised.
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
Cc: Fahad Alrashed <fahad@keylock.net>,
    Fahad Alrashed <fahad@keylock.net>

From: Fahad Alrashed <fahad@keylock.net>

Bug fix: During "git p4 clone" if p4 process returns
an error from the server, it will store it in variable
"err". The it will send a text command "die-now" to
git-fast-import. However, git-fast-import raises an
exception: "fatal: Unsupported command: die-now"
and err is never displayed. This patch ensures that
err is dispayed using "finally:"

Signed-off-by: Fahad Alrashed <fahad@keylock.net>
---
    In git p4, git fast-import fails from die-now command and err (from
    Perforce) is not shown
    
    When importing from Perforce using git p4 clone <depot location>,
    cloning works fine until Perforce command p4 raises an error. This error
    message is stored in err variable then git-fast-import is sent a die-now
    command to kill it. An exception is raised fatal: Unsupported command:
    die-now.
    
    This patch forces python to call die() with the err message returned
    from Perforce.
    
    This commit fixes the root cause of a bug that took me hours to find.
    I'm sure many faced the cryptic error and declared that git-p4 is not
    working for them.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1668%2Falrashedf%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1668/alrashedf/master-v1
Pull-Request: https://github.com/git/git/pull/1668

 git-p4.py | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 28ab12c72b6..f1ab31d5403 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3253,17 +3253,19 @@ def streamP4FilesCb(self, marshalled):
             if self.stream_have_file_info:
                 if "depotFile" in self.stream_file:
                     f = self.stream_file["depotFile"]
-            # force a failure in fast-import, else an empty
-            # commit will be made
-            self.gitStream.write("\n")
-            self.gitStream.write("die-now\n")
-            self.gitStream.close()
-            # ignore errors, but make sure it exits first
-            self.importProcess.wait()
-            if f:
-                die("Error from p4 print for %s: %s" % (f, err))
-            else:
-                die("Error from p4 print: %s" % err)
+            try:
+                # force a failure in fast-import, else an empty
+                # commit will be made
+                self.gitStream.write("\n")
+                self.gitStream.write("die-now\n")
+                self.gitStream.close()
+                # ignore errors, but make sure it exits first
+                self.importProcess.wait()
+            finally:
+                if f:
+                    die("Error from p4 print for %s: %s" % (f, err))
+                else:
+                    die("Error from p4 print: %s" % err)
 
         if 'depotFile' in marshalled and self.stream_have_file_info:
             # start of a new file - output the old one first

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
-- 
gitgitgadget
