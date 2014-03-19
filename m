From: babourn <ba.bourn@gmail.com>
Subject: [PATCH 2/2][GSoC 2014] diff: used is_dot_or_dotdot() in code
Date: Tue, 18 Mar 2014 18:30:36 -0700 (PDT)
Message-ID: <1395192636735-7605956.post@n2.nabble.com>
References: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 02:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ5L7-0002cQ-OQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 02:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700AbaCSBah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 21:30:37 -0400
Received: from sam.nabble.com ([216.139.236.26]:41478 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757668AbaCSBah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2014 21:30:37 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <ba.bourn@gmail.com>)
	id 1WQ5L2-0004bP-O2
	for git@vger.kernel.org; Tue, 18 Mar 2014 18:30:36 -0700
In-Reply-To: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244405>

in accordance with the GSoC Microproject implemented
the call is_dot_or_dotdot() in the code in order to
further universalize the call to the function and
increase code continuity.

Signed-off-by: Brian Bourn <bab2177@columbia.edu>
---
=C2=A0diff-no-index.c | 2 +-
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ba915af..44cce25 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -26,7 +26,7 @@ static int read_directory_contents(const char *path,
struct string_list *list)
=C2=A0 return error("Could not open directory %s", path);

=C2=A0 while ((e =3D readdir(dir)))
- if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+ if (!is_dot_or_dotdot(e->d_name))
=C2=A0 string_list_insert(list, e->d_name);

=C2=A0 closedir(dir);
--
1.9.0



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-GSo=
C-2014-diff-Imported-dir-h-and-renamed-read-directory-tp7605950p7605956=
=2Ehtml
Sent from the git mailing list archive at Nabble.com.
