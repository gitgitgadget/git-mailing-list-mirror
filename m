Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB3197A97
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089443; cv=none; b=m23qGKKag77k6cCnJu++L0aGA+tbf2RqvJl2P6NbJ6psolfPFjw4/lzal1Ao7iKu8AyjlnTbpeoMni0kpreNVHJ/FKs+NEySLNpS7RSnZt8FlN8iPr3ra49MK9WU4CdMroEB5F6gVYdJ5WJhl+ZOmLbGXMCxriSix+dO7YurWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089443; c=relaxed/simple;
	bh=ArmCzCYHYKQpt4WiqR/CTJupjAWi+HN99LWDUw/ZR54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7OunLyQZJ7H5fPlvpK7Dsd+TJGhLj3n4GvULmdac0fWwaGik+HNfgy0iMywecKyjjTBIQYCgJR26I0QUvAllVy5iPvh8xeVEoHZ73LYaposYrrIdSDmyMsET6O85yA0t6HqsyOdtuD4M1wkkFy0ON8/piwXTTMvt03RUFfyWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM4yqtew; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM4yqtew"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c1120a32so2658998f8f.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089439; x=1727694239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phph/+1PKx0yn/bHHMQjk+2sSUIq2/x/kNl587yVykk=;
        b=SM4yqtewPeCc6ukRYzjbFAymmpB3am89OYwaa7tDomQt5jjch5h0bIj7t2FldydKuT
         KyX9q2gTYlYa/gPMnqONIHDc+O7HCLRna/sCdZHgVp9jNIYI60aSqLimzHJKh/pPR0in
         oPvIM0NyWasBf8uePTOdhy3dtBrGwUmZjI4N14xjt1PRw7p8o1MYw2iq56A14O/stVoo
         13SUqRHoOrpnwuU0Z5yc0qoIWAaCT+99N5+zMXemvPsqvZc/fn2t1RsoyolyAVZKKrcv
         D1WRv/Nt/yNHmNn9uSgOz+QysVBt0I0qw0NM34bgW46kQnF+GdbGJkL5VNUpkUW3FdGk
         ZxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089439; x=1727694239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Phph/+1PKx0yn/bHHMQjk+2sSUIq2/x/kNl587yVykk=;
        b=i5qbkvSRexlODTcYachw9KcKYvNWFXn7wg4O+uOUTcDufS3vqq0Z3Txk2ulnncpuld
         +QkxQFh/3mPPvljbyc7Kr+EHg2PuQ5sJpK3ukiaMjrwhhFAIDiYCNkUQut+/eedWf7yS
         9TCupY4e4ySWZxJ1LFCQNs7H+nNNL7/qWMVwJTOZKwRm8VooCU4wmw6uVxX0oQULrrCp
         uixcrQRUlePhd6gitQpgbntMPouTDIs6paz0BHaWe9nzWmMIvTXlFVQL1aPZFqN+QE9l
         l/cNsLIFoJhNaSv3+gC0yD1gtbwDfGNjNFeMzQKsCSY17rzENvUiINUK7in/udj7yXDM
         ldkQ==
X-Gm-Message-State: AOJu0YzYmZ2fTpSyHRxqJhODmYNvCHa4nKTwt6IiChKPuuPvITBjv552
	OPFbsrTqgfN96VcVfkt0jlOsT0S/RXeV5twphj0KDAShGV9ulG3FQu6VJA==
X-Google-Smtp-Source: AGHT+IFNOYoQB17NflmcmsI2pK80ddhvkdrxFeQu52AUXDrx9q8dalxRWYtu1ojZ3iValZf4Dyt+8Q==
X-Received: by 2002:a05:6000:1108:b0:371:a844:d326 with SMTP id ffacd0b85a97d-37a4235a0a6mr5786742f8f.43.1727089438466;
        Mon, 23 Sep 2024 04:03:58 -0700 (PDT)
Received: from void.void ([94.230.83.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780578csm24366413f8f.109.2024.09.23.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:03:57 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 2/2] Documentation: fix typos
Date: Mon, 23 Sep 2024 14:03:43 +0300
Message-Id: <20240923110343.12388-2-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240923110343.12388-1-algonell@gmail.com>
References: <20240923110343.12388-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/BreakingChanges.txt        | 2 +-
 Documentation/DecisionMaking.txt         | 2 +-
 Documentation/gitformat-commit-graph.txt | 2 +-
 Documentation/gitweb.txt                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 2b64665694..112770a9da 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -117,7 +117,7 @@ Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
 
 * The git-pack-redundant(1) command can be used to remove redundant pack files.
   The subcommand is unusably slow and the reason why nobody reports it as a
-  performance bug is suspected to be the absense of users. We have nominated
+  performance bug is suspected to be the absence of users. We have nominated
   the command for removal and have started to emit a user-visible warning in
   c3b58472be (pack-redundant: gauge the usage before proposing its removal,
   2020-08-25) whenever the command is executed.
diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
index dbb4c1f569..b43c472ae5 100644
--- a/Documentation/DecisionMaking.txt
+++ b/Documentation/DecisionMaking.txt
@@ -54,7 +54,7 @@ implementation, for very large changes).
 
 For non-technical decisions such as community norms or processes, it is up to
 the community as a whole to implement and sustain agreed-upon changes.
-The project leadership committe (PLC) may help the implementation of
+The project leadership committee (PLC) may help the implementation of
 policy decisions.
 
 
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 3e906e8030..14d1631234 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -122,7 +122,7 @@ All multi-byte numbers are in network byte order.
       for commits with corrected commit date offsets that cannot be
       stored within 31 bits.
     * Generation Data Overflow chunk is present only when Generation Data
-      chunk is present and atleast one corrected commit date offset cannot
+      chunk is present and at least one corrected commit date offset cannot
       be stored within 31 bits.
 
 ==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 56d24a30a3..5e2b491ec2 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -234,7 +234,7 @@ from the template during repository creation, usually installed in
 configuration variable, but the file takes precedence.
 
 category (or `gitweb.category`)::
-	Singe line category of a project, used to group projects if
+	Single line category of a project, used to group projects if
 	`$projects_list_group_categories` is enabled.  By default (file and
 	configuration variable absent), uncategorized projects are put in the
 	`$project_list_default_category` category.  You can use the
-- 
2.39.5

