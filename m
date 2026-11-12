Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504862;
	b=ZIgIZp9YgIqcSo1J2BoTAjVq6Qaf4dSX1Kk0yjUD34KYKkr5bsctQx6DuS75qH3H3Cy7
	 2+v8cFVVrLKzYp0FUJLASvdh6ZKNWVX0msAVJ1dY8udDMIC7RnZzDwJNFi7enyHazwkyY
	 fUL64Hg/NDKUVcsoJ3qzW2bFJMUvrfhXxOSD1uv7vjoYO+7MSxij0AVVqoJQ2fwMHQZjX
	 O5XI5ft/PzXI3GTNRCtZV4o8SPzNjJfruwh17NpUgKw/uqWt+qpV9+gKKRVcuCh5Nwus9
	 8UmlqfTurjyLChoyRjoP08NhZ1Jkpbmz4j2dy8DKRPUVr9RqwwBzqqxLxp4xwb06HQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=I1p89RKY5VAQnZzQvZXQBc1tIYKzCFlAI6VhlpezSjs=;
	b=DjvdOc2qZmjvKH9XsHXYUDXUuxwdzls4HqukuVUSwrlc50g7Tv3MeNdnhEPwqtCv0Ucm
	 QIWfcSodjvDDEJFBi4jupY7kEoUp5xxeGhfBmV5KrXb2NxEqdx/WC+6lD6SpTPx6FT8ot
	 4w6WLiTsPIq9rOWT+GHBf1pMnEVfD2J55/AuULnybRuFNSTAHq8hAvVE/4uJyGQNSQW7P
	 BAuG/8O5K/b7fU0L51faGivPOoVKiwOd3rT6xUnEwdF4+MR359zRXGR9O1g5fWOBGyQSE
	 QY7zfb7WuBhSF4YtqxvNQKT+GQSsc6psteE9FZpqC7w5ro9h6ieU153RokMU4JgmTew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUcSfEsY;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E7606A232
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3E7606A232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUcSfEsY
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2462f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504860; x=1795109660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1p89RKY5VAQnZzQvZXQBc1tIYKzCFlAI6VhlpezSjs=;
        b=AUcSfEsYIUoTF+wiuZyFXfOLoaUv0illyT7xx3BYPBu8X8P/i4Y5a5gGWq+L3EmNof
         3QI9sZWOIRjXUEef29VtCl+f1+RQkI26lgOhgfS5iq2A1qktBjy22y7D0lCTSz2WExvR
         7FM4b9Epg1w5tJjEQjH6VKDke3dMb6ELZtYkHY+RevI4Kp9y/G7wn2nCLrLp35w39CUb
         RIj6v8nHQXNba8TsRMd4onLZswOjliRdfXrgjy3EI+4iF1z+5+2Gq7lPpTup35fULzj/
         9BpeoyZO+QhEWL51B0nqqKXraOGiTjGmp/LFiWm54z+VKEE86zId+0khSWR42DU0aKND
         Nz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504860; x=1795109660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1p89RKY5VAQnZzQvZXQBc1tIYKzCFlAI6VhlpezSjs=;
        b=MzoR+U3lUtoFPxjeVYL2Gki95tAL6Lj2CccLdOYPk+Fqmmb8vF76o/boNJG0DvNh5o
         dPmgyn0+60UP3zO84igg5HQ/VXA1g22Q6cmleB5OCGuxuUZ5Hvlk6vlNMCoVa8cUjz+q
         pWhJrG+/vdUTAjCHTax4vuJokNc8YTKmaSaBsBOIbhMDD3+sDwd1lEFAR0KwBnNwf7j0
         /jw6Cg/ap0DKMScSXXYPhHZIjReD61GLosjKNLkNuVReZXQclS9Y3m0iVdc8Zc5crZ4T
         AnIQVGYT+X54+sW8zoNQzB/k9O4X/qtGyPBtfcFjPccrG+uED5gzbneglC71zfq/Ffbh
         Hutw==
X-Gm-Message-State: APuU4Z8PO7Y1smNsUYXyIfpRx6L8tSXF4OnE9SXIBWH9+r9gJtfwh84C
	gpvRYPPILUN/3bq+qQrVynv25x97C0JdT2hxLWVQ0uQ3qqoZOF8dLYxi4V/+sw==
X-Gm-Gg: AYBFou2lnQLK2A29mMmWDfl/95Eq4NPTfZXLOwAgzOagnnuGvUU9mJoweEbE2myp/Zh
	/Mlx3do0f312eIEx8f0hodthJkpRFROrptb8DBYPoaeKJZoIgF/RkXwLW8PwwUcUW/Hh2tg20Xl
	Lyy6wUH6hrSU0n/FpNeMsJUFcUVVwY2Of59hUuZ7nm5vlI34c4uECuu5ibamNm24BI+amyYnFt6
	18pjz4iZNo1rfSvLvSu9TzYkj1uiD9p9MlC1Sy5+/lY0uUi5T3gXCAVTKojFb9EBH1ZnWQ+sHne
	JUYzurkBCgYL73nRa0zUpXrBcCPhDWERyOH8Z9/x9WN0rn4egtyW36uP+qK3R3P9a/ibDegkQXE
	U3yLP05th4nUv5AaXzhmiPdWLFcbaZ7Jfk4d9rYQZUfZsMyqSUOZ27jeAvu6a/jmcIJRMrTmYKv
	D2FwHcnjvtYcDRhUXdl11UfG+uoDRvwaWU3/jIbhGyHYRKe3uIsjvNY+1DNZf7t/oVvHoHFkD1g
	aMXOoZnlRE3v1pSiNi4pIyoB2OScfmvgExcJdZjkC1J64FmnK62kSINrq+I6g4GGLcFVrKbOyhR
	NEQeT27VZD0pL1cRUnpRQ89LLRxM3KRQsaRGYg288hbtNwueE/lcbi8Gt7feBWtvifF+
X-Received: by 2002:a05:6000:4582:b0:48d:deaa:4dbb with SMTP id ffacd0b85a97d-49c714a3502mr109925f8f.40.1794504859922;
        Thu, 12 Nov 2026 09:34:19 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:19 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:07 +0100
Subject: [PATCH v2 07/20] t9300: make the series P tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-7-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7387; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mj2e+VJ/aTbeqHK/Xpxr1V+90nLnNiParWmos2espOE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JEaJEBFKX0/I3MQj6xHfvt1Zim3hkt4G
 JT3GjIJTrTuJIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiRAAoJED7VnySO
 Rox/BPYL/3gR0AUHovAHWlG8yrhwF2PkdT8Yecqo8E4wF3ngcTk50mnr5tCZ8XzAuqTO0ScwnpB
 MowhAJp9B7h9wZym+ebjS3GBN91JNZV2pWf/ZUZYftmDJBqfmH+HEhsMLNX/bPjXDXpqLEBpbMv
 F+DAeW/BL/YSykAiBaq6Yr1uaxQdYLc6XYssB779jy3pXpLMlK0n8QsX/Gq9oIuLuz2cDb7xsKb
 vJrleR2HTHsxRSYiOa5tCQ4PgvFOq/A7FcOGkbBlqb1sILjR4qGtHiuZDPvP7qY5a/zbu+6mYF5
 vP2ssGWEthsQBF5g7hlxNHXBEFETIRBo+NfJDhKC6WFhKj2fUCPZHyBbIp+izFBdk2Juf9HzP33
 piSchBKXhBkfWjVRKU9wGH0hUpEJsBjXMbJwl5tkfPD+5u7Ctd15hFg1ju6wXZEGozXfSD62b6w
 zKShZPPWBKMu3OOQzs1XxDm1l//jjTf0yfeoH01C6Og6aRA3sumaAX3K/obejA3t/IRbKvj8Tc6
 VM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series P' to make
them independent of state from previous tests.

Move the setup to a 'setup_gitlinks_repo()' function, so each test can
invoke it.

The 'fail on inline gitlink' and 'fail on blob mark in gitlink' tests
create their commit on top of 'subuse2', which is only written by the
'verbatim SHA gitlinks' test. Use 'subuse1' from the setup instead, as
these tests only check that the invalid gitlink is rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 290 +++++++++++++++++++++++++++----------------------
 1 file changed, 161 insertions(+), 129 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index a85e3e0757..920fcd52b5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1891,157 +1891,189 @@ test_expect_success 'O: progress outputs as requested by input' '
 ### series P (gitlinks)
 ###
 
-test_expect_success 'P: superproject & submodule mix' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data 10
-	test file
-
-	reset refs/heads/sub
-	commit refs/heads/sub
-	mark :2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 12
-	sub_initial
-	M 100644 :1 file
-
-	blob
-	mark :3
-	data <<DATAEND
-	[submodule "sub"]
-		path = sub
-		url = "$(pwd)/sub"
-	DATAEND
-
-	commit refs/heads/subuse1
-	mark :4
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 8
-	initial
-	from refs/heads/main
-	M 100644 :3 .gitmodules
-	M 160000 :2 sub
-
-	blob
-	mark :5
-	data 20
-	test file
-	more data
-
-	commit refs/heads/sub
-	mark :6
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 11
-	sub_second
-	from :2
-	M 100644 :5 file
-
-	commit refs/heads/subuse1
-	mark :7
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 7
-	second
-	from :4
-	M 160000 :6 sub
-
-	INPUT_END
-
-	git fast-import <input &&
-	git checkout subuse1 &&
-	rm -rf sub &&
-	mkdir sub &&
+setup_gitlinks_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo base &&
 	(
-		cd sub &&
-		git init &&
-		git fetch --update-head-ok .. refs/heads/sub:refs/heads/main &&
-		git checkout main
-	) &&
-	git submodule init &&
-	git submodule update
+		cd repo &&
+
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data 10
+		test file
+
+		reset refs/heads/sub
+		commit refs/heads/sub
+		mark :2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 12
+		sub_initial
+		M 100644 :1 file
+
+		blob
+		mark :3
+		data <<DATAEND
+		[submodule "sub"]
+			path = sub
+			url = "$(pwd)/sub"
+		DATAEND
+
+		commit refs/heads/subuse1
+		mark :4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 8
+		initial
+		from refs/heads/main
+		M 100644 :3 .gitmodules
+		M 160000 :2 sub
+
+		blob
+		mark :5
+		data 20
+		test file
+		more data
+
+		commit refs/heads/sub
+		mark :6
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 11
+		sub_second
+		from :2
+		M 100644 :5 file
+
+		commit refs/heads/subuse1
+		mark :7
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 7
+		second
+		from :4
+		M 160000 :6 sub
+
+		INPUT_END
+
+		git fast-import <input
+	)
+}
+
+test_expect_success 'P: superproject & submodule mix' '
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
+
+		git checkout subuse1 &&
+		rm -rf sub &&
+		mkdir sub &&
+		(
+			cd sub &&
+			git init &&
+			git fetch --update-head-ok .. refs/heads/sub:refs/heads/main &&
+			git checkout main
+		) &&
+		git submodule init &&
+		git submodule update
+	)
 '
 
 test_expect_success 'P: verbatim SHA gitlinks' '
-	SUBLAST=$(git rev-parse --verify sub) &&
-	SUBPREV=$(git rev-parse --verify sub^) &&
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
 
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<DATAEND
-	[submodule "sub"]
-		path = sub
-		url = "$(pwd)/sub"
-	DATAEND
+		SUBLAST=$(git rev-parse --verify sub) &&
+		SUBPREV=$(git rev-parse --verify sub^) &&
 
-	commit refs/heads/subuse2
-	mark :2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 8
-	initial
-	from refs/heads/main
-	M 100644 :1 .gitmodules
-	M 160000 $SUBPREV sub
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<DATAEND
+		[submodule "sub"]
+			path = sub
+			url = "$(pwd)/sub"
+		DATAEND
 
-	commit refs/heads/subuse2
-	mark :3
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 7
-	second
-	from :2
-	M 160000 $SUBLAST sub
+		commit refs/heads/subuse2
+		mark :2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 8
+		initial
+		from refs/heads/main
+		M 100644 :1 .gitmodules
+		M 160000 $SUBPREV sub
 
-	INPUT_END
+		commit refs/heads/subuse2
+		mark :3
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 7
+		second
+		from :2
+		M 160000 $SUBLAST sub
 
-	git branch -D sub &&
-	git gc --prune=now &&
-	git fast-import <input &&
-	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+		INPUT_END
+
+		git branch -D sub &&
+		git gc --prune=now &&
+		git fast-import <input &&
+		test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+	)
 '
 
 test_expect_success 'P: fail on inline gitlink' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/subuse3
-	mark :1
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	corrupt
-	COMMIT
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
 
-	from refs/heads/subuse2
-	M 160000 inline sub
-	data <<DATA
-	$SUBPREV
-	DATA
+		SUBPREV=$(git rev-parse --verify sub^) &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/subuse3
+		mark :1
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
 
-	INPUT_END
+		from refs/heads/subuse1
+		M 160000 inline sub
+		data <<DATA
+		$SUBPREV
+		DATA
 
-	test_must_fail git fast-import <input
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<DATA
-	$SUBPREV
-	DATA
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/subuse3
-	mark :2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	corrupt
-	COMMIT
+		SUBPREV=$(git rev-parse --verify sub^) &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<DATA
+		$SUBPREV
+		DATA
 
-	from refs/heads/subuse2
-	M 160000 :1 sub
+		commit refs/heads/subuse3
+		mark :2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
 
-	INPUT_END
+		from refs/heads/subuse1
+		M 160000 :1 sub
 
-	test_must_fail git fast-import <input
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 ###

-- 
2.56.GIT

