Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA081F78E6
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041122; cv=none; b=BtPSJFcM41c58v2hUNnETRAY4z8pMKnn/GQenha9xcZH7TS5UIqKDy3B4OXayhc6u+K5ynniEwShhvRMOof0eWrOGJn4K1Vpt70Jeqt4OfTZUpspL3l+qGth5R4rHwWtZpjQSTyFkyfLpzQHAODloVijgPBiNrb7r2SqGbJ+vUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041122; c=relaxed/simple;
	bh=LTTkTJrepFb3AFPUpbta5Y8CRlSEWpTIY9I0vArSKZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=So41kejCEOZSM8cZcO2CeklfqQqxsI9VTzA0JXgfHl5SQR1fD2eyD/PdCjo3nFLsu8Wk39ojOwlLEaSQTJpwFG6ivZo5M7EUXX0jxyS2W4xzX3v/eXoJk5v0ImuKSEfjldEWhWokQNcJA4gIcvBnbAvY1q1uq0IimHOd1VWnRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cekn2/KD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cekn2/KD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso6196945e9.0
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763041119; x=1763645919; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mTFouIBcyGvtI/qhv96ecaupniVrBiYWtJbwpCEFi4=;
        b=Cekn2/KDPvedFz9h2r0lRVs3alCQOdPbZ2pbO77/RrZYcEkmKqvWGbWi9H7AxEZ0me
         9NdUXVKgfbWyNchjO9H0ZchUv1IWSq9s5urTaR03uMS4cE4KJTotxDecqQPIjH7KhPLT
         jE1WSQ+rZ9J4t3p03x60WOnKEMXMFL/0F72xvZGaOG6G084Uhsg9BrtzCiu/U6HY8buX
         5QgIPqmSyHktRGpSp1WYOcXgRq8o0rRvGtFwC3EHGVxTs2Q1EBT1TdWZ7fLWS4wRZGNW
         YLLqXyYYJB3NI+y/9oS6JwFP13aq/1usuVEJfDRazEHeqfEvYMNqFBEi3TKt5aFNJZaC
         pHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041119; x=1763645919;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mTFouIBcyGvtI/qhv96ecaupniVrBiYWtJbwpCEFi4=;
        b=qIRjv/RqwKhk5in2ab77m98HH6daz7ZcWv7bQKwBGNsJ1/UjQ0RU34Gl6xuePXuBrx
         899JzUyF59lbW2oV8/rwVLDoJu+g528tc/HhMr5N+Y1ZqBFvbgZqf6hfZXG6lzonzK1S
         b0HmVBUHSOHB6V/khdwG484z2ZiEpjyQJSnLtRyMNpnzwpDpC6B5hsAkjGzJOKbX8Y8k
         3MgKmwi0H86+r6UjfXkyS0v2Z9m7iqy2gdVLbvsA7S3y7t9x1uSmXkFGDJglzvo+V/vX
         /947dc0bR3EJ+c+2DcKsE+F/xguYmWhqVC09EjoBL5si+7JTJIrrcsuXguAMgc8uU6mJ
         NRWQ==
X-Gm-Message-State: AOJu0YyKxC0FXkHGUjt9rX+xGwE4sHLhf89+d9mVzEydP5U6pxKkkg1J
	ghi5Dz9b9h89FZVoxlCb9vsP7Rk2CpZ6YjF1FZX65/0mZt7hYbk7iZOD
X-Gm-Gg: ASbGncvGZon9FaVNQKGtIwOpZR/2aIQPbkoXYOEUZJU8gCJZMKe8Z6hurGPAMKT1cQp
	vPULabWSYqQYmkkjBKYgAM9ELNkNj4CoO/zce8NKsuGrwFbW+jMErRnOzjy/DDW0dF6xAS3U6g0
	YrPpceXyFHW8AkR22a1DkKPAy9SJtJnJ8ynr8Q2+qMe2e2R5YsHxd6bzK84+D3BlP4djoKc9TGG
	xzV1Al4PFGm50GvEZbeuW88rQi86qB1BfBaEvZSVvgISHtFAmVLB1yHZFUYZQ2BvZLBE8Lohfed
	BvxdcHwlBHmnbJuWPq3mLO+TxCMG4wjaL1vAF/fzuG0thWKyo7f6NjhBLBKZzoxVCW1tj9+IQ6u
	8uLzgEOYNX0Tea0gJWwefEvdEBgkn8nHVNI+UeepLk7Lc4yEBcvI9oR0Lko+DHYuRihwyN8SJYd
	0qZuN036KSJ+4=
X-Google-Smtp-Source: AGHT+IEm8/JmzkaJslZC3kXzD+BaTeWEOBGMgJKhzu5POSwBxSryPUVcwWzCzLe4xVp8KnDJFgXpWg==
X-Received: by 2002:a05:6000:2c11:b0:42b:3ed2:c08a with SMTP id ffacd0b85a97d-42b4bb74d67mr6860903f8f.13.1763041119101;
        Thu, 13 Nov 2025 05:38:39 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm3861166f8f.37.2025.11.13.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:38:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/2] fetch: fix non-conflicting tags not being committed
Date: Thu, 13 Nov 2025 14:38:35 +0100
Message-Id: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzfFWkC/4XOwQqDMAwG4FeRnpfRtLXKTnuPsUOsUQtThxXZE
 N991ZMIsuMf8n/JLAIPnoO4JbMYePLB910M6SURrqGuZvBlzEJJlSJKDZX/wEh1gK4foeLRNb6
 rQVZoFZLJTGlE7L4Hjoub+3jG3Pgw9sN3OzPhOv0nTggIbLUjLqxD1Pe6Jf+6ur4VqzipvWLPF
 BUVi9IVppCcufyo6L2SnykaJBAqip+Ykrg6KmanIJ4pJiqYp2WuLTuraK8sy/IDPmxnyYwBAAA
 =
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5527; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=LTTkTJrepFb3AFPUpbta5Y8CRlSEWpTIY9I0vArSKZo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkV313Uznh0fp7WMB0KHoYn2osNQmdaxxTy1
 M2/iOMfkGaAHokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpFd9dAAoJED7VnySO
 Rox/gegL/2Iiqpfr4QxPXlanT7gem+SQnpDNKgxtvXizLwAlDWW/UMOd83AdIYBXssudplYPWhP
 D9ZFDM0dvsf2ILjQNHtaKKU/JU9c+ogPMJUTO0piOLYjI2qoj1mvjZBifaqQlMJqNIIQs9D7g6l
 rNM+MCCM068NgIzBI0YyUzrypbIqmbgWBv+/p2Xc3arlPAgEr1iSpjiWYPAowkJ8yQpd9vm1QMH
 QFrxo0g/83IDhJZCN8VvKcZwfRyEBXTxfxMMmLUz+FJZH7JEOMRFwvhASk4RVnB/SLq0nUMdC5u
 EYCOK9fi4pC/6x9gIs34gonS0lg0U0f+HazGyumLnLbOYMERWMg971eo7nH33P1o1mcqZTsXcGB
 PXmlvmR0FA5WLpd8KEQyiX6SDLradWNMOtlrmenzZYDR/fQ3hctFYx0j3yW5vumNTXspn8P7NzY
 kOa3q8P2eemnCOm1uNBoYZfTZ4qv3pWFkQPwhKeXgK9AZ20492WZeDTiI8tariBBsw11GjQfbA4
 cs=
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
Changes in v5:
- In the previous version, I assumed that the `prune_refs()` function
  also triggers committing of batched updates. However this was
  incorrect as the transaction for batched updates, is only created
  after the call to `prune_refs()`. This makes sense, since we want to
  isolate deletions from the rest of the ref updates, to avoid
  conflicts. I've amended the commit message accordingly.
- I noticed I missed cleanup of the repos created in the test, which
  I've now done.
- Link to v4: https://patch.msgid.link/20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com

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

Range-diff versus v4:

1:  ba560e030b = 1:  cc187b053f fetch: extract out reference committing logic
2:  0403971a5b ! 2:  27497a1b9d fetch: fix non-conflicting tags not being committed
    @@ Commit message
     
         The cleanup section is reached with `retcode` set in several scenarios:
     
    -       - `truncate_fetch_head()` and `open_fetch_head()` both set `retcode`
    -         before the transaction is created, so no commit is attempted.
    -
    -       - `prune_refs()` sets `retcode` after creating the transaction, so
    -         the commit will now proceed. Before batched updates, `prune_refs()`
    -         created its own transaction internally with all-or-nothing
    -         semantics. This was done since all deletions were made without an
    -         old OID, which meant they were assumed to never fail. This change
    -         allows partial deletions to succeed, consistent with how other
    -         reference updates behave during fetch.
    +       - `truncate_fetch_head()`, `open_fetch_head()` and `prune_refs()` set
    +         `retcode` before the transaction is created, so no commit is
    +         attempted.
     
            - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
              cases this fix targets, both setting a positive `retcode` to
    @@ t/t5510-fetch.sh: test_expect_success REFFILES 'D/F conflict on case sensitive f
     +'
     +
     +test_expect_success "backfill tags when providing a refspec" '
    ++	test_when_finished rm -rf source target &&
    ++
     +	git init source &&
     +	git -C source commit --allow-empty --message common &&
     +	git clone file://"$(pwd)"/source target &&
     +	(
     +	    cd source &&
    -+	    git commit --allow-empty --message history &&
    -+	    git tag history &&
    -+	    git commit --allow-empty --message fetch-me &&
    -+	    git tag fetch-me
    ++	    test_commit history &&
    ++	    test_commit fetch-me
     +	) &&
     +
     +	# The "history" tag is backfilled eventhough we requested


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
change-id: 20251103-fix-tags-not-fetching-0f1621a474d4

Thanks
- Karthik

