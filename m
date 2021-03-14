Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A016C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE6164E98
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCNOiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 10:38:20 -0400
Received: from mout.web.de ([212.227.15.3]:35373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233259AbhCNOhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 10:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615732661;
        bh=8rADbJ41ET0wRiy+Ccuu0b8dMYsbNoRuiA+yfRpWLRY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Je6C7DqvPt0R+ZdKpGxlA1m/S0D0Jiyu9NIUg4nb898XDcpjnjHpeTApY3reoxSy/
         4bbPr+4v4Hx8vTHPKSaSzdok7I2kOFbWtl5mU89Cuy0EyC+Jk1hhbNmzc7ohf/YsmA
         sKz27+XfVdyI704nxSmxQt+H2ieTsa1q+n7ysnp4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M2ggd-1lHrEx3Nz5-004J6I; Sun, 14 Mar 2021 15:37:40 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Subject: [PATCH] vcs-svn: remove header files as well
Message-ID: <b937922d-8b56-c333-3f76-6e17a28210e3@web.de>
Date:   Sun, 14 Mar 2021 15:37:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X2+4ByxAONuVhIgiFts+QWPFVtHqp0gin7vR36kyS8xY3qHn+I8
 V8GuqFRiEdCGrJp0IsO/qUoeki6rGBC8E03g/mxeaixNdxLGk1oZaS2umMz+S9o2P5OpZxK
 WmHZqAj9aF4DVYYRktN8mmc3ZwyqVxolfCFXKDmAvW9tXsHr3m+SAQWppc+jI37lqFMjpFi
 S1k7v/bkpBb6aBcMrVNcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rD056FYg92E=:zagjOjdFhi1mWTIp+cdyrz
 fWyJ7eDh1A8a7GS8ro35DCACmmedbugLXItewHFqgA0kmbSbCFt9QY0p7Mv8PGWLfSKGXZbZW
 mfIPyNgcdzCfluBWuZBxwfz2afyL58oyeUd/SJ1kRv22vKLNFK2PAYZT49UNuHLA8oenHUAZP
 7TntaVz/kAEvsoT6TzvifFlDs/XZ8RcUseMh+g+2QK05DPWyQ/x7jDgHtZELGJtcHf8tj/6Gu
 tMuyhmnaws1ZkKwOIRFrOgEOn6/p4GdmOP1QaTpNrkesqtR/VezkDc9N4GeiqTFtlntRS+k/Z
 Rf8t3PiFt6vzy1JSBJX5WpR34rO92JWwBtRsr1v6n6IbstTz4eQ0P13f5ucILTUwluWeCoX+Y
 JnlvSDO7BfWrNHyzj+h3Y4lFcZT0+CgXJKcGsweJ6nMB79q5xzbHXJ7G9pBI9jUNx6wTcK4FP
 6iGYlqLBcIVqGVpPIVsTaxQ0tir4r3bci3ZDxuu6THwgz1FOVn/m91A2HRvI59fT27UNu9Du9
 kjiIfAi25eU2H2pswXZytHh3krcoB5znIX09ZOajeFjDRnq0UEwKTUfn5BZt8fvZhQLwvR1cU
 lT81NOCV0j3gcr2LmNMXlsg9Sw5q8ZSaUK3IObKu2qwp4ylyMO2Ki4er6qFK1WZtea7pKN9iG
 ARo74CgY0XLOEjEBwSSxACJsvqEmQ0aVaN0xaRuY+kgj92lc8es7KaG9en8wGMjFZXLDq8Rs6
 am9sWemMca0WZhIHiZS4jXX3yyx18/L9AqcVu308DNoAS63Hlpp+1vsDRqvaSR4wgvGKX4yWq
 Pky7Un9RvaL6MI/9zRbSYJuHGIwNgAlxokLyrfF3XNuUH5l8g2akwg8LhkyKogmsHBHfVNTyf
 692vtCK0RtGg/XQzC56A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fc47391e24 (drop vcs-svn experiment, 2020-08-13) removed most vcs-svn
files.  Drop the remaining header files as well, as they are no longer
used.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 vcs-svn/fast_export.h    | 34 ----------------------------------
 vcs-svn/line_buffer.h    | 30 ------------------------------
 vcs-svn/sliding_window.h | 18 ------------------
 vcs-svn/svndiff.h        | 10 ----------
 vcs-svn/svndump.h        | 10 ----------
 5 files changed, 102 deletions(-)
 delete mode 100644 vcs-svn/fast_export.h
 delete mode 100644 vcs-svn/line_buffer.h
 delete mode 100644 vcs-svn/sliding_window.h
 delete mode 100644 vcs-svn/svndiff.h
 delete mode 100644 vcs-svn/svndump.h

diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
deleted file mode 100644
index 9dcf9337c1..0000000000
=2D-- a/vcs-svn/fast_export.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef FAST_EXPORT_H
-#define FAST_EXPORT_H
-
-struct strbuf;
-struct line_buffer;
-
-void fast_export_init(int fd);
-void fast_export_deinit(void);
-
-void fast_export_delete(const char *path);
-void fast_export_modify(const char *path, uint32_t mode, const char *data=
ref);
-void fast_export_note(const char *committish, const char *dataref);
-void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, timestamp_t timestamp, const char *note_ref);
-void fast_export_begin_commit(uint32_t revision, const char *author,
-			const struct strbuf *log, const char *uuid,const char *url,
-			timestamp_t timestamp, const char *local_ref);
-void fast_export_end_commit(uint32_t revision);
-void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input=
);
-void fast_export_buf_to_data(const struct strbuf *data);
-void fast_export_blob_delta(uint32_t mode,
-			uint32_t old_mode, const char *old_data,
-			off_t len, struct line_buffer *input);
-
-/* If there is no such file at that rev, returns -1, errno =3D=3D ENOENT.=
 */
-int fast_export_ls_rev(uint32_t rev, const char *path,
-			uint32_t *mode_out, struct strbuf *dataref_out);
-int fast_export_ls(const char *path,
-			uint32_t *mode_out, struct strbuf *dataref_out);
-
-void fast_export_copy(uint32_t revision, const char *src, const char *dst=
);
-const char *fast_export_read_path(const char *path, uint32_t *mode_out);
-
-#endif
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
deleted file mode 100644
index e192aedea2..0000000000
=2D-- a/vcs-svn/line_buffer.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef LINE_BUFFER_H
-#define LINE_BUFFER_H
-
-#include "strbuf.h"
-
-#define LINE_BUFFER_LEN 10000
-
-struct line_buffer {
-	char line_buffer[LINE_BUFFER_LEN];
-	FILE *infile;
-};
-#define LINE_BUFFER_INIT { "", NULL }
-
-int buffer_init(struct line_buffer *buf, const char *filename);
-int buffer_fdinit(struct line_buffer *buf, int fd);
-int buffer_deinit(struct line_buffer *buf);
-
-int buffer_tmpfile_init(struct line_buffer *buf);
-FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write=
. */
-long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
-
-int buffer_ferror(struct line_buffer *buf);
-char *buffer_read_line(struct line_buffer *buf);
-int buffer_read_char(struct line_buffer *buf);
-size_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, siz=
e_t len);
-/* Returns number of bytes read (not necessarily written). */
-off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
-off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
-
-#endif
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
deleted file mode 100644
index a7fc0999cb..0000000000
=2D-- a/vcs-svn/sliding_window.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef SLIDING_WINDOW_H
-#define SLIDING_WINDOW_H
-
-#include "strbuf.h"
-
-struct sliding_view {
-	struct line_buffer *file;
-	off_t off;
-	size_t width;
-	off_t max_off;	/* -1 means unlimited */
-	struct strbuf buf;
-};
-
-#define SLIDING_VIEW_INIT(input, len)	{ (input), 0, 0, (len), STRBUF_INIT=
 }
-
-int move_window(struct sliding_view *view, off_t off, size_t width);
-
-#endif
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
deleted file mode 100644
index 625d950bb8..0000000000
=2D-- a/vcs-svn/svndiff.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef SVNDIFF_H
-#define SVNDIFF_H
-
-struct line_buffer;
-struct sliding_view;
-
-int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-		   struct sliding_view *preimage, FILE *postimage);
-
-#endif
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
deleted file mode 100644
index 26faed5968..0000000000
=2D-- a/vcs-svn/svndump.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef SVNDUMP_H
-#define SVNDUMP_H
-
-int svndump_init(const char *filename);
-int svndump_init_fd(int in_fd, int back_fd);
-void svndump_read(const char *url, const char *local_ref, const char *not=
es_ref);
-void svndump_deinit(void);
-void svndump_reset(void);
-
-#endif
=2D-
2.30.2

