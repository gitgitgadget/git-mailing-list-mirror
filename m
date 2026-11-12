Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504875;
	b=DEnislE9p8tX+H2WPFNrzmT0QXJhmH7oig7TbX0+nV2gtZ0EwCcPbkDtxfK5gJ29kclP
	 iq/x+APMSLGga7DrZzbuBMeKqdFWzAunmCbroD5no37uq5Yl05eO0MJWxoYr5CVT2QKSW
	 KuUooc38SVRE2ztHgethv5z4v1QXd77bMj25qgAHAEUvmUkyyNEOhXkg5InGOCzkwdqSt
	 hIpjffQ4h+hXK9vaxFKSul7rilwoZYwe9cCeeUOw91Vr1AXSDqPKdT+wSVXWnHTjgP+MO
	 /qZOTlS4SyIAwl2INIYMbAPrs9bx7z/GH7Phv1eJyRfGAxrl8LZvbiXsCBe8BV9QTCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xk7DBxPemW7OJa8hYbFRB4QKhCzlxNjCNzGJUNSuibI=;
	b=EzBro17BByL3Jnu8SQEcKSvufmNVxdAf3kedU4QAyNF+6npCrG70iRKg210/C8t9AKG8
	 lly+IegtAf1hgsg5uz2N0qZ4+qJF5vqXhv362hMaMGq9NyDHL95KB5OaJen69ZL51Kf/k
	 s137D0mYRgd6OXSByuASYMN4o8c6I839mMJZW51Htl7z+46YFor3EJDcBoyTz4wP0a3oT
	 85jCFeJzCrJSUy1y7VnHUGQnrlK5l4ygg+o8NXuRMjZVjZRIzZhocolIBkP1DpiHJRt34
	 UUF533E5Idiy2ppevNT6mOstORzK9arWSfVmn/lFEH2M8CZXQJ+Ch+E7Om6ojkhbZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itT2H2IV;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BCC606DF26
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BCC606DF26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itT2H2IV
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so3022889f8f.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504873; x=1795109673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xk7DBxPemW7OJa8hYbFRB4QKhCzlxNjCNzGJUNSuibI=;
        b=itT2H2IV0U/n9SAa3d2t42xB1HIPZVjv0I473RxtGEfwD+NCTurODdHBzvoiZiI5xP
         f96ksdBN6kt+dE/tR6k2G7Mbbtd2Foq89vjROeGqzO+YZdwVKajc+smeHESORVVZAZvN
         MIjEXU+zPhV6gvdphB/YxgMXlmHY7VPKf4J2Dgy3MUCcpR4sy/cNoBtcaymPN75RSdSz
         bq1Itovk0piRCliMevLDG+yhSmyycZB3LfsA1Fe8z0P0kCyk89CTbQiVBxK3bZ6l3KBq
         spc/HmDspVs4URhwVHV9azS6NEOhkfbUTkTWVh/3Rr8YUsVRA6Dqj7kc5YGEhacitH0C
         xV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504873; x=1795109673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xk7DBxPemW7OJa8hYbFRB4QKhCzlxNjCNzGJUNSuibI=;
        b=fvbQWwbwI9vD+Ulgp+1vBAOzRzsqodogXpPwGjA4fELx5g7y8UFSTbDe8ji5pUIIoS
         8jHfit5jfZO59CCbND/zskQIrJ+Y5SZNNLDV83DJtyPxGSMPUzUcwap+36olmsTwXB22
         MNQbVwokmPavQbaIdanOTPgx8UX/R0wBPcqwpUIbjlZ5utXlp3d3VY3n87Q1EP2bikQ1
         NmA0i6K1cgaMve6ezC2Kw4lL10CCsQ8+NHC14MekPDGRPePb1Dbgfr2ugLbtWJjy96YJ
         m/hJXEAcpy40KvUu3ol9UcdI/HOQ5nLA8XYZHdxBuxcnrZbgyS6RLRNlNa+s8ZIEbwnY
         k8Yw==
X-Gm-Message-State: APuU4Z9EHnInCwBopRvCkmqhhcSnZBt8QPtEz+kjD/7wGC+8iI5gV0W9
	4ACyFPYlCx0UiVpBMukEarpdc9/usNJ3wsJLYugQS1QOoAm8PPgdiRirWyCkVg==
X-Gm-Gg: AYBFou2iO3RU+etjHvYcdIyojisiVlS3qGOc7jAJtbWRYaEdZqolxNNB2mbOuwr8Siw
	uEBj8RSc5jiD9wpYdbetApMIaA3nhxgaedJMiI7l8GYB5q/lgpkjQxaJpS4nbH6qOxZtYhQisIH
	m35QL8x7jXTw/9tbT46geEuZEYtrmFtbsRTXgRiaUpl53WyDBJEKHh+Fw6HF2RDz6yF24ic7//C
	/GlNMATqD9SW+H0OW5Wi7FLks2HEqefSDN8K34LRUx5RgIS0Q8nrN2r9XUyn4xpiDhvYqI8pdgA
	phTx1bfqUd/4QpQvl+EbX5ugDvM569XGJTqybu+rDrM4/bbTBCvYieZIp93jiuhA96Rab2ENPy7
	yyvox4mdZyJGEyl8qeygfjZFObAX7BjknY4PAuRB/90bf1s3yVIzk8f33wnGM8Hgw1ZI5RBXSS7
	uYq/Y0v0dwLeyjLlRu8DIHuk6IAkmUGbDNx+A3LkkVTJnlmjtm4fVKDfhR9uiEMBs/0tggA/JFW
	l42rPgAJlSKR6x7m/D637vnZZOfpf24CadKvZY93INJ5yRBQjvVy+M2mVrvgZUoCaqyjQrwIyob
	dFs65lP0qqotepE+PTbxGF34zGUfOXGG5FMhW4G6Hj4Z+MkyZqB9SBUyyTCyF8v8uXFe
X-Received: by 2002:a05:6000:46c4:b0:491:286f:8e63 with SMTP id ffacd0b85a97d-49c731648a8mr70706f8f.14.1794504873306;
        Thu, 12 Nov 2026 09:34:33 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:18 +0100
Subject: [PATCH v2 18/20] t9300: make the get-mark and encoding tests
 self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-18-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4822; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=CHVl/mgPTfl6kiCv4S/Io90lioNTasuVS4miPHHdofU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JNwID5gTAinP8toeS83w68IsPm4E1/Xe
 2UA88qqH96TRIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiTAAoJED7VnySO
 Rox/G4YL/iIll1Qw8eieBHOUllPdmEaFMiHz/j7hBQDzQmWN/a11KGFnUfiH3425Q6Wa9WvmFCh
 zRztjxl/wWNBhNQPfBqZd8HwH7PaHFqvqsIwZRsVuHcFImOPMGphDjDy+sUhhc2CICfZ1Le9FlX
 G2A0v5VYdV0m00kTPR/Dtj4UV85+0HRTW7TfOKqnCbjkhHSrDzZfa5CuF5a5B3BGeHewL2k4Tk3
 J0EDOMEPLvZZ9BzJY/a/WS7q/Ka+8c6LDdJiURanCwiwZVkGmIH8vlX3Ya+Offl5QD8OKvzuAF8
 JjuPG7owOPXsTrIh85xSnfTTnFaAMgfOnrTtA3pWqcI/0K8NXQGOc8Ssl3Hzl/b/VubxeClIze9
 InhYIuQc0xTganoZjLui6SuuXW4YboxK5Dm1dxsd5GW+zhBAGBUI0RvoMtZhyAlqcK41TN8xFMe
 NRPKcEbrU47G6mOIYqw8LiD28m5B5nqI8RQ+lydAsxllfKPU++nYju8y9l44dz87hpLwfdW4JF6
 Hk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series W' and 'X:
handling encoding' to make them independent of state from previous
tests.

The 'W' tests read the 'W-input' file written at the top level of the
script, which is not in the new repository. Turn it into a 'w_input()'
function which prints the stream.

'X: replace ref that becomes useless is removed' changes its working
directory and doesn't change back, so the tests after it, run in that
repository. Move the 'cd' into the subshell, and cleanup when the test
completes.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 81 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 45720ed003..07bd48d2e8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4626,7 +4626,8 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
 ### series W (get-mark and empty orphan commits)
 ###
 
-cat >>W-input <<-W_INPUT_END
+w_input () {
+	cat <<-W_INPUT_END
 	commit refs/heads/W-branch
 	mark :1
 	author Full Name <user@company.tld> 1000000000 +0100
@@ -4635,28 +4636,53 @@ cat >>W-input <<-W_INPUT_END
 	Intentionally empty commit
 	LFsget-mark :1
 	W_INPUT_END
+}
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with no newlines' '
-	sed -e s/LFs// W-input | tr L "\n" | git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		w_input | sed -e s/LFs// | tr L "\n" | git fast-import
+	)
 '
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with one newline' '
-	sed -e s/LFs/L/ W-input | tr L "\n" | git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		w_input | sed -e s/LFs/L/ | tr L "\n" | git fast-import
+	)
 '
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with ugly second newline' '
-	# Technically, this should fail as it has too many linefeeds
-	# according to the grammar in fast-import.txt.  But, for whatever
-	# reason, it works.  Since using the correct number of newlines
-	# does not work with older (pre-2.22) versions of git, allow apps
-	# that used this second-newline workaround to keep working by
-	# checking it with this test...
-	sed -e s/LFs/LL/ W-input | tr L "\n" | git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Technically, this should fail as it has too many linefeeds
+		# according to the grammar in fast-import.txt.  But, for whatever
+		# reason, it works.  Since using the correct number of newlines
+		# does not work with older (pre-2.22) versions of git, allow apps
+		# that used this second-newline workaround to keep working by
+		# checking it with this test...
+		w_input | sed -e s/LFs/LL/ | tr L "\n" | git fast-import
+	)
 '
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous third newline' '
-	# ...but do NOT allow more empty lines than that (see previous test).
-	sed -e s/LFs/LLL/ W-input | tr L "\n" | test_must_fail git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# ...but do NOT allow more empty lines than that (see previous test).
+		w_input | sed -e s/LFs/LLL/ | tr L "\n" | test_must_fail git fast-import
+	)
 '
 
 ###
@@ -4664,25 +4690,32 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
 ###
 
 test_expect_success ICONV 'X: handling encoding' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/encoding
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	encoding iso-8859-7
-	data <<COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	printf "Pi: \360\nCOMMIT\n" >>input &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/encoding
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		encoding iso-8859-7
+		data <<COMMIT
+		INPUT_END
 
-	git fast-import <input &&
-	git cat-file -p encoding | grep $(printf "\360") &&
-	git log -1 --format=%B encoding | grep $(printf "\317\200")
+		printf "Pi: \360\nCOMMIT\n" >>input &&
+
+		git fast-import <input &&
+		git cat-file -p encoding | grep $(printf "\360") &&
+		git log -1 --format=%B encoding | grep $(printf "\317\200")
+	)
 '
 
 test_expect_success 'X: replace ref that becomes useless is removed' '
+	test_when_finished "rm -rf testrepo" &&
 	git init -qb main testrepo &&
-	cd testrepo &&
 	(
+		cd testrepo &&
 		test_commit test &&
 
 		test_commit msg somename content &&

-- 
2.56.GIT

