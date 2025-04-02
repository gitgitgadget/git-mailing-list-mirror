Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE011713
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558322; cv=none; b=J6bhpGyCxIsK7lKATKsL6ghsr/6Q4ZNbnM9gaaABg26BSiJ7OcBwAFJyGfkg3jYz51Di9Y4h0KJ0lAg8DZBKekC0hoDLJ9wOBgSDJFomSwzJK3kKPFCsCOCqUK1VQYpbWqWg/8y3qr3HtFq+5aeXY87RW0W7GHXB/x0OS3BZGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558322; c=relaxed/simple;
	bh=ryEMurHklBu/fS1Hiq0Ao8d97CWw2pxhj1EXW+6WI1I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=DfD1mpFsX89p702HyYI1O5fB098GQ1NbyXrXRTToDbBbh4+YkhiAc1p8OFJui+x8hH6nwTdEjAPKFnteTgXFltmeC5vDATEjMktBTjpJ5lFao/MVIBMLc7TxFpWP6L1n2aE0USB+2st2V2+0kQPeQE9DOizKveOVSTvXvnUg+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM5zxMoT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM5zxMoT"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d129c1aso253617f8f.0
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 18:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743558317; x=1744163117; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eHF7dXS6YRnpTAKreFrHogPGm0mq/uCQeXxZr8u97rw=;
        b=eM5zxMoTsXvpcB9k9YfMc2UhLYf/xFKRnF8iUch2n9kmmakvOw6hvwahXLniuDGSMI
         PkCM4FEwBiMQSvv/Av4qi+b1CIBBmjprptpL8DQgl8F5Kp09qgkWKZBfvFfrMaj54dJ/
         BmI5fAbf2b2hZzk0o0Qq+mtjO8B94X/gxUUflQSI96/CERTLHRMah41zr4cbaO59GcgR
         B3wJnf6lTcoXv8FvQt/EutUEjNS7NammhBM/75WZLGCJYoxwvTUeUgILRt4IzncmLHcF
         7cQdGfHNtiLt4G/S9LOpGUKExe1FLvkSJgowBvQHQg7gc7P8eKREFYpbxBQANRv5eHNA
         uTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743558317; x=1744163117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHF7dXS6YRnpTAKreFrHogPGm0mq/uCQeXxZr8u97rw=;
        b=b/BfRsvyu9YgRfsN7Xj04GFbMOE9r77IRQYRsok8YCSMpSfmQ6tioadvMXy2MkYEG+
         27XWtDzurDjhrzH0SjRZJxaZy4ehr46CH7nt0D4KhM6IR7xHsZSxlxNctrnm70OK/z7F
         z+GuuVpc3KfIktM+soExSCNBvczB3uwhDXltKxR8vFGtdgBoATmPgMlvWZawucuqWD0D
         QqsIYWQwRm5eA7gnI0gAL3t8TMiviA/XaorR5Xb27hhRvvC2VIbsFDL6TdPsmdLINh0G
         ZvtwGNsUDAbCnthl55HiAS9hiaJUx7RHqog4CTaZ3BjV0w/MgFK7D3zUQOZ6xCYO7g9z
         AeOA==
X-Gm-Message-State: AOJu0YwYLRCyT6XFq7WkNQdifICeT2l+Gs5e/d5tLYPhevKO6TOigUT+
	aykcjUxEoEf/XOcay9Wtac0Ok8pDf6rmt65NmLwa0fvrQhZqrVJwQjONxQ==
X-Gm-Gg: ASbGncv9PEK/ABqhaG2sC0ruuU4lxF9Lk+w3iV0S3HwTbsQs8m9X6YJLEtgSE3Q/SO+
	y3ixFrKJ739dCLBrbJOZcI1gQoKZTgs3ExCQuZU6nq6EvGlhhqLHys9SADFWWT7ElOdiO1lXTjS
	8+r9fTtyIbgNXH4TjvTHOv4SAJUIIG+7+Oscx7/XrN5Hl1THwv038GasdAf6111lPsdEcMFhiEx
	0RClE6vPUsViJMECBodWr4wuuukHAyCGP+N9FNWS6znLj5cfR0FH2nJY5if3aftCjvD2aq/CqAx
	/rWulPcFlaubtAq6yq4mhOTrYVI6CKTIKqFqN4XTchdu4A==
X-Google-Smtp-Source: AGHT+IELIA7PQLtcqrqKXW9Ec6ZjuLnJq2yJN4NtWr8CsAzGsC85waet13mzSYACmQ8mm0MKNMfCLg==
X-Received: by 2002:a05:6000:2903:b0:391:952:c74a with SMTP id ffacd0b85a97d-39c2a34cbcemr186430f8f.8.1743558316897;
        Tue, 01 Apr 2025 18:45:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6656afsm15386550f8f.40.2025.04.01.18.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 18:45:16 -0700 (PDT)
Message-Id: <pull.1937.git.git.1743558315633.gitgitgadget@gmail.com>
From: "HJ C. via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Apr 2025 01:45:15 +0000
Subject: [PATCH] column: exit early when indent length is larger than width
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    gitster@pobox.com,
    code@khaugsbakk.name,
    "HJ C." <hyunjidev@gmail.com>,
    lavendarlatte <hyunjidev@gmail.com>

From: lavendarlatte <hyunjidev@gmail.com>

The code exits with "fatal size_t overflow" when indent length is
larger than width. This is because when calculating cols of struct
column_data, unsigned underflow happens and cols is set to negative
value, then converted to size_t when calling REALLOC_ARRAY in
shrink_columns() function. This can lead to allocating extremely
large chunk of memory when succeeds, or crash when fails.

The change exits code early with failure reason to avoid underflow
and clarify argument limitations. This change ensures that cols is
always positive, making the code clearer. It also eliminates the need
for warning suppression related to signed-unsigned comparisons, as
cols can be safely converted to size_t.

Signed-off-by: Hyunji Choi <hyunjidev@gmail.com>
---
    column: exit early when indent length is larger than width
    
    I have sent this to git-security first for potential security check.
    Thank you Patrick for review and reply. Based on your comment I have
    updated BUG() to die() and added two tests. Also confirmed all existing
    column tests pass with new check.
    
    This is copy of his reply:
    
    Hi, thanks for your report!
    
    The use of both print_columns() and run_column_filter() is rather
    limited across the Git codebase and only covers across a small set of
    builtin commands:
    
     * git-branch(1), where the value can be changed via the --column
       command line option.
     * git-clean(1), where the values are hardcoded.
     * git-column(1), obviously.
     * git-help(1), but again the values are hardcoded.
     * git-status(1) via wt_longstatus_print_other(), but the values are
       hardcoded.
     * git-tag(1) with the --column command line option.
    
    So only git-branch(1), git-tag(1) and git-column(1) are relevant in this
    context, and I cannot think of any way to exploit these in a meaningful
    way. I also think that --column options are unlikely to be used in any
    scripts.
    
    So all in all I think it's fine to discuss this on our normal mailing
    list and fix the issue in the open. But I'd maybe wait a day or two for
    others to chime in before doing so. Given that these values are
    user-controlled we probably shouldn't use BUG() because it isn't. die()
    would likely be a better fit. We should also have one or two tests to
    verify that things work as expected.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1937%2Flavendarlatte%2Findent-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1937/lavendarlatte/indent-v1
Pull-Request: https://github.com/git/git/pull/1937

 column.c          |  6 ++++++
 t/t9002-column.sh | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/column.c b/column.c
index 93fae316b45..692fefafabd 100644
--- a/column.c
+++ b/column.c
@@ -186,6 +186,9 @@ void print_columns(const struct string_list *list, unsigned int colopts,
 
 	if (opts && (0 > opts->padding))
 		BUG("padding must be non-negative");
+	if (opts && (opts->width > 0) && opts->indent &&
+		(opts->width < strlen(opts->indent)))
+		die("length of indent cannot exceed width");
 	if (!list->nr)
 		return;
 	assert((colopts & COL_ENABLE_MASK) != COL_AUTO);
@@ -367,6 +370,9 @@ int run_column_filter(int colopts, const struct column_options *opts)
 
 	if (opts && (0 > opts->padding))
 		BUG("padding must be non-negative");
+	if (opts && (opts->width > 0) && opts->indent &&
+		(opts->width < strlen(opts->indent)))
+		die("length of indent cannot exceed width");
 	if (fd_out != -1)
 		return -1;
 
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 7353815c11b..1b448be4567 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -206,4 +206,26 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'length of indent cannot exceed width' '
+	cat >input <<\EOF &&
+1 2 3 4 5 6
+EOF
+	cat >expected <<\EOF &&
+fatal: length of indent cannot exceed width
+EOF
+	test_must_fail git column --mode=column --width=1 --indent="--" <input >actual 2>&1 &&
+	test_cmp expected actual
+'
+
+test_expect_success 'padding must be non-negative checked before indent length' '
+	cat >input <<\EOF &&
+1 2 3 4 5 6
+EOF
+	cat >expected <<\EOF &&
+fatal: --padding must be non-negative
+EOF
+	test_must_fail git column --mode=column --padding=-1 --width=1 --indent="--" <input >actual 2>&1 &&
+	test_cmp expected actual
+'
+
 test_done

base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
-- 
gitgitgadget
