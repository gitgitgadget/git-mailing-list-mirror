Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8732346783
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994051; cv=none; b=aYOWX5bhxGBR8qBWljV3s7h2tD6WP42OMMZ6ygUxqrZo1yDsI5tmQIs5OufKQJRQO5EqZ3M/TkakzSHA4h3SIcCW+SzKsTyg2xco/iYpArKqIZJH+SrFDNJ0x5SfhWeGR7vP+0NML+9rVIwx1k/a/19DM2GNC+LSi1Cl+GGG2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994051; c=relaxed/simple;
	bh=rfCtTZ2y5m9mmtPadgl5pX4PvaoncxB2mzPoS0/RFUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BphdF2zoTM4M2J7iYkR1+26WAQGY9p2QPOksq4ShoI7LqEj33dCvp+QGGRbZaD72hW89qgujRaN/AZJHFdfsLW7V5PXvl+EpN7C8o3494yf7l6fDYzn5cuT10DbU85eUJhqCxO/d7NyU2camHAPiziihV7uxKPK7riJHWMmelmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0TqWt9Q; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0TqWt9Q"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so5245516a34.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994048; x=1766598848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WY6gSSnqXHwx95ksyqpjSGvr3OwfF/ORUPzGFFNDWA=;
        b=G0TqWt9Qy0y2q0XzaKPy3s5vn50ALQX0icmI22f3YZJ2CMRxZELlrOno0UQKOCYPgx
         Le2esUP8i54ocPN2CEGriwpdN+mIjM5k0FR+C90xU1eA9IsJPlgDp+BxCneVMiSuT1J1
         GCeAnsnnKrt1t3YXR5Zy18LLPUkezAo9GVYDwNa/0HExYK2cb4sL62jaUYqWZNRthCeW
         gzxCXepxvXAjo0d1izIV/yZkJiliOJpu66a2yWRDYs0UXTWl3shlIrWj3MzMYUuVPhuT
         tl72pQkQfcLDyxUXlP/JziJlsELfIWvex58L3x02FTwH2F1yo8jJHixEFDL+a6tfRcVW
         bqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994048; x=1766598848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WY6gSSnqXHwx95ksyqpjSGvr3OwfF/ORUPzGFFNDWA=;
        b=EpaiKxJh9ve49dL87QKAuh8OWwIAi8bvPgUefUA35mlX0EPBMzVDLziKpFLEYv3orF
         ogp1tUmKqxSR8b+eUd4o7oLZHOg3CW7qTTG+27g2HybQGvBY91SsKEVZ23Oov3gdntJn
         Q2UoKpzKl25rKaEtNykWpzMIYC0qZcwBNUG8qiHVEFwHs+dJ/aiMe6c4dMro9bB/1Nqx
         KbLyg4hnPKNI+7eryZJK6zc7RYuqc6/E8hHLD8IySOTblRnx0apO4IRokSRrKJ9q+xhJ
         72c+h9pWnZq6fxmUfYiysAG8QM/qQGNsMVIbNNHl8C5vuRA/1Hkb00XJMPZB5Ku9w5Kz
         k+jA==
X-Gm-Message-State: AOJu0Yw5BbbsrXnBdZA6QFOJ9sGgqaiXBZNBVwEEl3OVHi7pPIVmqZOZ
	cPC6pmlXbZQaEscGAmYv1nzNkG67mAY22EeKerkNsNDiPlSLpKxfZuHlCstpGw==
X-Gm-Gg: AY/fxX7vkDGN4MZtpPYwhcgoVprgu9UjJkUAzZiMNOs7PwUi9Xd/YAQ3cKdf19y4ykV
	6okzio8MXVxShBR1wiXkxmuiPmNqUYovQQW+XlTX5NXzEsWTupISebH8Z1HC7HGrnHssenOdIFb
	1oMeD8hSKg+bEPwIyUrMDT+A/gE9N5v1V4DGRnr9s/N9dJH7aIeAt31ubuWm4YI1gEcZfKkpcj/
	CpUg+OdKloEDKcBn5rlI6ddaEKEQGYeHF/598NBfGNgiijg1mtJOSjGXHnqpk74MlMNKeqP1B+o
	wqNBZMQwjLa/wDuBC0ap8Zjb5BD4G/aCDor/Ml8naIW6XaW7zWXexoPiJSnWC8FjERp/jhVvV4i
	eATdIRN/AYXDdejUJZpFo5ycRC0ViHZtHFq1PQKYuiGwmUcsSmQKbwn9lqHB0gLWidxh0W87FCj
	FOqJuzLQiBlXTFd85nTA0=
X-Google-Smtp-Source: AGHT+IHa0lpUWha7JRaBgZPVt6YF/7bF2nNE++YA3hiB2f/EOV9XfYq7M3fMeQp7smj2CEeios5LJg==
X-Received: by 2002:a05:6820:4d09:b0:659:9a49:8ec0 with SMTP id 006d021491bc7-65b45281f96mr8248392eaf.68.1765994048291;
        Wed, 17 Dec 2025 09:54:08 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:07 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 0/7] builtin/repo: add object size info to structure output
Date: Wed, 17 Dec 2025 11:53:57 -0600
Message-ID: <20251217175404.37963-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series extends the recently introduced "structure" subcommand
for git-repo(1) to collect object size information. More specifically,
it shows total inflated and disk sizes of objects by object type. The
aim to provide additional insight that may be useful to users regarding
the structure of a repository.

In addition to this change, this series also updates the table output
format to downscale larger output values along with the appropriate unit
prefix. This is done to make table output more human friendly. The
keyvalue and nul output formats are left the same since they are
intended more for machine parsing.

Changes in V5:
- Small updates to some comments and log messages to improve
  correctness.
- Adjusted spacing in builtin/repo.c:count_objects().

Changes in V4:
- Unmark "byte" string in "t/helper/test-simple-ipc.c" for translation
  to avoid conflict with translated plural "byte/bytes" string.
- Remove some unnecessary translations and add comments to clarify some
  of the added translations.
- Some small changes to the tests in patch 7.

Changes in V3:
- Address potential localization regression by making the downscaled
  number format string also translatable. Also make the format string
  for how the values and unit prefixes are displayed via
  `strbuf_humanise_{bytes,rate}()` translatable to be more flexible.
- `strbuf_humanise_{bytes,count}_value()` has been renamed to
  `humanise_{bytes,count}()` and updated to provide both the value and
  unit prefix as separate strings.
- Unit prefix strings are no longer allocated and instead constant.
- The humanise flags are now defined in an enum.
- Instead of using `OBJECT_INFO_FOR_PREFETCH`,
  `OBJECT_INFO_SKIP_FETCH_OBJECT` and `OBJECT_INFO_QUICK` are used
  explicitly.
- Tests now use git-rev-list(1) to verify disk size info.

Changes in V2:
- Factor out and reuse existing logic from strbuf_humanise() to handle
  downscaling values and determining the appropriate unit prefix
  separately. This enables more control over how exactly the values are
  written to the structure output table which is useful for alignment
  reasons. I'm not how about the interface used in patch 2. Feedback is
  most welcome.
- In the previous version, when checking object size on a missing object
  we would die. Instead we now ignore missing objects. This allows the
  structure command to work on partial clones.
- disk/inflated keyvalue names renamed to disk_size/inflated_size.
- Unit prefixes are marked for translation.
- The test for keyvalue disk size values are updated to check against
  real expected values instead of skipping. Table output tests still
  skip verifing human-readable values though.

Thanks,
-Justin

Justin Tobler (7):
  builtin/repo: group per-type object values into struct
  strbuf: split out logic to humanise byte values
  builtin/repo: humanise count values in structure output
  builtin/repo: add inflated object info to keyvalue structure output
  builtin/repo: add inflated object info to structure table
  builtin/repo: add disk size info to keyvalue stucture output
  builtin/repo: add object disk size info to structure table

 Documentation/git-repo.adoc |   2 +
 builtin/repo.c              | 175 ++++++++++++++++++++++++++++++------
 strbuf.c                    | 102 ++++++++++++++-------
 strbuf.h                    |  25 ++++++
 t/helper/test-simple-ipc.c  |   7 +-
 t/t1901-repo-structure.sh   | 118 ++++++++++++++++--------
 6 files changed, 331 insertions(+), 98 deletions(-)

Range-diff against v4:
1:  be14de68f6 = 1:  be14de68f6 builtin/repo: group per-type object values into struct
2:  0a145cfeec ! 2:  61cff22afa strbuf: split out logic to humanise byte values
    @@ Commit message
         In a subsequent commit, byte size values displayed in table output for
         the git-repo(1) "structure" subcommand will be shown in a more
         human-readable format with the appropriate unit prefixes. For this
    -    usecase, the downscaled values and unit prefixes must be handled
    +    usecase, the downscaled values and unit strings must be handled
         separately to ensure proper column alignment.
     
         Split out logic from strbuf_humanise() to downscale byte values and
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     +
     +	/*
     +	 * TRANSLATORS: The first argument is the number string. The second
    -+	 * argument is the unit prefix string (i.e. "12.34 MiB/s").
    ++	 * argument is the unit string (i.e. "12.34 MiB/s").
     +	 */
     +	strbuf_addf(buf, _("%s %s"), value, unit);
     +	free(value);
    @@ strbuf.h: void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbu
      
     +enum humanise_flags {
     +	/*
    -+	 * Use rate based unit prefixes for humanised values.
    ++	 * Use rate based units for humanised values.
     +	 */
     +	HUMANISE_RATE = (1 << 0),
     +};
     +
     +/**
     + * Converts the given byte size into a downscaled human-readable value and
    -+ * corresponding unit prefix as two separate strings.
    ++ * corresponding unit as two separate strings.
     + */
     +void humanise_bytes(off_t bytes, char **value, const char **unit,
     +		    unsigned flags);
3:  eebf0d917b ! 3:  0b575738c2 builtin/repo: humanise count values in structure output
    @@ strbuf.h: enum humanise_flags {
      
     +/**
     + * Converts the given count into a downscaled human-readable value and
    -+ * corresponding unit prefix as two separate strings.
    ++ * corresponding unit as two separate strings.
     + */
     +void humanise_count(size_t count, char **value, const char **unit);
     +
4:  37f71cc1bc ! 4:  e2c79c8759 builtin/repo: add inflated object info to keyvalue structure output
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
     +
     +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
     +						  OBJECT_INFO_SKIP_FETCH_OBJECT |
    -+							  OBJECT_INFO_QUICK) < 0)
    ++						  OBJECT_INFO_QUICK) < 0)
     +			continue;
     +
     +		inflated_total += inflated;
5:  40edf4c20b ! 5:  03219630cc builtin/repo: add inflated object info to structure table
    @@ strbuf.c: void humanise_bytes(off_t bytes, char **value, const char **unit,
     
      ## strbuf.h ##
     @@ strbuf.h: enum humanise_flags {
    - 	 * Use rate based unit prefixes for humanised values.
    + 	 * Use rate based units for humanised values.
      	 */
      	HUMANISE_RATE = (1 << 0),
     +	/*
    -+	 * Use compact "B" unit prefixes instead of "byte/bytes" for humanised
    ++	 * Use compact "B" unit symbol instead of "byte/bytes" for humanised
     +	 * values.
     +	 */
     +	HUMANISE_COMPACT = (1 << 1),
6:  ba861f37c9 = 6:  7d8862a064 builtin/repo: add disk size info to keyvalue stucture output
7:  3118c17ae3 ! 7:  3e2d5c20f8 builtin/repo: add object disk size info to structure table
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references
     -		cat >expect <<-\EOF &&
     +		# The tags disk size is handled specially due to the
     +		# git-rev-list(1) --disk-usage=human option printing the full
    -+		# "byte/bytes" unit prefix instead of just "B".
    ++		# "byte/bytes" unit string instead of just "B".
     +		cat >expect <<-EOF &&
      		| Repository structure | Value      |
      		| -------------------- | ---------- |

base-commit: e85ae279b0d58edc2f4c3fd5ac391b51e1223985
-- 
2.52.0.209.ge85ae279b0

