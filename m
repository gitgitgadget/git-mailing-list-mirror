Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893AB67F
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757763186; cv=none; b=nBaA8AoTpYlEaD4zXEmqEtjYUFCRTBO+B1O9aoLOvD+p+8KAtwe1HSOsQFvImufRhhbSaZrtAIZH14nyTioQhw3yIUvsc8jyR2zyVIcM2Su+TaylXp4biVKAQ3+MXcs2yN7W46d1fp54nGnnnQKb5xhKr5sx04+Z8sS8xePrZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757763186; c=relaxed/simple;
	bh=KxBF1Jdwgp/pHE/vhSiL2HSXqGZUjeH27RQnDXQC0D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJmCgGn5AouQPDbNu0odLWWKGH3+IVFzkcvBRd5BiYIITtmBFbkrRz9TBg4t0ntkXbadYS6n+DgWsYPtD06LWLpGBSZOi0jqKBg9EOf+x3TOPZ8cVIFRzvg9036XFIjjGiEuZ5VRa4gnToCCgYugMA7h2UaO+ikQ5yczSIJSw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THFVOciA; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THFVOciA"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea3dbcc5525so1070226276.2
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757763183; x=1758367983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+XNgv4Xz2Z7QNz4CxMULp2oh2yvFIRiQ86q65FsIVg=;
        b=THFVOciAlNA0bMhtBxPuhKXCRCHFgeE8mgQ4g0qkRFknFC6s6KyibOc1qTYbZ7CF9u
         Z4zocQc9v+hHLTLEPlisPD/GAZP7/WxO1VZPcOpEothvI6c0UkbYBLvIoWIFs+coiyiv
         J1D585xlJxBFYgBTLSqGC7FeATCPnu4FSw1qvea+77L/dgdTq+IegeE2A30s1j9zwGP6
         ZOOejuEUZNA/OtN+HykOsk1lmWGDHkYgbFSV8OoczRetsB02oKCI8BK0EVZ4Y3033xLp
         lBHDoVSZG9pqYLpio2mUupy3jpy7CVWe5j2lE3othr2MuX+vJxHkiquvcLTyQVuEwr6L
         EN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757763183; x=1758367983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+XNgv4Xz2Z7QNz4CxMULp2oh2yvFIRiQ86q65FsIVg=;
        b=tbmjmrfxsbv5Pt4cNlkw6fOLrK2s+ZrUW+fjrRmQM6mkpWJkN88wNMWBtwvHIpo1qz
         jThIHlcNrM3XcUI7a9nBVRPAEfRTHIVIQNzbXGXMyUAZvJpTs3aWjKN28WEUP4dmfjQd
         pE9/VvxXjvRojyZDSbXL5o/DAOLJz+Cngriz6HJ84x1SKeaX464xiIHh/haSYrTeyXA8
         4jBVSAfwD39PdiP+al8nhQW53a8/ZLLqSM2X8p1vYu0muKgll1/++IFDgjmZYEUCFCNG
         g0x0MDWbi2IAIaJD9GkOLMXs4EY6VA+xK1zFVcUH/A7BNwrbuTIwflpnr5wxuHpE4ydE
         XH9A==
X-Gm-Message-State: AOJu0YzfwVIXgYiGLgCT/tXTESQwVW3hP203q0K2BwzYBXIUMqP3Cfov
	4f9QPiUyewtk8UdZSMqQm3maH7xM8CPUPe+eKaF0F3EWzGEERPSU0hmpNSBo+qJH
X-Gm-Gg: ASbGncsPbHrEIP5uvmnTD0j8itpOIZDdftFnsa6L6eAaRuTjVT+/qBCa+98wgkZcK9e
	eLrcBE4s5Llo1DNCWPHDISO3MQWfYiALea9N3cTphBcoz4+K4RcTJzL7ijMDudo1NnRblHoOauX
	Y/4ArFPCCTQX++Xzpabjl/4lpWr+Wd5V+WvA3JOHgRPQjGjmaaaElKgtbkLtY3oZ4D3wUQwiGTj
	6o8QUQbQAVx1DZb9DwNOEwUyDqpM7JPlyTjf7z6mCA3sm/9hSIWKtz3y+1q5UPyLQ78obtesRjS
	bYFyvU9ZRWpWPkZUsTra4FyAiV+Agfk30StHiQf9qI3qzPFqKmNp8DacTR7He826vLzMwKxyP8U
	cmt1MCB9EvaGR8xsYCSeOGBXRydernkbfXK1D3wrJlVPDGw9YSD8QyzpM6JGUDQo7L+LxtlS4RF
	FsPfAGW0+VG+zlS2ZBs/i8OUdqfK38PXs=
X-Google-Smtp-Source: AGHT+IHheBWJKK4+g4P2edir7YJbW+G1UOBLFSUZ1OS+sIWG6nNMU/POMsShNaVH7S24ccjShi9MLQ==
X-Received: by 2002:a05:6902:4004:b0:e97:f18:127 with SMTP id 3f1490d57ef6-ea3d9a734b5mr5537547276.33.1757763182671;
        Sat, 13 Sep 2025 04:33:02 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cf267a90sm2158258276.33.2025.09.13.04.33.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Sep 2025 04:33:01 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] gitk: fix error when remote tracking branch is deleted
Date: Sat, 13 Sep 2025 07:31:51 -0400
Message-ID: <20250913113253.74362-1-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote tracking branch is deleted (e.g., via 'git push --delete
origin branch'), the headids array entry for that branch is removed, but
upstreamofref may still reference it. This causes gitk to show an error
and prevents the Tags and Heads view from opening.

Fix by checking that headids($upstreamofref($n)) exists before accessing
it in the refill_reflist function.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
To reproduce the case:
```
mkdir sample-repo-remote &&
cd sample-repo-remote &&
git init --bare --initial-branch master && 
cd .. &&
git clone sample-repo-remote sample-repo &&
cd sample-repo &&
git commit --allow-empty -m "Sample commit" &&
git push origin master &&
git push origin master:master2 &&
git branch master2 origin/master2 &&
git push --delete origin master2
```
Then run gitk --all then bring up the "Tags and Heads" view.


 gitk | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 6e4d71d585..3cfc9ef291 100755
--- a/gitk
+++ b/gitk
@@ -10294,7 +10294,9 @@ proc refill_reflist {} {
         if {![string match "remotes/*" $n] && [string match $reflistfilter $n]} {
             if {[commitinview $headids($n) $curview]} {
                 lappend localrefs [list $n H]
-                if {[info exists upstreamofref($n)] && [commitinview $headids($upstreamofref($n)) $curview]} {
+                if {[info exists upstreamofref($n)] && \
+                        [info exists headids($upstreamofref($n))] && \
+                        [commitinview $headids($upstreamofref($n)) $curview]} {
                     lappend trackedremoterefs [list $upstreamofref($n) R]
                 }
             } else {
-- 
2.51.0

