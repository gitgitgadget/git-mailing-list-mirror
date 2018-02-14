Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0521F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162473AbeBNTC0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:26 -0500
Received: from mail-it0-f74.google.com ([209.85.214.74]:43730 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162588AbeBNTCW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:22 -0500
Received: by mail-it0-f74.google.com with SMTP id k19so12964521ita.8
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mpi1KJf78LKNHccNYVCQOX4lbwaETiaDQivbYYOcF9E=;
        b=Qt6sgpTjuctqmQ73VJHcZeOKUGiBJO1NL2zFRnlSg4K7tN3fuAzd4+9taRQ73wi6gq
         lA6yyAGK/gjCpDjKsL5D5Efs7sW/gQjJzy1pZS1IIRITTGhfZwOaRWzOnccfocrehgEm
         MtsN69EvcgDHchhcDlunn+3aUJWZ6e/MEogUNr12M9OI9Gl5wk28Mox4P4MRy3OAcyBU
         xzrZS7Vz6GOD0QaSNw7ZuwP28v1hK9Nb0dx2vguMI2bO6/Q4ABrTLwFWEoZ80Lly2hVT
         X/q5/OGP69PA4/M2iR9MfZ6Q6C7VJWSlH4GvLbZwygZT3SvXm3mDrvpPcsilASdHhxJI
         wm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mpi1KJf78LKNHccNYVCQOX4lbwaETiaDQivbYYOcF9E=;
        b=CMH65qhhtkI4ijRrvcZU4wTuBgm8x+fgU1eQydn4gUWHdhcL81XYTKk3IxrVm8Bnv3
         mt7/h4OoTMUdpOTUx3rQi09p3R0EvoYYqhT/6CkGlgK6icTV9NAff9aQPAuqu3ye+OBD
         1v29nturVN1mNoR3eRiXVP4iv4aYrZjA4qK1ZngYT36kcdjYqrdpO2gMW5v0QHPeDkzx
         0+WLwGgTzzZNCUeQay3Hh+12RTUCLrgTreaXbOe+SWNEOcdLh6vKbb9hxFEBlvTf26X8
         Kl1FnDx2NXEjY39p4Ti7SAjZXRKkSaNxX2pHgjrNWCKkeqDYYLpLya9osjV6U4HgII+l
         3jWA==
X-Gm-Message-State: APf1xPDSiKAJYG7K7zB7z6Dgwx4cejdqg6r5HtW96O3yOVJdCMjC3db8
        2xQ60u/Ef2vZP7cZXjeK7dEuL3wpfpDEXuuG0FVT3USKn6QwB312w2exTRVY5Q2hT2kZC/8fyHc
        cTFKkPZSdYTmklvcBjXN4uajZ/GkPvc2VHEMygLLxQyGXqrrkQ5bEiT+0FA==
X-Google-Smtp-Source: AH8x22438RfSY+FmMMAyBjtUTfEpuTjjt6AbFnwUhI4K2wmqCFtYvO/65bHOgfjXutqeYpmAJ15w1tRS3H4=
MIME-Version: 1.0
X-Received: by 10.36.95.77 with SMTP id r74mr28217itb.35.1518634942045; Wed,
 14 Feb 2018 11:02:22 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:59 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-38-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 37/37] replace: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/replace.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 42cf4f62a..303ca134d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -284,30 +284,30 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 {
 	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 	enum object_type type;
-	struct object_id old, new, prev;
+	struct object_id old_oid, new_oid, prev;
 	struct strbuf ref = STRBUF_INIT;
 
-	if (get_oid(object_ref, &old) < 0)
+	if (get_oid(object_ref, &old_oid) < 0)
 		die("Not a valid object name: '%s'", object_ref);
 
-	type = sha1_object_info(old.hash, NULL);
+	type = sha1_object_info(old_oid.hash, NULL);
 	if (type < 0)
-		die("unable to get object type for %s", oid_to_hex(&old));
+		die("unable to get object type for %s", oid_to_hex(&old_oid));
 
-	check_ref_valid(&old, &prev, &ref, force);
+	check_ref_valid(&old_oid, &prev, &ref, force);
 	strbuf_release(&ref);
 
-	export_object(&old, type, raw, tmpfile);
+	export_object(&old_oid, type, raw, tmpfile);
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
 		die("editing object file failed");
-	import_object(&new, type, raw, tmpfile);
+	import_object(&new_oid, type, raw, tmpfile);
 
 	free(tmpfile);
 
-	if (!oidcmp(&old, &new))
-		return error("new object is the same as the old one: '%s'", oid_to_hex(&old));
+	if (!oidcmp(&old_oid, &new_oid))
+		return error("new object is the same as the old one: '%s'", oid_to_hex(&old_oid));
 
-	return replace_object_oid(object_ref, &old, "replacement", &new, force);
+	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
 }
 
 static void replace_parents(struct strbuf *buf, int argc, const char **argv)
@@ -386,16 +386,16 @@ static void check_mergetags(struct commit *commit, int argc, const char **argv)
 
 static int create_graft(int argc, const char **argv, int force)
 {
-	struct object_id old, new;
+	struct object_id old_oid, new_oid;
 	const char *old_ref = argv[0];
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *buffer;
 	unsigned long size;
 
-	if (get_oid(old_ref, &old) < 0)
+	if (get_oid(old_ref, &old_oid) < 0)
 		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(&old, old_ref);
+	commit = lookup_commit_or_die(&old_oid, old_ref);
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
@@ -410,15 +410,15 @@ static int create_graft(int argc, const char **argv, int force)
 
 	check_mergetags(commit, argc, argv);
 
-	if (write_sha1_file(buf.buf, buf.len, commit_type, new.hash))
+	if (write_sha1_file(buf.buf, buf.len, commit_type, new_oid.hash))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
 	strbuf_release(&buf);
 
-	if (!oidcmp(&old, &new))
-		return error("new commit is the same as the old one: '%s'", oid_to_hex(&old));
+	if (!oidcmp(&old_oid, &new_oid))
+		return error("new commit is the same as the old one: '%s'", oid_to_hex(&old_oid));
 
-	return replace_object_oid(old_ref, &old, "replacement", &new, force);
+	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
 }
 
 int cmd_replace(int argc, const char **argv, const char *prefix)
-- 
2.16.1.291.g4437f3f132-goog

