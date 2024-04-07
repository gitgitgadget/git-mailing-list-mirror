Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239031E893
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712524879; cv=none; b=fZP2WUQ5EGr7GtRrAA7GjuVls7Uqajy4QYpJnZwfruXAZXX0DkycpDM9enAZdW1Z5SzzzbULP7JGA4ssCu2wlWKcvVyyyCqZ0fARHp0JB3k8WPRRmwbTE8AN1tMPGIZPVA/FLoiiFkFRz+GvYjCIcJU/R+j9BwESnd6YIxxxv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712524879; c=relaxed/simple;
	bh=ShY1SAyX7LvCkIrcC5/O50DU95tiSOJAiD7ipHdn/II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNdZNmP84UB3obgys28XzrB7h4Oeukka4HT3gwdiXG2wUS9tWLDbxc5btqYuIBAFjuKDg6IwcsiSihadYnuLNtD/b+uZu62Qx3R8xzOyt+PTEoQw8FEooDZ+G4OeY24K2n+mjKolKD6hxYKTUoQxxyU/87Us1t+0HqfrcEgAjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=FisherFam.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz92Yv7o; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=FisherFam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz92Yv7o"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6151e2d037dso43099787b3.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712524877; x=1713129677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QilkQV5ceRmWVHVN7NBLucqm/3UZ9o4swfD//qadvtM=;
        b=Yz92Yv7oOwS8mNslzDvF0640GpE9dr/xaNGbLPO5/mfTzrru1ODvJ9+/EaPR1Yho0K
         sAgdYFGzJoDUKRRTmyhT3/NF2cW6u4dswP0ZBljfd5lP8CISvmj3Jo7yx6c61nyhkNH1
         lgMAHmIR30lxVfPoU0kVZhOr0ra4fD4E44xtttnyTz3WS0Pz+nsjdv9nw6lgbPYQ4ZCo
         5Pwgv52j8wuAdX4kFU79NCv16+OOlB4Jr21jFpxKFeSv1NJgwvkUFnoDsv2Q71BNnrYm
         xdZ6cC7q8O58HhdsAIg3BzLho+M0u62PGV9T5zSvZDnPgcUE4ubtZ/PQkW4YUYvcRfHA
         Ro2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712524877; x=1713129677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QilkQV5ceRmWVHVN7NBLucqm/3UZ9o4swfD//qadvtM=;
        b=AcS6Ewtk8oZ4/5NsrOSobo2KOuCVy6ymgU9jLidhnv2aIs3tidESoVPAQmXIaAqCQM
         uoqeTpMViaKukqNZWHeuLzRgm5V0Z1JrY6HgPBqW2xViAgNZ3whe9yUSQhr7KoaaMVSs
         TO2egtJ6bgtBSNHgYvPcQSUv7ZI7o0Pkb2hilHZnXDJ9jlqjjJR6eK+c2T/lGB+JIg5f
         rHMv8zXlqdvrXUonnisx0DMyr495ww7VOTDrpkSHgzkVSOJvnOVFdfVORY2QHsaqew7a
         W18k2KO8F52BWeJGssMQT0cHZrxh/eIp6C7UzSVKgjQDEUKqXH+JkqUoD3ZvbFEfUO91
         DMtA==
X-Gm-Message-State: AOJu0Yyzm7pqP8wJNWIF/tG5JHx687NsC8gEMz3jxuzpV2EImL2QwMgH
	YOPs3r5hEaFbzjYNpRpnu1QWgFbX+w1kK2oPRM/MHJBAYPlzhXAEEqY1ggDS
X-Google-Smtp-Source: AGHT+IFnqPub8GCo9ggyLg4DphlnYhvCpuQY7IHc9irUAEdHWvJA7NwD7eQnryyOSFqq0AyZk0qWJA==
X-Received: by 2002:a81:6c4a:0:b0:615:1511:7f7d with SMTP id h71-20020a816c4a000000b0061515117f7dmr6686800ywc.41.1712524876890;
        Sun, 07 Apr 2024 14:21:16 -0700 (PDT)
Received: from localhost.localdomain (35.91.249.216.dyn.smithville.net. [216.249.91.35])
        by smtp.gmail.com with ESMTPSA id hj9-20020a05690c618900b00608876ed731sm1392374ywb.126.2024.04.07.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:21:16 -0700 (PDT)
Sender: Benji Fisher <benji17fisher@gmail.com>
From: Benji Fisher <benji@FisherFam.org>
To: git@vger.kernel.org,
	nasamuffin@google.com
Cc: Benji Fisher <benji@FisherFam.org>
Subject: [PATCH] MyFirstContribution: use switch for changing branches
Date: Sun,  7 Apr 2024 17:21:09 -0400
Message-ID: <20240407212109.35131-1-benji@FisherFam.org>
X-Mailer: git-send-email 2.44.0.1.g59d73693c2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "git switch" instead of "git checkout" for changing branches.

Signed-off-by: Benji Fisher <benji@FisherFam.org>
---
 Documentation/MyFirstContribution.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e981..66f38a7055 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -122,7 +122,7 @@ branch of the upstream project. Create the `psuh` branch you will use for
 development like so:
 
 ----
-$ git checkout -b psuh origin/master
+$ git switch -c psuh origin/master
 ----
 
 We'll make a number of commits here in order to demonstrate how to send a topic
@@ -878,7 +878,7 @@ on `master`, so go ahead and update as shown below, or using your preferred
 workflow.
 
 ----
-$ git checkout master
+$ git switch master
 $ git pull -r
 $ git rebase master psuh
 ----
@@ -1139,7 +1139,7 @@ We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
 mark the tip of our v1 branch for easy reference:
 
 ----
-$ git checkout psuh
+$ git switch psuh
 $ git branch psuh-v1
 ----
 
-- 
2.40.1

