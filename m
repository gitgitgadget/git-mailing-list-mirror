Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8425601
	for <git@vger.kernel.org>; Sat, 25 May 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716639931; cv=none; b=du8zSYJDtoGnmAcySz8y4itoOQpO5eFExo+7Xp6kXu2YmMf4TIDu9NYK0AaPK5wWGZrtl6jeU/RgBDPGeDSc6UzNEZhOsdxby2HAhh7heZhHGwGAZNlZrRUj+e2TSXETRinQ4OsbBk9U0ju5b2VwU4IJ/CQCpQZBxu6VQuAaojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716639931; c=relaxed/simple;
	bh=i+yKBTGW8RrJ+lmQWwFO9rbZAmWxOp1F3TWm5Gq8MDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I40X/DFfvFgLsOlWBKntjWFldP9b+3Zya+0CpACZKLuxdKabMnd8aDVLA+Rs9msJWrofciGTeixVpZ50M2OtfoEVWEVpyBlP4engzbQeLyBApr2B7vJ3zstpKxw1zwszLpg5Zpyfo7QHBvVbsx4d3TFk19i90cziIvBXWqzWN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=cIcLJeY4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="cIcLJeY4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso1284248a12.3
        for <git@vger.kernel.org>; Sat, 25 May 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1716639926; x=1717244726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osBT+iEVthEi1Jt/FNZjePR9W4Yrrc9Nf/x6byktEiw=;
        b=cIcLJeY4P/cLjmzh+/oa37m38PNrg763RKGr9yB3m6SgDMwfglaFffnWJffHR3V9x8
         VenO/vkuxmiq9llD3c72+xPMRLXlyMkA8ii8W6uQ/phMoIi6kCquFoGszrcOaRi99tvt
         UPlt6lmAqB7NMTh2ObSKkXJdUcnktypneAtLSel/Cyz6AhFo/mElWaKo2H40B5rwS7MV
         ce/LecwEn5UrJNEBA7d44j9zbBsr3DT/G0wqkvbew1dL3dGp6mERdrNBvrkVLD/FgRlj
         LXN7sD6t7+Sh2tLFG04qKdDis4NNY70+IvqZfJ1w81T9EQvDek7V7i21c7TSEpOB96tb
         YA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716639926; x=1717244726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osBT+iEVthEi1Jt/FNZjePR9W4Yrrc9Nf/x6byktEiw=;
        b=jFw4030h+UZwITFxbN5a3FQk7lqpzfGSnDzgKp3ht60CQXb+2D+2uEg/FNQOIo6Zu6
         3deAxWppmhQ+o8gK2vG0wf5JWreP8bZwbHZvh/c6fiMkMh/WjGXmXCGlOK+i5b7fHMd7
         1GBhJhQyX4UmsWqJNZeJOGHE5sk51vdJXU1ff5ZrzWdwwKfcYXiJZYQMvjgilBFqe0fW
         Hk4mkdLm3ft0VBseBtF3A25qu9xEgx04Dq+jZbeYL+QZwq1u5ZXJbttopBZv9UIGqoNQ
         sPFjwrpGzmQb5zzz3i0OPnzQql1g2c4OBXP2iqeMeUtR6uIBdUN6TFk0OcsQlRmgbwc8
         2Dfg==
X-Gm-Message-State: AOJu0YxhYgsxmQgV5XNQLoZOmDhFWmpamXvfd3HtPQp2AhOn9qnQnLMf
	PvUyudIYzeZpr/pp9tZiSTHMwbJtV/aePiEFtypfAt+YOqMfUdqwutpg9/o4hShuZuBas/zev7z
	7xXg=
X-Google-Smtp-Source: AGHT+IHl/ODa2ZKWq3Ue1nw1f7kFxFWuK164KXtciHMhoapZ3sosqCnHaRzHOPZVUPI0fnGUJPnLTw==
X-Received: by 2002:a50:9f4b:0:b0:578:6378:bc4 with SMTP id 4fb4d7f45d1cf-57863780cb5mr1713053a12.10.1716639926360;
        Sat, 25 May 2024 05:25:26 -0700 (PDT)
Received: from localhost.localdomain ([147.161.172.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852339fc4sm3054485a12.15.2024.05.25.05.25.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 May 2024 05:25:25 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 2 0/1] Allowing localized substitution hints in parse-options
Date: Sat, 25 May 2024 14:24:37 +0200
Message-ID: <20240525122514.2608-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <xmqq5xwa1pfl.fsf@gitster.g>
References: <xmqq5xwa1pfl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I hope this time patch submit is better.
Requests for changes from previous review should be handled.

parse-options.c contains functions and macros to print messages with
terms optionally enclosed in chars promting substitution to users such as:

  blah-blah-blah <TERM>

Since languages using different alphabets or writing systems can translate
the term in an obvious manner to prompt the user to substitute them, I expose
these character to the translators so the messages can use the same style as
elsewhere in git.

Comments to the translators are shorter than before but hopefully they are
not cryptic.

Alexander Shopov (1):
  parse-options: allow localized substitution hints in macros

 parse-options.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--
2.45.1
