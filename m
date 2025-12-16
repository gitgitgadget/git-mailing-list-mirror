Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F92EB10
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906758; cv=none; b=llLDBp9H5X1g0jL7b2r4li4wlp5lF5PKBSXWAeT7UaDoq0hJBbTT7f+ktGygpyQeR+14XgvZON0hOD5eAykdtwV89bWMZ95Z1DDE+4wdZtElaAwTSXKqhELsvAHrtvsU8aA4ZmcEe7onCiLZYhD1mSE727wmLSRj/2cht/I0a3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906758; c=relaxed/simple;
	bh=Y7yH146XDqcyfna0E9x47Bq/jDF0P32pFNZpFEF0TNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0rP7Y37k3dDkVckNNtmKevJLSswwqykRzEoSRsKZslaQDlcU0L6b95z2xSTdPgplZ41dxk3qDBHKsrYM8q8iMcKbbIlNT2809G6rzoc2lvDs7VYP2TfcSuJ/37b+BqxO0lwSA1IYH8998UHkHNUuBmAhvZiPqOOkVqicnvUiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM48u5rb; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM48u5rb"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e8f418e051so3366010fac.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906755; x=1766511555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNBoneGLHoxpBp5mmzI/bb2fnRYo8+uKXrbOcrtu6Rg=;
        b=lM48u5rbyCI3lyUfwHrpKac6SJ4zfsldhAknurMzEe7U8s45yBnCGTHSKKJgycRgWe
         0SDdodO109O7JIGm9VYydy2l4Jrkd44KHMy0AG0IAXItWYp3yqBXdFYluK+czBlaRfJf
         PxB4fTwoimw+gdchGViB6LphNpvO0IjdpSuWM9MXbu6UNuS87FCQ4eoKL3CRdDjiggpu
         juy7+PFzN3KP7Nk4uJuUjsYeDhy2tWYHvPazKLrN2F+29W4clX3KgjuS1GmAiWz42hi4
         eyL9+iyEWJ8Zf1sn9bXXral1X7tb9x/IePId55e312yA7QY2nsLei7M82EHcNBSe3vmN
         7JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906755; x=1766511555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNBoneGLHoxpBp5mmzI/bb2fnRYo8+uKXrbOcrtu6Rg=;
        b=pMUZgqcUjrdYXwgk1VjPfxDSAGhhfvP5aHGLSAEO9xkUIdfocLMXYHdB/c9tVZpp1+
         1PbtWPNsnx1Brg2RcktaowH8r0X4v5PbyAy+5YcWV0O5RKGwWoX4KUQAvURdQWg2Ge7T
         kFGF7JEFVcR2KQLzHyREO25SjsmTh2Thqx7qzW7na1CCEYocBV4NW/8fpGcoavm8CzVV
         Y/bVPhWO3YPAWpnVNrM86Ac+L+d1C6PDMB3HUaaTJ6wUN6VdmSVP4aTZP/kY1LE5HzSD
         6PvFqBW/ULgH2t2dsODWQLuKsPCL+yWAYGze6ELoB5wayyaTXSmLxi2zJtUW7buByHoj
         FV/Q==
X-Gm-Message-State: AOJu0Yy4dqV3m41Pd7BVIIhlp1HKjaeaozBEU7bgCKqtiDN7VgCtqtF5
	rNQklPhW0qvv5za+vulD3FO9UEu12ns9P7bMfvkKzDJVRJH0eijS7GBeYtsWYQ==
X-Gm-Gg: AY/fxX5OO0tRa1w2jh/afVCD8RwKzKo846ZdNvvxsEjuOm/+nsmRvTYmDBIbQqSi23D
	2VHx9eA4xKK+RoccFmplFAULtVo6dQAqInckDpI9eN3OW7Qrn6vghE2M4NUWXggQ4xweLK/30yl
	f2G3a0P3khbooeSvbmr7HGU0et4kMZ6u0pV7PSZmQHYVmrBPjIl1tFqK8GtlWZWt0cR7fNpQHzm
	11/jmJkMGg5sk9o7GvWFZmIC1vY6s2y/vdWUyZ1SA5KFQo2KMGs6hg/9LqMnyGWN7Ch5i31HVt/
	QPhPNPVKq/1dnB0aR/MX+DZoBaBt2Y8huy5/sBrmefhCM2hnVI1s5uhxMPHKMVXqtN/+eFdzYAi
	6bR4AY/NuAPtTo81ZbQgp75yCF5Um0Ir4eMEsipJCLqg6D44cKqfBmiU9YUlUvUwAyHqfXtpW9l
	3WAK79TzOnn0S/OOZuywzkOTHvgAzv0w==
X-Google-Smtp-Source: AGHT+IE3HVUCng69K9hV/ttXPRWiLuwU+bV0DtvqXvAOm82lx6UM5Te2YN+/X3redJTLziffD9TzWA==
X-Received: by 2002:a05:6870:6591:b0:3e8:9537:f84c with SMTP id 586e51a60fabf-3f5f894ca41mr8068294fac.46.1765906754570;
        Tue, 16 Dec 2025 09:39:14 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:14 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/7] builtin/repo: add object size info to structure output
Date: Tue, 16 Dec 2025 11:38:35 -0600
Message-ID: <20251216173842.3357832-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
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

Range-diff against v3:
1:  be14de68f6 = 1:  be14de68f6 builtin/repo: group per-type object values into struct
2:  1fa33f5906 ! 2:  0a145cfeec strbuf: split out logic to humanise byte values
    @@ Commit message
         determine the corresponding unit prefix into a separate humanise_bytes()
         function that provides seperate value and unit strings.
     
    +    Note that the "byte" string in "t/helper/test-simple-ipc.c" is unmarked
    +    for translation here so that it doesn't conflict with the newly defined
    +    plural "byte/bytes" translation and instead uses it.
    +
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## strbuf.c ##
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     -					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
     -					Q_("%u byte/s", "%u bytes/s", bytes),
     -				(unsigned)bytes);
    -+		*value = xstrfmt(_("%u"), (unsigned)bytes);
    ++		*value = xstrfmt("%u", (unsigned)bytes);
     +		*unit = humanise_rate ?
     +			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
     +			       Q_("byte/s", "bytes/s", bytes) :
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     +	const char *unit;
     +
     +	humanise_bytes(bytes, &value, &unit, flags);
    ++
    ++	/*
    ++	 * TRANSLATORS: The first argument is the number string. The second
    ++	 * argument is the unit prefix string (i.e. "12.34 MiB/s").
    ++	 */
     +	strbuf_addf(buf, _("%s %s"), value, unit);
     +	free(value);
     +}
    @@ strbuf.h: void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbu
      /**
       * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
       * 3.50 MiB).
    +
    + ## t/helper/test-simple-ipc.c ##
    +@@ t/helper/test-simple-ipc.c: int cmd__simple_ipc(int argc, const char **argv)
    + 		OPT_INTEGER(0, "bytecount", &cl_args.bytecount, N_("number of bytes")),
    + 		OPT_INTEGER(0, "batchsize", &cl_args.batchsize, N_("number of requests per thread")),
    + 
    +-		OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
    ++		/*
    ++		 * The "byte" string here is not marked for translation and
    ++		 * instead relies on translation in strbuf.c:humanise_bytes() to
    ++		 * avoid conflict with the plural form.
    ++		 */
    ++		OPT_STRING(0, "byte", &bytevalue, "byte", N_("ballast character")),
    + 		OPT_STRING(0, "token", &cl_args.token, N_("token"), N_("command token to send to the server")),
    + 
    + 		OPT_END()
3:  8f09f6358e ! 3:  eebf0d917b builtin/repo: humanise count values in structure output
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     +		size_t x = count + 5000000; /* for rounding */
     +		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000000),
     +				 (unsigned)(x % 1000000000 / 10000000));
    ++		/* TRANSLATORS: SI decimal prefix symbol for 10^9 */
     +		*unit = _("G");
     +	} else if (count >= 1000000) {
     +		size_t x = count + 5000; /* for rounding */
     +		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000),
     +				 (unsigned)(x % 1000000 / 10000));
    ++		/* TRANSLATORS: SI decimal prefix symbol for 10^6 */
     +		*unit = _("M");
     +	} else if (count >= 1000) {
     +		size_t x = count + 5; /* for rounding */
     +		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000),
     +				 (unsigned)(x % 1000 / 10));
    ++		/* TRANSLATORS: SI decimal prefix symbol for 10^3 */
     +		*unit = _("k");
     +	} else {
    -+		*value = xstrfmt(_("%u"), (unsigned)count);
    ++		*value = xstrfmt("%u", (unsigned)count);
     +		*unit = NULL;
     +	}
     +}
4:  3f4eabe94f = 4:  37f71cc1bc builtin/repo: add inflated object info to keyvalue structure output
5:  85d1052100 ! 5:  40edf4c20b builtin/repo: add inflated object info to structure table
    @@ strbuf.c
     @@ strbuf.c: void humanise_bytes(off_t bytes, char **value, const char **unit,
      		*unit = humanise_rate ? _("KiB/s") : _("KiB");
      	} else {
    - 		*value = xstrfmt(_("%u"), (unsigned)bytes);
    + 		*value = xstrfmt("%u", (unsigned)bytes);
     -		*unit = humanise_rate ?
     -			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
     -			       Q_("byte/s", "bytes/s", bytes) :
     -			       /* TRANSLATORS: IEC 80000-13:2008 byte */
     -			       Q_("byte", "bytes", bytes);
     +		if (flags & HUMANISE_COMPACT)
    ++			/* TRANSLATORS: IEC 80000-13:2008 byte/second and byte */
     +			*unit = humanise_rate ? _("B/s") : _("B");
     +		else
     +			*unit = humanise_rate ?
6:  e9fa9babec = 6:  ba861f37c9 builtin/repo: add disk size info to keyvalue stucture output
7:  df542c7bdf ! 7:  3118c17ae3 builtin/repo: add object disk size info to structure table
    @@ t/t1901-repo-structure.sh: test_description='test git repo structure'
     -		--filter-provided-objects
     +	disk_usage_opt="--disk-usage"
     +
    -+	if [ "$2" = "true" ]; then
    ++	if test "$2" = "true"
    ++	then
     +		disk_usage_opt="--disk-usage=human"
     +	fi
     +
    -+	if [ "$1" = "all" ]; then
    ++	if test "$1" = "all"
    ++	then
     +		git rev-list --all --objects $disk_usage_opt
     +	else
     +		git rev-list --all --objects $disk_usage_opt \
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references
      		git notes add -m foo &&
      
     -		cat >expect <<-\EOF &&
    ++		# The tags disk size is handled specially due to the
    ++		# git-rev-list(1) --disk-usage=human option printing the full
    ++		# "byte/bytes" unit prefix instead of just "B".
     +		cat >expect <<-EOF &&
      		| Repository structure | Value      |
      		| -------------------- | ---------- |

base-commit: e85ae279b0d58edc2f4c3fd5ac391b51e1223985
-- 
2.52.0.209.ge85ae279b0

