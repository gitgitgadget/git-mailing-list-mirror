Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8C79D1
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712466642; cv=none; b=aRx4eHF1o827n+g4wJMYieUBdwcojiEHGRJftnDjqOAIVJz65Tj8XtsGMjXhOcV0NpzYOhtVnnC6Jl843NVKCQtJD8AFfBjYM4lUz35WqmJV1PjrY1MFUf7IxfeK2gKbCtkbQ6EYjD0Sh7gxur2G9/BaRyztaJUdguP+8rqqb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712466642; c=relaxed/simple;
	bh=sxzbCA3ffx045V/qPftjGpLMG/Eb7h/ekiWsx/9XWU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NyeGsfVQjt475jIMAVpo/LPzuHGKmxnnsZjP++W5kUAdAURHr4ZAu5W1891h7+Em8syS3Epk78Rg8XDu/0zzjsekvpQn6cONbZ2Sa9A/LGdfHJfZc2e7NWdC9uYpYyopMMElY2Z6SWEjpJlKtOrKWa5LqXT5NBCasbHxuQZNyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBZ//Ey5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBZ//Ey5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so3048088b3a.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712466640; x=1713071440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy7icUnudEtQgVGSoOvmp1gt5wc+oQm5oAZXV3JHpds=;
        b=ZBZ//Ey5f91sU4WXGQAofY141b+Ic5ahq/wo5r+9JUUe34xEMD4G3oGKMbNVvtofIn
         rjjcfJcyCkCLwFY6RnoYR6HOve5T1QrYsCEAZhPhNktpLV+LbIa259FTA5JmP56+XZ5U
         4Mbu9W4H2Y5gP/2ODqWk29yFlMCwKrNYTN6hY638ntv3cPBVSypAT3tVSCNa3y1DL8BV
         ctFIB37eksz1XNz0eZTdXjj2YfTs9rGfYwVzOlhBT0LEl/oyNSb9FXo4FLHCGxvqIa3D
         l7b/eSt15QCiGOkFWCCknArH7I45fXlW60nQUewF0rR6KzL9DYQtvbhcA5djcK6qWc0C
         wl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712466640; x=1713071440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy7icUnudEtQgVGSoOvmp1gt5wc+oQm5oAZXV3JHpds=;
        b=Ylg74F+28L7C5XpH9SKkj1x3qE7bXyo2bPGG4pnMC39bOFUc7YIJPeoss2ihruGTh6
         zoKHuL1os5uidCDpwtUEvTWJMMN4QBITOB1xTp09RlyebUhJMKK7DaTIeVPCsA+TulX6
         3fhDaGEK5RCvBNiY9/woWDCR0UW2/tHXO4PbjwWE1gh2+pFmahkx/ivQLwuhUG6qY/Nm
         ZEnNOCs3rIS1KckPzjLBhSZfY0dDa/Je2CSbXpYvRJaCmzisB8TSgVcEJNzTf2i7tOC/
         mymuAO3WuPGdPNd4OwTGGSz/Yqt+arb6OD7h82vcz87NIVU5cP3Vwft4YclNPtZI9EPI
         3STg==
X-Gm-Message-State: AOJu0YzuvJ1F77CZyJmonYglT+8IUTKOA7cWi6tzz638k3pENSyhU1lR
	uSEibONYbpLQqrPzGkejZsjTb+DWxh7r2FdcEdukkLk6AVk+U+UXkRF8XeDJqwU=
X-Google-Smtp-Source: AGHT+IHqXnbG2cUcEKJ5oC27tgkh1Y+wrlAQ7qzCbbAKP9HRpiW0rOK/ZjDyhvfKzqQVUHLPqynIKg==
X-Received: by 2002:a05:6a20:6a13:b0:1a3:69a9:e3e4 with SMTP id p19-20020a056a206a1300b001a369a9e3e4mr5178430pzk.50.1712466639899;
        Sat, 06 Apr 2024 22:10:39 -0700 (PDT)
Received: from QuangPC.localdomain ([104.28.254.75])
        by smtp.gmail.com with ESMTPSA id kj8-20020a17090306c800b001dd69aca213sm4223103plb.270.2024.04.06.22.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 22:10:39 -0700 (PDT)
From: =?UTF-8?q?L=C3=AA=20Duy=20Quang?= <leduyquang753@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=AA=20Duy=20Quang?= <leduyquang753@gmail.com>
Subject: [RFC PATCH 0/1] Add lines to `git log --graph` to separate connected regions
Date: Sun,  7 Apr 2024 12:10:30 +0700
Message-ID: <20240407051031.6018-1-leduyquang753@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`git log --graph`, when invoked with multiple starting revisions and some
exclusions which cut the commit graph, may give a disconnected graph. In other
words, the resulting graph has more than one separate connected regions. The
command currently prints the connected regions on top of each other without any
separation.

This leads to a problem. Say there are two connected regions, each having two
commits, the graph would look like this:

* a2
* a1
* b2
* b1

which may lead to a misunderstanding that these four commits belong to the same
timeline, i.e. b2 is a parent of a1.

This patchset adds a separator line between each pair of connected regions to
clarify that they are not actually connected:

* a2
* a1
---
* b2
* b1

Lê Duy Quang (1):
  Add separator lines into `git log --graph`.

 graph.c                                |  55 +++++++++++-
 t/t4218-log-graph-connected-regions.sh | 119 +++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100755 t/t4218-log-graph-connected-regions.sh


base-commit: 19981daefd7c147444462739375462b49412ce33
-- 
2.44.0

