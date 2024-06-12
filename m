Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9661EB45
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171464; cv=none; b=GTaerSW5Ccyu1usnjlqKgsAGX83H/CtbCtt5GcH7uXuck3WFaQGEw/Ia4/x/kVaQaDOjIcdwMaAXUhpj84kECvAkhkOuP98L/otU1oQAaDGYa3cu7cMcl0YC7Qd8hUy+OSz+9mozoxB/iSOlc1pZ9hT877tab1m893rpDOCt5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171464; c=relaxed/simple;
	bh=KcrX0oP4WpcpSWbYiEcMVVqZbJa54IqgaFCTApnodVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv2ZuYxC3GBh1MnDourHQ//8wV0XCPh38mH//5vdsi/rTwsZAiNbSa+as2vkKG14xFcWOhNgCxyCLv+zRDd3vZ310DVcjPe8wLKmk+pPsJimx/QxK8KVXDgucFOYYhYv/Oavnz+ZC+vkcSQ44bwE6X0r4H6Tq8CMLu7B3Lltdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4rDBWHE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4rDBWHE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7041053c0fdso3585826b3a.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171462; x=1718776262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qqCniF37KBNJuwiFj46dyNeWnNZVgqIlYq1SLE7lOE=;
        b=L4rDBWHEgbD18+VJs/lvJRWH3Lab8I1GyfwG6EvzTXorCoSp0KCuOOH9oZ7t+QklDD
         shsbJjuRhnUTlwRi+WO2eWU1AYFO2NRE/0PDnBPgJROYsVv6wcV2wkB8mXOpPKzsPkfL
         pRxy8PSQ4SifNce9O4PVgfsk57hVatNaC6424coRmYX5QaWhQUbCgqjzNx1nBxgsTGT7
         vaNCUofiQ/GlA+AxqD+iGd3piPkHdEyoEwqakke30wr+NL9fdtg/IxzJngCWkppnQzjB
         ZkbSsCGfbm3MdRuqq+HInU8wdQJhRLYJjPO4cun2YBC9Ly0JWF6dyLQ5KWwinmS0LH3z
         qbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171462; x=1718776262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qqCniF37KBNJuwiFj46dyNeWnNZVgqIlYq1SLE7lOE=;
        b=GeFWkEF3zWX46j992C28QPhn7ZYVxBA3UkgG8UnHOgtxiZzTMQRrOFILI8gAvBsAg0
         6HN5pmCRLAqdPcGNneuNQbrCHWWiPdR9GRAMOLyuEDdTq2NKthGr2eiw85SNh1sCetPs
         mRTMhCdLr4EbdAdyhCNutehtE4zSDHepT8fXCyGhJZDfcRtptpL9HTKJ61LjnL/A+XEN
         T1lDtzvgeWSCTc7a2Wjsoj2TxYiOCS4ZAKIon764ATQR7NwcIPCONsdkgMzUsRHeiFGw
         OPDe5cFDwmAcvhQ71kfvHzjcuDWx7Sx2Tfp+c8c9YLrJl2ZUkqzcfqBXu0oNN5drlbUH
         7aOg==
X-Gm-Message-State: AOJu0YzyIRBeXauhTf8VZf0lfLpocdjuED/RIERkp0pc5zMAIlU2aoM+
	e9Itd3/SGxZaYzOw4SA0LhS+FFealhmvYWGhadnrg4YpRCLTgeFGrnrJvzGV
X-Google-Smtp-Source: AGHT+IEonlDquo0FbkfGuk3w2qrzMqsKSSqFsGB5mnCa3pbcybEgrweS1wX3r7lM1CdnT4gyiTgtNg==
X-Received: by 2002:a05:6a00:14d3:b0:704:2402:37ae with SMTP id d2e1a72fcca58-705bce08245mr1154948b3a.10.1718171461468;
        Tue, 11 Jun 2024 22:51:01 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6f78b8336a7sm1934114a12.73.2024.06.11.22.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:51:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v2 0/5] t: port reftable/tree_test.c to the unit testing framework
Date: Wed, 12 Jun 2024 11:08:09 +0530
Message-ID: <20240612055031.3607-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240610131017.8321-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/tree_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series is preparatory cleanup, the second patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Add more context in the commit message of the third patch
- Add an improvement patch for test_infix_walk()
- Small refactor changes

CI/PR: https://github.com/gitgitgadget/git/pull/1740

Chandra Pratap(5):
reftable: remove unnecessary curly braces in
t: move reftable/tree_test.c to the unit testing
t-reftable-tree: split test_tree() into two sub-test
t-reftable-tree: add test for non-existent key
t-reftable-tree: improve the test for infix_walk()

Makefile                       |  2 +-
reftable/tree.c                | 15 +++--------
reftable/tree_test.c           | 60 -------------------------------
t/helper/test-reftable.c       |  1 -
t/unit-tests/t-reftable-tree.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 82 insertions(+), 72 deletions(-)

Range-diff against v1:
1:  161d8892d6 ! 1:  542e497334 t-reftable-tree: split test_tree() into two sub-test functions
    @@ Commit message
         This improves the overall readability of the test file as well as
         simplifies debugging.
     
    +    Note that the last parameter in the tree_search() functiom is
    +    'int insert' which when set, inserts the key if it is not found
    +    in the tree. Otherwise, the function returns NULL for such cases.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ t/unit-tests/t-reftable-tree.c: static void check_increasing(void *arg, void *ke
      {
      	struct tree_node *root = NULL;
      	void *values[11] = { 0 };
    + 	struct tree_node *nodes[11] = { 0 };
    + 	size_t i = 1;
    +-	struct curry c = { 0 };
    + 
    + 	do {
    + 		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
     @@ t/unit-tests/t-reftable-tree.c: static void test_tree(void)
      		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
      	}
    @@ t/unit-tests/t-reftable-tree.c: static void test_tree(void)
     +static void test_infix_walk(void)
     +{
     +	struct tree_node *root = NULL;
    -+	void *values[13] = { 0 };
    ++	void *values[11] = { 0 };
     +	struct curry c = { 0 };
     +	size_t i = 1;
     +
     +	do {
     +		tree_search(values + i, &root, &test_compare, 1);
    -+		i = (i * 5) % 13;
    ++		i = (i * 7) % 11;
     +	} while (i != 1);
     +
     +	infix_walk(root, &check_increasing, &c);
2:  d649c4a193 = 2:  c976a37cbc t-reftable-tree: add test for non-existent key
-:  ---------- > 3:  3010c8f01a t-reftable-tree: improve the test for infix_walk()
