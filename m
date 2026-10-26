Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029569;
	b=0BFKZpZhWRIZ6Kb5us1JOWYyjDthehczbRRFHg1h0B4S8R4s15kY7bTZlgCELNm8z1jv
	 j9RA3Oten1iLZpAcaP66dAMtx/eNAcjsag8UofsEHLLjikapiVreRdxoKTORKhjL78bwl
	 pFaxw7aw8UgIEPU7RPm5Aal7GltvISwlFmffpUszmIwwyYTPpiWKEiwT63UnZUNGtPkfK
	 Y2IX8Y0xbJbkEfR6eb/Q0s1qXN8y/LrKiqMOWdNhDhpTKb5e3WR7mnLidB+CtVM1TPBs5
	 LKNbVnL+Mi9Rir9J9F9uI4foNGfC+w0k1PyPQkI3UYLSKhiYChh6XP5/gXfm7tV5RAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Io6olrFpWm3VR9CKRHylxTxnyxAZwzgWOusEfeW8LAE=;
	b=pmY0xwDkC+eSsHO7ZMc5MrhIjONgIs9SQjTba6tUoifu9U4iyXP2jt3J3dP6l/7NCepA
	 +AMIu1hqMcvSfLh6UjqZOacbKdmx4E8N9UVJh6n5eWuNQkKRmgKo46ZZF146apnkmcKy5
	 Diy2bQbAvsGbbIIPU4S7l8qAntTKtgSh/Jmg2VsMWpSbyV5TItpt7n64HhwnVyZp2zuDo
	 LeHkGXwJ1MAyQ1eedSxjPVymq7kS8I4rEo+yoxYCMcn8UFLIooQWH02ppC/AitsJx8erw
	 CdpF3U+GmNOfmq1o8558UsBz97N9pqZ5f1pKjaD93F4NskXH/CQMRrRVLkwNLBsCZ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ehgmGgCR;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE870606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE870606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ehgmGgCR
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2418146b3a.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029568; x=1793634368; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Io6olrFpWm3VR9CKRHylxTxnyxAZwzgWOusEfeW8LAE=;
        b=ehgmGgCRgf4IRsEHULAK3sBvp7aeo7J3ieIa5QTOjqinzqfnwHaCTxsqSMPMzN1RHm
         RWuUEEgqqoxmsRj7pX77HaVH7qDckjHkHybyGPeroFV6yQxZ76CazKaHZa+Db6BmmwUk
         XmK0WPv0VjgO+smuer9zSwa/T6SancFdM04QszruUL8wCnALUHHY79ktnyNWJjkqMGzJ
         khWUHjo41Gs0mrbxsGngZc0zDg4cLveeyo8V93jnn4Cz69OJI8znju5/Cvx5rNCFOeQF
         10WD0b4TYN6aCS5QT6/STjUM/XuDP/nOCPZ5qrJNwofvZZE7rzZDncy0Rq6nRrs9UDbq
         H9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029568; x=1793634368;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Io6olrFpWm3VR9CKRHylxTxnyxAZwzgWOusEfeW8LAE=;
        b=h3eOdMwcRYTacMt0PsjRWRQneoU6U57qd3LdQcEI2OOSNQDeshVFqBj7okZ0TR34lS
         2G2IMOl7AayVkLkqOarLn/MudHD7MWp/mGdHwVOjCdIj6mBCC+zmAN57udX8PkFFGsZO
         GNw3E6pgjyWveILZfq9uZtH6gyFB7XqoeHf7Zz2j8bJsZSdnLCHSVmwzqz1lPU2YBJmx
         8sJxrnAOlepIN5fGjnoFkvY4FKmQLKd5SL0BKPDtJLkDRzqPZ3QXqN9YnVVNOlFw8fJI
         5alnvqr8Bh2coM+Li6+dux9quvD0absG6ZKTGWg5jboy0SCwmgeIE9EyX0U/iPq21xgy
         35Sg==
X-Gm-Message-State: AFq9FYLEXZHiSmPMkyfZmjjUTwKxFYRD3Byt0usNwI8hIHKNygVGmXxD
	h6VvCnGHG8O3iwfk/t6GgOxSWciPJ28VgvT1OQ7PlfbLM+aiE7+BxsyHxJQm2CGh
X-Gm-Gg: AYBFou37NBwS+PZZIT2vapxJePRR0QUYUNl3bKl75HidR/p1eyxvdcHz4dZ5JSK/L0M
	UmFOVjkXSGC6HjYfh2aiS6L6HceB6wh7ItoaedXfgtRDQwrMcOhgFS79LRWNSjZ5NC/7aszmR/i
	M7WpF7YsUkXa7RiylSXNtZcjsr9YYV8rl7YUrgZuqYp29N/TFzPwNX3VF5jjAGGsbZUs3w+I04b
	hA/y8eoo5e7jPEFwqQL8hXwFxAeWanFlrpdo7pBeADA17qyEv7YTjjLKM8NiMnhPepmDIsRupSb
	ymXDPiePZmFsQ6PW1lD3cxdjLNfBzPE7T/sPRetmlDQIl+b6D4b5BElk/WTCIDiSs41Hx+fY2xf
	47NGy4RubudGt/EfjW1STLNXXvlpI5HY7aLGJ5x+cKbZteLAhgnyLJTXPpcTtvoyTvYAlXYyoB9
	nBYRxdjMEtSZrnmCx1BCVL7vIAbAGhZtiCxqWBbMvsaI83GZ1juqM34Ah/OCaE4+c7i1OriQA5V
	zkj2ZdZ1B7RynKRsgiQDkW30yzas+Jj8Y69kD4+V3SSwy1eIMyRANEMy5EM8r9I3tS4UXFZFB4m
	QJVDN9JVLdLEX8kXuA1DkYun9IKqqyY=
X-Received: by 2002:a05:6a21:3981:b0:3e3:1013:4651 with SMTP id adf61e73a8af0-3e7bfc13c06mr5084204637.61.1793029568159;
        Mon, 26 Oct 2026 08:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.34.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a5863826c4sm1137316b3a.41.2026.10.26.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:46:07 -0700 (PDT)
Message-Id: <84157f543eebc2ed347dd2165ed6046305e9226b.1793029565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
References: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
From: "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 15:46:03 +0000
Subject: [PATCH 1/3] t5516: record redundant blobs after rebasing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
    Marc Strapetz <marc.strapetz@syntevo.com>

From: Marc Strapetz <marc.strapetz@syntevo.com>

A forced push of a rebased branch can resend an unchanged blob even
though the receiver has it through the advertised old tip.

Add object-count tests for --force, --force-with-lease and forced
refspecs. Confirm that the blob is unchanged by the rebase and record
the current three-object pack: the rebased commit, its tree and the
unchanged blob. Disable push bitmaps to exercise normal enumeration.

Also cover local replacement refs, which must not cause objects
missing from the receiver to be omitted.

Assisted-by: GPT-6 Astra, GPT-6.1 Sol
Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/t5516-fetch-push.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b982b209bf..a46ba91ba0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -193,6 +193,49 @@ grep_wrote () {
 	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
 }
 
+for push_args in \
+	"--force origin topic" \
+	"--force-with-lease origin topic" \
+	"origin +topic"
+do
+	test_expect_success "push of rebased branch with $push_args" '
+		mk_test testrepo heads/main &&
+		test_when_finished "rm -rf rebased rebased-push-event" &&
+		git clone testrepo rebased &&
+		(
+			cd rebased &&
+			git checkout -b topic &&
+			test_commit feature &&
+			git push origin topic &&
+			git checkout main &&
+			test_commit upstream path1 &&
+			git push origin main &&
+			git checkout topic &&
+			git rebase main &&
+			test_cmp_rev feature:feature.t HEAD:feature.t &&
+			GIT_TRACE2_EVENT="$D/rebased-push-event" \
+			git -c push.useBitmaps=false push $push_args
+		) &&
+		grep_wrote 3 rebased-push-event # 1 commit, 1 tree, 1 blob
+	'
+done
+
+test_expect_success 'forced update ignores replacement for old tip' '
+	mk_test testrepo heads/main &&
+	test_when_finished "rm -rf replaced" &&
+	git clone testrepo replaced &&
+	(
+		cd replaced &&
+		test_commit old &&
+		git push origin main &&
+		old_tip=$(git rev-parse HEAD) &&
+		git reset --hard HEAD^ &&
+		test_commit new &&
+		git replace "$old_tip" HEAD &&
+		git push --force origin main
+	)
+'
+
 test_expect_success 'push without negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
-- 
gitgitgadget

