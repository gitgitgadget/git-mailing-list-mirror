From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Make some strbuf_*() struct strbuf arguments const.
Date: Sun, 13 Jul 2008 20:28:24 +0200
Organization: Chalmers
Message-ID: <487A4948.8080003@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7vod55o0tx.fsf@gitster.siamese.dyndns.org> <48768F30.8070409@etek.chalmers.se> <7v3amhnwy9.fsf@gitster.siamese.dyndns.org> <48769E40.8030303@etek.chalmers.se> <48769E91.60205@etek.chalmers.se> <7vy747fx9x.fsf_-_@gitster.siamese.dyndns.org> <487A46C5.6000503@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI6K4-00071J-Qo
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbYGMS20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 14:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbYGMS20
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:28:26 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:42374 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbYGMS20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:28:26 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id D6D0C11C5E;
	Sun, 13 Jul 2008 20:28:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <487A46C5.6000503@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88318>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

 strbuf.c |    2 +-
 strbuf.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 4aed752..7767170 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -67,7 +67,7 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] =3D '\0';
 }
=20
-int strbuf_cmp(struct strbuf *a, struct strbuf *b)
+int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 {
 	int cmp;
 	if (a->len < b->len) {
diff --git a/strbuf.h b/strbuf.h
index faec229..a1b0143 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -61,7 +61,7 @@ static inline void strbuf_swap(struct strbuf *a, stru=
ct strbuf *b) {
 }
=20
 /*----- strbuf size related -----*/
-static inline size_t strbuf_avail(struct strbuf *sb) {
+static inline size_t strbuf_avail(const struct strbuf *sb) {
 	return sb->alloc ? sb->alloc - sb->len - 1 : 0;
 }
=20
@@ -78,7 +78,7 @@ static inline void strbuf_setlen(struct strbuf *sb, s=
ize_t len) {
=20
 /*----- content related -----*/
 extern void strbuf_rtrim(struct strbuf *);
-extern int strbuf_cmp(struct strbuf *, struct strbuf *);
+extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
=20
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
@@ -98,7 +98,7 @@ extern void strbuf_add(struct strbuf *, const void *,=
 size_t);
 static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 	strbuf_add(sb, s, strlen(s));
 }
-static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2=
) {
+static inline void strbuf_addbuf(struct strbuf *sb, const struct strbu=
f *sb2) {
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
--=20
1.5.4.5
