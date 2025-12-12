Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EF254AE1
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579012; cv=none; b=Yfo5pxJScneZVPOWyLAgK2TE2JWap6mWbNt26AZtK8Mwecsy+3MabD/9gre3Wd1e/GOawDlotpolvTiL3bODROjzvznEHS4iDmDgvyFED8F2qWi5lVElWkDzZsNqpiw44teqf62MwFkLc+PNh+Ib2mitNGt2YiNS+FKNME0gIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579012; c=relaxed/simple;
	bh=L781huXuB7LJB+b7LWjmsnbh2pBFLe9HptNY2Wslh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7AFWAcd2e7JL4Mp3S1G1dwxVWXI6LmX7r1jrKhNxRqBoomMAHId9LpakV0MYz9cbhjLCmf4o5XCGonoaEzuXSX3lQGhRb8kue/82XyfCxH8q4N0lsjCh4u5Q8tZIiw4j7+ZPbL56YetcCkfP/8nHWlFUwMVDI4sTAk1vNpPWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKc4FQsG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKc4FQsG"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e8f418e051so1197392fac.3
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579008; x=1766183808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlXlvo9V1JwGWj9ymajd4FytmrqpgJyc7Iw5tvwqLsg=;
        b=KKc4FQsGP3RnPzn8LA/F850pwaxMZnQpuKE/miyI6ptY0fXf/wsKHuL1RciwwKeDsQ
         r3s3mJu2OyqNSxBlHCYbgRbq1Q4GEpjI+VjFU9kbyKDGrd80d/TImdb+tMNU9+L05U2e
         2HBxBxARMEikwrIhJJmkisGPFpfA7V0JLmOXQLJPRV37l8E0ErZ5dsHgqr2/yJAJdHBH
         q4TZKrsSeF4VlMZef60hAX7BYIholGCk9tSH3bePZBqrXq7NKlAE/rhss1PZCSyFVSGu
         ovqqd1JZzsxQTEJgcxJiIvCHkL3zvDH88GwJp6sBO03QoKxzY8twRUuytNdGlTSS4Rb9
         2wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579008; x=1766183808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlXlvo9V1JwGWj9ymajd4FytmrqpgJyc7Iw5tvwqLsg=;
        b=xHZn/uoHhaEq16azgrEaZRCSD6Z/HXGafz3115azrrFOm71EY3kauwkY3mM9t7AqRI
         x888ySIFpPq1BZaX3tQ2/e9SPGCEFA5jsKW+rigpsjnXEB0WyXXbKX2jMedrxIiurVxE
         0cKaVTZCGJp7v9riZYjVY8CWbIfCQudsrKfZW7EQ8oWac77kmkUYqgZk6z3XVUQronVx
         T8C/pEi7OXuGotQ4AGWmJzCps++MEq0QLFFAn0vmW3clb25DCHxfRmJxA5YeMsx0LVm6
         6JNHKaKx6ZlwT33cGH8Qy0HgTyy2VxHVUHUIuuV6mPTeczVTQV3zfk2B7WyrUmMgDCRU
         y4Eg==
X-Gm-Message-State: AOJu0YwnURWN3ixUuCUflQy2RVD7nidaa6KmY+P+yvTslHUAkp2sp0ky
	O1caEi1bzRKv0UFFmhf+GsSR9dsFXNpevN1dskTbSeKhz00TuoI9Q/QgmWF+Wg==
X-Gm-Gg: AY/fxX7WfG0xd/qOR/yVMoj/YB4W6GOyVDhENwT0cUguDLebyzMJjrd27Wj7CUsAWFS
	3nYljeSNj9bP8+kmX/SZSOQyiH5z9BreqUq4pp4Z9923woqC69TYfmRvKDMZkp3zaYqX8XWOxkO
	jWRVeOq3h6+jUoCtwRI4BbJJbPrIfrwPCplbeWvh50LNE6ClbxRA4/joA4NpMs1H9WcrByYY2op
	dx7Buo+9qWT4RLWVjaYTqESS6ToAJDXNaXoD+xLL2uKGSNttvqoIWKrB30atRBwGmbJW4cTAOXi
	ipLVRCPZ/e8ZYbwBcC6twoWmIpiYM0Z6x/lASuhqYser4hS8kxMXcOe7FvtAcvHkxi5T2cFVIRa
	jLiY+D1eJ1QRf9mjN2ZpY1bRSlg5MJLCD9ryCwV8USxbjyzsqqGWQmJe7wKE9GzKClBzozFwIkL
	Jvq1I/6ULx9M8xI6lOzXQ=
X-Google-Smtp-Source: AGHT+IH9UHQ5M99bH6yyA7r8UnjMCJCzWAc6+WwZ4z1AKtOllAq/gCM5D7USFaM9aFRVNTCQJCKi6w==
X-Received: by 2002:a05:6870:2489:b0:3ec:2fa7:8180 with SMTP id 586e51a60fabf-3f5f838e275mr2159166fac.0.1765579008023;
        Fri, 12 Dec 2025 14:36:48 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:47 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/7] builtin/repo: add object size info to structure output
Date: Fri, 12 Dec 2025 16:36:37 -0600
Message-ID: <20251212223644.3090879-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251209225820.2861276-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
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
 builtin/repo.c              | 185 ++++++++++++++++++++++++++++++------
 strbuf.c                    |  89 ++++++++++-------
 strbuf.h                    |  17 ++++
 t/t1901-repo-structure.sh   | 110 ++++++++++++++-------
 5 files changed, 304 insertions(+), 99 deletions(-)

Range-diff against v1:
1:  bd3f1e6ec6 = 1:  be14de68f6 builtin/repo: group per-type object values into struct
6:  bce4c7b5f1 ! 2:  5ca6f9b708 builtin/repo: add object disk size info to structure table
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    builtin/repo: add object disk size info to structure table
    +    strbuf: split out logic to humanise byte values
     
    -    Similar to a prior commit, update the table output format for the
    -    git-repo(1) structure commdn to display the total object disk usage by
    -    object type.
    -
    -    Since disk size may vary between platforms, tests do not validate actual
    -    values and only check that size info is printed in an empty repository.
    +    In a subsequent commit, byte size values displayed in table output for
    +    the git-repo(1) "structure" subcommand will be shown in a more
    +    human-readable format with the appropriate unit prefixes. For this
    +    usecase, the downscaled values and unit prefixes must be handled
    +    separately to ensure proper column alignment. Refactor strbuf_humanise()
    +    to instead append the downscaled byte value to the buffer only and
    +    return the appropriate unit prefix string.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    - ## builtin/repo.c ##
    -@@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
    - 	struct ref_stats *refs = &stats->refs;
    - 	size_t inflated_object_total;
    - 	size_t object_count_total;
    -+	size_t disk_object_total;
    - 	size_t ref_total;
    + ## strbuf.c ##
    +@@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
    + 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
    + }
      
    - 	ref_total = get_total_reference_count(refs);
    -@@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
    - 			      "    * %s", _("Blobs"));
    - 	stats_table_size_addf(table, objects->inflated_sizes.tags,
    - 			      "    * %s", _("Tags"));
    +-static void strbuf_humanise(struct strbuf *buf, off_t bytes,
    +-				 int humanise_rate)
    ++char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
    + {
    ++	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
     +
    -+	disk_object_total = get_total_object_values(&objects->disk_sizes);
    -+	stats_table_size_addf(table, disk_object_total,
    -+			      "  * %s", _("Disk size"));
    -+	stats_table_size_addf(table, objects->disk_sizes.commits,
    -+			      "    * %s", _("Commits"));
    -+	stats_table_size_addf(table, objects->disk_sizes.trees,
    -+			      "    * %s", _("Trees"));
    -+	stats_table_size_addf(table, objects->disk_sizes.blobs,
    -+			      "    * %s", _("Blobs"));
    -+	stats_table_size_addf(table, objects->disk_sizes.tags,
    -+			      "    * %s", _("Tags"));
    + 	if (bytes > 1 << 30) {
    +-		strbuf_addf(buf,
    +-				humanise_rate == 0 ?
    +-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
    +-					_("%u.%2.2u GiB") :
    +-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
    +-					_("%u.%2.2u GiB/s"),
    +-			    (unsigned)(bytes >> 30),
    ++		strbuf_addf(buf, "%u.%2.2u", (unsigned)(bytes >> 30),
    + 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
    ++		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
    ++		return humanise_rate ? xstrfmt(_("GiB/s")) : xstrfmt(_("GiB"));
    + 	} else if (bytes > 1 << 20) {
    +-		unsigned x = bytes + 5243;  /* for rounding */
    +-		strbuf_addf(buf,
    +-				humanise_rate == 0 ?
    +-					/* TRANSLATORS: IEC 80000-13:2008 mebibyte */
    +-					_("%u.%2.2u MiB") :
    +-					/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second */
    +-					_("%u.%2.2u MiB/s"),
    +-			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
    ++		unsigned x = bytes + 5243; /* for rounding */
    ++		strbuf_addf(buf, "%u.%2.2u", x >> 20,
    ++			    ((x & ((1 << 20) - 1)) * 100) >> 20);
    ++		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second and mebibyte */
    ++		return humanise_rate ? xstrfmt(_("MiB/s")) : xstrfmt(_("MiB"));
    + 	} else if (bytes > 1 << 10) {
    +-		unsigned x = bytes + 5;  /* for rounding */
    +-		strbuf_addf(buf,
    +-				humanise_rate == 0 ?
    +-					/* TRANSLATORS: IEC 80000-13:2008 kibibyte */
    +-					_("%u.%2.2u KiB") :
    +-					/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second */
    +-					_("%u.%2.2u KiB/s"),
    +-			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
    ++		unsigned x = bytes + 5; /* for rounding */
    ++		strbuf_addf(buf, "%u.%2.2u", x >> 10,
    ++			    ((x & ((1 << 10) - 1)) * 100) >> 10);
    ++		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second and kibibyte */
    ++		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
    + 	} else {
    +-		strbuf_addf(buf,
    +-				humanise_rate == 0 ?
    +-					/* TRANSLATORS: IEC 80000-13:2008 byte */
    +-					Q_("%u byte", "%u bytes", bytes) :
    +-					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
    +-					Q_("%u byte/s", "%u bytes/s", bytes),
    +-				(unsigned)bytes);
    ++		strbuf_addf(buf, "%u", (unsigned)bytes);
    ++		return humanise_rate ?
    ++			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
    ++			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
    ++			       /* TRANSLATORS: IEC 80000-13:2008 byte */
    ++			       xstrfmt(Q_("byte", "bytes", bytes));
    + 	}
      }
      
    - static void stats_table_print_structure(const struct stats_table *table)
    -
    - ## t/t1901-repo-structure.sh ##
    -@@ t/t1901-repo-structure.sh: test_description='test git repo structure'
    - 
    - . ./test-lib.sh
    + void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
    + {
    +-	strbuf_humanise(buf, bytes, 0);
    ++	char *unit = strbuf_humanise_bytes_value(buf, bytes, 0);
    ++	strbuf_addf(buf, " %s", unit);
    ++	free(unit);
    + }
      
    -+strip_object_disk_usage() {
    -+	awk '
    -+		/^\|   \* Disk size/ { skip=1; next }
    -+		skip && /^\|     \* / { next }
    -+		skip && !/^\|     \* / { skip=0 }
    -+		{ print }
    -+	' $1
    -+}
    -+
    - test_expect_success 'empty repository' '
    - 	test_when_finished "rm -rf repo" &&
    - 	git init repo &&
    -@@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
    - 		|     * Trees          |    0 B |
    - 		|     * Blobs          |    0 B |
    - 		|     * Tags           |    0 B |
    -+		|   * Disk size        |    0 B |
    -+		|     * Commits        |    0 B |
    -+		|     * Trees          |    0 B |
    -+		|     * Blobs          |    0 B |
    -+		|     * Tags           |    0 B |
    - 		EOF
    + void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
    + {
    +-	strbuf_humanise(buf, bytes, 1);
    ++	char *unit = strbuf_humanise_bytes_value(buf, bytes, STRBUF_HUMANISE_RATE);
    ++	strbuf_addf(buf, " %s", unit);
    ++	free(unit);
    + }
      
    - 		git repo structure >out 2>err &&
    -@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references and objects' '
    - 		|     * Tags           |    132 B   |
    - 		EOF
    + int printf_ln(const char *fmt, ...)
    +
    + ## strbuf.h ##
    +@@ strbuf.h: void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
    +  */
    + void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
      
    --		git repo structure >out 2>err &&
    -+		git repo structure >out.raw 2>err &&
    ++#define STRBUF_HUMANISE_RATE 1 << 0
     +
    -+		# Skip object disk sizes due to platform variance.
    -+		strip_object_disk_usage out.raw >out &&
    - 
    - 		test_cmp expect out &&
    - 		test_line_count = 0 err
    ++/**
    ++ * Append the given byte size as a human-readable string that is downscaled by
    ++ * some factor. A string with the corresponding unit prefix is returned
    ++ * separately.
    ++ */
    ++char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags);
    ++
    + /**
    +  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
    +  * 3.50 MiB).
2:  3f56d52cd9 ! 3:  2efc3533ef builtin/repo: humanise count values in structure output
    @@ builtin/repo.c: struct stats_table {
       */
      struct stats_table_entry {
      	char *value;
    -+	const char *unit;
    ++	char *unit;
      };
      
      static void stats_table_vaddf(struct stats_table *table,
    @@ builtin/repo.c: static void stats_table_vaddf(struct stats_table *table,
      }
      
      static void stats_table_addf(struct stats_table *table, const char *format, ...)
    -@@ builtin/repo.c: static void stats_table_addf(struct stats_table *table, const char *format, ...)
    - 	va_end(ap);
    - }
    - 
    -+static const char *unit_k = "k";
    -+static const char *unit_M = "M";
    -+static const char *unit_G = "G";
    -+
    - static void stats_table_count_addf(struct stats_table *table, size_t value,
    +@@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, size_t value,
      				   const char *format, ...)
      {
    -@@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, size_t value,
    + 	struct stats_table_entry *entry;
    ++	struct strbuf buf = STRBUF_INIT;
      	va_list ap;
      
      	CALLOC_ARRAY(entry, 1);
     -	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
     +
    -+	if (value >= 1000000000) {
    -+		uintmax_t x = (uintmax_t)value + 5000000;
    -+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
    -+				       x / 1000000000,
    -+				       x % 1000000000 / 10000000);
    -+		entry->unit = unit_G;
    -+	} else if (value >= 1000000) {
    -+		uintmax_t x = (uintmax_t)value + 5000;
    -+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
    -+				       x / 1000000, x % 1000000 / 10000);
    -+		entry->unit = unit_M;
    -+	} else if (value >= 1000) {
    -+		uintmax_t x = (uintmax_t)value + 5;
    -+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
    -+				       x / 1000, x % 1000 / 10);
    -+		entry->unit = unit_k;
    -+	} else {
    -+		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
    -+	}
    ++	entry->unit = strbuf_humanise_count_value(&buf, value);
    ++	entry->value = strbuf_detach(&buf, NULL);
      
      	va_start(ap, format);
      	stats_table_vaddf(table, entry, format, ap);
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
      		strbuf_addstr(&buf, " |");
      		printf("%s\n", buf.buf);
      	}
    +@@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
    + 
    + 	for_each_string_list_item(item, &table->rows) {
    + 		entry = item->util;
    +-		if (entry)
    ++		if (entry) {
    + 			free(entry->value);
    ++			free(entry->unit);
    ++		}
    + 	}
    + 
    + 	string_list_clear(&table->rows, 1);
    +
    + ## strbuf.c ##
    +@@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
    + 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
    + }
    + 
    ++char *strbuf_humanise_count_value(struct strbuf *buf, size_t value)
    ++{
    ++	if (value >= 1000000000) {
    ++		uintmax_t x = (uintmax_t)value + 5000000; /* for rounding */
    ++		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
    ++			    x / 1000000000, x % 1000000000 / 10000000);
    ++		return xstrfmt(_("G"));
    ++	} else if (value >= 1000000) {
    ++		uintmax_t x = (uintmax_t)value + 5000; /* for rounding */
    ++		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
    ++			    x / 1000000, x % 1000000 / 10000);
    ++		return xstrfmt(_("M"));
    ++	} else if (value >= 1000) {
    ++		uintmax_t x = (uintmax_t)value + 5; /* for rounding */
    ++		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
    ++			    x / 1000, x % 1000 / 10);
    ++		return xstrfmt(_("k"));
    ++	} else {
    ++		strbuf_addf(buf, "%" PRIuMAX, (uintmax_t)value);
    ++		return NULL;
    ++	}
    ++}
    ++
    + char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
    + {
    + 	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
    +
    + ## strbuf.h ##
    +@@ strbuf.h: void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
    +  */
    + char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags);
    + 
    ++/**
    ++ * Append the given count value as a human-readable string that is downsacled by
    ++ * some factor. A string with the corresponding unit prefix is returned
    ++ * separately.
    ++ */
    ++char *strbuf_humanise_count_value(struct strbuf *buf, size_t value);
    ++
    + /**
    +  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
    +  * 3.50 MiB).
     
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
3:  594bd320d1 ! 4:  627b8bf025 builtin/repo: add inflated object info to keyvalue structure output
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
      	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
      	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
      
    -+	printf("objects.commits.inflated%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
    -+	printf("objects.trees.inflated%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
    -+	printf("objects.blobs.inflated%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.blobs.inflated_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
    -+	printf("objects.tags.inflated%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
     +
      	fflush(stdout);
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
     +
     +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
     +						  OBJECT_INFO_FOR_PREFETCH) < 0)
    -+			die(_("cannot read object for %s"),
    -+			    oid_to_hex(&oids->oid[i]));
    ++			continue;
     +
     +		inflated_total += inflated;
     +	}
    @@ t/t1901-repo-structure.sh: test_expect_success 'keyvalue and nul format' '
      		objects.trees.count=42
      		objects.blobs.count=42
      		objects.tags.count=1
    -+		objects.commits.inflated=9225
    -+		objects.trees.inflated=28554
    -+		objects.blobs.inflated=453
    -+		objects.tags.inflated=132
    ++		objects.commits.inflated_size=9225
    ++		objects.trees.inflated_size=28554
    ++		objects.blobs.inflated_size=453
    ++		objects.tags.inflated_size=132
      		EOF
      
      		git repo structure --format=keyvalue >out 2>err &&
4:  3406b1ed90 ! 5:  14f4983e1d builtin/repo: add inflated object info to structure table
    @@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, si
      	va_end(ap);
      }
      
    -+static const char *unit_B = "B";
    -+static const char *unit_KiB = "KiB";
    -+static const char *unit_MiB = "MiB";
    -+static const char *unit_GiB = "GiB";
    -+
     +static void stats_table_size_addf(struct stats_table *table, size_t value,
     +				  const char *format, ...)
     +{
     +	struct stats_table_entry *entry;
    ++	struct strbuf buf = STRBUF_INIT;
     +	va_list ap;
     +
     +	CALLOC_ARRAY(entry, 1);
     +
    -+	if (value > 1 << 30) {
    -+		uintmax_t x = (uintmax_t)value + 5368709;
    -+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 30,
    -+				       ((x & ((1 << 30) - 1)) * 100) >> 30);
    -+		entry->unit = unit_GiB;
    -+	} else if (value > 1 << 20) {
    -+		uintmax_t x = (uintmax_t)value + 5243;
    -+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 20,
    -+				       ((x & ((1 << 20) - 1)) * 100) >> 20);
    -+		entry->unit = unit_MiB;
    -+	} else if (value > 1 << 10) {
    -+		uintmax_t x = (uintmax_t)value + 5;
    -+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 10,
    -+				       ((x & ((1 << 10) - 1)) * 100) >> 10);
    -+		entry->unit = unit_KiB;
    -+	} else {
    -+		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
    -+		entry->unit = unit_B;
    -+	}
    ++	entry->unit = strbuf_humanise_bytes_value(&buf, value,
    ++						  STRBUF_HUMANISE_COMPACT);
    ++	entry->value = strbuf_detach(&buf, NULL);
     +
     +	va_start(ap, format);
     +	stats_table_vaddf(table, entry, format, ap);
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      
      static void stats_table_print_structure(const struct stats_table *table)
     
    + ## strbuf.c ##
    +@@ strbuf.c: char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flag
    + 		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
    + 	} else {
    + 		strbuf_addf(buf, "%u", (unsigned)bytes);
    ++		if (flags & STRBUF_HUMANISE_COMPACT)
    ++			return humanise_rate ?
    ++				       xstrfmt(_("B/s")) :
    ++				       xstrfmt(_("B"));
    + 		return humanise_rate ?
    + 			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
    + 			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
    +
    + ## strbuf.h ##
    +@@ strbuf.h: void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
    +  */
    + void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
    + 
    +-#define STRBUF_HUMANISE_RATE 1 << 0
    ++#define STRBUF_HUMANISE_RATE	1 << 0
    ++#define STRBUF_HUMANISE_COMPACT 1 << 1
    + 
    + /**
    +  * Append the given byte size as a human-readable string that is downscaled by
    +
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      		| Repository structure | Value  |
5:  48461ac6a0 ! 6:  dc9e82889f builtin/repo: add disk size info to keyvalue stucture output
    @@ Commit message
         the git-repo(1) structure command to additionally provide info regarding
         total object disk sizes by object type.
     
    -    Since disk size may vary between platforms, tests do not validate actual
    -    values and only check that size info is printed in an empty repository.
    -
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## Documentation/git-repo.adoc ##
    @@ builtin/repo.c: struct object_values {
      
      struct repo_structure {
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 	printf("objects.tags.inflated%c%" PRIuMAX "%c", key_delim,
    + 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
      	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
      
    -+	printf("objects.commits.disk%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
    -+	printf("objects.trees.disk%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
    -+	printf("objects.blobs.disk%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
    -+	printf("objects.tags.disk%c%" PRIuMAX "%c", key_delim,
    ++	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
     +	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
     +
      	fflush(stdout);
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      
      		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
      						  OBJECT_INFO_FOR_PREFETCH) < 0)
    -@@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_array *oids,
    - 			    oid_to_hex(&oids->oid[i]));
    + 			continue;
      
      		inflated_total += inflated;
     +		disk_total += disk;
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      		BUG("invalid object type");
     
      ## t/t1901-repo-structure.sh ##
    -@@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
    - 		git repo structure >out 2>err &&
    +@@ t/t1901-repo-structure.sh: test_description='test git repo structure'
      
    - 		test_cmp expect out &&
    -+		test_line_count = 0 err &&
    -+
    -+		cat >expect <<-\EOF &&
    -+		references.branches.count=0
    -+		references.tags.count=0
    -+		references.remotes.count=0
    -+		references.others.count=0
    -+		objects.commits.count=0
    -+		objects.trees.count=0
    -+		objects.blobs.count=0
    -+		objects.tags.count=0
    -+		objects.commits.inflated=0
    -+		objects.trees.inflated=0
    -+		objects.blobs.inflated=0
    -+		objects.tags.inflated=0
    -+		objects.commits.disk=0
    -+		objects.trees.disk=0
    -+		objects.blobs.disk=0
    -+		objects.tags.disk=0
    -+		EOF
    -+
    -+		git repo structure --format=keyvalue >out 2>err &&
    -+
    -+		test_cmp expect out &&
    -+		test_line_count = 0 err &&
    -+
    -+		# Replace key and value delimiters for nul format.
    -+		tr "\n=" "\0\n" <expect >expect_nul &&
    -+		git repo structure --format=nul >out 2>err &&
    -+
    -+		test_cmp expect_nul out &&
    - 		test_line_count = 0 err
    - 	)
    - '
    -@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references and objects' '
    - 	)
    - '
    + . ./test-lib.sh
      
    --test_expect_success SHA1 'keyvalue and nul format' '
    -+test_expect_success SHA1 'keyvalue format' '
    ++object_type_disk_usage() {
    ++	git cat-file --batch-check='%(objectsize:disk)' --batch-all-objects \
    ++		--filter=object:type=$1 | awk '{ sum += $1 } END { print sum }'
    ++}
    ++
    + test_expect_success 'empty repository' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
    - 	(
     @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'keyvalue and nul format' '
    - 		objects.tags.inflated=132
    - 		EOF
    + 		test_commit_bulk 42 &&
    + 		git tag -a foo -m bar &&
      
    --		git repo structure --format=keyvalue >out 2>err &&
    -+		git repo structure --format=keyvalue >out.raw 2>err &&
    - 
    --		test_cmp expect out &&
    --		test_line_count = 0 err &&
    -+		# Strip object disk usage from output due to platform variance.
    -+		grep -v "objects\..*\.disk=" out.raw >out &&
    +-		cat >expect <<-\EOF &&
    ++		cat >expect <<-EOF &&
    + 		references.branches.count=1
    + 		references.tags.count=1
    + 		references.remotes.count=0
    +@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'keyvalue and nul format' '
    + 		objects.trees.inflated_size=28554
    + 		objects.blobs.inflated_size=453
    + 		objects.tags.inflated_size=132
    ++		objects.commits.disk_size=$(object_type_disk_usage commit)
    ++		objects.trees.disk_size=$(object_type_disk_usage tree)
    ++		objects.blobs.disk_size=$(object_type_disk_usage blob)
    ++		objects.tags.disk_size=$(object_type_disk_usage tag)
    + 		EOF
      
    --		# Replace key and value delimiters for nul format.
    --		tr "\n=" "\0\n" <expect >expect_nul &&
    --		git repo structure --format=nul >out 2>err &&
    --
    --		test_cmp expect_nul out &&
    -+		test_cmp expect out &&
    - 		test_line_count = 0 err
    - 	)
    - '
    + 		git repo structure --format=keyvalue >out 2>err &&
-:  ---------- > 7:  213b19dc7f builtin/repo: add object disk size info to structure table

base-commit: e85ae279b0d58edc2f4c3fd5ac391b51e1223985
-- 
2.52.0.209.ge85ae279b0

