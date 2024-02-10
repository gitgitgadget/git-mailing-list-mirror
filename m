Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985643612E
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551382; cv=none; b=Q6gmB1krWv1dBPXYwJVJWJa1Fw3hz4ltPOt17//Horr4mzzqIigH59F7+2osn9DXQ/r5qkVJgdNF1btpAQgFFzwGWkSkYPMNWjz3dtHMOpx1qlBWrwDIFdwOWJL6jGqY2FqAXSYOkfwWbYzH7nGMdc3pKktSSVB5mu8Nq6nk/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551382; c=relaxed/simple;
	bh=R/rQ/YU3zNTE2HxLiAPDtgNYGD76FMXhpgW5ajiFOD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5VC05/BWJ9uw9/HuJXNGhEVHNRVTRZFvRT1ldh/TAkp8k7OAiopsf2/mm5DyHNN8kulnltT1vRGAnUEserAscb9MHwrCkuu9BfX1rFCRAmrVQsTHbQmCkVP96cdUhIL4ntCiCPcqjChOFVjwU4zxXGGVa3GSH6ji1jPRNj7j34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8q+IC9t; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8q+IC9t"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-204f50f305cso1213829fac.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551379; x=1708156179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bv82aV5sIIPHJgFLNWp3Wxh7epgSws1zmMul7KsY6s=;
        b=e8q+IC9t63EzlzUApyvfir4SUho1d3hRZ1etGdcQGRpz8qZkP5Xe9NXyvyoewQ6asJ
         /A2NL33bF4VsrpZ3P9w/QYi8JJLsCNBnGXB31H60eB7z3e/I5txxR5CU+jsVSLfl4K7P
         HWDe402ckVYvCcZVgu8XKRlrusd7kmt1zfcLBfWqLGcqAY3hwF4fFV2oRFBwu0a8de4T
         TBXLcQRljw5eS9FVJC00cShqky2kgMhaR3X4ij3ee7Y9rh3EriFmF/PrIuwbdYsXkYbW
         39k7u1EPtM0p1yyQrFbFy6J60eUPTFLNhLUhGEVZ8NMfxJfDGMpfk8EBU3VIEIJfBowP
         m0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551379; x=1708156179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bv82aV5sIIPHJgFLNWp3Wxh7epgSws1zmMul7KsY6s=;
        b=X5n2a+7ckp9mVCnF1GfcmBntfHivB3BIt82tdnBwBnfrtHYSP23cekAal724zfL5Op
         Kwvjdxp8lwQKVy9IAaSyyed+2OAiYNYkU+RGhZVsrEP4Oj9RW37aL4yfhDiya5tzXE17
         MYGO57SvqfBBRsPpPN22Tusic9d8/J5uEQmZwqM/c+6dGIxS56NoIARm3XeIRE+jHcZP
         NcMh1rknu46d40JQ8fZ0E0w9JJIMKJFMPGlhVcufQIxor0uzvSBMg6l6CyEeR9WCLRIS
         r+aJIc7NsUlHUnQnWK3wqOdf9CLoSAxAfNXUUbeUOBrvwC6jttDLjGbHWOSniZgsSVca
         bL3A==
X-Gm-Message-State: AOJu0Yz6zXCoWunrgVALrdgvuHRTunJT2ntEL4OutHDOyzZ380RS4YND
	ubJLJTQu9u2dTqGHx9Te6/XLLxKEsmalDEqRcuf4LqknsKbsMt/Zrfh0MadYsKY=
X-Google-Smtp-Source: AGHT+IHpCediNbaw12z07dZ89I6v5MBODQb39qx3JuWgr9e6MBu8uvMPIOnaJw9juHsn482uK+tDmQ==
X-Received: by 2002:a05:6871:70b:b0:218:d4fe:406a with SMTP id f11-20020a056871070b00b00218d4fe406amr1669927oap.10.1707551378799;
        Fri, 09 Feb 2024 23:49:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSaNIl9FLFCud4QlIL40XYclEdJ+FEui7XbVVUkpBAfjp+duJFXctRGd3w5Plvv2JIhA3IpMUPs+RIIgz33VV0k+wL6z9rJJXfNXrdgcVTAWE2qntWceUa5LEFN+/16nekxirYyWJU5tuBW/v2x/+YQaZTuxpa+4zvy8V7otSI
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:37 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 5/8] sequencer: do not require `allow_empty` for redundant commit options
Date: Sat, 10 Feb 2024 01:43:53 -0600
Message-ID: <20240210074859.552497-6-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A consumer of the sequencer that wishes to take advantage of either the
`keep_redundant_commits` or `drop_redundant_commits` feature must also
specify `allow_empty`. However, these refer to two distinct types of
empty commits:

- `allow_empty` refers specifically to commits which start empty
- `keep_redundant_commits` refers specifically to commits that do not
  start empty, but become empty due to the content already existing in
  the target history

Conceptually, there is no reason that the behavior for handling one of
these should be entangled with the other. It is particularly unintuitive
to require `allow_empty` in order for `drop_redundant_commits` to have
an effect: in order to prevent redundant commits automatically,
initially-empty commits would need to be kept automatically as well.

Instead, rewrite the `allow_empty()` logic to remove the over-arching
requirement that `allow_empty` be specified in order to reach any of the
keep/drop behaviors. Only if the commit was originally empty will
`allow_empty` have an effect.

Note that no behavioral changes should result from this commit -- it
merely sets the stage for future commits. In one such future commit, an
`--empty` option will be added to git-cherry-pick(1), meaning that
`drop_redundant_commits` will be used by that command.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

This is the first half of the first commit[1] in v1, which has now been
split up. While the next commit may be considered somewhat
controversial, this part of the change should not be.

[1]: https://lore.kernel.org/git/20240119060721.3734775-2-brianmlyles@gmail.com/

 sequencer.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b1b19512de..3f41863dae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1725,34 +1725,25 @@ static int allow_empty(struct repository *r,
 	int index_unchanged, originally_empty;

 	/*
-	 * Four cases:
+	 * For a commit that is initially empty, allow_empty determines if it
+	 * should be kept or not
 	 *
-	 * (1) we do not allow empty at all and error out.
-	 *
-	 * (2) we allow ones that were initially empty, and
-	 *     just drop the ones that become empty
-	 *
-	 * (3) we allow ones that were initially empty, but
-	 *     halt for the ones that become empty;
-	 *
-	 * (4) we allow both.
+	 * For a commit that becomes empty, keep_redundant_commits and
+	 * drop_redundant_commits determine whether the commit should be kept or
+	 * dropped. If neither is specified, halt.
 	 */
-	if (!opts->allow_empty)
-		return 0; /* let "git commit" barf as necessary */
-
 	index_unchanged = is_index_unchanged(r);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */

-	if (opts->keep_redundant_commits)
-		return 1;
-
 	originally_empty = is_original_commit_empty(commit);
 	if (originally_empty < 0)
 		return originally_empty;
 	if (originally_empty)
+		return opts->allow_empty;
+	else if (opts->keep_redundant_commits)
 		return 1;
 	else if (opts->drop_redundant_commits)
 		return 2;
-- 
2.43.0

