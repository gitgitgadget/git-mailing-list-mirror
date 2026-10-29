Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316166;
	b=03zjVIh7J+O1cD7BVNeeiaV6wnhWWjP7bF9jVexiNydgwsroHGbNmyjQW27t+EdE5ONG
	 myhCnzoofC54lZnY1IOfwcppI70BJqOPx6wrlW+24StAApfLWX0A+7PqRJQsODNT7qWvQ
	 aITkmgioLNOafD7WkYRgokMdKjHH3p/IMC3Yp9x/9r9KdyBln9rmw0lzK1RZ5S6X4sCUK
	 dufPW5oV1kskct2hF/oKLlSkhmf48MxTuL46MV1HeWyqjSZm4ECuF8JLJJA6OboxFlZSR
	 X43T1uz7s8KF2rAaOAdURh37bUAsXieKGKwwnkQwcGtr78+UC01neQH8XteYixMn2ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K6hPh7ZtIH2q84BhBaX80iFDqAgQCqc8nUxKIwvyg0w=;
	b=yAdlMwsHfBk/Q6ptxQ9Pm2v8SApTiojCi9SO3rVg1BOhoryVY55PVN1p9er/syILC3Bf
	 LxNoaoiPIYwBRU1eQPRZuuLyyBqtQ70xcWUEjYlYct+EEfuaPRJaBuLZ7yo9w5Eja8jxc
	 1ApVqCAMz8Gjd4aUIlBJ9uu2YJlrOYgJvub3E6L59zw0kYLGVuROHwJRggA1uIxOQdsvZ
	 8a24mSTck6xW44J2dWzXbUeEoBrvmrPhxfEft6Ols1OEEFwp3rEDYB9rEWqISsUbkHA5r
	 FyN9+FUMl3AKLfCa15iI344ch7AMsFPIxuykjy1Vh1OZ070RWXDsYOJ7UhmE1ccfHWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+VZa8nm;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB6606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDB6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+VZa8nm
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-82109f51565so86763a34.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793316165; x=1793920965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6hPh7ZtIH2q84BhBaX80iFDqAgQCqc8nUxKIwvyg0w=;
        b=A+VZa8nmwK4ScC7g9gTKxUm7dOsRvSlwdge/HuNglNEU+9BMZ3B/ac7i20RkHmc17w
         +sBmNn1jyppMJb5fkFCl2JGOBul7qyrO+N9EhA2xUJyO5Qdb/x21RV8g8VVDgBHeUr4A
         v7doICGtyGnIYL4jMEWDLmmhit21lyucn92VR3q4Bm+4Wjb+nmnLiBqsK+LpPAxoiiGT
         hBrDy+X5JNv/2JUgbpVJLPeBDWu/ES0zmBjg4J4YNPjNqIVKZ58EoYAfZ5/BfqyZHe58
         5iEpLwKGB4xQK71gyhch3rZ8mTfTtbo68OwiMZBKZCM6reuY9MdMB4GlKK05HTFJsG4L
         J3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316165; x=1793920965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K6hPh7ZtIH2q84BhBaX80iFDqAgQCqc8nUxKIwvyg0w=;
        b=Q8omj/FjgoCzr4dBrQYMzKMpoTRF51AHt23al4Hed8Ex6VQlW+TT1boimESKc0ULsH
         ODlGUYTQa7e/Plo4SOAdnm+AlgS3tEQggeVkvMIX6k82bqS1USlKX1i0x4iEI5d8U/Lo
         6koKeUZeS7PX+9ktzkfwiwGDgsPVRtYZv1ZaaYDPqGzCjylJEwyLcBvlAlejSB1jLyKf
         Js7iPEj+BlDgMAumNl8l40QiQjeN/vA5BYttwq5+Wvr45RGa0m7dgtI/QUYOAXfA8zSc
         EGusRp5/5uzGAPef+QQJl7Fmoqmi2fpV7vvC7WV+aa52cKvfjKasu97MXk/jHXuYdx+z
         Wn1g==
X-Gm-Message-State: AFq9FYJ1SHlo8e6iEr7QVbH+w3y5onefj29zO373F04TP7O4xq+9AEnJ
	/aCeRiFLKogoHIiRvoyGzKWKcxdNeKrhnAHELUc9i/c0V8SvJo7yAigAk1k6lw==
X-Gm-Gg: AYBFou0RMPZj5sxlNUmmTPqtGJ6g100IjIVjJ1+vmvlXQXe1gPZwurSbUDrLQlAe+d4
	xw95ewkUPpLaQFlVkh3T4Ht2edMB7v7ToABfsB9+x7GRE1JmI4BnG7HSNknr0rd5xs2AeYZr7NH
	H3yOGCO4D2BQ7BSDzjkoGeA3CPqURlulxGdUDmxaast5SnzYaW7vO1KRSgEengFlVZa/gXjV5w4
	1Y6R85KpClBrkVwPG9V7+68+vLOZwYRyRZy9Ai79pa/9YDR05P9QTwfpZq8HvMLKAmh6HOQuPKW
	jQmB08dHGsUQ0EwsG3ICAqfIFBHPz+6xKCINYijaydazl3MOz8TAZBYXzmw8F8x9no9MWACQh9r
	pHjCLHNv7ELWbUIDtJ/zmujQvz7ai1TWqhrWCY92j45dCSNyAoqkHSoTx7jyqUe7QY0jFG8m1Gs
	X/s5xfbcD4ibigH+SKNw3cPI4j2l49/YOl2SXqoacdkIGgRc6R4NkP7jcDtR2qMPHQzElmIGW6I
	b6vZESLAYrx3mrXmiIu4WttgUpjtn44f/CNCEEC/svo1nfRub6Roz2if5XnmJO+3HMV8xponJ0S
	NYNjYtikb2P6BIL6pSG030C/7EsnK4+Tic/NEaeKU8PXwKL2ejlMPMAmz9/zsUCqm7le
X-Received: by 2002:a05:6830:264a:b0:846:5d82:8b69 with SMTP id 46e09a7af769-85d3656fb81mr598675a34.20.1793316164858;
        Thu, 29 Oct 2026 16:22:44 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d05e0sm694924a34.15.2026.10.29.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:22:44 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/4] loose: fix migrating "loose-object-idx" with batch fsync
Date: Thu, 29 Oct 2026 18:22:16 -0500
Message-ID: <20261029232220.1245827-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029002413.3291184-1-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

While working on a separate patch series to convert the "files" ODB
transaction to be eagerly created instead of lazily, I encountered this
bug that causes an ODB transaction to fail on commit when a
compatibility hash is also configured. This occurs because the temporary
directory migration code does not know how to handle the loose object
index file.

This patch addresses updating the migration logic to explicitly merge
mapping entries in the transaction and atomically write a new
"loose-object-idx" file.

Some other approaches I considered:
  - Storing the uncommitted object mapping entries in the transaction
    without writing a file and only writing on transaction commit. I
    chose to keep writing the temp index into the transaction so that
    child processes that write to the tempdir could still append entries.
  - Also writing mapping entires to the main ODB loose object index.
    This also didn't seem like a good apprach because it write entries
    that may not ultimately get committed.

Changes since V2:
  - Reading the src mapping file is now done prior to acquiring the lock
    to reduce the critical window.
  - Added a comment to `loose_object_idx_merge()` and updated some
    commit messages to improve clarity.

Changes since V1:
  - The loose object index write after the merging maps is now atomic.
  - Added a fixed timeout to all loose object index writers.
  - Duplicate entries are now dropped when writing the merged mapping file.

Thanks for the review,
-Justin

Justin Tobler (4):
  loose: use finite timeout when locking "loose-object-idx" file
  loose: lift loose object index parsing logic into helper
  loose: lift loose object index writing logic into helper
  tmp-objdir: merge loose object index when migrating tmpdir

 loose.c                       | 207 ++++++++++++++++++++++++----------
 loose.h                       |   9 ++
 t/t1016-compatObjectFormat.sh |  27 +++++
 tmp-objdir.c                  |  11 +-
 4 files changed, 196 insertions(+), 58 deletions(-)

Range-diff against v2:
1:  6f104c482e = 1:  6f104c482e loose: use finite timeout when locking "loose-object-idx" file
2:  4799421a74 ! 2:  3ae068f364 loose: lift loose object index parsing logic into helper
    @@ Commit message
         explicitly specify the map to insert the entries into. The
         `insert_loose_map()` helper function is also updated accordingly to
         explicitly operate on the provided map and optional cache instead of the
    -    object source.
    +    object source. The cache is made optional for future callers that may
    +    only be interested in updating the map.
     
         While at it, stop treating all errors related to opening the
         "loose-object-idx" file as success and instead only ignore ENOENT. It is
3:  4233e913ce ! 3:  0a05eb5fb6 loose: lift loose object index writing logic into helper
    @@ Commit message
         Extract the logic for writing a loose object index file into a separate
         `loose_object_map_write()` helper function that allows callers to
         explicitly specify both the loose object map as well as the file
    -    descriptor to write the entries to.
    +    descriptor to write the entries to. Note that the responsibility of
    +    locking the file being written to is left to callers so that it is
    +    possible for a lock to be held for longer than just this single
    +    operation.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
4:  614aab27d1 ! 4:  3c4a3332a5 tmp-objdir: merge loose object index when migrating tmpdir
    @@ loose.c: void loose_object_map_clear(struct loose_object_map **map)
     +
     +	loose_object_map_init(&map);
     +
    ++	if (loose_object_map_read(repo, src, map, NULL) < 0) {
    ++		ret = error(_("unable to read loose object index %s"), src);
    ++		goto out;
    ++	}
    ++
     +	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0,
     +						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
     +	if (fd < 0) {
    @@ loose.c: void loose_object_map_clear(struct loose_object_map **map)
     +		goto out;
     +	}
     +
    -+	if (loose_object_map_read(repo, src, map, NULL) < 0) {
    -+		ret = error(_("unable to read loose object index %s"), src);
    -+		goto out;
    -+	}
    -+
     +	if (loose_object_map_write(repo, map, fd) < 0) {
     +		ret = error_errno(_("unable to write %s"),
     +				  get_lock_file_path(&lock));
    @@ loose.c: void loose_object_map_clear(struct loose_object_map **map)
     
      ## loose.h ##
     @@ loose.h: int repo_add_loose_object_map(struct odb_source_loose *loose,
    - 			      const struct object_id *compat_oid);
      int repo_read_loose_object_map(struct repository *repo);
      int repo_write_loose_object_map(struct repository *repo);
    + 
    ++/*
    ++ * Merge the mapping entries of the loose object index at `src` into the one at
    ++ * `dst`. The resulting mapping file is written atomically.
    ++ *
    ++ * Returns 0 on success, a negative error code otherwise.
    ++ */
     +int loose_object_idx_merge(struct repository *repo, const char *src,
     +			   const char *dst);
    - 
    ++
      #endif
     
      ## t/t1016-compatObjectFormat.sh ##

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0.173.gf57c9a7388

