Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F05269816
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489546; cv=none; b=Hczl9/vHNFfZDftejaP0MgYeH2aISFCaQwVttUQGRF2TsQyhqQQBovyQgdDVae2WiaGzmoTX7kGBrtWBy/o6DZJWJq0h7PJzsvUKb2y1MUCDxnd/ob/DJuOupx8nza6mNp+whVgyv1YxQ70eFUC6sRWVZHvMoN58GDLge/Y22no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489546; c=relaxed/simple;
	bh=pxIwqEs5FBpLRpZJHsGB+bEu6aNizd23MxS6muxzWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT7ZZd3jAEwtrsldryjcYXCSvRjS5LG6OKhmeLy9GHayrtsHjLmMLoSvY7eVxsAROMCgRbJjS+GWkx7TKej0Xl+VeCqzwacYujiBaMe4aXsMM6D8VfZ5jF9lj2SFRoCXHysPWPVaM6YsFex6ZfDg+wou9nUwueHWQRgrbHemxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzQyKXAX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzQyKXAX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220dc3831e3so101954975ad.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489543; x=1741094343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSt4ej6rRVg9qGNkJQYQ32QCXadTLhsG9HF5V5rT5gU=;
        b=VzQyKXAXhvxj0I+G9mVbZXtW2H3+dKrg4gnNJZN6NV7mWPRqgAIoDfR8I++UGBlB8/
         YpP1aWemIzp8lVKNibaMc5+xrhpGAMa27Wt66gkT2Y4UnoCyjWzSJ3bB5/i/Chj7Gk4l
         BjNaOjl8HsF8mlGDa1mDOAyyAIh1jiGLZOZi+6sKQCwBdJ6fvyWpevcIn5P+8pyj7auh
         AFiYqJ3UvlJ/hzgUgrZt54exbkcMp9N6YBSt9Ly0dx38HdHh+129vQZk1MVolwmVYpU3
         QZLtL0uNupaYYvd6zFJO17M5H9GCfBWPuwDyShxLgUyXXXxN8ZNrXU2McCxwtt7TUxvX
         qedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489543; x=1741094343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSt4ej6rRVg9qGNkJQYQ32QCXadTLhsG9HF5V5rT5gU=;
        b=n8ZkK8cWPWvqgFjoBeN0t1GY9bV//dJBr1K2JnGxTwDxWI0xHn8DiwUb7N1ZmXAkhC
         V9hMfwLM47I6u555lG8EFBGaJt/5OhT+V8UdGRn6ewDIfnDfFk1WBXaX9XEk6WfUCECk
         Dvr5kOxySPpp83/A+GQKGQlnPgqNBhMwzQQGNbg25U1wEYAxdDJtONuRoN/eRHVaN2Ev
         k00XxQI5qvSvgEfkZVYNsGNCZFiwirG7sNyrxIdGMsFrn/D3jF+b1jsvoIzwTEQescGA
         vwM7vV6Nc4IgC6bf08jfmiC58v+EwEruHjKNLE2HvjI4DNzUX3cQisDhm5E9bIV4HG9W
         imhw==
X-Gm-Message-State: AOJu0YzNN3WDpYWtDUC0hWXj6eD2S9GpVswmDIzcBPH7bBpKxonE/LTL
	1X03MeY71WI7eXflt+WD1G1qr8ehS0peYrVNfYVyNnwNKi1pRNqPlc/8hg==
X-Gm-Gg: ASbGnctp87iAmcJNBgtQSN7XpzQ77S31SQmz2wcM8FPd7TDdkjRTDpHsRivLJ6qhreT
	EmPWw8IMx4gD3Gg4L8/Ci9YNNmg3n0aaLoAT/JvxwlIunJqHQMzpR5q1J4hpt8B9qnrS0C9/uag
	VytDLgLd10zZML/cdPiESi/Wor5qWJz8o2Oj9yE/w5goD+kIZGDgAOOU4J+S7JO9OY6dQPcLKmW
	1q9JtWN8RfgudOkIF7iARb4/XM9w+upLPvBMW2NadQ/y8FVrFCdsWcFwE3QqS36DXPVq8Iyqkbw
	7+kgk62sye9I2esFYAOeeA==
X-Google-Smtp-Source: AGHT+IHQYIfC++qvnfz7+EfaIFtki47FtDmvhheYkqHNWLsCD/UxbS8/pOm+INbR8/4MA13AV/WQsw==
X-Received: by 2002:a17:902:c411:b0:221:2d4b:b4c6 with SMTP id d9443c01a7336-2218c5576c9mr317320915ad.17.1740489543217;
        Tue, 25 Feb 2025 05:19:03 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a000995sm13708215ad.46.2025.02.25.05.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:19:02 -0800 (PST)
Date: Tue, 25 Feb 2025 21:19:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 0/9] add more ref consistency checks
Message-ID: <Z73DTwr9RicKMINe@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

Hi All:

This changes enhances the following things (v6-changed):

1. [PATCH v6 2/9]: enhance the comment.
2. [PATCH v6 3/9]: use '' to quote the file in the print message.
2. [PATCH v6 4/9]: a new commit message to explain why we can tighten
the rule.

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
 refs/packed-backend.c          |  369 +++++++++-
 t/t0602-reffiles-fsck.sh       | 1205 +++++++++++++++++++-------------
 worktree.c                     |    5 +
 worktree.h                     |    8 +
 9 files changed, 1162 insertions(+), 485 deletions(-)

Range-diff against v5:
 1:  b3952d80a2 =  1:  b3952d80a2 t0602: use subshell to ensure working directory unchanged
 2:  3695586f58 !  2:  fa5ce20bb7 builtin/refs: get worktrees without reading head information
    @@ worktree.h: struct worktree {
     +/*
     + * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
     + * get the worktree without worrying about failures pertaining to parsing
    -+ * the HEAD ref. This is useful when we want to check the ref db consistency.
    ++ * the HEAD ref. This is useful in contexts where it is assumed that the
    ++ * refdb may not be in a consistent state.
     + */
     +struct worktree **get_worktrees_without_reading_head(void);
     +
 3:  cbaae00e8b !  3:  787645a700 packed-backend: check whether the "packed-refs" is regular file
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +		 */
     +		if (errno == ENOENT)
     +			goto cleanup;
    -+		ret = error_errno(_("unable to stat %s"), refs->path);
    ++		ret = error_errno(_("unable to stat '%s'"), refs->path);
     +		goto cleanup;
     +	}
     +
 -:  ---------- >  4:  f097e0f093 packed-backend: check if header starts with "# pack-refs with: "
 4:  b9ce8734ac !  5:  a589a38b68 packed-backend: add "packed-refs" header consistency check
    @@ Commit message
     
         In "packed-backend.c::create_snapshot", if there is a header (the line
         which starts with '#'), we will check whether the line starts with "#
    -    pack-refs with:". Before we port this check into "packed_fsck", let's
    -    fix "create_snapshot" to check the prefix "# packed-ref with: " instead
    -    of "# packed-ref with:" due to that we will always write a single
    -    trailing space after the colon.
    -
    -    However, we need to consider other situations and discuss whether we
    -    need to add checks.
    +    pack-refs with: ". However, we need to consider other situations and
    +    discuss whether we need to add checks.
     
         1. If the header does not exist, we should not report an error to the
            user. This is because in older Git version, we never write header in
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(ZERO_PADDED_DATE, ERROR) \
     
      ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static struct snapshot *create_snapshot(struct packed_ref_store *refs)
    - 
    - 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
    - 
    --		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
    -+		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
    - 			die_invalid_line(refs->path,
    - 					 snapshot->buf,
    - 					 snapshot->eof - snapshot->buf);
     @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
      	return empty_ref_iterator_begin();
      }
 5:  9f638b3adf =  6:  7255c2b597 packed-backend: check whether the refname contains NUL characters
 6:  2c5395bdd0 =  7:  7794a2ebfd packed-backend: add "packed-refs" entry consistency check
 7:  648404c60d =  8:  2a9138b14d packed-backend: check whether the "packed-refs" is sorted
 8:  4dbbacf44b =  9:  ccde32491f builtin/fsck: add `git refs verify` child process
-- 
2.48.1

