Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205311F461
	for <e@80x24.org>; Wed, 10 Jul 2019 23:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGJX7X (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 19:59:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42145 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGJX7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 19:59:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so3376397qkm.9
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 16:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JiFZb2cYmuomelQ4BaUmCgBZN3bkJilalhm/txHTUW0=;
        b=U7ONMNcsafUCdKL6j6LUlm3IUgD4xpibX4wcRss1OhrN2tizw52IrtWmGh8FZ3goLI
         PR2VPakRuvK25tnr6f3/8L9zizokrPdE8nK+zHurQdUPWCGw+MjKW9FM8iGYwUON1xFY
         QvmKrk/AsdCDzoL+tsNdwVypr3q2h7GPnBTSFTxVR+ny4u+8lJpHdfEA8tlH1o4sSTwd
         86VFJDAi+B/d0mQ7ye2ifkQjhqCovvzltAPIDsWh/NK0dRU0swsiGQ19gBs2b3zLefd0
         doUmTlM24YQSOJGWSrBqFjdaUt4weFITlYqLTwwpQWn3G/aJIoyI7+yxFI+y5l6SC+S0
         9c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiFZb2cYmuomelQ4BaUmCgBZN3bkJilalhm/txHTUW0=;
        b=t8x8pF4/3D/6VoPhys6L5VduqPSn6LeCphNTsYop/565ew2Ti16CX7qk3FPGLgZeQe
         KvhGX1X9zaDOzeOAoJbQxVTzZ4t2UWIvr2YY50VRwPYjP0ACo24OZHpQnJmMqWpvZBPw
         LTDlmc/1bslk/T7IHwaGbXRLVN5xLS12yL5kUdi4rbBbSnlMFo4q7NU09WaF8PaP3gl8
         F1/3ieNevW7krAOKSmeSPMr/wafQmUwKTlVe9/KwTcRHKOor/uESifp8VdKIQA4jliB6
         PYAqvO5MSsVAJXojbSbXwZrPuROhu5oPnKQD2t1ejbfiZzWkvNV/0lpX5oQQucJVXo/V
         3rGA==
X-Gm-Message-State: APjAAAWQ/w8RroSSjcXrL9b7RggGRIEWYexoHgnB6OgyN6yrZiqDxIoa
        JGSZpdWv0mVhfHLlpeBw/Lqv8w==
X-Google-Smtp-Source: APXvYqydxOthCDRTQ4356WSLUybNaupp/yj8nqE6crSuJ/W0iwTjf4E0N4Qf7MaMHkHB2f1BMGM9Yg==
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr715194qkc.361.1562803161054;
        Wed, 10 Jul 2019 16:59:21 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.16.59.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 16:59:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v8 00/10] clone: dir-iterator refactoring with tests
Date:   Wed, 10 Jul 2019 20:58:54 -0300
Message-Id: <cover.1562801254.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset contains:
- tests to the dir-iterator API;
- dir-iterator refactoring to make its state machine simpler
  and feature adding with tests;
- a replacement of explicit recursive dir iteration at
  copy_or_link_directory for the dir-iterator API;
- some refactoring and behavior changes at local clone, mainly to
  take care of symlinks and hidden files at .git/objects, together
  with tests for these types of files.

Changes since v7[1]:
- Applied some style fixes at tests, as suggested by SZEDER
- Removed the code to find circular symlinks as suggested in this[2]
thread. The way it was previously implemented wouldn't work on Windows.
So Dscho suggested me to remove this section until we come up with a
more portable implementation.

[1]: https://public-inbox.org/git/cover.1560898723.git.matheus.bernardino@usp.br/
[2]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet/
travis build: https://travis-ci.org/matheustavares/git/builds/557047597

Daniel Ferreira (1):
  dir-iterator: add tests for dir-iterator API

Matheus Tavares (8):
  clone: better handle symlinked files at .git/objects/
  dir-iterator: use warning_errno when possible
  dir-iterator: refactor state machine model
  dir-iterator: add flags parameter to dir_iterator_begin
  clone: copy hidden paths at local clone
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal
  clone: replace strcmp by fspathcmp

Ævar Arnfjörð Bjarmason (1):
  clone: test for our behavior on odd objects/* content

 Makefile                     |   1 +
 builtin/clone.c              |  75 +++++-----
 dir-iterator.c               | 263 ++++++++++++++++++++---------------
 dir-iterator.h               |  64 +++++++--
 refs/files-backend.c         |  17 ++-
 t/helper/test-dir-iterator.c |  58 ++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0066-dir-iterator.sh      | 148 ++++++++++++++++++++
 t/t5604-clone-reference.sh   | 133 ++++++++++++++++++
 10 files changed, 597 insertions(+), 164 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0066-dir-iterator.sh

Range-diff against v7:
 1:  437b1eb1c7 !  1:  a2016d9d3b clone: test for our behavior on odd objects/* content
    @@ -98,7 +98,7 @@
     +		mv $last_loose a-loose-dir &&
     +		ln -s a-loose-dir $last_loose &&
     +		find . -type f | sort >../../../T.objects-files.raw &&
    -+		echo unknown_content> unknown_file
    ++		echo unknown_content >unknown_file
     +	) &&
     +	git -C T fsck &&
     +	git -C T rev-list --all --objects >T.objects
 2:  108bea2652 !  2:  47a4f9b31c clone: better handle symlinked files at .git/objects/
    @@ -80,7 +80,7 @@
     +		cd ../ &&
      		find . -type f | sort >../../../T.objects-files.raw &&
     +		find . -type l | sort >../../../T.objects-symlinks.raw &&
    - 		echo unknown_content> unknown_file
    + 		echo unknown_content >unknown_file
      	) &&
      	git -C T fsck &&
     @@
 3:  2c0232be6c !  3:  bbce6a601b dir-iterator: add tests for dir-iterator API
    @@ -129,7 +129,7 @@
     +	EOF
     +
     +	test-tool dir-iterator ./dir >out &&
    -+	sort <out >./actual-iteration-sorted-output &&
    ++	sort out >./actual-iteration-sorted-output &&
     +
     +	test_cmp expected-iteration-sorted-output actual-iteration-sorted-output
     +'
 4:  0b76044165 =  4:  0cc5f1f0b4 dir-iterator: use warning_errno when possible
 5:  44c47d579c !  5:  f871b5d3f4 dir-iterator: refactor state machine model
    @@ -340,14 +340,14 @@
       * A typical iteration looks like this:
       *
       *     int ok;
    -  *     struct iterator *iter = dir_iterator_begin(path);
    -  *
    +- *     struct iterator *iter = dir_iterator_begin(path);
    ++ *     struct dir_iterator *iter = dir_iterator_begin(path);
    ++ *
     + *     if (!iter)
     + *             goto error_handler;
    -+ *
    +  *
       *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
       *             if (want_to_stop_iteration()) {
    -  *                     ok = dir_iterator_abort(iter);
     @@
      };
      
 6:  86fc04ad0e !  6:  fe838d7eb4 dir-iterator: add flags parameter to dir_iterator_begin
    @@ -22,16 +22,6 @@
      diff --git a/dir-iterator.c b/dir-iterator.c
      --- a/dir-iterator.c
      +++ b/dir-iterator.c
    -@@
    - struct dir_iterator_level {
    - 	DIR *dir;
    - 
    -+	/* The inode number of this level's directory. */
    -+	ino_t ino;
    -+
    - 	/*
    - 	 * The length of the directory part of path at this level
    - 	 * (including a trailing '/'):
     @@
      	 * that will be included in this iteration.
      	 */
    @@ -51,10 +41,6 @@
      static int push_level(struct dir_iterator_int *iter)
      {
     @@
    - 	if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
    - 		strbuf_addch(&iter->base.path, '/');
    - 	level->prefix_len = iter->base.path.len;
    -+	level->ino = iter->base.st.st_ino;
      
      	level->dir = opendir(iter->base.path.buf);
      	if (!level->dir) {
    @@ -96,33 +82,17 @@
     +		err = stat(iter->base.path.buf, &iter->base.st);
     +	else
     +		err = lstat(iter->base.path.buf, &iter->base.st);
    -+
    + 
    +-	return 0;
     +	saved_errno = errno;
     +	if (err && errno != ENOENT)
     +		warning_errno("failed to stat '%s'", iter->base.path.buf);
     +
     +	errno = saved_errno;
     +	return err;
    -+}
    -+
    -+/*
    -+ * Look for a recursive symlink at iter->base.path pointing to any directory on
    -+ * the previous stack levels. If it is found, return 1. If not, return 0.
    -+ */
    -+static int find_recursive_symlinks(struct dir_iterator_int *iter)
    -+{
    -+	int i;
    -+
    -+	if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
    -+	    !S_ISDIR(iter->base.st.st_mode))
    -+		return 0;
    - 
    -+	for (i = 0; i < iter->levels_nr; ++i)
    -+		if (iter->base.st.st_ino == iter->levels[i].ino)
    -+			return 1;
    - 	return 0;
      }
      
    + int dir_iterator_advance(struct dir_iterator *dir_iterator)
     @@
      	struct dir_iterator_int *iter =
      		(struct dir_iterator_int *)dir_iterator;
    @@ -165,12 +135,6 @@
     +			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
     +				goto error_out;
      			continue;
    -+		}
    -+
    -+		if (find_recursive_symlinks(iter)) {
    -+			warning("ignoring recursive symlink at '%s'",
    -+				iter->base.path.buf);
    -+			continue;
     +		}
      
      		return ITER_OK;
    @@ -207,7 +171,7 @@
       * A typical iteration looks like this:
       *
       *     int ok;
    -- *     struct iterator *iter = dir_iterator_begin(path);
    +- *     struct dir_iterator *iter = dir_iterator_begin(path);
     + *     unsigned int flags = DIR_ITERATOR_PEDANTIC;
     + *     struct dir_iterator *iter = dir_iterator_begin(path, flags);
       *
    @@ -230,9 +194,12 @@
     + * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks.
     + *   i.e., linked directories' contents will be iterated over and
     + *   iter->base.st will contain information on the referred files,
    -+ *   not the symlinks themselves, which is the default behavior.
    -+ *   Recursive symlinks are skipped with a warning and broken symlinks
    -+ *   are ignored.
    ++ *   not the symlinks themselves, which is the default behavior. Broken
    ++ *   symlinks are ignored.
    ++ *
    ++ * Warning: circular symlinks are also followed when
    ++ * DIR_ITERATOR_FOLLOW_SYMLINKS is set. The iteration may end up with
    ++ * an ELOOP if they happen and DIR_ITERATOR_PEDANTIC is set.
     + */
     +#define DIR_ITERATOR_PEDANTIC (1 << 0)
     +#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
    @@ -383,7 +350,7 @@
     +	EOF
     +
     +	mkdir -p dir3/a &&
    -+	> dir3/a/b &&
    ++	>dir3/a/b &&
     +	chmod 0 dir3/a &&
     +
     +	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
    @@ -399,7 +366,7 @@
     +	EOF
     +
     +	mkdir -p dir3/a &&
    -+	> dir3/a/b &&
    ++	>dir3/a/b &&
     +	chmod 0 dir3/a &&
     +
     +	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
    @@ -435,7 +402,7 @@
     +	EOF
     +
     +	test-tool dir-iterator ./dir4 >out &&
    -+	sort <out >actual-no-follow-sorted-output &&
    ++	sort out >actual-no-follow-sorted-output &&
     +
     +	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
     +'
    @@ -452,24 +419,9 @@
     +	EOF
     +
     +	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
    -+	sort <out >actual-follow-sorted-output &&
    ++	sort out >actual-follow-sorted-output &&
     +
     +	test_cmp expected-follow-sorted-output actual-follow-sorted-output
     +'
    -+
    -+
    -+test_expect_success SYMLINKS 'dir-iterator should ignore recursive symlinks w/ follow flag' '
    -+	cat >expected-rec-symlinks-sorted-output <<-EOF &&
    -+	[d] (a) [a] ./dir5/a
    -+	[d] (a/b) [b] ./dir5/a/b
    -+	[d] (a/b/d) [d] ./dir5/a/b/d
    -+	[d] (a/c) [c] ./dir5/a/c
    -+	EOF
    -+
    -+	test-tool dir-iterator --follow-symlinks ./dir5 >out &&
    -+	sort <out >actual-rec-symlinks-sorted-output &&
    -+
    -+	test_cmp expected-rec-symlinks-sorted-output actual-rec-symlinks-sorted-output
    -+'
     +
      test_done
 7:  17685057cd =  7:  3da6408e04 clone: copy hidden paths at local clone
 8:  c7f3a8640e =  8:  af7430eb2c clone: extract function from copy_or_link_directory
 9:  7934036d30 !  9:  e8308c7408 clone: use dir-iterator to avoid explicit dir traversal
    @@ -11,11 +11,7 @@
         error on readdir or stat inside dir_iterator_advance. Previously it
         would just print a warning for errors on stat and ignore errors on
         readdir, which isn't nice because a local git clone could succeed even
    -    though the .git/objects copy didn't fully succeed. Also, with the
    -    dir-iterator API, recursive symlinks will be detected and skipped. This
    -    is another behavior improvement, since the current version would
    -    continue to copy the same content over and over until stat() returned an
    -    ELOOP error.
    +    though the .git/objects copy didn't fully succeed.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
10:  2e25c03c07 = 10:  782ca07eed clone: replace strcmp by fspathcmp
-- 
2.22.0

