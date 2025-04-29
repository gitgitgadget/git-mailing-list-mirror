Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306F22AE68
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949216; cv=none; b=e9YsJq7jsmpHoCPdZonBdAGmf/q6bN1ctfVRNJaxPvgNsEEYLL1sVaaAyDozcOei3COv8gS+f5M5MUX8+ev955gHXL5V/BYc2bzkFMPeonKlK9AuKuZsXvdmmmn9ExwZQj/1+bgKlDvvD7z7uZ8eMYr4X7qGK5Qrv09CLD12tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949216; c=relaxed/simple;
	bh=FhpTFFggUub4CWDn0jffmwlom2/UAUtnKG0P+LIHVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6YqFqoCW2ICE+tLS5yzUYxgyefEjGqpxW3wXE22haT3BOPWG/AZ8OwHE2OccTm+ck/Jk9bQFBZmKuj96WySpdpX1UMCLRPPMChHGoQC2UaY1VtgbIYp5CEnAjrEkjCncuTOBXZExLvu9LhUF7x2Rof5E/7H80kahWSG/hgu6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL7+IIjx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL7+IIjx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so47579435e9.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949212; x=1746554012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih2GvhU39MBV4pMAWM69MfX9bJkiWDcaLWiDZFX+vZg=;
        b=kL7+IIjxdIuGPpqkbIwNVRTNIKm21lr+N1bhb0XbXT7vEMn40tXef2SDcPX0FAtIzk
         NZYA11MUf4b1HQpUZQuiC0+RyL5HsToy/g2yozP2DRxvXbLPsCF8X201iwV8M0H7Al99
         7w/TJtCt1FBw44mo74niyX/amRm/4DnYwscEsLlNirk5RqtdZTDEJGpFytS0+vbaB85c
         4wwCQc+qlbJhGomMwo/8nTTuay+JqNWMHJfoZFTWOuKHmhEXaXmjCjs0AruRDyY8m3mf
         X/oA/oe0z1OFHwg7vmR/kIDIMpsa6h/tvzVYLo3ko3iKa0IqvpRvmMCncAlr3TWo6y2F
         BW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949212; x=1746554012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ih2GvhU39MBV4pMAWM69MfX9bJkiWDcaLWiDZFX+vZg=;
        b=sCTO8uiTPa6jGCFff+0dxEtZhPe1z31MiUqV4vTMwRz24nnNl3OWvEAr/9NH1zVByX
         nrX5uMLFoWh87hWj2Ler5x+pLKTrBnQ9H0jED39Ayu0suPrNAefOVuBnv3dymiQDUWuA
         b6tmQ5JWeh54JotSx/bXbmKgG7D50mcvFYCnI/LfwoEEqTMRgVGqYhzPIz4novedj4Jw
         WYLqx3JKglhT+ALzEWvX3Hn7oe/QPE1nwojKTjDaxn9eJxOGIedgxVc/9vlgCgL0AQ4m
         IENlLJhu98XGaQ2i1Q08lrl8cob1hHhHoLBY38SYNlQNYaVZkDa1ibkujDJnURYoK44P
         vGzA==
X-Gm-Message-State: AOJu0YyRJHqbOfzuBzbME74gq+qVGCyHrlREO2SH4RB3ekYXyjkygkvB
	wJMO4f99/gXgdDg3pmDnZ7tbhNrpSXoZjyfFznFpWY2yNAce5zbawyJQfniAA8eP7g==
X-Gm-Gg: ASbGncstnTogfI4ku8r13ergQauiNSwzIqoR+s+1W9bC4Ud+K5+SsR/fImFS9je/3s1
	VGO4eYZD6CwBAvL+Wfb3aWufU1Mxx6Ujb6Y3RW9TlOq8IIi3bGbEWFr8Raa4Vs4WNFZf8NoR2MA
	CsOg18z6JjnMAFSNaSpGU7f0hiXOZs191NrgLDk6kDvRW5mbax+bAYTAKUC67p4jvufVvybWZoT
	3qNdj1OHntTWCtFR3q06MlQrepuDRX8RAnk1KN0yDOd/5XbHWpPUHDB2jUBOh6qALdeC5chnumE
	sX0kF9N3IfwNl3lhd1bIZyTIBlHm+87q6SM=
X-Google-Smtp-Source: AGHT+IFqrMlUtzbZZDMeP6+OhCjyD+jBeZURjBiytLq94D1bnXsbX4o9gOeePfaVVaUKi98L8Ml6MA==
X-Received: by 2002:a05:6000:420e:b0:39e:f9ca:4359 with SMTP id ffacd0b85a97d-3a08f7a21a8mr245320f8f.30.1745949211680;
        Tue, 29 Apr 2025 10:53:31 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:31 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 00/10] t/unit-tests: convert unit-tests to use clar
Date: Tue, 29 Apr 2025 18:52:52 +0100
Message-ID: <20250429175302.23724-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series marks the final batch of our existing unit test
files transitioned to the Clar testing framework. It covers all the
reftable-related test files, and is part of our ongoing effort to
standardize our testing framework to enhance its maintainability.

Changes in v2:
 - some code refactoring based on review, which includes 
 temporary relocation of reftable helper functions to 
 t/unit-tests/unit-test.{c,h} files in the initial commit

Thanks
Seyi

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (10):
  t/unit-tests: implement reftable test helper functions in
    unit-test.{c,h}
  t/unit-tests: convert reftable basics test to use clar test framework
  t/unit-tests: convert reftable block test to use clar
  t/unit-tests: convert reftable merged test to use clar
  t/unit-tests: convert reftable pq test to use clar
  t/unit-tests: convert reftable reader test to use clar
  t/unit-tests: convert reftable readwrite test to use clar
  t/unit-tests: convert reftable record test to use clar
  t/unit-tests: convert reftable stack test to use clar
  t/unit-tests: adapt lib-reftable{c,h} helper functions to clar

 Makefile                            |   20 +-
 t/meson.build                       |   21 +-
 t/unit-tests/lib-reftable.c         |   26 +-
 t/unit-tests/lib-reftable.h         |    6 +-
 t/unit-tests/t-reftable-basics.c    |  219 ----
 t/unit-tests/t-reftable-block.c     |  383 -------
 t/unit-tests/t-reftable-merged.c    |  546 ----------
 t/unit-tests/t-reftable-pq.c        |  161 ---
 t/unit-tests/t-reftable-reader.c    |   96 --
 t/unit-tests/t-reftable-readwrite.c |  985 ------------------
 t/unit-tests/t-reftable-record.c    |  585 -----------
 t/unit-tests/t-reftable-stack.c     | 1451 ---------------------------
 t/unit-tests/u-reftable-basics.c    |  195 ++++
 t/unit-tests/u-reftable-block.c     |  373 +++++++
 t/unit-tests/u-reftable-merged.c    |  515 ++++++++++
 t/unit-tests/u-reftable-pq.c        |  152 +++
 t/unit-tests/u-reftable-reader.c    |   78 ++
 t/unit-tests/u-reftable-readwrite.c |  870 ++++++++++++++++
 t/unit-tests/u-reftable-record.c    |  565 +++++++++++
 t/unit-tests/u-reftable-stack.c     | 1247 +++++++++++++++++++++++
 20 files changed, 4031 insertions(+), 4463 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 delete mode 100644 t/unit-tests/t-reftable-block.c
 delete mode 100644 t/unit-tests/t-reftable-merged.c
 delete mode 100644 t/unit-tests/t-reftable-pq.c
 delete mode 100644 t/unit-tests/t-reftable-reader.c
 delete mode 100644 t/unit-tests/t-reftable-readwrite.c
 delete mode 100644 t/unit-tests/t-reftable-record.c
 delete mode 100644 t/unit-tests/t-reftable-stack.c
 create mode 100644 t/unit-tests/u-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-block.c
 create mode 100644 t/unit-tests/u-reftable-merged.c
 create mode 100644 t/unit-tests/u-reftable-pq.c
 create mode 100644 t/unit-tests/u-reftable-reader.c
 create mode 100644 t/unit-tests/u-reftable-readwrite.c
 create mode 100644 t/unit-tests/u-reftable-record.c
 create mode 100644 t/unit-tests/u-reftable-stack.c

Range-diff against v1:
 -:  ---------- >  1:  d85c5694ca t/unit-tests: implement reftable test helper functions in unit-test.{c,h}
 2:  4c5fc06603 !  2:  d24faa0176 t/unit-tests: convert reftable basics test to use clar test framework
    @@ Makefile: CLAR_TEST_SUITES += u-oid-array
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-basics
      UNIT_TEST_PROGRAMS += t-reftable-block
 3:  c9bdff8290 !  3:  d9eb47645b t/unit-tests: convert reftable block test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-oidmap
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-block
      UNIT_TEST_PROGRAMS += t-reftable-merged
 4:  60e2ff8bca !  4:  6ffc7cdfc6 t/unit-tests: convert reftable merged test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-oidtree
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-merged
      UNIT_TEST_PROGRAMS += t-reftable-pq
 5:  b06520b033 !  5:  19b08968a0 t/unit-tests: convert reftable pq test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-prio-queue
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-pq
      UNIT_TEST_PROGRAMS += t-reftable-reader
 6:  8b8ad57ff5 !  6:  b34d6714ed t/unit-tests: convert reftable reader test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-reftable-basics
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-reader
      UNIT_TEST_PROGRAMS += t-reftable-readwrite
 7:  da73e8c85b !  7:  05c909ea94 t/unit-tests: convert reftable readwrite test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-reftable-block
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-readwrite
      UNIT_TEST_PROGRAMS += t-reftable-record
 8:  ac6fd74321 !  8:  1515cf15b7 t/unit-tests: convert reftable record test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-reftable-merged
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-record
      UNIT_TEST_PROGRAMS += t-reftable-stack
 9:  5bc6a599c6 !  9:  dcbb2b6e56 t/unit-tests: convert reftable stack test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-reftable-pq
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-stack
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
    - 
    + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
 1:  304d17fef8 ! 10:  79aa0145aa t/unit-tests: adapt lib-reftable{c,h} helper functions to clar
    @@ Commit message
         Adapt functions in lib-reftable.{c,h} to use clar. These functions
         conform with the clar testing framework and become available for all
         reftable-related test files implemented using the clar testing
    -    framework, which requires them. This will be used by subsequent commits.
    +    framework, which requires them. This change migrates the helper
    +    functions back into `lib-reftable.{c,h}`.
     
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
    @@ Makefile: CLAR_TEST_SUITES += u-urlmatch-normalization
     +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
     +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      
    - UNIT_TEST_PROGRAMS += t-reftable-basics
    - UNIT_TEST_PROGRAMS += t-reftable-block
    -@@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-record
    - UNIT_TEST_PROGRAMS += t-reftable-stack
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
     -UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    @@ t/unit-tests/lib-reftable.h
      			     struct reftable_ref_record *refs,
      			     size_t nrecords,
      			     struct reftable_log_record *logs,
    +
    + ## t/unit-tests/unit-test.c ##
    +@@
    + #include "unit-test.h"
    + #include "hex.h"
    + #include "parse-options.h"
    +-#include "reftable/constants.h"
    +-#include "reftable/writer.h"
    + #include "strbuf.h"
    + #include "string-list.h"
    + #include "strvec.h"
    + 
    +-void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
    +-{
    +-	memset(p, (uint8_t)i, hash_size(id));
    +-}
    +-
    +-static ssize_t strbuf_writer_write(void *b, const void *data, size_t sz)
    +-{
    +-	strbuf_add(b, data, sz);
    +-	return sz;
    +-}
    +-
    +-static int strbuf_writer_flush(void *arg UNUSED)
    +-{
    +-	return 0;
    +-}
    +-
    +-struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
    +-						 struct reftable_write_options *opts)
    +-{
    +-	struct reftable_writer *writer;
    +-	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
    +-				      buf, opts);
    +-	cl_assert(ret == 0);
    +-	return writer;
    +-}
    +-
    +-void cl_reftable_write_to_buf(struct reftable_buf *buf,
    +-			     struct reftable_ref_record *refs,
    +-			     size_t nrefs,
    +-			     struct reftable_log_record *logs,
    +-			     size_t nlogs,
    +-			     struct reftable_write_options *_opts)
    +-{
    +-	struct reftable_write_options opts = { 0 };
    +-	const struct reftable_stats *stats;
    +-	struct reftable_writer *writer;
    +-	uint64_t min = 0xffffffff;
    +-	uint64_t max = 0;
    +-	int ret;
    +-
    +-	if (_opts)
    +-		opts = *_opts;
    +-
    +-	for (size_t i = 0; i < nrefs; i++) {
    +-		uint64_t ui = refs[i].update_index;
    +-		if (ui > max)
    +-			max = ui;
    +-		if (ui < min)
    +-			min = ui;
    +-	}
    +-	for (size_t i = 0; i < nlogs; i++) {
    +-		uint64_t ui = logs[i].update_index;
    +-		if (ui > max)
    +-			max = ui;
    +-		if (ui < min)
    +-			min = ui;
    +-	}
    +-
    +-	writer = cl_reftable_strbuf_writer(buf, &opts);
    +-	reftable_writer_set_limits(writer, min, max);
    +-
    +-	if (nrefs) {
    +-		ret = reftable_writer_add_refs(writer, refs, nrefs);
    +-		cl_assert_equal_i(ret, 0);
    +-	}
    +-
    +-	if (nlogs) {
    +-		ret = reftable_writer_add_logs(writer, logs, nlogs);
    +-		cl_assert_equal_i(ret, 0);
    +-	}
    +-
    +-	ret = reftable_writer_close(writer);
    +-	cl_assert_equal_i(ret, 0);
    +-
    +-	stats = reftable_writer_stats(writer);
    +-	for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++) {
    +-		size_t off = i * (opts.block_size ? opts.block_size
    +-						  : DEFAULT_BLOCK_SIZE);
    +-		if (!off)
    +-			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
    +-		cl_assert(buf->buf[off] == 'r');
    +-	}
    +-
    +-	if (nrefs)
    +-		cl_assert(stats->ref_stats.blocks > 0);
    +-	if (nlogs)
    +-		cl_assert(stats->log_stats.blocks > 0);
    +-
    +-	reftable_writer_free(writer);
    +-}
    +-
    + static const char * const unit_test_usage[] = {
    + 	N_("unit-test [<options>]"),
    + 	NULL,
    +
    + ## t/unit-tests/unit-test.h ##
    +@@
    + #include "git-compat-util.h"
    + #include "clar/clar.h"
    + #include "clar-decls.h"
    +-#include "git-compat-util.h"
    +-#include "reftable/reftable-writer.h"
    + #include "strbuf.h"
    + 
    +-struct reftable_buf;
    +-
    +-void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
    +-
    +-struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
    +-						 struct reftable_write_options *opts);
    +-
    +-void cl_reftable_write_to_buf(struct reftable_buf *buf,
    +-			     struct reftable_ref_record *refs,
    +-			     size_t nrecords,
    +-			     struct reftable_log_record *logs,
    +-			     size_t nlogs,
    +-			     struct reftable_write_options *opts);
    +-
    + #define cl_failf(fmt, ...) do { \
    + 	char desc[4096]; \
    + 	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
-- 
2.43.0

