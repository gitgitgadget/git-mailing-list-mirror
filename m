Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5CE1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162571AbeBNTB5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:57 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:50899 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162472AbeBNTBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:50 -0500
Received: by mail-yw0-f202.google.com with SMTP id o201so22375157ywd.17
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Xjdxki3sm1fyxTBgbVy7+yrs/jEYWc4+47wWry4iPtE=;
        b=PS9u/V/cRuxkqrCZvOZG9xj5dqKi1BwDdZQQFg6QDbwi5MGRp2hv1kF6iIRO0kidII
         VfKnCbvzoANTLDKXsqkT6YEpbWPmYyRbsQEklO7gsCF3eVO0lxfGrJejL28eVrmtGXRV
         QbRiqX2S7fJ+qWZYqxnrgG9LYtifTnLMg4WsdQGAx4XEjQKI0WhWA4DPR3SQoApPt+NA
         L1MU0+bkVoehA/fQbpE/1ur6Oao6aqVjadzcj+itxyS3ZD6/NlbboW72jlTDa1SSD6PZ
         YI4w27aEJJ6AqGkCpdHGPHD16IrBlMVRdME3lMQNNmM1B2CCEOJMnfY/UQCzg1URyUtP
         HaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Xjdxki3sm1fyxTBgbVy7+yrs/jEYWc4+47wWry4iPtE=;
        b=cbrRh1dlzg1QA4JF57m4TozOFyORP+Y2BiyTOrZZACX2xExce4rIBH9Wl52iJkG4u2
         Pu2R+U++GrXx9oox+sZkzL40k2vYSPHLQpDryZRBsKUjYwVXdk/G8kxo04mrhF0FtYqB
         KMzCvcwOvI+Sr52UqmutHJAOmQX9XC26oES9UzGExtldEqBv5oVDHelA8nbETSBCxXX2
         7b1AQM15Mjd1/iUrdgEae9JmZev+tae2L2gFgHPpYRpBmIOWSSwILBRd6U018JE5lOwh
         +8fWkgjuZhZxrCHJ7CaVUv40ikrCHM/gcqJ7RnJ3QG6hkQkUu54j3OssGAl658EwVYKm
         Flag==
X-Gm-Message-State: APf1xPD0bm7nYW2Gn9Iaoz5lxM298IJvBLSbn0agziayOfaOtokZBajw
        p0U0g/nSu5HvY/YgWmU4Zw4kI7BGuNbBsOlPqHpZswFJJuZWuCSk0Ti3zPiYwjq5ZB9maWxyDRO
        Cq79CHoVVO0UBP4dWzQT1Bxi6csKUtW7A/IZ/IEk/JTLV9liBMlcCHeOIRw==
X-Google-Smtp-Source: AH8x227hJd4mFdTr16keGmSGaV3ja9zr55mzCAwCryESVukWVvoMSrfm8pOOewfiWff6Zn7TYXvKJOAjFsw=
MIME-Version: 1.0
X-Received: by 10.37.2.200 with SMTP id 191mr3091557ybc.4.1518634909390; Wed,
 14 Feb 2018 11:01:49 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:47 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-26-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 25/37] remote: rename 'new' variables
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
 remote.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index 4e93753e1..2922dca07 100644
--- a/remote.c
+++ b/remote.c
@@ -1970,33 +1970,33 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 {
 	struct object *o;
-	struct commit *old, *new;
+	struct commit *old_commit, *new_commit;
 	struct commit_list *list, *used;
 	int found = 0;
 
 	/*
-	 * Both new and old must be commit-ish and new is descendant of
-	 * old.  Otherwise we require --force.
+	 * Both new_commit and old_commit must be commit-ish and new_commit is descendant of
+	 * old_commit.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
-	old = (struct commit *) o;
+	old_commit = (struct commit *) o;
 
 	o = deref_tag(parse_object(new_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
-	new = (struct commit *) o;
+	new_commit = (struct commit *) o;
 
-	if (parse_commit(new) < 0)
+	if (parse_commit(new_commit) < 0)
 		return 0;
 
 	used = list = NULL;
-	commit_list_insert(new, &list);
+	commit_list_insert(new_commit, &list);
 	while (list) {
-		new = pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new, &used);
-		if (new == old) {
+		new_commit = pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new_commit, &used);
+		if (new_commit == old_commit) {
 			found = 1;
 			break;
 		}
-- 
2.16.1.291.g4437f3f132-goog

