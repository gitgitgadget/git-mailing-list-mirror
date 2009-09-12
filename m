From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 13/14] Allow flexible organization of notes trees,
 using both commit date and SHA1
Date: Sat, 12 Sep 2009 11:41:23 -0700
Message-ID: <7viqfof1kc.fsf@alter.siamese.dyndns.org>
References: <200909121752.07523.johan@herland.net>
 <1252771728-27206-14-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXXk-0002vh-9w
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbZILSlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbZILSln
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:41:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbZILSlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:41:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19EC34EB87;
	Sat, 12 Sep 2009 14:41:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vNYDkGabN7wEBzUKP3iFr1q3NPg=; b=k4nS2R
	XxYN9e6dXc6+ryy69KJQ97unH+VART8+efF2WL1o3ePjsRGQZNwuT/qgWZGtLrvu
	mAtpDTWcY4YOHkXWh44BoVeI1N2rvs/5MyK81QCQ0jVPeizFV7sZVeY7+L7WEMS6
	XvCMAFQ49UR0FIE12uK3mW81f/bTIsGTCyYgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnxfzf64OyeWSuJf5RFIw4SsvBO6g+9/
	v9WuNrDlfOhhz3F450Dzwi1LYz01PgDn3sjqVRT8hCHeXE042uJZhYxs86/2zEHk
	76P4r+hW5mSJApLfP9l6asILSJOZ9ETuYdF0fHCnuQ+JPCWl8Zsj0ATjQvB2Vllp
	xFBHaIp/pio=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A42454EB83;
	Sat, 12 Sep 2009 14:41:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09BF94EB81; Sat, 12 Sep 2009
 14:41:24 -0400 (EDT)
In-Reply-To: <1252771728-27206-14-git-send-email-johan@herland.net> (Johan
 Herland's message of "Sat\, 12 Sep 2009 18\:08\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7590A3C-9FCB-11DE-B254-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128281>

Johan Herland <johan@herland.net> writes:

> This is a major expansion of the notes lookup code to allow for variations
> in the notes tree organization. The variations allowed include mixing fanout
> schemes based on the commit dates of the annotated commits (aka. date-based
> fanout) with fanout schemes based on the SHA1 of the annotated commits (aka.
> SHA1-based fanout).

Will squash this in.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 12 Sep 2009 11:36:42 -0700
Subject: [PATCH] notes.[ch] fixup: avoid unnamed struct members

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes.c |   82 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/notes.c b/notes.c
index c573ffa..9a92853 100644
--- a/notes.c
+++ b/notes.c
@@ -118,8 +118,8 @@ struct int_node {
 			struct int_node *parent;
 			unsigned char tree_sha1[20];
 			char period[11];  /* Enough to hold "YYYY-MM-DD" */
-		};
-	};
+		} s;
+	} u;
 };
 
 /*
@@ -182,7 +182,7 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 {
 	struct leaf_node *l;
 	unsigned char i = GET_NIBBLE(n, key_sha1);
-	void *p = tree->a[i];
+	void *p = tree->u.a[i];
 
 	switch(GET_PTR_TYPE(p)) {
 	case PTR_TYPE_INTERNAL:
@@ -199,7 +199,7 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 		l = (struct leaf_node *) CLR_PTR_TYPE(p);
 		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
 			/* unpack tree and resume search */
-			tree->a[i] = NULL;
+			tree->u.a[i] = NULL;
 			load_subtree(l->val_sha1, l->key_sha1, l->key_sha1[19],
 				     tree, NULL, (int) n);
 			free(l);
@@ -214,16 +214,16 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 
 	/*
 	 * Did not find key at this (or any lower) level.
-	 * Check if there's a matching subtree entry in tree->a[0].
+	 * Check if there's a matching subtree entry in tree->u.a[0].
 	 * If so, unpack tree and resume search.
 	 */
-	p = tree->a[0];
+	p = tree->u.a[0];
 	if (GET_PTR_TYPE(p) != PTR_TYPE_SUBTREE)
 		return NULL;
 	l = (struct leaf_node *) CLR_PTR_TYPE(p);
 	if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
 		/* unpack tree and resume search */
-		tree->a[0] = NULL;
+		tree->u.a[0] = NULL;
 		load_subtree(l->val_sha1, l->key_sha1, l->key_sha1[19], tree,
 			     NULL, (int) n);
 		free(l);
@@ -250,12 +250,12 @@ static int note_tree_insert(struct int_node *tree, unsigned char n,
 	const struct leaf_node *l;
 	int ret;
 	unsigned char i = GET_NIBBLE(n, entry->key_sha1);
-	void *p = tree->a[i];
+	void *p = tree->u.a[i];
 	assert(GET_PTR_TYPE(entry) == PTR_TYPE_NULL);
 	switch(GET_PTR_TYPE(p)) {
 	case PTR_TYPE_NULL:
 		assert(!p);
-		tree->a[i] = SET_PTR_TYPE(entry, type);
+		tree->u.a[i] = SET_PTR_TYPE(entry, type);
 		return 0;
 	case PTR_TYPE_INTERNAL:
 		return note_tree_insert(CLR_PTR_TYPE(p), n + 1, entry, type);
@@ -273,7 +273,7 @@ static int note_tree_insert(struct int_node *tree, unsigned char n,
 			free(new_node);
 			return -1;
 		}
-		tree->a[i] = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
+		tree->u.a[i] = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
 		return note_tree_insert(new_node, n + 1, entry, type);
 	}
 }
@@ -281,20 +281,20 @@ static int note_tree_insert(struct int_node *tree, unsigned char n,
 /* Free the entire notes data contained in the given tree */
 static void note_tree_free(struct int_node *tree)
 {
-	if (tree->magic == (void *) ~0) {
-		if (tree->prev) {
-			note_tree_free(tree->prev);
-			free(tree->prev);
+	if (tree->u.s.magic == (void *) ~0) {
+		if (tree->u.s.prev) {
+			note_tree_free(tree->u.s.prev);
+			free(tree->u.s.prev);
 		}
-		if (tree->child) {
-			note_tree_free(tree->child);
-			free(tree->child);
+		if (tree->u.s.magic) {
+			note_tree_free(tree->u.s.magic);
+			free(tree->u.s.magic);
 		}
 	}
 	else {
 		unsigned int i;
 		for (i = 0; i < 16; i++) {
-			void *p = tree->a[i];
+			void *p = tree->u.a[i];
 			switch(GET_PTR_TYPE(p)) {
 			case PTR_TYPE_INTERNAL:
 				note_tree_free(CLR_PTR_TYPE(p));
@@ -439,12 +439,12 @@ static void load_date_subtree(struct tree_desc *tree_desc,
 		else  /* this is the last entry, store directly into node */
 			new_node = node;
 
-		new_node->magic = (void *) ~0;
-		new_node->child = NULL;
-		new_node->prev = cur_node;
-		new_node->parent = parent;
-		hashcpy(new_node->tree_sha1, entry.sha1);
-		strcpy(new_node->period, period);
+		new_node->u.s.magic = (void *) ~0;
+		new_node->u.s.magic = NULL;
+		new_node->u.s.prev = cur_node;
+		new_node->u.s.parent = parent;
+		hashcpy(new_node->u.s.tree_sha1, entry.sha1);
+		strcpy(new_node->u.s.period, period);
 		cur_node = new_node;
 	}
 	assert(!cur_node || cur_node == node);
@@ -552,38 +552,38 @@ static unsigned char *lookup_notes(const struct commit *commit)
 	/* Convert commit->date to YYYY-MM-DD format */
 	short_date = show_date(commit->date, 0, DATE_SHORT);
 
-	while (node->magic == (void *) ~0) {  /* date-based node */
-		int cmp = SUBTREE_DATE_PREFIXCMP(short_date, node->period);
+	while (node->u.s.magic == (void *) ~0) {  /* date-based node */
+		int cmp = SUBTREE_DATE_PREFIXCMP(short_date, node->u.s.period);
 		if (cmp == 0) {
 			/* Search inside child node */
-			if (!node->child) {
+			if (!node->u.s.magic) {
 				/* Must unpack child node first */
-				node->child = (struct int_node *)
+				node->u.s.magic = (struct int_node *)
 					xcalloc(sizeof(struct int_node), 1);
-				load_subtree(node->tree_sha1,
-					(const unsigned char *) node->period,
-					strlen(node->period), node->child,
+				load_subtree(node->u.s.tree_sha1,
+					(const unsigned char *) node->u.s.period,
+					strlen(node->u.s.period), node->u.s.magic,
 					node, -1);
 			}
 			seen_node = node;
-			node = node->child;
+			node = node->u.s.magic;
 		}
 		else if (cmp > 0) {
 			/* Search in past node */
-			if (node->prev)
-				node = node->prev;
+			if (node->u.s.prev)
+				node = node->u.s.prev;
 			else
-				node = node->parent;
+				node = node->u.s.parent;
 		}
 		else {
 			/* Search in future node */
-			if (!node->parent) {
+			if (!node->u.s.parent) {
 				/* Restart from root_node */
 				seen_node = node;
 				node = &root_node;
 			}
 			else
-				node = node->parent;
+				node = node->u.s.parent;
 		}
 		if (!node || node == seen_node) {
 			/* We've been here before, give up search */
@@ -591,15 +591,15 @@ static unsigned char *lookup_notes(const struct commit *commit)
 		}
 	}
 	while (cur_node &&
-	       SUBTREE_DATE_PREFIXCMP(cur_node->period, seen_node->period) < 0)
+	       SUBTREE_DATE_PREFIXCMP(cur_node->u.s.period, seen_node->u.s.period) < 0)
 	{
 		/*
 		 * We're about to move cur_node backwards in history. We are
 		 * unlikely to need this cur_node in the future, so free() it.
 		 */
-		note_tree_free(cur_node->child);
-		cur_node->child = NULL;
-		cur_node = cur_node->parent;
+		note_tree_free(cur_node->u.s.magic);
+		cur_node->u.s.magic = NULL;
+		cur_node = cur_node->u.s.parent;
 	}
 	cur_node = seen_node;
 
-- 
1.6.5.rc0.82.g1c5d9
