Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA35328256
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867634; cv=none; b=cXpdMa+s9X0oNCYzvW7gyA3PWAk8hTloOBDjbaWW/kNzNjdPWdpvB/SFPENegHOxwsVMlw+LozfAHHq6ADl5HZUJpdHv1TRG/K2N2EGQ3F852KCkGfWji2Mbcv2eZaxmo3Zm6Bz+uoNojN8AbNIiAuYnA3uxTftF0phr7DtlA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867634; c=relaxed/simple;
	bh=B4/djaL6Eu51u8DSpvgC4Qxduj6QkVrliBvxyQTKbUI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ghZrUMJqW+IO9M91gX4FPCL3e7GnIz03+eQpw7+hmkByWTkgMP8zvW/EMqhXGhy2PktMnJPQesMHLldgpLEtLFDHI3DzxdBjkoUgDbjb2dMlEgeJkwgtbNVqoBgMfauggrZ3WNUJK7bzDNhK6A0L4X7AWrBO/sNvgyyJiihdi4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edgekZQW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edgekZQW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso31770015e9.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762867630; x=1763472430; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfBpjX5DG+IyxJZie2NgnjJvLDxG80HZMDUd3pOVPxM=;
        b=edgekZQWC5b23GehdXKHAmNT/dCnRPkN+XffX4G3bbJ43323hOKXFurDMu6iSvbEdO
         IWhseGzZAMKmbLx8HmMNM09D/sIhFepDsrd+VnZikglX8EWe302QYP/nU0Z0rI/9kfyV
         kDUMnGpb3qTRJ2vGl8EhPjzByV1aCd6rej2NfeZ6AxcwNybD7+ooNnPxJdFd+wjhXs2Q
         4LnWLu3eZycopkrUBM4WFoRsAuzglw96KEkajreQZ6Gp4D/a2E/pOyO6JMSx71bxVpId
         Ydz9o9yCfmPFxXtenRV/TrslqzvMdqaH9HCPDJAMcHN9maJ1CzMUqrV5vm403aULHdJA
         Zkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867630; x=1763472430;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfBpjX5DG+IyxJZie2NgnjJvLDxG80HZMDUd3pOVPxM=;
        b=K1SsVMY0ct7TV0gFpHP1dqJqo/Ua2XeYdzI6XcQyw2q/dY0/6XdpzNL96yEgyEvjbZ
         A5rHKFmlFyPcJYCksiEeRFnb9FuGlNPkXHN2HiFjiikBCBpdYbon6PaqHkwEEA8AATsf
         U1Stst1j7n5aej9FGIPY9iVez9FDC+iEQgmr969ty7j0mHr0iJ3j9VpPM799hScxcTvN
         scyl8cw8CGdXM7WEtHVze8jNb4OMXtNtWYxgOXPTRVsm/Xoc7a0i5xjkVj7qp2YUA0Hj
         TLof06Tmb1k2sVgQQu8XVHdATaKKQFQfsphQmIv2Noy1bnD5T9eGMkZ7E7CwmFhIONLT
         vrMQ==
X-Gm-Message-State: AOJu0Yz6TKQ5yf23KPIn7ytN0PLaO7Pp9AB6fB8q2giaSwXOV4Xz8pB6
	lMtwN9c+sEhR6EmF7vTaiVI7DkoFsWSzREXaVnHTargb/YqAwYmtM3jW
X-Gm-Gg: ASbGncvrR3uBliQeOFuKZXyI2puCV6cmEJzGuXZTAMcnKhrHNKhnXrz+tek1pTiTLRu
	8fTXYoXmg1qOYATVU0XTffBGkLY3klwkW42Tk2xFOV3xcw/wPBKSDMlO+7TerTcWbP4/rwz/iqu
	mPosN8IE1jFy/9eXyNuN/EveRJsIN2UDGPDG48vYW1Va5320eUM8ZXK1bSxkYgTgfQmr4qesiuY
	7sE7vAAyn8yyXpUaA5BBY9sRsLupyEgyGqk5QNeF5ScQfVRfmZxooDHCjGHt9laFKElS8AvhJrr
	HK5GmxWMOu1m5LGEKQP/ZvyrtUvv45O+h3Rx0nrq0zyqbEnj8KSmXr5i2O/P8OrvSDuzPC58A4K
	IQWQM8MVArZES1lhyCGanK72ZT6PSjLC+hIn+3rhuofEhimfaWIymbvC8AZ2KMZ+JEuBmsnmzCu
	Vz
X-Google-Smtp-Source: AGHT+IEeVTam+2xP1uI5z6locD7YE3yAHVfhtZRecx9e3zrD0aBFk17JdxKoW9EJlHDSvdeP5p4U8g==
X-Received: by 2002:a05:600c:474c:b0:477:6d96:b3ca with SMTP id 5b1f17b1804b1-477732298a2mr106997425e9.5.1762867630212;
        Tue, 11 Nov 2025 05:27:10 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd521fsm300794715e9.6.2025.11.11.05.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:27:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/2] fetch: fix non-conflicting tags not being committed
Date: Tue, 11 Nov 2025 14:27:06 +0100
Message-Id: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKo5E2kC/4XOwQqDMAwG4FeRnpfRtF2VnfYeY4da01qYOlqRD
 fHdVz3JQHb8Q/4vmVmiGCixazGzSFNIYehzUKeC2db0niA0OTPBxQWRS3DhDaPxCfphBEejbUP
 vgTvUAo0qVaNY7r4i5cXNvT9ybkMah/jZzky4Tv+JEwICaWkN1doiypvvTHie7dCxVZzEXtFHi
 siKRm5rVXMqbfWryL1SHSkSOBgUJn+iGkNuryzL8gWGZPP8RgEAAA==
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 David Bohman <debohman@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 jltobler@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6871; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=B4/djaL6Eu51u8DSpvgC4Qxduj6QkVrliBvxyQTKbUI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkTOaxNKFaXVh16CCY4MpHO/cTTg29yZel4G
 YZXkM+uV4PYuIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpEzmsAAoJED7VnySO
 Rox/7dQL/3tE20ur7XLPmP0NNtarrbo9TttC1tzfncKaKcGKr3UgsGORA9b3lmKNv1CA5vN7iQe
 jvmdrg954yA84NYMkQe+v1rPh6qGj+AG2Ippib0uTWVWDuq2BTy5zYOBw+AP7fDOz9fGF6Do4eZ
 Nhwj0WykL04f7lPOKrDDhVKD44HE4ffGkdJQc0KkfQQium23oi1hqSaniWiXGMHrM7h2flGuZeQ
 De2BxUwhZWCrsvs86QUi3Ox724ETDWWEp6lWFN0yHZDLbAjfrZMFvFnuBJA/bL/8FtQ2TTpLCVp
 G1zyu56PjhfWnJKuBsBiD/mbjpN10fGRhBjjPk8LIj2KaLnJlVF698oBYexTZXR2Q8X0CFaSYG4
 9XwIxl4g19wUDtQeVmV4Tm0vOJ+xojbQW8TJiwMJB1gQjCFlMXUBo2pa+9h2bumCj6fJ5B4Nj+7
 SxaSKPs7Tj/6FSCfyzQtWOcxfMbV4iVnyRzfBsvwNY4leBG7A8dmG79+pOmc+PNMPTtgsfX09I6
 K8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This fixes the bug reported by David Bohman [1].

The 'git-fetch(1)' uses batched updates to perform reference updates
when not using 'atomic' transactions. One scenario which was missed
here, was fetching tags. When fetching conflicting tags, the
`fetch_and_consume_refs()` function returns '1', which skipped
committing the transaction and directly jumped to the cleanup section.
This mean that no updates were applied. This also extends to backfilling
tags.

The first commit, extracts out common code for committing a reference
transaction and handling rejected updates. The second commit ensures
any failures would also commit pending updates.

[1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v4:
- Cleanup the code in the first commit to make it simpler to read.
- In the second commit, we were specifically checking for `retcode > 0`
  for committing the transaction. This is a bit confusing since that
  begs the questions why not `retcode < 0`. There is no real reason
  there, so I've change the code to simple do `if (retcode && ...)`.
  I've also added more information about the flows which would commit
  the transaction in the commit message.
- Link to v3: https://patch.msgid.link/20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com

Changes in v3:
- Split the patch into two commits. One for extracting out existing code
  into a new commit and the other to perform the fix.
- Add back error handling when commit via the normal flow.
- Instead of calling the commit function at every failure, make it part
  of the cleanup code.
- Link to v2: https://patch.msgid.link/20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com

Changes in v2:
- Add a comment to explain the purpose of `commit_ref_transaction()` and
  how it works.
- Also extend the same logic towards backfilling tags. While I was able
  to add a test for the happy path, I couldn't figure out how to test
  when `backfill_tags()` tags would fail.
  Tangentially, this flow seems to only be triggered when using the now
  deprecated 'branches/' remote format.
- Remove unneeded subshells from the tests.
- Link to v1: https://patch.msgid.link/20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com

---
 builtin/fetch.c  | 67 ++++++++++++++++++++++++++++++++++----------------------
 t/t5510-fetch.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 26 deletions(-)

Karthik Nayak (2):
      fetch: extract out reference committing logic
      fetch: fix non-conflicting tags not being committed

Range-diff versus v3:

1:  ee20b46cc2 ! 1:  49fa9a85ef fetch: extract out reference committing logic
    @@ Commit message
         rejection handling logic into a separate function called
         `commit_ref_transaction()`.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/fetch.c ##
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
     +				  struct strbuf *err)
     +{
     +	int retcode = ref_transaction_commit(*transaction, err);
    -+	if (retcode) {
    -+		/*
    -+		 * Explicitly handle transaction cleanup to avoid
    -+		 * aborting an already closed transaction.
    -+		 */
    -+		ref_transaction_free(*transaction);
    -+		*transaction = NULL;
    -+	}
    ++	if (retcode)
    ++		goto out;
     +
    -+	if (*transaction && !is_atomic) {
    ++	if (!is_atomic) {
     +		struct ref_rejection_data data = {
     +			.conflict_msg_shown = 0,
     +			.remote_name = remote_name,
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
     +		ref_transaction_for_each_rejected_update(*transaction,
     +							 ref_transaction_rejection_handler,
     +							 &data);
    -+
    -+		ref_transaction_free(*transaction);
    -+		*transaction = NULL;
     +	}
     +
    ++out:
    ++	ref_transaction_free(*transaction);
    ++	*transaction = NULL;
     +	return retcode;
     +}
     +
2:  543b67c97c ! 2:  12c71b602d fetch: fix non-conflicting tags not being committed
    @@ Commit message
         extends to backfilling tags which is done when fetching specific
         refspecs which contains tags in their history.
     
    -    Fix this by committing the transaction even when we have an error code.
    -    This ensures other references are applied. Add tests to check for this
    -    regression. While here, add a missing cleanup from previous test.
    +    Fix this by committing the transaction when we have an error code and
    +    not using an atomic transaction. This ensures other references are
    +    applied even when some updates fail.
    +
    +    The cleanup section is reached with `retcode` set in several scenarios:
    +
    +       - `truncate_fetch_head()` and `open_fetch_head()` both set `retcode`
    +         before the transaction is created, so no commit is attempted.
    +
    +       - `prune_refs()` sets `retcode` after creating the transaction, so
    +         the commit will now proceed. Before batched updates, `prune_refs()`
    +         created its own transaction internally with all-or-nothing
    +         semantics. This was done since all deletions were made without an
    +         old OID, which meant they were assumed to never fail. This change
    +         allows partial deletions to succeed, consistent with how other
    +         reference updates behave during fetch.
    +
    +       - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
    +         cases this fix targets, both setting a positive `retcode` to
    +         trigger the committing of the transaction.
    +
    +    This simplifies error handling and ensures future modifications to
    +    `do_fetch()` don't need special handling for batched updates.
    +
    +    Add tests to check for this regression. While here, add a missing
    +    cleanup from previous test.
     
         Reported-by: David Bohman <debohman@gmail.com>
         Helped-by: Patrick Steinhardt <ps@pks.im>
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +	 * When using batched updates, we want to commit the non-rejected
     +	 * updates and also handle the rejections.
     +	 */
    -+	if (retcode > 0 && !atomic_fetch && transaction)
    ++	if (retcode && !atomic_fetch && transaction)
     +		commit_ref_transaction(&transaction, false,
     +				       transport->remote->name, &err);
     +


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
change-id: 20251103-fix-tags-not-fetching-0f1621a474d4

Thanks
- Karthik

