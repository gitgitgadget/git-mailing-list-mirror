From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] arguments cleanup and some formatting
Date: Tue, 22 Nov 2005 15:59:22 +0100
Message-ID: <81b0412b0511220659u2d647b8aw5030ab7654dd8807@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4906_4844970.1132671562073"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 22 16:00:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeZcK-0001bl-2D
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 15:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVKVO7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 09:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVKVO7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 09:59:24 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:43604 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964960AbVKVO7X (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 09:59:23 -0500
Received: by nproxy.gmail.com with SMTP id x4so155652nfb
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 06:59:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=jtU055Fz+MUaiIfvb60D4yn1ICZbB4WlT1efQda8nDPge36iruNO4BM+QzcjFoBJxdHHdA3DOq3nUcz++6OtyHpBhZPI9i/9lk9ywnjqkT4R4kjsf05wLGJlPiRV/DbWkfX1eVKaaW5/MEtWUEBE2D6AsIhkYAYco3QuplTFAk0=
Received: by 10.48.248.6 with SMTP id v6mr388957nfh;
        Tue, 22 Nov 2005 06:59:22 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Tue, 22 Nov 2005 06:59:22 -0800 (PST)
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12551>

------=_Part_4906_4844970.1132671562073
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_4906_4844970.1132671562073
Content-Type: text/plain; 
	name=0003-arguments-cleanup-and-some-formatting.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0003-arguments-cleanup-and-some-formatting.txt"

Subject: [PATCH] arguments cleanup and some formatting

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 pack-redundant.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

applies-to: 50ace31f398f055b2d9b25dbc86c85ddf15beadc
571f5a3ff794ff1afba5b9b708116c307b0f6aa7
diff --git a/pack-redundant.c b/pack-redundant.c
index 8b37da9..82bc8ad 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -149,8 +149,9 @@ static inline struct llist_item * llist_
 }
 
 /* returns a pointer to an item in front of sha1 */
-static inline struct llist_item * llist_sorted_remove(struct llist *list, char *sha1,
-					       struct llist_item *hint)
+static inline struct llist_item * llist_sorted_remove(struct llist *list,
+						      const char *sha1,
+						      struct llist_item *hint)
 {
 	struct llist_item *prev, *l;
 
@@ -218,10 +219,11 @@ static inline size_t pack_list_size(stru
 	return ret;
 }
 
-static struct pack_list * pack_list_difference(struct pack_list *A,
-					struct pack_list *B)
+static struct pack_list * pack_list_difference(const struct pack_list *A,
+					       const struct pack_list *B)
 {
-	struct pack_list *ret, *pl;
+	struct pack_list *ret;
+	const struct pack_list *pl;
 
 	if (A == NULL)
 		return NULL;
@@ -350,8 +352,7 @@ static int is_superset(struct pack_list 
 	diff = llist_copy(list);
 
 	while (pl) {
-		llist_sorted_difference_inplace(diff,
-						pl->all_objects);
+		llist_sorted_difference_inplace(diff, pl->all_objects);
 		if (diff->size == 0) { /* we're done */
 			llist_free(diff);
 			return 1;
---
0.99.9.GIT

------=_Part_4906_4844970.1132671562073--
