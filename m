Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D067EC678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCDMjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 07:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCDMjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 07:39:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2366DF77C
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 04:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1677933553; i=mpartap@gmx.net;
        bh=OArnmJBEjZXahVygRvi5vIACfbVteI/Js420Kqy5GuM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=mwzBkO1NtP9sC8nebyBB+V6UdED6EGKLHF5ptBOEx3n2WJqsfx48B7LvOlhmZWbDZ
         XYK/V+lzXtoekNghWPLMyzHFF9GoH8aQUJ1LSIDYF+a8Wkd+4VTxxLWPJTXSqZIwPD
         eaHb52ZPDxYOwb4atnFWVBR4iMaP9/XZgc5EdbdAf5NLdj7qsCOkeOsyLor+ZcIC9x
         LM8WQUS1eUb2kiV06vYxy4PH1jbre0+nOLeieiOu92wv+tdjp5rnblCc/heWgK+MnY
         NZUlSF7MV7sfnkRZI1gg10q9vpELONfiJBJVTfT1wUzdQkR4yqP8Gx8lnW8Pvy8YqW
         OZGUNk++f5JOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from base.lan ([92.206.220.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1q4M8z071Q-00W1iN; Sat, 04
 Mar 2023 13:39:13 +0100
From:   Marcel Partap <mpartap@gmx.net>
To:     git@vger.kernel.org
Cc:     mpartap@gmx.net
Subject: [PATCH] add -p: obey diff.noprefix option if set
Date:   Sat,  4 Mar 2023 13:39:00 +0100
Message-Id: <20230304123900.358048-1-mpartap@gmx.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8JblcSyUbti6unx8vRzdwkUx42dVC0T3dOYLaEtpJWyh5V8rdFE
 mN3qz3KEwIPt40cKzIuJuW+WqXKrTPx1672n10ttMeA0GtQrgm7M3NMPetw74gpl0g7OSRm
 KODa0zi+0q6hg52F76kFEF8NLzo6cW0h2OOThxs0Go1mwSxBuFSDwC0wj5V5rGbpll81HP+
 EcbPX2pL8VzRPI8UbXOPg==
UI-OutboundReport: notjunk:1;M01:P0:LrV7mkm/uJc=;qc5pH+0RC850CrOnZwseeaKJak+
 K+fbhjPC+gIuPglAdOKNeWEA0uHW5DeZ7pWWtetQIK5c8am0fgZcHSLHET7QNLlCdHV+9CLZy
 2tzEdUoknPMeQR5KhkPSyfTvsmkN0gtczf0x0O/FI/ECSrjr33GC9pBYcG6X1Mn5tVD/QRrmD
 SKmeV+5b8hHE9a+32pITmZg6KHGirXWU9qSJnu5ak2UxEdLYYJoErLtHS4wmcQoIXmIppVfX8
 aDtADwvQbtvFgYy16qGMMqgueNp7qba8+Q4TngcW2DoJeL5uzLsP5IoJXiZZsrmzi/cwCsg6O
 jixoABlEWe+LrHP92NOOCcYx/vKr67ohYD+MEAnuufJgu8XFPA27nCcCLmnCQ0ia1lthd7jrF
 MnwI8YBW0TZ2Rby5DqXw56H8se6yGgJ+cbDfqoWgV8JhbRDwfIYK2NeGwV8RNaXyVIA4lUXcU
 8luMRqVOpoRHa+hlftpz8P9opUQr1QLlGl3qDvxzjEeT9ZBDHr6Gm4arkOb1FTp4Sr7BHhBMY
 +adK1RO836gHjF0y1kdn2b+weDPQR96olDeXe1veu/rEfdNgB3FdEYywHBV5aqHbmAYiVBNjU
 fNEwiTNXYZPY4zVIjpHeJ8Aw2TfWd/Kr2VcQ5epA5I6rmR4soqtMcar38E2slzfmj6xqLTRNf
 RBcidfvrmioZX7pqYYYj8/TyhrCv/H16f72n3WVeRCFSWgvScPkNPMq4FRHPN8kCRL7PYpl9W
 TG5uXAD0P6iLT1ge4kSTyLtiI1I/biGbimSAWwB1fyr22+Nwq+xRQcDCR+GX5AXW6k1AMRIFQ
 ZgyTKGRrPyOBZPmr3ovZGTUvsGDIczehTtKaFp6Qr8neTWdez6j+qK+G56IO/EFiBGq48hX+e
 yuS8hncx8wwz9JFDUUQoazICs1xnL2q47lkzHBwcVXL2viQ0bFK17OnKoO5cLTO6xjXeb38lI
 ORc+KenBxGq1uU+mAkg4WSLlbMU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user has set the diff.noprefix option, he likely will expect
this display setting to also apply when interactively adding hunks.

Signed-off-by: Marcel Partap <mpartap@gmx.net>
=2D--
 add-patch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git add-patch.c add-patch.c
index a86a92e164..520faae9cb 100644
=2D-- add-patch.c
+++ add-patch.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "add-interactive.h"
 #include "strbuf.h"
 #include "run-command.h"
@@ -404,11 +405,13 @@ static int parse_diff(struct add_p_state *s, const s=
truct pathspec *ps)
 	size_t file_diff_alloc =3D 0, i, color_arg_index;
 	struct file_diff *file_diff =3D NULL;
 	struct hunk *hunk =3D NULL;
-	int res;
+	int res, noprefix;

 	strvec_pushv(&args, s->mode->diff_cmd);
 	if (diff_algorithm)
 		strvec_pushf(&args, "--diff-algorithm=3D%s", diff_algorithm);
+	if (!git_config_get_bool("diff.noprefix", &noprefix) && noprefix)
+		strvec_pushf(&args, "--no-prefix");
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
=2D-
2.38.1

