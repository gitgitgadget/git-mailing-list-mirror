Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EB22D78A
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605538; cv=none; b=p8AeUGflMUk100fj+Rh85gfJmaj28MbvpIHqYB0xVyQ0RmD84AaijEN3yP3RziYbPMvWlQh9H0S/2olUqkc6jwtsZQWFgP4T1kS/ZFIFrV7SWXPakPeCcrXD7R/TjOVVcoXHZb1YkcxEsZP46csLTiDAZAqmyoWxtPbC0nB4Bfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605538; c=relaxed/simple;
	bh=laf16dHzij7YCZp2chVsDHBvhNl7TqGcO1i6FVRg77g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFxBg8sm1BpIQhCFnEtgcWaNcy9cZUnkucKCFhBNlsivuCt0vMq57KOTXxa8mzCeymz8vxChXrMkaYbxvqJBvPVjzF0O+fEkahacHlmXF8MvOc15FlO6RczN/gL1zOLsPLQXTCYE30N8T4Qi0cEOjMCmM9+lKByTFmLzapYsY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf8TRUwS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf8TRUwS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747e41d5469so6096662b3a.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605536; x=1753210336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqNbRtF5Yhb2hQAHA2bjjjALiMHHYd4Ew9MfhRG7N3Y=;
        b=Jf8TRUwSh0a5oS4Zc8SHvBQVsaQuPKwgGjriaE9YrcCQ7MRHPwmRSLsb9aVFgGmNaY
         Cdl6DNjMK6E4QbBXdNavyqHS4e9v2D3rw4Caavwt4qxsyK06HjBlA8b6e03oCp3MV/fe
         YByiRjTs+6+52u5zdiDd7NXnXogEAe9ROZKWU9p8hYlnGtDikDFr9yptT073NHcNOF1a
         F8kcR5yryeb+HX82ARqQPWN1wFWFGLvMrFZyLiBcrZRd/CfoFMX52TGZlVcNHkeEzP3T
         S1zndBB925NUCVgeaRx+UWby8MJsVtmVIWeVJ0Ayz872St2w/zdCWIai7YdsJjRwgcvs
         anug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605536; x=1753210336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqNbRtF5Yhb2hQAHA2bjjjALiMHHYd4Ew9MfhRG7N3Y=;
        b=OpH02loujIiQVRPalL4mbP65y5syU7Im/TQ6jyACkmyEcSenS0rK2MxFHrtbCTN6XY
         E7cWw4b/tlgPrHCvewqMkRBGvtLI/nynyq0T0+vkwWOrKRRBpxBr+MqJ5P2e/wv1BdJv
         oRyZaPgp+iAa78/V5grl8GmrqDIb7tcOAYZuUSzHeJfeliiKFSyprLKqp/ZDZlD53cL6
         xCMo6VjSh044gWR/bREBwlUCFjW8gK2u7R8gG48S/NbAZKDou+70y3mFQNs28Gfo2Lce
         IDlT9i7AeVNxPQLd/IJyK7hpeAqawxO7Xzqv+T/QM6Z+Bvm4fj1PablbNYVX/mRQprBX
         oB2w==
X-Forwarded-Encrypted: i=1; AJvYcCUUYgxkWcVeKwoYDONHRIovJ/agomkSQYfjP66EZx+FMMGwkFfJHQXYAlyc/dtkJ71ga2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8FXg+FSTTyoK2Ka44vehxwlYzJRW6EYODrxAQSQ1ac2bFnqW
	vj/UjxpqNQSzEjS4zDNi8BmVaMs16VQ3DejwxBfAQldnMx/wKX1Yn95r
X-Gm-Gg: ASbGncsBkO/Rp2L7xUBJu6lZmSnCFazotcvjyOLXLv2u1elHJmWXO2Py+mN2I16Vsm9
	Jhg+0hZ93V51AnIZp2/Me5JPvyRNs1LoddPGxnbr+2TEGCs4INAJzZG/FcdIOOOUEBjDHvtrC5W
	tcyiHteOyRacSREe4Dx0ezaWP8ofsV1nwk76uiBraEMZXGZ2E/ko4f0j4pZXZaL6De9taowdeJD
	VpJ8nT2hAv3FE1erONyJGOggT/nZ7k3csq0EDVUTr+8DeLac/Ex0Xn6ue69/EGs9PAMRJxvuxxF
	6OCtMxHCa0qnDOjIST0Bbr2Dg0sTMXa8RVl9VoHINok3eOmJpN/p+bzucsq3WlDAa1s7aRLcuyE
	zvwlcYK0wqVvU6PAAdMNkClumv0/ueeJqdvTaT+9Q3XNtUQ==
X-Google-Smtp-Source: AGHT+IG4F6d22weR+pRMrrW5zWzbiOcWoBZS0N2WGedvhRxm6LgMP88ql7t8Zu+r1FJvSm4w57GxyQ==
X-Received: by 2002:a05:6a20:3d19:b0:21e:f2b5:30de with SMTP id adf61e73a8af0-237d560910bmr562627637.12.1752605535810;
        Tue, 15 Jul 2025 11:52:15 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52c914sm12415806a12.7.2025.07.15.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:52:15 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH 1/2] commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
Date: Wed, 16 Jul 2025 00:21:25 +0530
Message-ID: <fbee656fb80ef673ea0ee4fafdf4baa9f18b5619.1752602474.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752602474.git.ayu.chandekar@gmail.com>
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When core.commentChar is set to "auto", Git selects a comment character
by scanning the commit message contents and avoiding any character
already present in the message.

If the message still contains old conflict comments (starting with a
comment character), Git assumes that character is in use and chooses a
different one. As a result, those existing comment lines are no longer
recognized as comments and end up being included in the final commit
message.

To avoid this, skip scanning the trailing comment block when selecting
the comment character. This allows Git to safely reuse the original
character when appropriate, keeping the commit message clean and free of
leftover conflict information.

Background:

The "auto" value for core.commentchar was introduced in the commit
84c9dc2c5a (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17) but did not exhibit this issue at that time.

The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
with conflicts, 2024-04-18) where Git started writing conflict comments
to the file at 'rebase_path_message()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/commit.c           |  6 +++++-
 t/t3418-rebase-continue.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64..63e7158e98 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -688,6 +688,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	char candidates[] = "#;@!$%^&|:";
 	char *candidate;
 	const char *p;
+	size_t cutoff;
+
+	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
+	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
 		free(comment_line_str_to_free);
@@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	candidate = strchr(candidates, *p);
 	if (candidate)
 		*candidate = ' ';
-	for (p = sb->buf; *p; p++) {
+	for (p = sb->buf; p + 1 < sb->buf + cutoff; p++) {
 		if ((p[0] == '\n' || p[0] == '\r') && p[1]) {
 			candidate = strchr(candidates, p[1]);
 			if (candidate)
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f722..b8a8dd77e7 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -328,6 +328,19 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
+	git checkout -b branch-a &&
+	test_commit A F1 &&
+	git checkout -b branch-b HEAD^ &&
+	test_commit B F1 &&
+	test_must_fail git rebase branch-a &&
+	printf "B\nA\n" >F1 &&
+	git add F1 &&
+	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
+	# Check that "#" is still the comment character.
+	test_grep "^# Changes to be committed" actual
+'
+
 test_orig_head_helper () {
 	test_when_finished 'git rebase --abort &&
 		git checkout topic &&
-- 
2.49.0

