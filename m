Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDF35C1AD
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697513; cv=none; b=IOvO/A+zm4Q26wNqbwYT36HkAEscUV+RCjeOgjkWlaT8EJwAn9ySqwerjGN+jk6j1i6QOiy0PSdFb3I6VU5lC9DqSBWMWtX0Vj9U5A4KUVBRdu/rRKftiRYI4rP9N0xRditlQj3YmwmNxjBwxJzUgx/xWVjMNhXifA0OXlufn7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697513; c=relaxed/simple;
	bh=pFwaMsafGALrINBXboPnCV+P8YvcWvFlfR+veVwktd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fi0rTHOu65uToXqhA6Noourh9WK17AKSmi1b0HlzDGmAEUXtOh3fkOGJ5udfrjCiMCipVTAP+O/I+T5Lc9Ufc1j+OB0JGNIKhMj638yJVC25cfxMXG5O8oRGw5sk3UoWpuFXczagTnMhr65nbWtGYafTvpsLsS4em1CzdIuN98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzQdVjgn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzQdVjgn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso35931715e9.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697511; x=1777302311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ4LOa6Lm97ca/GLPdqFV8bncBKQzgpGFaOmUWVtlhg=;
        b=LzQdVjgnlDK/WPX/67qfe3yA29OL2Va4sKGeSOQAmfva9j5JZMPT2BJ9RTE+Y2upxY
         N4KHZqKt1HkoEJGYcWhiwXNzhkarEJ9NXOejN6MjDDN8w/Gd9BHvSkLnB8Tm4ly9TP53
         V1uUPihIPHGbfijmpvK7nS4Vqs2gIfuakmH3vIZZhafWiigVM3yMkv9yvqEHN1JX1Kho
         VLGe7k7BPYUg7B2Ik2ADg0ZJ/6B/Fwhv2YTEtrohEE7CfMkyfT6RhAXJfUP209wCvKCV
         omFMeE9vRF91UfvLA/MtJsM47izRhU9kY5W+8DzbNPgz32dgz3Gi2StqO0qhUWI0FQE2
         TrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697511; x=1777302311;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJ4LOa6Lm97ca/GLPdqFV8bncBKQzgpGFaOmUWVtlhg=;
        b=FDp5ALi1CcGnWS4yeaka8dcXY7Ubbc2MsbZes6S5YoVYSBKFGacJtM0jsH0ltfceAo
         mooOudtN/q9Q4EpFzp6vuXHzES0L/s/M4lkOBnWTYFvAoogqNoldXfFvJf0HsVcf5Ebi
         jEwqtjzRxfR4qhAYMNW2782QcO3d14R/aeUFw5i83w2wuu7KliJDmdx7ZZ3tbER5BO5m
         2tsJW0kuggJC3COflzLl+6i04koMqHPpXBf/E0C1HBFQCFIKBBh74SmtLZ7Tkk+wRuCx
         Vf8e/W/BF7fV1OPizGS94N3zQkFIBI0/e9R2fXliMvzCavBsVLDDpUjVihsZ+qKiI1xW
         5/0w==
X-Gm-Message-State: AOJu0YwL1haucme9DRcr6Zkowlh1wQzXkuDBVp3rzTrSyR57fK0EEO6B
	5giJVprDz3Uw4+4Pu1D7nLCr8dA53Nl2FdM/z0+DMCsLvpJzlrLUy0olRF0zpg==
X-Gm-Gg: AeBDietz22wLgMtJN1Z3Y9BL4eq37x/Mo+C02yFhOxn3PPeMtxJwq9pJLCJjlsWQAF0
	IDEhMy4OCZEchvVYHtjE6vlA7HjQHdQcQqurVarc9lm1/hhV0K7Gk5rxRRrmd6gwqSFIn69Hhd5
	9IfJnMKgb5Wqq2zGuBadpcwsXQMdm8OtXAf2D0AJMV1dGFGR0wflkEsizKfze9ZSQ8ASoyD5trH
	vKqp9OGjBagtcpnXgKoBPcSKypLqWtxg/6XXHTAmRrZ0Q3+O1hnk9LqdQhv8wOXNGZoUKpxzYkO
	h/Vu+cV6nhqwbGg5ghvMN8FfR6w1YNtuVGoxULNcU/wk3BcH6hVLekltLQA9+oJzvFsd3TJFFaX
	L6AW6GakoddwbrN5dWpFMusOzem4F9jti1QO2NublKkfgxyGrTVNBvaA5wWrcIa1cvLPjkxNzEG
	3wQUtpZODDHeDa+s+C97qgP8L7g5LvHvrqEvjY
X-Received: by 2002:a05:600c:1587:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-4891f976b4dmr24243675e9.28.1776697510429;
        Mon, 20 Apr 2026 08:05:10 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm27335685e9.13.2026.04.20.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:05:09 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/2] status: improve rebase todo list parsing
Date: Mon, 20 Apr 2026 16:04:42 +0100
Message-ID: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is rebase in progress "git status" displays the last couple
of completed and the next couple of pending commands from the todo
list. When it does this is tries to abbreviate the object ids of
the commits to be picked. Unfortunately it does not abbreviate the
object ids when the line starts with "fixup -C" or "merge -C". It
also mistakenly replaces the refname in "reset main" and "update-ref
refs/heads/main" with the object id that the ref points to.

This series fixes that. The first patch factors out the sequencer
code that parses the command names in the todo list. The second patch
uses that function in "git status" to parse the command names so that
it knows whether the line may contain "-C" and whether there is an
object id that should be abbreviated.

Base-Commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fimprove-status-todo-list-parsing%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/8c9303b1f...d20dc1f65
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/improve-status-todo-list-parsing/v1


Phillip Wood (2):
  sequencer: factor out parsing of todo commands
  status: improve rebase todo list parsing

 sequencer.c            |  45 ++++++++++-----
 sequencer.h            |   1 +
 t/t7512-status-help.sh |  74 ++++++++++++++++---------
 wt-status.c            | 121 ++++++++++++++++++++++++++++++++---------
 4 files changed, 174 insertions(+), 67 deletions(-)

-- 
2.54.0.rc1.174.gd833f386ac5.dirty

