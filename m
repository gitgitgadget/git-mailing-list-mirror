Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BD520A10
	for <e@80x24.org>; Tue,  7 Nov 2017 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbdKGFjs (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 00:39:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752842AbdKGFjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 00:39:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 810F1A8858
        for <git@vger.kernel.org>; Tue,  7 Nov 2017 00:39:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ZeJBVgOCJ6QsB5C85LaqBflnp
        Ec=; b=D2xXtPI/YZ7pFEYfYE/JSCDqEIb9HicPB/M55Waug6/lOuOBVzoJw+yvX
        KDsYgeY6yNjM0HYClnwP5trXak/s1Dam0I3DqG94nSGnuYX7lkzgrQjcA+1g4CI9
        EdfalEove8YLglUOl1ph6JIB3x+BPcaKt3yheRFcmVcKEuVle4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=rEIm5rYQ/YOo4IJvamk
        EVUnc6eTDC9XHihGlFOTByRq2rfWEg8tgjSB9YzyIHb1K405XSSy7Zgr50jmN8t0
        IRdl8o8h4cKWtCmTIVhE/wttwa8XmRoyp8G9un9DZxcqMUIYiQwJCfBX19XcItU5
        Hj3fRyYa9J5WbZlQkvZTGj3o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 788DAA8857
        for <git@vger.kernel.org>; Tue,  7 Nov 2017 00:39:46 -0500 (EST)
Received: from morphine.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2D99A8856
        for <git@vger.kernel.org>; Tue,  7 Nov 2017 00:39:45 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH/RFC] Replace Free Software Foundation address in license notices
Date:   Tue,  7 Nov 2017 00:39:33 -0500
Message-Id: <20171107053933.23370-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 100575C2-C37E-11E7-8AFA-575F0C78B957-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mailing address for the FSF has changed over the years.  Rather than
updating the address across all files, refer readers to gnu.org, as the
GNU GPL documentation now suggests for license notices.  The mailing
address is retained in the full license files (COPYING and LGPL-2.1).

The old address is still present in t/diff-lib/COPYING.  This is
intentional, as the file is used in tests and the contents are not
expected to change.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

As further rationale for this change, the package lint checks in Fedora (=
and
other distributions) look for installed files which contain references to
outdated Free Software Foundation mailing addresses.  (This occurs mostly=
 for
interpreted scripts in the installation.)

In the interest of ensuring that end-users who may read such files and sc=
ripts
and wish to contact the FSF for a copy of the license file, having a corr=
ect
address is useful.  Of course, changing piles of files anytime an address
changes is a bit of relatively useless churn.

Using the license notice template from the current GPL instructions=C2=B9=
 should
make this change easier, as it uses a URL which ought to be more stable t=
han a
postal address.  And, of course, both the git project and distributors of
binary packages like Fedora ship the full COPYING file(s) with the respec=
tive
tarballs/packages.

While the Fedora package lint checks don't see or care about the old addr=
ess in
source files which will be compiled before installation, it seems best to=
 be
consistent.  If that's not generally agreeable, I can submit a version of=
 this
patch which only touches files which are installed as-is and contain the =
old
FSF mailing address.

=C2=B9 https://www.gnu.org/licenses/gpl-howto.html

 compat/obstack.c                                                | 5 ++--=
-
 compat/obstack.h                                                | 5 ++--=
-
 compat/poll/poll.c                                              | 3 +--
 compat/poll/poll.h                                              | 3 +--
 compat/regex/regcomp.c                                          | 5 ++--=
-
 compat/regex/regex.c                                            | 5 ++--=
-
 compat/regex/regex.h                                            | 5 ++--=
-
 compat/regex/regex_internal.c                                   | 5 ++--=
-
 compat/regex/regex_internal.h                                   | 5 ++--=
-
 compat/regex/regexec.c                                          | 5 ++--=
-
 contrib/completion/git-completion.bash                          | 3 +--
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 3 +--
 contrib/credential/libsecret/git-credential-libsecret.c         | 3 +--
 contrib/emacs/git-blame.el                                      | 5 ++--=
-
 contrib/emacs/git.el                                            | 5 ++--=
-
 contrib/fast-import/import-directories.perl                     | 3 +--
 contrib/hg-to-git/hg-to-git.py                                  | 3 +--
 ewah/bitmap.c                                                   | 3 +--
 ewah/ewah_bitmap.c                                              | 3 +--
 ewah/ewah_io.c                                                  | 3 +--
 ewah/ewah_rlw.c                                                 | 3 +--
 ewah/ewok.h                                                     | 3 +--
 ewah/ewok_rlw.h                                                 | 3 +--
 git-gui/git-gui.sh                                              | 3 +--
 imap-send.c                                                     | 3 +--
 kwset.c                                                         | 4 +---
 kwset.h                                                         | 4 +---
 sh-i18n--envsubst.c                                             | 6 ++--=
--
 t/t9114-git-svn-dcommit-merge.sh                                | 4 +---
 trace.c                                                         | 3 +--
 xdiff/xdiff.h                                                   | 4 ++--
 xdiff/xdiffi.c                                                  | 4 ++--
 xdiff/xdiffi.h                                                  | 4 ++--
 xdiff/xemit.c                                                   | 4 ++--
 xdiff/xemit.h                                                   | 4 ++--
 xdiff/xinclude.h                                                | 4 ++--
 xdiff/xmacros.h                                                 | 4 ++--
 xdiff/xmerge.c                                                  | 4 ++--
 xdiff/xpatience.c                                               | 4 ++--
 xdiff/xprepare.c                                                | 4 ++--
 xdiff/xprepare.h                                                | 4 ++--
 xdiff/xtypes.h                                                  | 4 ++--
 xdiff/xutils.c                                                  | 4 ++--
 xdiff/xutils.h                                                  | 4 ++--
 44 files changed, 69 insertions(+), 103 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index e276ccd7b3..4d1d95beeb 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
-   Boston, MA 02110-1301, USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 #include "git-compat-util.h"
 #include <gettext.h>
diff --git a/compat/obstack.h b/compat/obstack.h
index ceb4bdbcdd..6bc24b7644 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
-   Boston, MA 02110-1301, USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 /* Summary:
=20
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index ae03b74a6f..7ed3fbbea1 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -16,8 +16,7 @@
    GNU General Public License for more details.
=20
    You should have received a copy of the GNU General Public License alo=
ng
-   with this program; if not, write to the Free Software Foundation,
-   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  *=
/
+   with this program; if not, see <http://www.gnu.org/licenses/>.  */
=20
 /* Tell gcc not to warn about the (nfd < 0) tests, below.  */
 #if (__GNUC__ =3D=3D 4 && 3 <=3D __GNUC_MINOR__) || 4 < __GNUC__
diff --git a/compat/poll/poll.h b/compat/poll/poll.h
index b7aa59d973..cd1995292a 100644
--- a/compat/poll/poll.h
+++ b/compat/poll/poll.h
@@ -16,8 +16,7 @@
    GNU General Public License for more details.
=20
    You should have received a copy of the GNU General Public License alo=
ng
-   with this program; if not, write to the Free Software Foundation,
-   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  *=
/
+   with this program; if not, see <http://www.gnu.org/licenses/>.  */
=20
 #ifndef _GL_POLL_H
 #define _GL_POLL_H
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d8bde06f1a..51cd60baa3 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, M=
A
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pa=
ttern,
 					  size_t length, reg_syntax_t syntax);
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5cb23e5d59..f3e03a9eab 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, M=
A
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 #ifdef HAVE_CONFIG_H
 #include "config.h"
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 61c9683872..4d81358a83 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -18,9 +18,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, M=
A
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 #ifndef _REGEX_H
 #define _REGEX_H 1
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.=
c
index 98342b8316..59bf151336 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, M=
A
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 static void re_string_construct_common (const char *str, int len,
 					re_string_t *pstr,
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.=
h
index 4184d7f5a6..3ee8aae59d 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
-   02111-1307 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 #ifndef _REGEX_INTERNAL_H
 #define _REGEX_INTERNAL_H 1
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 6f2b48a78b..1b5d89fd5e 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -14,9 +14,8 @@
    Lesser General Public License for more details.
=20
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, M=
A
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
=20
 static reg_errcode_t match_ctx_init (re_match_context_t *cache, int efla=
gs,
 				     int n) internal_function;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
index fdd984d34a..f07f16b28f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -111,8 +111,7 @@ __git ()
 #   GNU General Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License
-#   along with this program; if not, write to the Free Software Foundati=
on,
-#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+#   along with this program; if not, see <http://www.gnu.org/licenses/>.
 #
 #   The latest version of this software can be obtained here:
 #
diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyrin=
g.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 2a317fca44..d389bfadce 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -13,8 +13,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
 /*
diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/co=
ntrib/credential/libsecret/git-credential-libsecret.c
index 4c56979d8a..cfe295f36b 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
 /*
diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index e671f6c1c6..510e0f7103 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -25,9 +25,8 @@
 ;; PURPOSE.  See the GNU General Public License for more details.
=20
 ;; You should have received a copy of the GNU General Public
-;; License along with this program; if not, write to the Free
-;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-;; MA 02111-1307 USA
+;; License along with this program; if not, see
+;; <http://www.gnu.org/licenses/>.
=20
 ;; http://www.fsf.org/copyleft/gpl.html
=20
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5ffc506f6d..97919f2d73 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -15,9 +15,8 @@
 ;; PURPOSE.  See the GNU General Public License for more details.
 ;;
 ;; You should have received a copy of the GNU General Public
-;; License along with this program; if not, write to the Free
-;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-;; MA 02111-1307 USA
+;; License along with this program; if not, see
+;; <http://www.gnu.org/licenses/>.
=20
 ;;; Commentary:
=20
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-i=
mport/import-directories.perl
index 4dec1f18e4..a16f79cfdc 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -14,8 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
 #
 # ----------------------------------------------------------------------=
--
=20
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git=
.py
index 60dec86d37..de3f81667e 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -15,8 +15,7 @@
     GNU General Public License for more details.
=20
     You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    along with this program; if not, see <http://www.gnu.org/licenses/>.
 """
=20
 import os, os.path, sys
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 7103ceefbf..756bdd050e 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -14,8 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "cache.h"
 #include "ewok.h"
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 06c479f70a..b9fdda1d3d 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -14,8 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index f73210973f..bed1994551 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -14,8 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
index c723f1aefd..b9643b7d0f 100644
--- a/ewah/ewah_rlw.c
+++ b/ewah/ewah_rlw.c
@@ -14,8 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 269a1a8706..dc43d05b64 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -14,8 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef __EWOK_BITMAP_H__
 #define __EWOK_BITMAP_H__
diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index 63efdf9698..bb3c6ff7e0 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -14,8 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef __EWOK_RLW_H__
 #define __EWOK_RLW_H__
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 5bc21b878d..ed24aa9d2f 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -24,8 +24,7 @@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  S=
ee the
 GNU General Public License for more details.
=20
 You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  US=
A}]
+along with this program; if not, see <http://www.gnu.org/licenses/>.}]
=20
 ######################################################################
 ##
diff --git a/imap-send.c b/imap-send.c
index 8c785f3ca2..e0523d3427 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
 #include "cache.h"
diff --git a/kwset.c b/kwset.c
index e6236a0359..4fb6455aca 100644
--- a/kwset.c
+++ b/kwset.c
@@ -18,9 +18,7 @@
    GNU General Public License for more details.
=20
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with this program; if not, see <http://www.gnu.org/licenses/>. =
*/
=20
 /* Written August 1989 by Mike Haertel.
    The author may be reached (Email) at the address mike@ai.mit.edu,
diff --git a/kwset.h b/kwset.h
index 61a134f256..583f6268ef 100644
--- a/kwset.h
+++ b/kwset.h
@@ -17,9 +17,7 @@
    GNU General Public License for more details.
=20
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with this program; if not, see <http://www.gnu.org/licenses/>. =
*/
=20
 /* Written August 1989 by Mike Haertel.
    The author may be reached (Email) at the address mike@ai.mit.edu,
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index c3a2b5ad17..09c6b445b9 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -30,8 +30,7 @@
    GNU General Public License for more details.
=20
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software Foundatio=
n,
-   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  *=
/
+   along with this program; if not, see <http://www.gnu.org/licenses/>. =
 */
=20
 /* closeout.c - close standard output and standard error
    Copyright (C) 1998-2007 Free Software Foundation, Inc.
@@ -47,8 +46,7 @@
    GNU General Public License for more details.
=20
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software Foundatio=
n,
-   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  *=
/
+   along with this program; if not, see <http://www.gnu.org/licenses/>. =
 */
=20
 #include <errno.h>
 #include <stdio.h>
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-m=
erge.sh
index a3d388228a..50bca62def 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -27,9 +27,7 @@ cat << EOF
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-# MA 02111-1307 USA
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
 #
 EOF
 }
diff --git a/trace.c b/trace.c
index 7508aea028..cb1293ed33 100644
--- a/trace.c
+++ b/trace.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
 #include "cache.h"
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b090ad8eac..785ecb0899 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 93a65680a1..0de1ef463b 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 8b81206c9a..8f1c7c8b04 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 8c88dbde38..6881445e4a 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index d29710770c..1b9887e670 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index 526ccb344d..f35c4485df 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 165a895a93..2809a28ca9 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index f338ad6c75..1659edb453 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 9f91702de7..a44e776328 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 13b55aba74..abeb8fb84e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
index 8fb06a5374..947d9fc1bb 100644
--- a/xdiff/xprepare.h
+++ b/xdiff/xprepare.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 2511aef8d8..8442bd436e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04d7b32e4e..088001db4f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 4646ce5752..fba7bae03c 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -13,8 +13,8 @@
  *  Lesser General Public License for more details.
  *
  *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
--=20
2.15.0

