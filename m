Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296230;
	b=ElxPhT6bU3/Qm8K+gJNZ6cwOeeU4dkh0KGCl7Ehl5GKBA+N7pvMIr4TWsG+aN3nDYzS8
	 bmswhd50b/bZJSCv76aUlUTjdHnzIE2gxUCIll1W1v+DC4X6gZehVSY0hfXTBawkZpIK2
	 zfKKSD3OgBiuavpnjeyrdqLvQjcYwyvNTJ2PNLF+/rcGUFiYZOFsvTTisjkpFbCt1gE8g
	 Qh/69Bd2uIsMvB5GvMleswd8YeRd3ZjE6hDH9Rr9geHSfa8WdN6H+FImjEvctCDGfo9oJ
	 3zCXgPIiayTUcvQy+mC3tSN/8bFxkEKzCdXdOBsNgj+D37ha64f8vQKCCqg8H8A+ADw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2fY4MnsgY1Ma0iGidqE6W4+zuJKOdqsAeUD5xVMt4wo=;
	b=cd+goLquwfMbbKVuI1GvnRWPU5uql3Lu9nXsNIwEW699iZZVH8ddAGM6jumDAzKqUhed
	 BPwFcGXcPBJHrbv36j8Li+tACibXxMJZNU1xpnglk55waLuO7ZtFaNbNy/S46NtXV0jkG
	 CYuEKDU97J21vsCAUHWoOsoTDanpf1Sncbs9Xg88eTR8aBtbpKGpBRcV/XWvlK68DtZrR
	 //k1TdxV9HqXuOWkt7sR3Xsbui0EPMP0leUCV2ALjG5f68vi9F5dfSpD3Uo8JGzdLGX9t
	 +gG4Fq/oX6xAtXOH0hGbrC/kjywpw1cKGpRb5sQxe/NlQbMzRSgkwU8ufPPSt39WuaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TzcAP1oA;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898C60A6F4C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7898C60A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TzcAP1oA
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-85d363fb73cso938433a34.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296229; x=1794901029; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2fY4MnsgY1Ma0iGidqE6W4+zuJKOdqsAeUD5xVMt4wo=;
        b=TzcAP1oAEecTDqeA9NDVoEHaylt9QYxwnhdDW9L292t2DB8vKjYTIKrPxLt4qBki3j
         21ZECJfr328TAlA4fqT7YDe5yKiWNvIp30dGdSV6RrMJREvVZ2a5y3KkB6Mxt4rsQULq
         pOOSIswEaJCs9EdS93DL7XrXJiUVVZnUc37IzrSo5d3zK3BEtbQdtlm/HhlqzVEGYFy6
         ReAcn00/SHgPyplBLMsBVE4gIah074CW/rUCc8tuvsh8flCMXAD8pw6HC1cfLN1F2GeQ
         fRZNgv+pX1e4SIQA0nnevEq4TAbt4RpJOBV7Ec92acGJUjC+Ad5wej3Kl42gCUE3K4+s
         IdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296229; x=1794901029;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fY4MnsgY1Ma0iGidqE6W4+zuJKOdqsAeUD5xVMt4wo=;
        b=JwHw4Ljxk7JBzb4dD4iDtfrCTInjiXerYjPiZEdmBA1+AjnL7Dmw13btVP/b5PTOJL
         Qdonczn3XrfKzDT2QfQ/SJV8C6SxM7HlOe5FtHqnQn5HPrSCqpX41SXWU6tE3XAAYUzI
         bHzUkcZPa18YussPjjDXusxZ1URIRHjeWNyulxYiOe+tlea/hAtM8c4cDLXt43bPJMsX
         J93I+L5HMsHljbowT3GkyDVQiAPvxivKetWz2zDGHwBrt8HXpUfvQ5RfsvUgU8wpxKwK
         pB+j+kioi3clogT/ZJovfuaW72ZpUrkoPJpfrdneSEou7hnIiMlpFPC2+upFHG/p4cc6
         DREw==
X-Gm-Message-State: APuU4Z+ZYveMK9emwR9Y9pQfZRkQ7eB1UNXZfFiL+Gkn6Nqw3gsJaHWd
	k8Jv7QQZw4KpQe23yCC8K74gEHfQXobORBiLWTTkePoeDXaMgzsw6gwI0zbEdrpl
X-Gm-Gg: AYBFou12Tgloz3q1Zc8otHnrj7NDUarzgRJtHu51JsMXU70OzPztRXED5X4HKsf+ePV
	MLBKWuVmlSG0aIcb60ZIZQV4pMYhB5DhuPukmMCC7e1qsVMjRl/9adjEf5/FTbsRqsMgkVd1t7i
	S/IzXpZkmJmuR3PYiAgMUsgMMXajRx8EVyFFTqvhfPHH3nUrFLrN6QFCFOWCglx/yXd1RF/2HSJ
	O3Y5nsMADO5NcIx5SGdst0vWNhEox+7UJDVyz2ZgNRorqMDzqG8+xR5f/tu2Nk8TThsS2X8K0ue
	nMxF2BHfFU8N8a2KHiolf4mAYCoAjroOzxKONBxYYpfP3QCGV8S26HLIjw/F8irmswnpVeLT+89
	g/ugwUR6pLdulyieFXejDWR0tZnIhaa6HOP/dqakX8X5wA8QExymbygWqwHPwrGa2Rw0VVBMBk4
	eAyIlSgzR3kO5kZnegfNcL4vLOWNhVMHxUiiHWNMUkdfJQ2MGCaSWhfA0GxgSyuJbdCAM0mY7VW
	Ng1VGkTSIwPqy1Cp8e3gfz2Fak4Wf9+ZKNaoyGjd+7QY31rXwrsb5YcGnu5+p4NtS2IcxHaV/5P
	wskhdgz9ocBwUD7Ui9GBuGwRwR8Cdm1uGMCK
X-Received: by 2002:a05:6830:440d:b0:804:bb22:6d42 with SMTP id 46e09a7af769-860dc7e466amr1128871a34.17.1794296229351;
        Mon, 09 Nov 2026 23:37:09 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dca41c80sm1366310a34.3.2026.11.09.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:08 -0800 (PST)
Message-Id: <d8681a8560c6e5185f66df372f65c9b9dee99cc3.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:38 +0000
Subject: [PATCH v2 08/15] merge: handle NULL value for
 branch.<name>.mergeOptions
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A branch.<name>.mergeOptions without a value makes "git merge"
segfault on that branch: git_merge_config() passes the NULL value to
xstrdup().

Reject a missing value with config_error_nonbool(), as
git_config_string() already does for the other strings that
git_merge_config() reads.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/merge.c  | 2 ++
 t/t7600-merge.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index d7bf209114..c6f9356ccb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -668,6 +668,8 @@ static int git_merge_config(const char *k, const char *v,
 	    skip_prefix(k, "branch.", &str) &&
 	    skip_prefix(str, branch, &str) &&
 	    !strcmp(str, ".mergeoptions")) {
+		if (!v)
+			return config_error_nonbool(k);
 		free(branch_mergeoptions);
 		branch_mergeoptions = xstrdup(v);
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 8f6109fb91..2da12d6662 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -552,6 +552,12 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
+test_expect_success 'merge rejects branch.main.mergeOptions without a value' '
+	git reset --hard c1 &&
+	test_must_fail git -c branch.main.mergeOptions merge c2 2>err &&
+	test_grep "missing value for .branch.main.mergeoptions." err
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option -n with --summary' '
-- 
gitgitgadget

