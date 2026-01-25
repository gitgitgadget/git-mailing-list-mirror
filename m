Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D4823DD
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381566; cv=none; b=qFABTvLQI4IG95O7cJfF1mlmmhx3olSyP1ex+QqJobtwBwdav340hCavZYCQOktOQbdA1W4XPOIoQ0zpha3RFrNcvhbMhDdoQN+Wm6vZYi4Ntv16kS7/X4PW72K/rbK0wfaeIJq73xp6EoqzKMkFm6LWvk/riKRqMtAkgXU0vR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381566; c=relaxed/simple;
	bh=jlIyRdIJaFFeZeUfmHaIU4xDsaM2h9Aez6fql3QVdl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ftfsj04NJwnxo+geOJTYjswcCLVmpuFASnGbTxGBJRigiItNlm3fFW7K2BThVEyp9pqiD8Jcno5BuXGfLY5NbLI90pdw0ZVKKz3cy7ziQ6UDfhbegkzuK1QRe+vzs0/oZ0Hqkp9dECgVulH/1mHpaFp87RFll0W4tnYeGcTpn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm9YG5wM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm9YG5wM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee974e230so35209865e9.2
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381563; x=1769986363; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5q5j5oM/i/1OWQOuZ2gN3DLPDFKsXaCgRCuFV0KVj8=;
        b=hm9YG5wMRHmunTqTOJfNZr+bx83FLhcYWdjYN/FFP4iDeRQb/u5nfumY4cSeezcjmp
         BrbI4/o+o3/0lgo+Z97uC/+GYeeucY2tzv+L63inyUAPPCKHQ9Bw1AgMvAqHpghICsic
         Y01cF7Ldx9zuR0/6QZNR+vACqee7ytkzCCILw4PlM12yBzFKUYKBPkbUb9g2X1X3Ke11
         tGGrUXJ7BtXFfpFfo3Cr3cAGUr+CeeRsRU3CQL7jP3zIVtpm6+PsH7UJTILZgyNF5Tsr
         tFLy9UOHv418id5HncvZdS9TKwWhCryuwo5zmqAkSGo6R4Cak84UyW0BD0UGJvURf0KJ
         gnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381563; x=1769986363;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5q5j5oM/i/1OWQOuZ2gN3DLPDFKsXaCgRCuFV0KVj8=;
        b=Vkk4t/h5vEN7OwExhc2tKeW+tWb4qQ/lFslQtD2SJonZB/mmmNUlW6xM3nBh0Dr1fY
         6tqE8T55bBu6YenGYAHL//d3t42ku3edo6MxB8qnqNmExngwVXmWzZ7aT8ZSVG4PxQeK
         WCY8fHsBPO30jMlrpMvriQurKjY+NtTOxBFsJDQvjKfivFnys1FpLBNpHeNljJcQ7Wql
         h/ZPhO4ZrZQgBxxGtOal1bMPJvejvQwbPpo6Mv+hUKcYiYABRfBg4YP8citewgGFBNcH
         UbhmJtzZsM6Xj/xsc7+UJQ7RqIkYjDg+37X9bmqAF6S/wTYHx9cpOgysQeVBFG4aW8vD
         oc+w==
X-Gm-Message-State: AOJu0Yyv5MyfIifBzf6PSzPecoTnKE7VsLyQttIV809XDZgrssvLuW5E
	A+i+Xd8kdrbskv1nFjrQM/RiJRpLH1oedDKim44Tliy3cECqc0vQ1+By
X-Gm-Gg: AZuq6aJnBpCKncr4xHYyXEZTmEUhbOe/FWHPPev7P3fPzjnC5XSlxhJhRcx/+ZtIO/a
	rEpxxdKrMl1o/TOG8oJRvvnRkeml4yFhqDjdmc2/vqrEprRpVAPIy9EVi+JExJHJehwksu8rvog
	KlTVF1oeG8bf6Ha/ptAK81e19m0JLhNraIpcPLivj8laaFIF1j5kZDGYMX+owndDbZ8VyL6rJTo
	OKhhfP/enM8bL+9eFxeS5xe3G20BQNPTrqtdht4c0VoKlxi4jYWWZy7ZjE7YObdiYKwWmw3xbFz
	0Gs/YMHKJ4E2aeBl4QlhBNJpmgVXg5XXJvGSYKgb+69IwQlRBbmPdyL3gZhhtfQWkE3cA01gcnO
	Sl1u7VHp+EukZJkjMWMPxXpLOFe3sMf9KD5oSI+Gju9FLVNadgPMD61FVn6b+CYfvCJY7yjQ2X0
	7jZGCWB2yynoSbkACx3Ktsl6/KMao/
X-Received: by 2002:a05:600c:8b0f:b0:480:3338:292d with SMTP id 5b1f17b1804b1-4805d064d72mr48492645e9.31.1769381563349;
        Sun, 25 Jan 2026 14:52:43 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:42 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/6] refs: provide detailed error messages when using
 batched update
Date: Sun, 25 Jan 2026 23:52:35 +0100
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALSedmkC/7XOy27DIBAF0F+JWHcqGPArq/5H1QWPsU0Vm8g4b
 qvI/95xqkpW9t5x4Q5z7iLTFCmL8+kuJlpijmnkULychO/t2BHEwFmgxFIqpaHUGibqJspbFS4
 pzxCi7UY+RA8D31ue+upphOst93HsYOSiT8MQZ0juk/ycYU78S5uhJxsyqKqqS4eybowVvPrKb
 /H7wXr/+Mv59pjcLFujj3lO08/Dvait9080xxAXBRLaoq2dqrQvpHrrBhsvrzwkNuKCe0R5EAI
 Z0WBhJTW+ajU+I/QOgfIghGYESQoOG+sdtc8Is0fgQQjDCAzBWVlrNEbuEeu6/gJrR4yC2QIAA
 A==
X-Change-ID: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6444; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jlIyRdIJaFFeZeUfmHaIU4xDsaM2h9Aez6fql3QVdl4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nrdzv91hmhiInbBhQhUfJ/BLjGgqSYVt0
 ZD5y8SmvOMdookBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp63AAoJED7VnySO
 Rox/0KwMAIwG0wKa6eICqJyT3JzgGehwERg6S9yz/8J81VhWIQ1ms8zeOv4VUlh5RW3SfEU7Qg4
 sdt3RK48JGjJSZpTvOpkCxCTxDloBP8UcHaneC+bglDZ2Wiva/dsKiZ6XRXXHUl+des3LkiGrJq
 q4jpZXLrC3l9OOhhJzbCqXprm80u2bQoaQAYyStUDlw0+iV0ZLG/ZipxX5ThLpLN09Hpy6lOL7H
 TDvMfOuOdaZZ/q6BGg2tX5ZUy27mD2MWa3DOu/+DA4pbuIDMeseBChObaiumzt6flfG2SGcbjoz
 kLK2L19aMGHPtwJCbVuDyk6Y/uJnqyV6LFVJgOgpP4D1uPRif8n3wI29n0OiimjCYYJ3qMLZ7Sf
 EJKfAMwphhwouhaVd0baoxZBe7L36P9eTivH5hky+PorHmQ7EhSkfvmGiZeSaVoKUthJdD/kTAl
 MV82UkiaEskFxPtMetIN8B7IW+I9OLaHfvgSAwcCyArlXCuNrkcvS3KNqKClDtMuMQ9RG1fa+k6
 dU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs namespace uses an error buffer to capture details about failed
reference updates. However when we added batched update support to
reference transactions, these messages were never propagated, instead
only an error code pertaining to the type of failure was propagated.

Currently, there are three regions which utilize batched updates:

  - git update-ref --batch-updates
  - git fetch
  - git receive-pack

While 'git update-ref --batch-updates' was a newly introduced flag, both
'git fetch' and 'git receive-pack' were pre-existing. Before using
batched updates, they provided more detailed error messages to the user,
but this changed with the introduction of batched updates. This is a
regression in their workings.

This patch series fixes this, by passing the detailed error message and
utilizing it whenever available. The regression was reported by Elijah
Newren [1] and based on the patch submitted by Jeff King [2].

[1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
[2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/

---
Changes in v5:
- In the last commit, drop 'const *' used to indicate immutability of
  fields within the struct. In the project it is more common to use
  'const *' to indicate ownership. Since the memory of the fields are
  owned by the struct, let's drop the 'const *'.
- Link to v4: https://patch.msgid.link/20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com

Changes in v4:
- In the last commit, instead of propagating {*list, count}, propagate
  an array with {*list, nr, count} and use ALLOC_GROW. This simplifies
  the variables passed and cleanups the code.
- Link to v3: https://patch.msgid.link/20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com

Changes in v3:
- Drop the first commit.
- For the last commit, where we delay 'git fetch' status information,
  delay all information to the end. Also use a list to compliment the
  existing strmap, this ensures that the order is maintained.
- Link to v2: https://patch.msgid.link/20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com

Changes in v2:
- Updates to the commit messages to be more descriptive.
- Instead of passing the char pointer for the error description, pass
  the 'strbuf' itself. This makes the API a lot cleaner to deal with.
  Also avoids having to remember to reset the strbuf after usage.
- Chalk out a separate commit for using a 'goto next_ref' in
  `refs_verify_refnames_available()`. This makes the intention much
  clearer.
- For git-update-ref(1), keep the existing implementation as is and only
  output the detailed error message to stderr.
- For git-receive-pack(1), use 'rp_error()' for detailed error message
  while keeping the current implementation as is.
- Added a separate patch to handle missing information in git-fetch(1)'s
  status table. This involves delaying updates to the end, where update
  success/failure information is available. I'm not too confident about
  this approach though, we could also drop it from the series and I
  could pick that up independently. This is still 1.19 ± 0.02 times
  faster than non-batched version (v2.50.0) in the files backend.
- Link to v1: https://patch.msgid.link/20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com

---
 builtin/fetch.c         | 255 +++++++++++++++++++++++++++++++++++++-----------
 builtin/receive-pack.c  |   7 +-
 builtin/update-ref.c    |   7 +-
 refs.c                  |  46 +++++----
 refs.h                  |   1 +
 refs/files-backend.c    |   5 +-
 refs/packed-backend.c   |  12 +--
 refs/refs-internal.h    |   4 +-
 refs/reftable-backend.c |   5 +-
 t/t1400-update-ref.sh   |  71 ++++++++------
 t/t5510-fetch.sh        |   8 +-
 t/t5516-fetch-push.sh   |  16 +++
 12 files changed, 312 insertions(+), 125 deletions(-)

Karthik Nayak (6):
      refs: skip to next ref when current ref is rejected
      refs: add rejection detail to the callback function
      update-ref: utilize rejected error details if available
      fetch: utilize rejected ref error details
      receive-pack: utilize rejected ref error details
      fetch: delay user information post committing of transaction

Range-diff versus v4:

1:  3264b8c3bf = 1:  661265fb86 refs: skip to next ref when current ref is rejected
2:  3d2af7a15a = 2:  1f0f2b6224 refs: add rejection detail to the callback function
3:  bc7556f4b0 = 3:  8413ca46b5 update-ref: utilize rejected error details if available
4:  d114f13967 = 4:  b0c4441c55 fetch: utilize rejected ref error details
5:  4606c3b991 = 5:  8aa4477f51 receive-pack: utilize rejected ref error details
6:  c75ccc40f3 ! 6:  c9698e06bb fetch: delay user information post committing of transaction
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     +	bool failed;
     +	char success_code;
     +	char fail_code;
    -+	const char *summary;
    -+	const char *fail_detail;
    -+	const char *success_detail;
    -+	const char *ref;
    -+	const char *remote;
    ++	char *summary;
    ++	char *fail_detail;
    ++	char *success_detail;
    ++	char *ref;
    ++	char *remote;
     +	struct object_id old_oid;
     +	struct object_id new_oid;
     +};
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     +
     +static void ref_update_display_info_free(struct ref_update_display_info *info)
     +{
    -+	free((char *)info->summary);
    -+	free((char *)info->success_detail);
    -+	free((char *)info->fail_detail);
    -+	free((char *)info->remote);
    -+	free((char *)info->ref);
    ++	free(info->summary);
    ++	free(info->success_detail);
    ++	free(info->fail_detail);
    ++	free(info->remote);
    ++	free(info->ref);
     +}
     +
     +static void ref_update_display_info_display(struct ref_update_display_info *info,


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
change-id: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a

Thanks
- Karthik

