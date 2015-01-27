From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 1/2] t2026 needs procondition SANITY
Date: Tue, 27 Jan 2015 16:38:49 +0100
Message-ID: <54C7B109.70700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:39:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG8EJ-0004Pr-QE
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 16:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbbA0PjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 10:39:00 -0500
Received: from mout.web.de ([212.227.17.11]:61435 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941AbbA0Pi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 10:38:58 -0500
Received: from macce.lan ([78.68.171.17]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LtnzN-1XWf1Z1rPB-011C1h; Tue, 27 Jan 2015 16:38:56
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:SYmxgJAjtgp88Ah/FTl51XKTJyh1rXe824xHbkkt5A0Zb/p2XfK
 rtKDZHJfUe5I1nzi6cagGrfEimCWmtyGTp9qBwWH+LmWuahJMT7AJno/KcHaepzkxTKns3N
 vrNrQo3KzBau3LpIRpE+puVZNgK7K7heBrCVx/VaNccqGWbVoJuG3i/U+C1ftKCqlsC03b4
 xpuDRlPSD5/hqhtawtdAg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263070>

When running t0026 as root 'prune directories with unreadable gitdir' f=
ails.
Skip this test if SANITY is not set (the use of POSIXPERM is wrong here=
)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Here is the promised patch, on top of pu:

The fix of t0026 is unrelated to all other patches, I think.

The advantage of the series is that it has been tested
on CYGWIN/MINGW/Mac/Linux/root@Mac, root@Linux,
the disadvantage may be that the commit message may need
improvements.


 t/t2026-prune-linked-checkouts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-c=
heckouts.sh
index 170aefe..2936d52 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -33,7 +33,7 @@ EOF
 	! test -d .git/worktrees
 '
=20
-test_expect_success POSIXPERM 'prune directories with unreadable gitdi=
r' '
+test_expect_success SANITY 'prune directories with unreadable gitdir' =
'
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
--=20
2.2.0.rc1.26.g3e3a70d
