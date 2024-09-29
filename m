Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F841A80
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594242; cv=none; b=cOtnR4d3OuvvekzMzM3hdDGMFWPktPqtfrxwWNT2VXNI26U1j2zBp18fkH0iMPBFqaRdwo6/TpvevpENOGdhkOdVzSYkkhNqLVwuymktbr6UuEXNWTkaJaa8FQIHiVTSfPRQ4+OJ312NiOAz5mIowRTw/ZTBYlMd2QGXPsZ+5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594242; c=relaxed/simple;
	bh=ooiR5gK4TTbqyFkShGRd5x1jM3o3sZmcWH6YybD51dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpfD2TRd/8dVp8PJxV2UlOd9+fzDNfi2me5A0ccRza73mFT27evihyHG1yEtKwpgQ5oKdBswgKq2/LFQWg1z6PNAVM5NnX908zQfsQtTTmoceOLxoGH0Czy/mVsb+lfKNVGgd4d3arsUDIFNKA5F50b/CoqPN1yZtr+8L/XUVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF9eUnc7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF9eUnc7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-205722ba00cso31023635ad.0
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594240; x=1728199040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z19YvUHUUyJtN2aTo7tINeCHtO/uAVDcxKH49xO8ps=;
        b=DF9eUnc7GRwcdGZW0IylIy6K2kuH9WN3tJ2DJkHndPH2RngFcEShDpUq+lM9gwSmCG
         ocbP0s5GEWlQyUdEs76Px+sqI+EeyiZSBxnN0ncHIEEbU8dsDXKIdxy2LTTnpAl+Gs2x
         X5iDD1292IFj0bkjdw6qE0/OFlywuGNiRvoNAxjN0A+eo7Nguq3Zu8RbuQD/LrVeXNBc
         amLe3VoylcGTCdJMn2zFisRfU70B9tjw8r+YGYURD7lGPYxgpotKwfsmW3Tq/LOhJSXP
         EqQ6CQ2szCAzKJM2TAhYV53884+pq8P0QQ7od2bSBQeKbjAX6oz4PVFXPOfpgcNO23pM
         Mvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594240; x=1728199040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z19YvUHUUyJtN2aTo7tINeCHtO/uAVDcxKH49xO8ps=;
        b=I4VXkgIWxRJ3AVnJYpXAD/9yEHqZyLRwpyW1X5z4aXKTPaa47YOKDSTSIbyKWq+NmJ
         aDdGeTlgRkUJUqu3ua+xSQid7AGF3PDBpBtDhqMEP70eWkqwSGillLLf/8scbtMpN4XY
         mOXAgR9iwr1TlIX6+bSsneM/9ivHT1o39/JoIiZ4FeX8qWY150GamI1Olcf5ctWcahSZ
         QR8cC4KGHsMCymqVLlAfmAWWDthWAqjhEKuHccp7+cPjYHJr8jsPt96gH07sTSQrpfWU
         RF1c6F2jTIs0nbyZR8jg5dMJ50Sa0/nAtB+EdaWtl2pvrm9SzUZ/iFf07thUTSRvq7ev
         1OSw==
X-Gm-Message-State: AOJu0Yx5pRh7McseQ1jtwZnOjWDAA7r01+7WvqmR2QbeVGf5UkzJJdNb
	MCBoUdHfuBlkuz6tq/0Pvmzj4UAYxfrpM6IZpneK1NsKGI1IYTi7/OcgWA==
X-Google-Smtp-Source: AGHT+IGpuxTAIhyOA3ev7OZVbSMd9TfSzUQLLCrYEFG1rPHBhlBquROyXzqH382KkWd22/EGmXiOZg==
X-Received: by 2002:a17:902:d506:b0:20b:61c0:43ed with SMTP id d9443c01a7336-20b61c0457fmr53139375ad.30.1727594239550;
        Sun, 29 Sep 2024 00:17:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5ef7fsm35821755ad.22.2024.09.29.00.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:17:19 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:17:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 8/9] t0602: add ref content checks for worktrees
Message-ID: <Zvj-_tO_Qtp6EDBy@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

We have already added content tests, but we don't have tests when there
are worktrees in the repository. Add a new test to test all the
functionalities we have added for worktrees.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/t0602-reffiles-fsck.sh | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 936448f780..97bbcd3f13 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -420,4 +420,70 @@ test_expect_success 'textual symref escape check should work with worktrees' '
 	test_must_be_empty err
 '
 
+test_expect_success 'all textual symref checks should work with worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git branch branch-3 &&
+	git worktree add ./worktree-1 branch-2 &&
+	git worktree add ./worktree-2 branch-3 &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+
+	bad_content_1=$(git rev-parse HEAD)x &&
+	bad_content_2=xfsazqfxcadas &&
+	bad_content_3=Xfsazqfxcadas &&
+
+	printf "%s" $bad_content_1 >$worktree1_refdir_prefix/bad-branch-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/worktree/bad-branch-1: badRefContent: $bad_content_1
+	EOF
+	rm $worktree1_refdir_prefix/bad-branch-1 &&
+	test_cmp expect err &&
+
+	printf "%s" $bad_content_2 >$worktree2_refdir_prefix/bad-branch-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/worktree/bad-branch-2: badRefContent: $bad_content_2
+	EOF
+	rm $worktree2_refdir_prefix/bad-branch-2 &&
+	test_cmp expect err &&
+
+	printf "%s" $bad_content_3 >$worktree1_refdir_prefix/bad-branch-3 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/worktree/bad-branch-3: badRefContent: $bad_content_3
+	EOF
+	rm $worktree1_refdir_prefix/bad-branch-3 &&
+	test_cmp expect err &&
+
+	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/worktree/branch-no-newline: unofficialFormattedRef: misses LF at the end
+	EOF
+	rm $worktree1_refdir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse HEAD)" >$worktree2_refdir_prefix/branch-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/worktree/branch-garbage: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
+	EOF
+	rm $worktree2_refdir_prefix/branch-garbage
+'
+
 test_done
-- 
2.46.2

