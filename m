Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D551DE89F
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394477; cv=none; b=kcTm3y4uLhFlayIMRgn4BkUJOJ4ccIGutpN9nmK+R68UTL8zNSPkd3bc7neptciZQztW4HmwFizFW6CaX/wabi5gnsRX0xN8CjB/Kx8MMZ55zI/+W1ClcjXMzJZuD6C2pKRw8Tt2gBWxX9vBwMaA0QMW6jm7iF+kbYUUtqZang0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394477; c=relaxed/simple;
	bh=4zggei7YJXz1Rn/UiIL74Ej7ycn6JRNyq8qLI/HmRrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcDGGPcEwseq0yMR4zB1Tba/CfHeW0rCHdt3Oqhvae55PEkgEhj38bkooRFJAwcf9M50JYTTZTqnFOgbL5n6g69nVfbcRXOu4wz4vB71p6QGSd1KM5RDpVJL2BLJoaF32Iu8uvhIix08oDxbIZkFJUlBdwlSLPJEPkYqA4r7jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Basn/G1i; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Basn/G1i"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccfada422so3394812f8f.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394473; x=1728999273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krnSsc3rt8RuJ9N3cbTHjr7Cw2i9XvvOpZ3OnQAvabc=;
        b=Basn/G1iQJRtcw0iHgY3w3PoNeARa2mpdg3JXdhCtYNQER0HesG57CwTF8duC/Fht7
         /M0Vb7TjECz+FwJci4vURlhl8b/C55gkXd0tA3rISHXIsXYy6IljyM12ApBVnAXaQCx2
         dzi8R93uqgaozS8OenusQlgIjSvNmubjWi2ZJQ5Dg6bGdE3DQ/jc8oTwfzVvdtMGZVOW
         glZJRmSq6xo9bwHw7D10WC9xfNiBxloPMTXtqCqR6PZAy9WoD2evePjVmidI4sEehmP/
         Q6HxBbIpuZIqlWF6TndH+MUn7rszyGTB+HDwBfQJamvLmZbv/BruwrwYb7FEHLQdzZOi
         Fjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394473; x=1728999273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krnSsc3rt8RuJ9N3cbTHjr7Cw2i9XvvOpZ3OnQAvabc=;
        b=cBSwlm1/Ybp3+9/LwW6ZLeZioQGnelQjZrNvanAhzkqf8eEDACJkEw+DpbV2EANmfG
         tiYY3fHReRKZd/+6gnMS93wkGJz1ejBTPHbisNHxk+PIN0rZrZnc5hOqtoDzCCIWGkC7
         MugQHZ/++TFNMNWL1HyNr3bcRhRDgHr5FszNLhufuNdCXV8vaDuSdt8uDdxmCqWr5E6S
         eQPHVHDCDPTgywcPVKcJPeTNf494HDdIQCOT1UcF8GxXeRXDL3OdgPitlmSw/QoAHZ42
         lsBUjED//F9gHKsfxgiUA0NYlwWKPoEaz2ofAyl70iopfhMfUPL6wl6Kd8AndpORUeBc
         nKhw==
X-Gm-Message-State: AOJu0Yz17Pv/SufE0/Ob1zVqMwrDWddD1rBtEq7kCN+erzAAUtjiDtr1
	34ccdUmDlpT+Fi0hiXNUhqfqrdgka5FqX4XcWZoor3EHf2WDHETD3m4hTj1Cimg=
X-Google-Smtp-Source: AGHT+IGwYo2C2BCCF1cJL7RzeZq9ZpcWtC6DEYz/joayAqR0SsCOsHuwRUZhqY/K+akLsSFhqElFKg==
X-Received: by 2002:a05:6000:1818:b0:37c:d54b:a39a with SMTP id ffacd0b85a97d-37d0e7b5615mr9571668f8f.33.1728394472615;
        Tue, 08 Oct 2024 06:34:32 -0700 (PDT)
Received: from void.void ([141.226.169.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e606sm8141261f8f.69.2024.10.08.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:34:32 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2] gitk: fix a typo
Date: Tue,  8 Oct 2024 16:34:27 +0300
Message-Id: <20241008133427.5443-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments: wont -> won't.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v2:
  - A repost, there is no range-diff.
v1:
  - https://lore.kernel.org/all/20241002223816.14858-5-algonell@gmail.com/

 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d..f85c421c5f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3687,7 +3687,7 @@ proc external_diff {} {
         set diffidto [lindex $diffids 1]
     }
 
-    # make sure that several diffs wont collide
+    # make sure that several diffs won't collide
     set diffdir [gitknewtmpdir]
     if {$diffdir eq {}} return
 
-- 
2.39.5

