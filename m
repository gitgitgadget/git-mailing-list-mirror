Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176E41F453
	for <e@80x24.org>; Thu,  2 May 2019 14:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEBOsn (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:48:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38222 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:48:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so2785661qth.5
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7Wu6U0reyXcBU1pXGi9734Uq48dT44qPHDvlvTXVIU=;
        b=NA8MXx/BdWwYRcLZbMVmnzB9w812SEqpH7nGU7pRXZWfgcYbg59qo29mBevhNbye1T
         yMQrI5w02wLDzThE4cKq4MeA2iBS1KVy6mp15DnqiOporOqx1k3uehuWVH9wgLm68uF4
         VNy5T6JYyDcBSYfsnlCLNPWhiM4kUKuE7BpmTNMEloZIHGMKel4ZxsjeM6/ifFr6dx7z
         fR4nVgsfPVKVpXO8fhTGgP7YJVD+9bJUYZqNrkm+w64uYBAgH4GlF7YbUpiKCbvHI61L
         U/BsBdgjTioJfa2s6cZ6lln6Y6HrCNXgWAfc3hckhvbK7hHmkvGK27+i7EdqsFHJoLdE
         /23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7Wu6U0reyXcBU1pXGi9734Uq48dT44qPHDvlvTXVIU=;
        b=JqKDryChNBtBuwm2U5MEXLFXDPwx5jc8xnLul8W+UxFpoVaJl8GHcQD7Av2cXgz0lS
         JB02ffBD5e4gBeT1c3LTdWmyQEEyc1szOzNq0Yt/Y8lWKSP51pVt3MOP6xT9JWwG6o7k
         IHpzJJd+HsUyMleXprtyMLb6gIC/21hSecmGvbtblQChnVhkUPxYtjEbyMmk2/GYs8q2
         ogYq+DqzvkQcvx/fAxaC4kw7wTi11hqz7kqaPlftS5vrJIBOWVp4L8sQ9RJmEMmWFE3z
         dfM1+jmqXT/iMLYW17XKU0SnpZK3KjUPocN5HvCOg8aSEj22rWA/odToQQUpQRXC1VFU
         1E0w==
X-Gm-Message-State: APjAAAVE9gYjFYi3lMYDDQSNtUToJN1l5OwF3VVSw+gvOLurNqlTtbNo
        x7zQE5/h0CInZL2YTqU1Yw/kOoctvFA=
X-Google-Smtp-Source: APXvYqyRZi1y/zRxGP3zGmg26Pt/z+zhoaH3Am80QrGJx87lEnkMjSNPETDO4nDZhj3f1gc7doDqPg==
X-Received: by 2002:ac8:396e:: with SMTP id t43mr3482436qtb.1.1556808520787;
        Thu, 02 May 2019 07:48:40 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:48:40 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v6 00/10] clone: dir-iterator refactoring with tests
Date:   Thu,  2 May 2019 11:48:19 -0300
Message-Id: <20190502144829.4394-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset contains:
- a replacement of explicit recursive dir iteration at
  copy_or_link_directory for the dir-iterator API;
- some refactoring and behaviour changes at local clone, mainly to
  take care of symlinks and hidden files at .git/objects, together
  with tests for this types of files.
- dir-iterator refactoring and feature adding with tests.

Changes since v5:
- Add tests for the dir-iterator API
- Refactor the dir-iterator state machine model, simplifying its
  mechanics to improve readability.
- Change warning() to warning_errno() at dir-iterator.c
- Add a recursive symlinks check for dir_iterator_advance() in order
  to avoid unwanted recursions with DIR_ITERATOR_FOLLOW_SYMLIKS
- Add tests for the dir-iterator flags feature
- Make warnings be emitted both when DIR_ITERATOR_PEDANTIC is
  supplied and when it's not. It contains more relevant information
  on the error, so I thought it should be always printed.
- Make dir_iterator_begin() check if the given argument is a valid
  path to a directory.
- Adjusted some minor codestyle problems and commit messages
- Address Thomas comments in v5

v5: https://public-inbox.org/git/20190330224907.3277-1-matheus.bernardino@usp.br/
travis build: https://travis-ci.org/MatheusBernardino/git/builds/527176611

Note: I tried to use --range-diff as Thomas suggested but I'm not sure
the output is as desired. Please, let me know if I did something wrong
using it.

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
 builtin/clone.c              |  75 +++++----
 dir-iterator.c               | 289 +++++++++++++++++++++--------------
 dir-iterator.h               |  59 +++++--
 refs/files-backend.c         |  17 ++-
 t/helper/test-dir-iterator.c |  58 +++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0066-dir-iterator.sh      | 163 ++++++++++++++++++++
 t/t5604-clone-reference.sh   | 133 ++++++++++++++++
 10 files changed, 634 insertions(+), 163 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0066-dir-iterator.sh

Range-diff against v5:
 1:  3d422dd4de =  1:  a630b1a129 clone: test for our behavior on odd objects/* content
 2:  35819e6ed1 !  2:  51e06687fc clone: better handle symlinked files at .git/objects/
    @@ -45,10 +45,7 @@
      			die_errno(_("failed to unlink '%s'"), dest->buf);
      		if (!option_no_hardlinks) {
     -			if (!link(src->buf, dest->buf))
    -+			char *resolved_path = real_pathdup(src->buf, 1);
    -+			int status = link(resolved_path, dest->buf);
    -+			free(resolved_path);
    -+			if (!status)
    ++			if (!link(real_path(src->buf), dest->buf))
      				continue;
      			if (option_local > 0)
      				die_errno(_("failed to create link '%s'"), dest->buf);
 3:  2afe3208a4 <  -:  ---------- dir-iterator: add flags parameter to dir_iterator_begin
 -:  ---------- >  3:  c8a860e3a5 dir-iterator: add tests for dir-iterator API
 -:  ---------- >  4:  b975351080 dir-iterator: use warning_errno when possible
 -:  ---------- >  5:  0fdbd1633e dir-iterator: refactor state machine model
 -:  ---------- >  6:  7b2a9ae947 dir-iterator: add flags parameter to dir_iterator_begin
 4:  71d64e6278 =  7:  b9f298cbc6 clone: copy hidden paths at local clone
 5:  35e36756db =  8:  0e7b1e49e2 clone: extract function from copy_or_link_directory
 6:  1bfda87879 !  9:  f726ce2733 clone: use dir-iterator to avoid explicit dir traversal
    @@ -8,10 +8,14 @@
         copy_or_link_directory.
     
         This process also makes copy_or_link_directory call die() in case of an
    -    error on readdir or stat, inside dir_iterator_advance. Previously it
    +    error on readdir or stat inside dir_iterator_advance. Previously it
         would just print a warning for errors on stat and ignore errors on
         readdir, which isn't nice because a local git clone could succeed even
    -    though the .git/objects copy didn't fully succeed.
    +    though the .git/objects copy didn't fully succeed. Also, with the
    +    dir-iterator API, recursive symlinks will be detected and skipped. This
    +    is another behavior improvement, since the current version would
    +    continue to copy the same content over and over until stat() returned an
    +    ELOOP error.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ -44,12 +48,15 @@
     -		die_errno(_("failed to open '%s'"), src->buf);
     +	struct dir_iterator *iter;
     +	int iter_status;
    -+	unsigned flags;
    ++	unsigned int flags;
      
      	mkdir_if_missing(dest->buf, 0777);
      
     +	flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
     +	iter = dir_iterator_begin(src->buf, flags);
    ++
    ++	if (!iter)
    ++		die_errno(_("failed to start iterator over '%s'"), src->buf);
     +
      	strbuf_addch(src, '/');
      	src_len = src->len;
 7:  3861b30108 = 10:  6a57bb3887 clone: replace strcmp by fspathcmp
-- 
2.20.1

