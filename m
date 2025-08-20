Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7C182D2
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703913; cv=none; b=gV6fL8SDWK2eBIlbn/0Cgv8+TQ02SERA3T6EV3zJK7umalVZSwUXQvIIgRt2dzNs8e0RN9ld6F1mkwVBHOZprya1bBglVXVv9D2qwFhkMEVkrYIKhaJc6E1EY2XZ4YXTCOg1lFiK4FzHlz9eUfq5oBhj6Yul+Hg1dBY+mH0SHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703913; c=relaxed/simple;
	bh=VugqTynD0gqWQIzRUVe9nEHYMUJygeCAIBedVnF7lJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYOoZYsa05GT9JuogztdXnmOtmlkqbKCMKMYjc7AC5XeNcWAAi4/Y3jhOTiPYGub6XUlj4Ojmn0aMyQaltqNswKIJRjMxWdWl/Yxl+a9f5FZapaO123WVt2zdg2OOszg3AcFzyWYoq9erEw6iSZ/m4/rK0e+swVWN9YzlilA0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQP9M6ku; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQP9M6ku"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8704b7a3dso725241385a.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755703910; x=1756308710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9Sdyapb9MQMlBDKGYE0yEzDh6uRsCPCm1l1zQIiQ5Q=;
        b=nQP9M6ku7E3KyKlhpGqWvB5wUFveRjz8XCfiQP5qFHkduBRIB4X8AZ+A9jqvUH1OqM
         ForaDJqxVMWrKzHG37kOmb+mDDOqFXRrOY+etPR7XtMBLxbqXVyTGHrhPp2OfG9xOQZL
         LF5GW4RxBgWTEBSbV12Nv5B3CjNLhsxbSKEwR+E/bntJWBVUZG05p3L3wE1ynbDcRV/9
         NiyQ9MyMd04Yz7dD7cke4oWCOhL/jL/Q0YxSgEuFcIicY7G/9TE3ywX4ox1rMqQYOghQ
         W7GxGsNlYswA7kbIw0oXTqWwaAA1CvxE2OJmR4s3qtFi4PiReiKgO6ATEz+cCNHhxk/r
         7xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703910; x=1756308710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9Sdyapb9MQMlBDKGYE0yEzDh6uRsCPCm1l1zQIiQ5Q=;
        b=XOkfuebyANbHU/scQWH6ylCtIJ55XwBo7NS8ABflRGYC8OdzRTR8qwsMMGk1ne2YiR
         xheEPc0J76hl3GVEMJXL7/5pLQiXaCqodrzdpJbB21eOQcUVY57xbjipS+1pPG7f73hI
         q3EsBdVFZC+eLuybMJ/S7M4wLIIHU5vAEjddkuc2lN2LoHerS6NpHMLT4navH4tNt4qO
         B5AePu9x6n9UeERJELHQq5sCvBmWwZnLYri3EPMB/LE3VDqKC1lBPHrQugloqIPLCYXq
         soW0Ucq1YimdGM6yLiYkCtbNDrRHW2JLfQGPAuzSIPP5v/dq+DF2VjuxByQde0hVqwev
         CNrw==
X-Gm-Message-State: AOJu0YwoP+LcugL60AuozD2QdTkXj0JsKX+cLO6e08E/o9g5tladaj3Q
	dI+OavmP+CNuEKbgF5jEortOA09gJXfqsXzWwl5cN2uBasOEYa6c1ayrrz1LSGC7I5g=
X-Gm-Gg: ASbGnctGnnleAIrtTKgGEqTH/AWFXGVxaCOD8IDpm4xtD82RAqE2MuiC/fVJPJAARPi
	L9OJ7QHzuCFO7RFHU160nleVZ34UHSbDMdVjod9vGjy210maLB7NLKIy5ZUYtAj5WdYKZpJeDUy
	Mg/qIUfiZZH6J8V5YZ121Y2g6QeVTlTIm/qdQPYPsiRdZeyF3FcAsyku9VMopfXBtsZgARI2FXJ
	KsQh19y+SNJlvlkjsDMTJvvy97OzrwGBDBmG6iij9UxHW77mSx13Ny8urm19C38OtK9B9ffLsSB
	WyBkwstW96SExgVbV/17cPET7J0sqRzml1r1UkE48rBWJ/VfvU8RTWxCqcHwg9hKLmBRetePd2F
	V15UWDAl+8hhp4ddlVsOUY63Z7ODmWpF6ttwlXGb3UJCNADGQ1DW61KS7s+i6wpLyeDT4
X-Google-Smtp-Source: AGHT+IHhxW3VQNDQoeKDSwQbkY8BYJMTJCG78w4nqTfeBZYVScwU8BiLlDSS+HQKO+zdrks5yVPiLA==
X-Received: by 2002:a05:620a:370d:b0:7e8:4337:8ffe with SMTP id af79cd13be357-7e9fcb0bc33mr387408585a.47.1755703910401;
        Wed, 20 Aug 2025 08:31:50 -0700 (PDT)
Received: from markl5i.lan (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0216a9sm967939385a.4.2025.08.20.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:31:50 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-gui: simplify PATH de-duplication
Date: Wed, 20 Aug 2025 11:31:43 -0400
Message-ID: <20250820153143.21181-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.51.0.99.15
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui since 8fe7861c51 ("git-gui: assure PATH has only absolute
elements.", 2025-04-11) uses a list to maintain order and a dict to
detect duplicated elements without quadratic complexity.  But, Tcl's
dict explicitly maintains keys in the order first added, thus the list
is not needed.  Simplify the code.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b64d065..4528b22 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -103,21 +103,16 @@ if {[is_Windows]} {
 	set _path_sep {:}
 }
 
-set _search_path {}
 set _path_seen [dict create]
 foreach p [split $env(PATH) $_path_sep] {
 	# Keep only absolute paths, getting rid of ., empty, etc.
 	if {[file pathtype $p] ne {absolute}} {
 		continue
 	}
-	# Keep only the first occurence of any duplicates.
 	set norm_p [file normalize $p]
-	if {[dict exists $_path_seen $norm_p]} {
-		continue
-	}
 	dict set _path_seen $norm_p 1
-	lappend _search_path $norm_p
 }
+set _search_path [dict keys $_path_seen]
 unset _path_seen
 
 set env(PATH) [join $_search_path $_path_sep]
-- 
2.51.0.99.15

