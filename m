Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246158;
	b=OG9X4C2V5UC9BKkwYKes05TJzX5b9noaxcdOIKz9tuonHi5dMgxvrAg9TrZJTaEkIp68
	 awVRi5SiEjOsdmhuz0wiw0HmfRwVXiAh4D6MU+pDw+qoJykwnhJl6mvX8QXVGSTP90uOQ
	 WH21bhgBdTQKOo4DYmY0rfDSHvjTW+X+7ZRiHEj7ONHhX/oKtVuKBHh4zRxb0fqXA6fjG
	 RFf1bnwg68N52j4E6cvKK/wk+uEHyqT/OZMSUPQrKAfYKTarP8w+p7w08d9wceuWlsCds
	 ZsQrUKHMupHg3qGN2AEu+PGK205B4j2GFZaMuxHYmBnyUW/uv9SWgaefHOYSVYawpdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=3I8TtOGdefiuQZB/907jXBepEvXTmQ6BK7ZKs5sgrhU=;
	b=lBtG1DKukHXVcRFb7tCIRStvyU+x6p4dHrROR+oxaKQsCnTefXR2paXr+BvoGodn0jfx
	 nKGWREEbFJvLqfWeIa9RJ4CvGKqh2uvffjM3soc05Xt33Nynd0d9n/gCAn4e8dOjd+k3a
	 RH9+vQIU9QpgMItkHOSVDq/OaFA2edVzn6dNS/pdeAYKuva4auc7xYQKzLKwM75lyT8A+
	 OFfRQPiIE6pmuehs/wRlRgAuP5e4lH0/YtMjh8NsASFU+ZjTnRp32i5HAcs7Di80wKdjp
	 qPymWV5KcHGhsaMKdvWIpcNrv/F6ncGkSRGIeRDj6j3O1+ajYF4vEoJEXyZF891GK7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3v7pJPs;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18430606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 03:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18430606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3v7pJPs
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1846bc43c28so2013193c88.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793246157; x=1793850957; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3I8TtOGdefiuQZB/907jXBepEvXTmQ6BK7ZKs5sgrhU=;
        b=f3v7pJPs04SPju4duSnJdZyi8AUHhiRuAlVjv53zdZN9LBx6N1xFs1nxshSuujcWtz
         dXPnO1JApjESbPhZ3MUVZC9k0kA91vVvl7GFwu30K3Z0BE0PapygQk1tF0TrNu1a8gJy
         KQ3n6KMbCqIUvgtC224HsdAEzgofYvZ6aDWMnqN2sLfOHR3kC8c4y5Z6hOC+Lylhj//h
         W1WjZSTp3K14no2riW20ot0bSCPiXJrPP/LUmqvPoAVwfvGtHTVZMY/y18oWb/1DOIe5
         yCe9s+Tf9MyBH8fFK1u+5J3cjzK4/63vWrdhLmqKR61L73KxZzu0ssx5fpeOU/0eip1h
         ZiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793246157; x=1793850957;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3I8TtOGdefiuQZB/907jXBepEvXTmQ6BK7ZKs5sgrhU=;
        b=s5iclAIhhfV8wQDugckc/gVOM8LVx83lMBV90IulcY/ZjDhoW92qQvROkfmqIPbNRi
         fWLrlVWhCY8jxBt4okCFPpapmSeuU5U/3W410noCmraAU5bKeK2RlUHhoT1hWVngkZe2
         40W6qywdo0IKVmtwelSaQuLt/WCRRSxcDjNCSSNXS7xd8xBUho0nAWFoHjHyVPNy26sp
         MlyyHbu50LQWbF66mw9DOALHAu14Ni0hlUJiwuwQnJltfnRU/WkKXFuHICg4yKHBLMxU
         3+unDpWfcfEB1XCgATbIHB0oFrGIkWZIA6I3f/g9886GQBXxJjIX67ftTYDCmVPhcS6D
         +v5g==
X-Gm-Message-State: AFq9FYIKa+bEfcTfPVyW2EsJHrA9Dv3xVqkZu2hDjJ8//RTXbrcRlWG3
	xmEEJoOgjK3WTyPutSP477RamEMhQWNITLJV7YeMjQ5gj7AJHfx69gBivj4bNfn1
X-Gm-Gg: AYBFou1dv+WY6OmWoVkdQHb68gnZWrotXTKEkh3PGlZtGYiI7swLkaxjPXdazm+PaBS
	vDRkbWzyMYNFLWVrl3AnKlm0cS4PijMCq3KzDWnm4NFDWmQM3rGe6gUUwsxQ8aujKEmoLFyYo6f
	Umh16bmvVdZI4lgDkdSyP31+DTSzQEztNV8UiPnSbL2LEVEr0D5MJx+hbqae+pMNdsnKwXSSIL4
	SbqNOnOTf33s0cuTOoSRe+qwcsqRxSkFnohXP8hwBEBqebuxyENflqhxDPWremfuyqjYc+MpvHf
	mOc944KHvTe1Utkp5qrUMcNhcotiJZmw3vzPpiTZQ4Gvzygx9RrsX72eQx3fYDYtUEk/11nGQuZ
	Ji2tDSerILfnScTcdgqCHMbU8KYgMQkocQguNKhtHWzflTnE0GWc2Kp8CWtpWsoJ4o3M0GKdb90
	9aVfrZi9Ce+7quAMrlWPH/Z15PMalg28z0jggor9NQX2lTzja9Wciu0jY3yX6K913to1k9inJns
	tSlzNpJsHM23KANzpHMicN51q6euqZaI917RTUa9SiHnZTYUFM4Aif1Oh1sa3erqE2e4VOibM8z
	QHMmEoApcL89s0UqT4HHMGgncaCiSHB/WUs=
X-Received: by 2002:a05:7022:f502:b0:1a3:65d7:efae with SMTP id a92af1059eb24-1a6ce1136e4mr5451781c88.21.1793246156989;
        Wed, 28 Oct 2026 20:55:56 -0700 (PDT)
Received: from [127.0.0.2] ([50.168.54.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a7549528ebsm10103105c88.0.2026.10.28.20.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:55:56 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 28 Oct 2026 20:55:50 -0700
Subject: [PATCH] notes: do not drop notes written by a concurrent process
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxG4atUnrGURi2iXAUxgPkLZkiQnRZE1
 bsTYPyG9xZymMJp3yxkmNU1p4p205DcTukK1ks1xRC3bYg7Ht+ccoGz5CSTGVLhp2kBd0A/hKH
 vIKDaPwyjvn7vw/Fvn853SPkOaV0/L8i4T30AAAA=
X-Change-ID: 20261028-fz-notes-concurrent-write-4ee590954ece
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

"git notes add" and the other commands that modify notes read the
notes ref, update the notes tree in memory, and then commit it on top
of whatever the ref points to by then. If another process updated the
ref in the meantime, its notes are silently lost.

The fix is to remember the commit the notes were read from, and use
it as both the parent of the new notes commit and the expected old
value of the ref update. A concurrent update now makes the command
fail with "cannot lock ref" instead.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
I found this with Rewind, a deterministic VM I am building that replays
a program under many thread schedules until one fails. Two "git notes
add" commands run at once on different commits lost one of the two
notes in 15 of 32 schedules, while both exited 0. It is not specific to
Rewind: on a plain Linux machine 25 of 30 runs lost a note. How Rewind
narrowed it down to commit_notes() is written up at:

  https://fzakaria.com/2026/10/28/reading-the-code-is-the-hard-part

With this patch no notes are lost; when two commands race, one of them
fails with "cannot lock ref" and can be retried.
---
 notes-utils.c    | 15 +++++++++++++--
 notes.c          |  8 ++++++--
 notes.h          |  3 ++-
 t/t3301-notes.sh | 18 ++++++++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..0ce430304f 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -46,6 +46,7 @@ void create_notes_commit(struct repository *r,
 void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct commit_list *parents = NULL;
 	struct object_id commit_oid;
 
 	if (!t)
@@ -59,12 +60,22 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 	strbuf_addstr(&buf, msg);
 	strbuf_complete_line(&buf);
 
-	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
+	/* Build on the commit the notes were loaded from */
+	if (!is_null_oid(&t->base_oid)) {
+		struct commit *parent = lookup_commit(r, &t->base_oid);
+		if (repo_parse_commit(r, parent))
+			die("Failed to find/parse commit %s", t->ref);
+		commit_list_insert(parent, &parents);
+	}
+
+	create_notes_commit(r, t, parents, buf.buf, buf.len, &commit_oid);
 	strbuf_insertstr(&buf, 0, "notes: ");
 	refs_update_ref(get_main_ref_store(the_repository), buf.buf,
-			t->update_ref, &commit_oid, NULL, 0,
+			t->update_ref, &commit_oid, &t->base_oid, 0,
 			UPDATE_REFS_DIE_ON_ERR);
+	oidcpy(&t->base_oid, &commit_oid);
 
+	commit_list_free(parents);
 	strbuf_release(&buf);
 }
 
diff --git a/notes.c b/notes.c
index ec9c2cb150..d71b528f37 100644
--- a/notes.c
+++ b/notes.c
@@ -1039,12 +1039,16 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
 	t->dirty = 0;
+	oidclr(&t->base_oid, the_repository->hash_algo);
 
 	if (flags & NOTES_INIT_EMPTY ||
 	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
 		goto out;
-	if (flags & NOTES_INIT_WRITABLE && refs_read_ref(get_main_ref_store(the_repository), notes_ref, &object_oid))
-		die("Cannot use notes ref %s", notes_ref);
+	if (flags & NOTES_INIT_WRITABLE) {
+		if (refs_read_ref(get_main_ref_store(the_repository), notes_ref, &object_oid))
+			die("Cannot use notes ref %s", notes_ref);
+		oidcpy(&t->base_oid, &object_oid);
+	}
 	if (get_tree_entry(the_repository, &object_oid, "", &oid, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
diff --git a/notes.h b/notes.h
index 6dc6d7b265..30f4ece5e9 100644
--- a/notes.h
+++ b/notes.h
@@ -1,9 +1,9 @@
 #ifndef NOTES_H
 #define NOTES_H
 
+#include "hash.h"
 #include "string-list.h"
 
-struct object_id;
 struct repository;
 struct strbuf;
 
@@ -54,6 +54,7 @@ extern struct notes_tree {
 	struct non_note *first_non_note, *prev_non_note;
 	char *ref;
 	char *update_ref;
+	struct object_id base_oid;
 	combine_notes_fn combine_notes;
 	int initialized;
 	int dirty;
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 18a6000171..561f9ccc18 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1629,4 +1629,22 @@ test_expect_success 'git notes append aborts when editor fails with -e' '
 	test_must_fail git notes show
 '
 
+test_expect_success 'git notes add does not drop notes added while it runs' '
+	test_commit 23rd &&
+	test_commit 24th &&
+
+	# The editor adds a note to another commit while the outer
+	# "git notes add" is waiting for it, as a concurrent process would.
+	write_script racing_editor <<-\EOF &&
+	git notes add -m "added meanwhile" 23rd &&
+	echo "edited" >"$1"
+	EOF
+	test_must_fail env GIT_EDITOR=./racing_editor git notes add 24th &&
+
+	echo "added meanwhile" >expect &&
+	git notes show 23rd >actual &&
+	test_cmp expect actual &&
+	test_must_fail git notes show 24th
+'
+
 test_done

---
base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
change-id: 20261028-fz-notes-concurrent-write-4ee590954ece

