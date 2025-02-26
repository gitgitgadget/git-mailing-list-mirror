Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F6DDCD
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577682; cv=none; b=gxRYDR4bFQ1eOcW85ioXsCAHKcljzum4t1oRIfdtXm0AyvkZTf4kLj35C4Dix9cSS+LH3msaDz1hEdCecqZpBQHQroKLL5wUn/ad19dat577Yf6U3NPujbvjdoIqQuG0wddNwVqGl6lin66OLGCW2Yj1AF2tiG/WOcw4hAiynIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577682; c=relaxed/simple;
	bh=9Q4sWGPKDlt+sTMvaIZq6RFGsbROoWrKzgmRR8PX+KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLecMnk5qu6S8XELSHLK7RFdYdg6UF8KRuA2Imds6q2idNL6EfFTm7iT+Bc/QBFLny5zU5HXs6RTPXI48XB3Xi5qtsulE9G2yEen9VD9OxMHHN+GBbJ1E8hcnKx8J5JSrvLkAAUL0VUvc/cBfEKLtVWO0cW4Yr1RSPgHtAQLUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDItJ68X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDItJ68X"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e6028214so147962435ad.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577679; x=1741182479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HolBtc3TpQENgWQ0xuqqUpCY9dOz5buzYVREgfoKgg=;
        b=QDItJ68XSWzaXIz35ntCtyOtaHdYPrRuRLMgGzTpsHtosCmQ2A5hxUvpgxhBk8PArr
         mcg6Ee2th3SN7FhmO0RYqHoQU4WVH4W6zKtICHiFOTlxiEbRPHxaFp2juwxi7iNilgNI
         81h8Uf80qzy7WghmKfpLiG4txFN4sIfdX2kJvnKysb7UCZAAChIYI4r7bknw/asy60r2
         W+3tHufAbLCXZr4clF3SutvvKju9cfHuzEsopbtwmG0cgfnM8wmAcgiPy9Mdr4TJnksX
         fxGt5756GqJQrcgtIeknPaQ9p6gRdHi7bdPIoYgf/7xSDJ7FjF5oyW+xjeQnNIzrpPg3
         0aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577679; x=1741182479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HolBtc3TpQENgWQ0xuqqUpCY9dOz5buzYVREgfoKgg=;
        b=cRpqPLYUAOQFZnbhCAIDztc+LFzCPMjeKrNXBZdVAX7JOHB+OCiS6Bcbei+KvI7LDD
         +iQ7A+LV/jBpYeVM3hw12kSTZ7GpG6SF8fcGJiuU98Uq19C8CFeXsvCxZ3Q2w0tFYqq3
         XcuQnf9HMZsF1yuPowOcNwaEbiKxF5OpTc9ifQIfuglTQLvjzvJmfr2/VuCzcev9G+Tt
         Bz+hx/Q25/SA63HplTg+1/JGvJCR8KpjSr779jXnKAu1xsI6pgcMS41tKoeeq23Em4x7
         tw8WShq5pVIsYFQIeaimvCL/IZkVuB0w0zdiUzi6DB/WCbelDhrAdFkY7bDLJ8xuJzgM
         qvxg==
X-Gm-Message-State: AOJu0YzxQ8pc0DTeGpeCPG4dBU5SZlDO8A6198r4pyyOg1GmNUiGppmS
	7HEbFStE7Of7KLjeiDfKLmd5LekoSj5RRrBIVzJj48epISz/b4Cmn+4fRw==
X-Gm-Gg: ASbGncvS8PziBQqRcfzSnT7CHxX+8GEJuDOdZq+UNOm1jSijGUKeFQwyxADvb3jmgwz
	+Gx5k3TiJDUTQ45TzPFPiunRGKTA29HpjtuC4bfflAntQKW+qbkWEGq6ATtV4UXZgSrnGohz3Pf
	AwJJR2s5O6P4B+ZgWcR3ZFU5cxqe25/kR5p/Z7inEyDl9t8IxKqUgGXc5FXQOQjgS+UgKe4ABhK
	ZuCi22f9KBvWL2rgDeenQLdRaKxOSD9lKADQ7xWgD90W1sMohadL+Eq33AsQOfbmCcK2ptcXpIC
	vjqqL8ruV2wDyL0b8Nnh4Q==
X-Google-Smtp-Source: AGHT+IFORnyKE+DHj/2U6GF18nWMiVb/Oz78YM7cx9CYjGzoLxwrbDiH4EgeCJUdXR3A6AejUZxawQ==
X-Received: by 2002:a05:6a00:174c:b0:732:6231:f2a3 with SMTP id d2e1a72fcca58-73426c8d3a7mr36883192b3a.3.1740577679390;
        Wed, 26 Feb 2025 05:47:59 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a8202e3sm3384378b3a.155.2025.02.26.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:47:58 -0800 (PST)
Date: Wed, 26 Feb 2025 21:48:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 0/9] add more ref consistency checks
Message-ID: <Z78bmBSrDR20GY6g@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

Hi All:

This changes enhances the following things:

1. [PATCH v7 3/9]: use "open_nofollow" with "fstat" to check whether the
file is regular. And update the test to improve coverage.
2. [PACTH v7 4/9]: improve the commit message suggested by Patrick.

Thanks,
Jialuo

---

This series mainly does the following things:

1. Fix subshell issues
2. Add ref checks for packed-backend.
   1. Check whether the filetype of "packed-refs" is correct.
   2. Check whether the syntax of "packed-refs" is correct by using the
      rules from "packed-backend.c::create_snapshot" and
      "packed-backend.c::next_record".
   3. Check whether the pointed object exists and whether the
      "packed-refs" file is sorted.
3. Call "git refs verify" for "git-fsck(1)".

shejialuo (9):
  t0602: use subshell to ensure working directory unchanged
  builtin/refs: get worktrees without reading head information
  packed-backend: check whether the "packed-refs" is regular file
  packed-backend: check if header starts with "# pack-refs with: "
  packed-backend: add "packed-refs" header consistency check
  packed-backend: check whether the refname contains NUL characters
  packed-backend: add "packed-refs" entry consistency check
  packed-backend: check whether the "packed-refs" is sorted
  builtin/fsck: add `git refs verify` child process

 Documentation/fsck-msgids.adoc |   14 +
 Documentation/git-fsck.adoc    |    7 +-
 builtin/fsck.c                 |   33 +-
 builtin/refs.c                 |    2 +-
 fsck.h                         |    4 +
 refs/packed-backend.c          |  361 +++++++++-
 t/t0602-reffiles-fsck.sh       | 1209 +++++++++++++++++++-------------
 worktree.c                     |    5 +
 worktree.h                     |    8 +
 9 files changed, 1161 insertions(+), 482 deletions(-)

Range-diff against v6:
 1:  b3952d80a2 =  1:  b3952d80a2 t0602: use subshell to ensure working directory unchanged
 2:  fa5ce20bb7 =  2:  fa5ce20bb7 builtin/refs: get worktrees without reading head information
 3:  787645a700 !  3:  861583f417 packed-backend: check whether the "packed-refs" is regular file
    @@ Commit message
         the expected filetype, confirming it is created by "git pack-refs"
         command.
     
    -    Use "lstat" to check the file mode. If we cannot check the file status
    -    due to there is no such file this is OK because there is a possibility
    -    that there is no "packed-refs" in the repo.
    +    We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
    +    If the returned "fd" value is less than 0, we could check whether the
    +    "errno" is "ELOOP" to report an error to the user. And then we use
    +    "fstat" to check whether the "packed-refs" file is a regular file.
     
         Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
         the user if "packed-refs" is not a regular file.
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +							REF_STORE_READ, "fsck");
     +	struct stat st;
     +	int ret = 0;
    ++	int fd;
      
      	if (!is_main_worktree(wt))
    --		return 0;
    -+		goto cleanup;
    + 		return 0;
      
     -	return 0;
     +	if (o->verbose)
     +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
     +
    -+	if (lstat(refs->path, &st) < 0) {
    ++	fd = open_nofollow(refs->path, O_RDONLY);
    ++	if (fd < 0) {
     +		/*
     +		 * If the packed-refs file doesn't exist, there's nothing
     +		 * to check.
     +		 */
     +		if (errno == ENOENT)
     +			goto cleanup;
    ++
    ++		if (errno == ELOOP) {
    ++			struct fsck_ref_report report = { 0 };
    ++			report.path = "packed-refs";
    ++			ret = fsck_report_ref(o, &report,
    ++					      FSCK_MSG_BAD_REF_FILETYPE,
    ++					      "not a regular file but a symlink");
    ++			goto cleanup;
    ++		}
    ++
    ++		ret = error_errno(_("unable to open '%s'"), refs->path);
    ++		goto cleanup;
    ++	} else if (fstat(fd, &st) < 0) {
     +		ret = error_errno(_("unable to stat '%s'"), refs->path);
     +		goto cleanup;
    -+	}
    -+
    -+	if (!S_ISREG(st.st_mode)) {
    ++	} else if (!S_ISREG(st.st_mode)) {
     +		struct fsck_ref_report report = { 0 };
     +		report.path = "packed-refs";
     +		ret = fsck_report_ref(o, &report,
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +	}
     +
     +cleanup:
    ++	if (fd >= 0)
    ++		close(fd);
     +	return ret;
      }
      
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref content checks should work wi
     +		ln -sf packed-refs-back .git/packed-refs &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: packed-refs: badRefFiletype: not a regular file
    ++		error: packed-refs: badRefFiletype: not a regular file but a symlink
     +		EOF
     +		rm .git/packed-refs &&
    ++		test_cmp expect err &&
    ++
    ++		mkdir .git/packed-refs &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: packed-refs: badRefFiletype: not a regular file
    ++		EOF
    ++		rm -r .git/packed-refs &&
     +		test_cmp expect err
     +	)
     +'
 4:  f097e0f093 !  4:  5f54cb05c3 packed-backend: check if header starts with "# pack-refs with: "
    @@ Metadata
      ## Commit message ##
         packed-backend: check if header starts with "# pack-refs with: "
     
    -    We always write a space after "# pack-refs with:". However, when
    -    creating the packed-ref snapshot, we only check whether the header
    -    starts with "# pack-refs with:". However, we need to make sure that we
    -    would not break compatibility by tightening the rule. The following is
    -    how some third-party libraries handle the header of "packed-ref" file.
    +    We always write a space after "# pack-refs with:" but we don't align
    +    with this rule in the "create_snapshot" method where we would check
    +    whether header starts with "# pack-refs with:". It might seem that we
    +    should undoubtedly tighten this rule, however, we don't have any
    +    technical documentation about this and there is a possibility that we
    +    would break the compatibility for other third-party libraries.
    +
    +    By investigating influential third-party libraries, we could conclude
    +    how these libraries handle the header of "packed-refs" file:
     
         1. libgit2 is fine and always writes the space. It also expects the
            whitespace to exist.
    @@ Commit message
         3. gitoxide expects the space t exist and writes it.
         4. go-git doesn't create the header by default.
     
    -    So, we are safe to tighten the rule by checking whether the header
    -    starts with "# pack-refs with: ".
    +    As many third-party libraries expect a single space after "# pack-refs
    +    with:", if we forget to write the space after the colon,
    +    "create_snapshot" won't catch this. And we would break other
    +    re-implementations. So, we'd better tighten the rule by checking whether
    +    the header starts with "# pack-refs with: ".
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
 5:  a589a38b68 !  5:  7d7dc899ad packed-backend: add "packed-refs" header consistency check
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
      							REF_STORE_READ, "fsck");
     +	struct strbuf packed_ref_content = STRBUF_INIT;
      	struct stat st;
    -+	int fd;
      	int ret = 0;
    - 
    - 	if (!is_main_worktree(wt))
    + 	int fd;
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
      
    -+	/*
    -+	 * There is a chance that "packed-refs" file is removed or converted to
    -+	 * a symlink after filetype check and before open. So we need to avoid
    -+	 * this race condition by opening the file.
    -+	 */
    -+	fd = open_nofollow(refs->path, O_RDONLY);
    -+	if (fd < 0) {
    -+		if (errno == ENOENT)
    -+			goto cleanup;
    -+
    -+		if (errno == ELOOP) {
    -+			struct fsck_ref_report report = { 0 };
    -+			report.path = "packed-refs";
    -+			ret = fsck_report_ref(o, &report,
    -+					      FSCK_MSG_BAD_REF_FILETYPE,
    -+					      "not a regular file");
    -+			goto cleanup;
    -+		}
    -+	}
    -+
     +	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
    -+		ret = error_errno(_("unable to read %s"), refs->path);
    ++		ret = error_errno(_("unable to read '%s'"), refs->path);
     +		goto cleanup;
     +	}
     +
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
     +				      packed_ref_content.buf + packed_ref_content.len);
     +
      cleanup:
    + 	if (fd >= 0)
    + 		close(fd);
     +	strbuf_release(&packed_ref_content);
      	return ret;
      }
 6:  7255c2b597 =  6:  571479d3e7 packed-backend: check whether the refname contains NUL characters
 7:  7794a2ebfd =  7:  e498a57286 packed-backend: add "packed-refs" entry consistency check
 8:  2a9138b14d !  8:  3638cb118d packed-backend: check whether the "packed-refs" is sorted
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      	struct strbuf packed_ref_content = STRBUF_INIT;
     +	unsigned int sorted = 0;
      	struct stat st;
    --	int fd;
      	int ret = 0;
    -+	int fd;
    - 
    - 	if (!is_main_worktree(wt))
    - 		goto cleanup;
    + 	int fd;
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
     +					     packed_ref_content.buf + packed_ref_content.len);
      
      cleanup:
    - 	strbuf_release(&packed_ref_content);
    + 	if (fd >= 0)
     
      ## t/t0602-reffiles-fsck.sh ##
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'packed-refs content should be checked' '
 9:  ccde32491f =  9:  5d87e76d28 builtin/fsck: add `git refs verify` child process
-- 
2.48.1

