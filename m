Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5E10A0E
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594003; cv=none; b=OlLN+3Jp9q3syLBHWGGo44ai2fWEyc0GD/ezoW4sh81MltHAuvEWiJN27aJOVZhJHoa6JzBx0pU/PpPgD/pqKcK8DEX1RIX/t600EGPLCfunTkqIAF7oC21Qm1r+dh4mhuBoutakhbGRYKbF5NLwCmfVSqVZ6YYZHlwwpVW6Tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594003; c=relaxed/simple;
	bh=MZY4hGGCGf4zDiZFG9DOM6fKCE3qgauGiQMvKreM0Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR7WmtXqSF5/rpyhLa5qK69/HZyx8a38uFTlRk1psYux+sBzOarNSO+lrPK6L6T+WY0WiP5eh3LgGoweefvYTK4BuKrzb58lcENruf6OWHv9LfYsjFQPLpN5jbEYOeWSCUabEZTjAXOHTlIQ/HTK1vHBuN0oPLHN7+fB8F/J3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLSPG3kl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLSPG3kl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2057835395aso36831535ad.3
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594000; x=1728198800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8G/k3fTmYEyQziA2ZiXtvwhDOV2Vml8uuaxEaamZOk8=;
        b=nLSPG3klmZT4FMn615KyYb1AxNp14ztXe9WZkPSfUYvvmaDHGQYI1Bzhafq5/TxfNw
         813kP7j9CTKWQQLJldmy5fnUF0y4CxvFoNv0GkPbSeVRWbEDCgN6a9iWcOsLfu74mpDl
         tnDZMFum+Y+xzBbjz5lPAHP+RNLoegrUAEFnLjVOITQLWr3wAC+May7vTnWmQoJdVRp7
         /pl76+WvnFcp50uTAHCk85ZInThrILtVfFWDtMDX0vXH8Al0H3bC6F0y/b5oX8x58PGz
         rMF52WO+I8uk8D6pXrsTynjbPFIkXdbA107YulAGxP7+LdhT9GGr+G5aptifIjUc9qt5
         6Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594000; x=1728198800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G/k3fTmYEyQziA2ZiXtvwhDOV2Vml8uuaxEaamZOk8=;
        b=RZN6G02cYA9BoSATun1/rDkpEi4hijZqfTp7vjz5DfCMfDoMeIicaE6PCW+1lDNZth
         CunTEO+E+4TR6zRxti+8Kv59BheumAcCCwQuWObhbYFgRarQ2tJkOY21CHYKBcgvWXU7
         ZWOtsgRjuEPhefl9pGPn7H/DhtkC8yYrCJgTCilAVR/C0VaULTAHv+rBls7gmEZiWZbU
         yogpW9v2GkpJT7hvCRr+JOKZOW62c0luX2IxzlNgmlWIUliQJSGJCSceDdeiUhouIchr
         7y3/9Q+eOUhDWrnOfq7IOYw1RPC0eyUg3kshQnYXpOZkOJM++lKAWcKJLCQ77OF0CBEJ
         eFnQ==
X-Gm-Message-State: AOJu0YxG0yxQ65sQP/W+wjJsg1x26g5NrHkvv/29cdZik7ZBplfFnxpE
	qKdl34kak6JmXf8KJ+ZFU5eQhXsdZJ/BvSFLK4E6zwWOmqK1CD41QnWeiQ==
X-Google-Smtp-Source: AGHT+IE0exZrgC/EBJ4I68VPQ0CPFcXCy5W7oVvIwiPJY8lxmhhcfloQv3wwmKTegzZlo9bos/6sxg==
X-Received: by 2002:a17:903:22c2:b0:207:14d1:8270 with SMTP id d9443c01a7336-20b367e9349mr139105645ad.16.1727594000066;
        Sun, 29 Sep 2024 00:13:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c2560sm4112560b3a.87.2024.09.29.00.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:13:19 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:13:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/9] add ref content check for files backend
Message-ID: <Zvj-DgHqtC30KjJe@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuRzCyjQFilGhj8j@ArchLinux>

Hi All:

This version handles a lot of review from Junio.

1. [PATCH v5 1/9] enhances the commit message compared with the previous
[PATCH v4 1/5].

2. [PATCH v5 2/9] is a new topic which has not never been introduced in
the previous. It supports multiple worktrees check for refs. During the
GSoC PATCH: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>, I do not implement
the code to support worktree check. However, we need to add this due to
the review from Junio:
  > > +`escapeReferent`::
  > > +	(ERROR) The referent of a symref is outside the "ref" directory.
  >
  > I am not sure starting this as ERROR is wise.  Users and third-party
  > tools make creative uses of the system and I cannot offhand think of
  > an argument why it should be forbidden to create a symbolic link to
  > our own HEAD or to some worktree-specific ref in another worktree.
When checking the escape situation of the referent, I didn't consider
the worktree. So, I decide to first add checks for multiple worktree.
And then add a new test for multiple worktrees.

3. The intention of the [PATCH v5 3/9] is the same as the [PATCH v4
2/5].

  + Enhance the commit message suggested by Junio.
  + Use "fsck_ref_report" to tell the user we cannot read the file
  instead of reporting general error.
  + For "FSCK_MSG_BAD_REF_CONTENT" message id, instead of just reporting
  the no-information message "invalid ref content", report the actual
  content of the ref, i.e., "ref_content.buf".

4. The intention of the [PATCH v5 4/9] is the same as the [PATCH v4
3/5].

  + Instead of using the concrete "refMissingNewline" and
  "trailingRefContent" fsck messages, create a fsck info message
  "unofficialFormattedRef"
  + Follow the advice from Junio, use "fsck_ref_report" to report more
  useful information. For example, what is the trailing garbage.

5. The PATCH[v4 4/5] is split into 4 commits from [PATCH v5 5/9] to
[PATCH v5 8/9]. The reason why I decide to do this is that I introduce
the check for worktree and the version 4 is a little messy for the
commit message. Although the C code is not changed too much, the commit
message is hard to write and make the reviewer confused.

6. [PATCH v5 5/9] aims to add checks for textual symref except escape
situation.

  + Because I split commit here, it's easy to write the clean commit
  message, which should be changed according to the review from Junio.
  + Followed the advice from Junio to gracefully check the symref. Thus,
  the commit message is more clean.
  + Drop the check for "referent" pointing to a directory. We allow
  this, it's a dangling symref. No need to check this. So we could drop
  the parameter "referent_path" in "files_fsck_symref_target()".
  + Enhance the "fsck_ref_report" to report more useful information.

7. [PATCH v5 6/9] enhances the check for escape situation. Introduce a
new fsck message "escapeReferent(INFO)".

8. [PATCH v5 7/9] enhances the situation where we use multiple
worktrees. In practice, we allow point to ref of one of the linked
worktrees from primary worktree or one of the linked worktrees. We
should not warn about this.

9. [PATCH v5 8/9] enhances the test script for worktrees.

10. The intention of [PATCH v5 9/9] is the same as the [PATCH v4 5/5].
Not so much change.

Because I do not sync the upstream for a long time. For this series, I
sync the latest upstream and generate the patch, it is based on

  3857aae53f (Git 2.47-rc0, 2024-09-25)

And I don't think range-diff is useful, it is messy for the reviewers.
Actually, there are not so many logic changes in this new version.

Thanks,
Jialuo

shejialuo (9):
  ref: initialize "fsck_ref_report" with zero
  builtin/refs: support multiple worktrees check for refs.
  ref: port git-fsck(1) regular refs check for files backend
  ref: add more strict checks for regular refs
  ref: add basic symref content check for files backend
  ref: add escape check for the referent of symref
  ref: enhance escape situation for worktrees
  t0602: add ref content checks for worktrees
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  28 +++
 builtin/refs.c                |  11 +-
 fsck.h                        |   5 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 168 ++++++++++++-
 refs/refs-internal.h          |   2 +-
 t/t0602-reffiles-fsck.sh      | 442 ++++++++++++++++++++++++++++++++++
 7 files changed, 646 insertions(+), 12 deletions(-)

-- 
2.46.2

