From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] ref-filter: mark some file-local functions static
Date: Wed, 2 Dec 2015 20:02:49 +0000
Message-ID: <565F4E69.5050800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 21:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Dcp-0003RA-GP
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 21:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbbLBUDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 15:03:33 -0500
Received: from avasout08.plus.net ([212.159.14.20]:55938 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbLBUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 15:03:29 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout08 with smtp
	id ok2v1r0035UqX4q01k2wka; Wed, 02 Dec 2015 20:02:57 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=k5bdU34yff694eqKpu4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281913>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Karthik,

If you need to re-roll the patches in your 'kn/ref-filter-atom-parsing'
branch, could you please squash the relevant parts of this patch into
yours.

Thanks!

ATB,
Ramsay Jones

 ref-filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 08f43b7..036549b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -79,14 +79,14 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 	return 1;
 }
 
-void color_atom_parser(struct used_atom *atom)
+static void color_atom_parser(struct used_atom *atom)
 {
 	match_atom_name(atom->str, "color", &atom->u.color);
 	if (!atom->u.color)
 		die(_("expected format: %%(color:<color>)"));
 }
 
-void remote_ref_atom_parser(struct used_atom *atom)
+static void remote_ref_atom_parser(struct used_atom *atom)
 {
 	const char *buf;
 
@@ -104,7 +104,7 @@ void remote_ref_atom_parser(struct used_atom *atom)
 		die(_("improper format entered align:%s"), buf);
 }
 
-void contents_atom_parser(struct used_atom *atom)
+static void contents_atom_parser(struct used_atom *atom)
 {
 	const char * buf;
 
@@ -127,7 +127,7 @@ void contents_atom_parser(struct used_atom *atom)
 		die(_("improper format entered contents:%s"), buf);
 }
 
-void objectname_atom_parser(struct used_atom *atom)
+static void objectname_atom_parser(struct used_atom *atom)
 {
 	const char * buf;
 
@@ -153,7 +153,7 @@ static align_type get_align_position(const char *type)
 	return -1;
 }
 
-void align_atom_parser(struct used_atom *atom)
+static void align_atom_parser(struct used_atom *atom)
 {
 	struct align *align = &atom->u.align;
 	const char *buf = NULL;
-- 
2.6.0
