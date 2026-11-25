Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640158;
	b=iWsnw9xCGAxIMblL6sTm1EKW7sZzjemO57mCa1Hg23RcYKYp1/iFO8WVF5wLZ1Go4gYr
	 SbbOEAAI3jAlXxYK8sLd9ewUdt06cI2h5dHyGNT58KKEm4D5E9lDld6kUJXbEcKq0r2Mc
	 PXQ7Fp4A+zanpuMe+lgGVCF3Uo3BDCr3vZ/3FHctonJOqLLB6ZoCZcEJgOtOnYcLoL+/3
	 4QrMUncCd4Z1G4eHvLvUb9NOD08/zeROdxX+/5YsYGAH4JAzg7jVDsM/IXJFUhS5fKQUD
	 Ll8LVO19xDyb695TamoJBqNSymHMn/OL7rFVOd5nDeccVtH7H1x7MhziqqXFmAaWVtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=5ZgVg5YHqqxD+8SAsRgc7iwK9RSXJdl23ulw7rhGZAE=;
	b=RnTieG97G3yAnmjd8nWqXs63NMB2sydnHQ1kK0uTPEP823iNbqETRDrGJAM2Eezx6s0s
	 agt2whiybKKmEIQWKnFo5WdvNzcOS/Vi/QntPgSW4CxXS47elF2+CDTjA+puqTb98uRUo
	 lIUywQFIe6qqHTDRZ316iIolDVYAjfO20pP1ihrbG1qzp3xMRrjE8/arF8m4e4ZVpXi2t
	 cMup1AoKL/VCm8b3huA08XDk4OcTQnD0mRVIkPEzs41KYxZDYFWR17ArXjGSXxVrIxR2o
	 rgAI6ajtGHxTSR6FRNCAAYpm0ne/V4x+66I7wKvHjrRotaLAed94D97enPyPWvCaQaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INJJfWwP;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E9606A33A
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C86E9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INJJfWwP
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71ad099391dso3069803eaf.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795640152; x=1796244952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ZgVg5YHqqxD+8SAsRgc7iwK9RSXJdl23ulw7rhGZAE=;
        b=INJJfWwPbNVtGXUd7YFohMOiXq/t7BAAR6BvOjtXXwfEgKU06/EQUodO112nUsGqLs
         qmu0liic2O+wcuWZeeyago5Bd27FZOVdQ2Ajx2mlDARC6zTHOs7APps1JwshRsF2e+ff
         K7zcbf8we9GSO6YCY3GPi1iH2AOvy/RwAkJ7Zybd25uN4WGGgaQzf2IB4R08YMZvX+uu
         sLinXev/mjjvcXPbDzfQCe1FxiOzjnFx8QlObCIXryz6ianztvi593hglwBRVUNO6x3X
         0aHgXzq/nR1U2ZwQWGdGTOO+dOcrDHKKnspOdBd/VqO1Fcyp6G3Ii/g+1oiGPGdS6suu
         rZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640152; x=1796244952;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZgVg5YHqqxD+8SAsRgc7iwK9RSXJdl23ulw7rhGZAE=;
        b=L11GybpB2E4NtFI2rWvglns3mWoGH0dTKtSBQQ882zgtj3GqgAR6i8+oQ6OQEgrpTR
         hr7AiN3sA8iiu1rr9DVZqXbM9JoQytj8uJ2+8ehpibltQqtg3FNilB0EYF+NWddd3/sD
         GCcElh6Z04IhVo77eCWsjFyBhMKhKl261qSoed8mS0wTSLGevK3P8O/HhvUDrMnTFXPf
         mxrUemUhNtTAhY2HcqLUognQ0cP63jqg6nG9LDoRn0oUcd5QpL5Xw4aZ0w2XcmDRgrDb
         hxevhjAw8l8Xll73ORg4xHUP2hHOLfqAQfmCJVRYICNB9KEDEvkoJt3qpUGmyHyjDYNU
         l94A==
X-Gm-Message-State: APuU4Z9VVIxpsd7kn55S8WLEF7Gekk9eZLL/1RCPAmzkZEuz+wb1tSak
	rowhR6MSixuqvDRFeiSew5dmL8f6JxZSR9CZjZYAVaNqdBxpoHUJvthK750QmA==
X-Gm-Gg: AZFdTZceLwu4ArI5daCHlPxDFpvhNKYZrSth7j/FBZAGJm+Mj+Otvbh9bFb3pZ8hZq/
	00dF+PeAMc7Xewk+AV6FPI82H6B0geL6j5YY9RIYiovEgl2h/X8eBbWdxN69mTs7vJqfjq+TkG0
	uar2ve6tnTZEjHPDE1cMscn3ihgq54bHr/j9DHoP2HF5SiBYzoRqncipxxD0DwspFxh0cSqx+P9
	xGhiow89FSmMnUg9Hex8t2EzkJyVU7XBu+2AFimTSnI6cLqn3X/MCI9CPpjD6/QALbbPqCuIcMj
	VbZO+CHMTuDQsI+MDZjJ/+8zhOnV78ksuzIgwL+YiF+j2zo1A0UhppElflMO7F1Wfb092gdIhrg
	JW+obb9253LFFtlKn/rnVhuJwXQeVciKcbkol993PnQhnZtHp7E8mlIkQZd9r/V1F4Hi6vDFGiV
	RFsQGH76DufEb8/+qDxZhYvvoRKqvZflOAP9AtN3MnZlBM7nbOIH+v3zfx3/YeO709VJ4qOV0OF
	kFaNolk1ZVBsOSLGsYUvjMsYOSVRRPT/YimWoUz2f0hsoSNZg4yGaPkEiE0B1hs+8xhAz0MQ6qz
	mZtpQhMaWA578Qd1rLDnFCSVOYHz/iyv
X-Received: by 2002:a05:6820:83cb:20b0:71a:f86d:a44a with SMTP id 006d021491bc7-71b395993ebmr10290128eaf.82.1795640152518;
        Wed, 25 Nov 2026 12:55:52 -0800 (PST)
Received: from [127.0.0.1] ([132.196.38.97])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631670c44dsm13476571a34.0.2026.11.25.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:55:51 -0800 (PST)
Message-Id: <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 20:55:44 +0000
Subject: [PATCH v3 0/5] Address overflows pointed out by Coverity
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is part of my effort to bring Git for Windows' Coverity
reports down to zero; Previous patch series have been merged in 347fe8a91b5
(Merge branch 'js/coverity-fixes', 2026-07-16), 0b75ef5168c (Merge branch
'js/coverity-fixes-null-safety', 2026-07-19), fcc8c931b53 (Merge branch
'js/coverity-unchecked-returns-fix', 2026-08-24) and 8bc9c7fcfd8 (Merge
branch 'js/coverity-fixes', 2026-10-03).

Changes since v2:

 * Fixed a grammar error and an overstatement in the "Changes since v1"
   section :-)
 * Accepted Junio's rewritten explanation in 2/5's commit message.
 * Clarified the design decision to abort on programing errors in 4/5's
   commit message.
 * Adjusted a few straggler ssize_t variables that can now safely be int or
   even be dropped.

Changes since v1:

 * Five callers of read_in_full() and all callers of write_in_full() are now
   no longer restricted by the range of ssize_t.
 * The signed_mult_overflows() and mult_overflows() macros have been
   dropped.
 * Since the approxidate() function only deals with non-negative values, the
   complicated overflow check could have been simplified.
 * Rebased to master, to avoid merge conflicts.

Johannes Schindelin (5):
  archive-tar: guard get_path_prefix against zero-length input
  http: use `size_t` for byte position in fwrite_sha1_file
  wrapper: avoid byte-count overflow in write_in_full()
  wrapper: add read_in_full_or_error()
  date: avoid overflow in approxidate relative-time multiplication

 Makefile                        |  1 +
 archive-tar.c                   |  2 +
 builtin/blame.c                 |  2 +-
 combine-diff.c                  |  6 +-
 config.c                        | 14 ++---
 date.c                          | 26 +++++++--
 dir.c                           |  2 +-
 entry.c                         |  2 +-
 grep.c                          |  2 +-
 http.c                          |  2 +-
 imap-send.c                     |  2 +-
 notes-merge.c                   | 13 +----
 odb/streaming.c                 |  6 +-
 parallel-checkout.c             |  2 +-
 refs/packed-backend.c           |  4 +-
 strbuf.c                        | 10 +++-
 t/meson.build                   |  1 +
 t/t0006-date.sh                 | 13 +++++
 t/unit-tests/u-reftable-stack.c |  2 +-
 t/unit-tests/u-wrapper.c        | 99 +++++++++++++++++++++++++++++++++
 wrapper.c                       | 56 ++++++++++++++-----
 wrapper.h                       | 14 ++++-
 22 files changed, 218 insertions(+), 63 deletions(-)
 create mode 100644 t/unit-tests/u-wrapper.c


base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2253%2Fdscho%2Fcoverity-fixes-overflow-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2253/dscho/coverity-fixes-overflow-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2253

Range-diff vs v2:

 1:  bb8225547f = 1:  bb8225547f archive-tar: guard get_path_prefix against zero-length input
 2:  38cc1dec53 ! 2:  aa2d3961b2 http: use `size_t` for byte position in fwrite_sha1_file
     @@ Metadata
       ## Commit message ##
          http: use `size_t` for byte position in fwrite_sha1_file
      
     -    The `fwrite_sha1_file()` function tracks the number of bytes written via
     -    an `int` variable, but the total size to write is of type `size_t`. When
     -    the HTTP response body exceeds INT_MAX (~2GB), this causes an overflow
     -    and a heap under-read, then writes that data to the local object file.
     -
     -    The hash check afterward would reject the corrupt object (so no bad data
     -    enters the object store), but the under-read itself could leak adjacent
     -    heap contents to the temporary file. In practice this is unlikely
     -    because curl delivers data in small chunks (typically 16KB per callback
     -    invocation), so in practice, the total size is far below INT_MAX in a
     -    single call. However, the function interface accepts arbitrary sizes,
     -    and the accumulation across the loop means that the `int` variable grows
     -    across calls within a single invocation, not across callbacks.
     -
     -    Change the type from `int` to `size_t` to match the type of the total
     -    size. This is a hardening fix: the attack surface (a malicious HTTP
     -    server triggering a >2GB single-callback delivery) is theoretical under
     -    normal curl configurations, but the type mismatch is a genuine defect.
     +    The `fwrite_sha1_file()` function tracks the number of bytes written
     +    during a single invocation in an `int` variable (`posn`), even though
     +    the buffer length `size = eltsize * nmemb` has type `size_t`. If a
     +    caller or callback ever passed more than `INT_MAX` bytes in a single
     +    call, `posn` could overflow and wrap negative, causing `(char *)ptr +
     +    posn` to under-read the buffer. While curl delivers data in small
     +    chunks in practice, matching the variable type to `size` avoids the
     +    defect.
      
          Pointed out by Coverity.
      
          Helped-by: Patrick Steinhardt <ps@pks.im>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Assisted-by: GPT-6 Luna
          Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 3:  b24520c50d ! 3:  f38c7e7133 wrapper: avoid byte-count overflow in write_in_full()
     @@ Makefile: CLAR_TEST_SUITES += u-strvec
       CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
       CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      
     + ## config.c ##
     +@@ config.c: static struct strbuf store_create_section(const char *key,
     + 	return sb;
     + }
     + 
     +-static ssize_t write_section(int fd, const char *key,
     +-			     const struct config_store_data *store)
     ++static int write_section(int fd, const char *key,
     ++			 const struct config_store_data *store)
     + {
     + 	struct strbuf sb = store_create_section(key, store);
     +-	ssize_t ret;
     ++	int ret;
     + 
     + 	ret = write_in_full(fd, sb.buf, sb.len);
     + 	strbuf_release(&sb);
     +@@ config.c: static ssize_t write_section(int fd, const char *key,
     + 	return ret;
     + }
     + 
     +-static ssize_t write_pair(int fd, const char *key, const char *value,
     +-			  const char *comment,
     +-			  const struct config_store_data *store)
     ++static int write_pair(int fd, const char *key, const char *value,
     ++		      const char *comment,
     ++		      const struct config_store_data *store)
     + {
     + 	int i;
     +-	ssize_t ret;
     ++	int ret;
     + 	const char *quote = "";
     + 	struct strbuf sb = STRBUF_INIT;
     + 
     +
     + ## entry.c ##
     +@@ entry.c: static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
     + 	char *new_blob;
     + 	struct strbuf buf = STRBUF_INIT;
     + 	size_t size;
     +-	ssize_t wrote;
     ++	int wrote;
     + 	size_t newsize = 0;
     + 	struct stat st;
     + 	const struct submodule *sub;
     +
       ## imap-send.c ##
      @@ imap-send.c: static int socket_write(struct imap_socket *sock, const char *buf, int len)
       		n = SSL_write(sock->ssl, buf, len);
     @@ notes-merge.c: static void write_buf_to_worktree(const struct object_id *obj,
       	close(fd);
       	free(path);
      
     + ## odb/streaming.c ##
     +@@ odb/streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
     + 		goto close_and_exit;
     + 	for (;;) {
     + 		char buf[1024 * 16];
     +-		ssize_t wrote, holeto;
     ++		ssize_t holeto;
     + 		ssize_t readlen = odb_stream_read(st, buf, sizeof(buf));
     + 
     + 		if (readlen < 0)
     +@@ odb/streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
     + 			goto close_and_exit;
     + 		else
     + 			kept = 0;
     +-		wrote = write_in_full(fd, buf, readlen);
     +-
     +-		if (wrote < 0)
     ++		if (write_in_full(fd, buf, readlen) < 0)
     + 			goto close_and_exit;
     + 	}
     + 	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
     +
     + ## parallel-checkout.c ##
     +@@ parallel-checkout.c: static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
     + 	struct strbuf buf = STRBUF_INIT;
     + 	char *blob;
     + 	size_t size;
     +-	ssize_t wrote;
     ++	int wrote;
     + 
     + 	/* Sanity check */
     + 	ASSERT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
     +
       ## t/meson.build ##
      @@ t/meson.build: clar_test_suites = [
         'unit-tests/u-trailer.c',
 4:  ca30ed613d ! 4:  d45982f1cc wrapper: add read_in_full_or_error()
     @@ Commit message
          that returns a Boolean to indicate success or faiure.
      
          Callers that do need to know that byte count can still call
     -    `read_in_full()`, but will now error out early if the requested byte
     -    count exceeds what `ssize_t` can represent.
     +    `read_in_full()`, but will now abort to signal a programming error when
     +    the requested byte count exceeds what `ssize_t` can represent.
      
          Pointed out by Coverity.
      
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     -    Assisted-by: GPT-6.1
     +    Assisted-by: GPT-6.1 and GPT-6 Luna
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/blame.c ##
 5:  6057734709 = 5:  23ec6cf8f0 date: avoid overflow in approxidate relative-time multiplication

-- 
gitgitgadget
