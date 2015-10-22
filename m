From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: Re: [PATCH] Consider object stores in alternates during a dissociating
 clone
Date: Thu, 22 Oct 2015 18:41:17 +0200
Message-ID: <562911AD.50004@cetitec.com>
References: <561F8DE9.4040703@cetitec.com>	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>	<5628EBAF.1030205@cetitec.com> <xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpIvg-0005js-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 18:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbbJVQlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 12:41:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:64339 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbJVQlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 12:41:23 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue004) with ESMTPSA (Nemesis) id
 0M8n1M-1ZfS5L3FKm-00CD0a; Thu, 22 Oct 2015 18:41:19 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 19098B00935;
	Thu, 22 Oct 2015 18:41:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-2pDswrshRk; Thu, 22 Oct 2015 18:41:17 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id 2ABA4B00064;
	Thu, 22 Oct 2015 18:41:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:CwhwGQRghKUTDtnrhxuaxwFLnVnZIGnp4UJb1UnEHqE5sO4iQvk
 WPHS1lViD3wPFjQQFvdp6usn0lzeWcLUy1eIAfTZk0MYC0ibJkhcJ7e4Ee8hZzmWulrwGId
 XtxaB5mH5rxZrIOGBsO0PYyl/jYDUxY24Nj3O6riZwEoGoghdZnbMSBXneqBTkfqihR4HkD
 DhZI1fO+Bi9PyZSW3LZ9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kCsGygXtz5k=:cLBGquc6PuMpCLFaQ2j+z3
 mK9E2k8+u8dL8VWgRoTLlbUzob+FJB0GaRgP4o7RDT0wV42F7WK3YzeEnbQ1tiX8RgVZAz1is
 86sUlKDrKMoIXB1BehIPvzKwixi5lW+cVIlvwfQABgGFlNjY/QPmgnLiHCQQ1fFX2zBbUofYm
 5i+hgk0MzMexASI1CgMoWnMoZ4nEOFVD9wqIPwzmxN6oBwkrUkKWpYrmbxnuU4pA1vXhPmiRT
 im7T5gsqA/MNtdmpqkxNkwUyOSX+HeI/kLP79RZJxMI1VbBsvaZ2SFe9VC4VTFFCkewHapT54
 EleMCVdN7tP2y73vdUe3i32T0X/+uy4yKuvrNHXFIclesuOHwGL3PaqA6aDSux8X6917kxqBk
 HebLuNS8t1TV9gdcWiN9N67iIcUgI3wbw2/753WWYGUCqBabZQMEnlKX7k769MsI7IT9ixPEU
 fBEGkJ25G22MTRuwwShS4IvD9A38tCKh6xj81hd0p5Qh2owKCD2L90+hOo8d6unbhQOBVPgDY
 M8ANoAYzE11VPbF5vU4Ma5igRuf0vaJNkeicXB8YREsNPbmGRN+ovPfnVtH4Gmf1UJbUVf0Ke
 VWwlU5IWcavbd0XNC8dO+xdhWJNZfrOZ0lF5gQXM/XxtkxMSwBm1f9eh/fS6Suwi1Z6PgSMwo
 azYgAssf21mxZyi7qjcRCo/MCCBZPi3n288UpizDAl5mifa3QuF4xalrqfGV/5fa49XZpP7Jj
 /lz2U6xea8BKXvz6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280063>

From: Alex Riesen <raa.lkml@gmail.com>

The "--reference" option is not the only way to provide a repository to borrow
objects from.
For instance, the objects/info/alternates of the origin repository lists
object stores which the origin repository borrowed objects from. During
clone operations which bypass a git aware transport (i.e.  simply copy the
things over, like git clone --local) the file is copied into the cloned
repository.
In such a case, even if there were no reference repositories given in the
command-line, there might be still something to "dissociate" the cloned
repository from, before it is really independent.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
On 10/22/2015 06:12 PM, Junio C Hamano wrote:
> Alexander Riesen  <alexander.riesen@cetitec.com> writes:
 >> +    if (access(alts, F_OK) < 0)
 >> +        return;
 >
 > You leak alts here.

Fixed.

> Perhaps you would want a new  test somewhere that (1) prepares the
 > ultimate source, (2) prepares a borrowing source with "clone
 > --reference" from the previous, (3) creates a local clone of the
 > previous with "clone --local" without "--reference" but with
 > "--dissociate", and (4) checks the end result by ensuring the
 > absense of $GIT_DIR/objects/info/alternates and runs "fsck" on it.

Added. t5700-clone-reference seemed like a logical place for it.

Regards,
Alex

---
  builtin/clone.c            | 11 ++++++-----
  t/t5700-clone-reference.sh | 11 +++++++++++
  2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..1e14810 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -801,11 +801,16 @@ static void write_refspec_config(const char *src_ref_prefix,
  static void dissociate_from_references(void)
  {
      static const char* argv[] = { "repack", "-a", "-d", NULL };
+    char *alts = git_pathdup("objects/info/alternates");

+    if (access(alts, F_OK) < 0)
+        goto done;
      if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
          die(_("cannot repack to clean up"));
-    if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
+    if (unlink(alts) && errno != ENOENT)
          die_errno(_("cannot unlink temporary alternates file"));
+done:
+    free(alts);
  }

  int cmd_clone(int argc, const char **argv, const char *prefix)
@@ -954,10 +959,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)

      if (option_reference.nr)
          setup_reference();
-    else if (option_dissociate) {
-        warning(_("--dissociate given, but there is no --reference"));
-        option_dissociate = 0;
-    }

      fetch_pattern = value.buf;
      refspec = parse_fetch_refspec(1, &fetch_pattern);
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 2250ef4..dfa1bf7 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -210,4 +210,15 @@ test_expect_success 'clone, dissociate from partial 
reference and repack' '
      test_line_count = 1 packs.txt
  '

+test_expect_success 'clone, dissociate from alternates' '
+    rm -fr A B C &&
+    test_create_repo A &&
+    commit_in A file1 &&
+    git clone --reference=A A B &&
+    test_line_count = 1 B/.git/objects/info/alternates &&
+    git clone --local --dissociate B C &&
+    ! test -f C/.git/objects/info/alternates &&
+    ( cd C && git fsck )
+'
+
  test_done
-- 
2.6.2.313.gdf7a1dc
