From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/4] t/README: Document the Smoke testing
Date: Sun,  8 Aug 2010 14:49:25 +0000
Message-ID: <1281278967-31376-3-git-send-email-avarab@gmail.com>
References: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 16:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi7CZ-00055O-M5
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 16:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab0HHOtx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 10:49:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59084 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab0HHOtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 10:49:42 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so10744882wwj.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=55Puk0GE3fGkWBKEhV8oEs020XA4trKCDMUHs97iA/Y=;
        b=JbUo1fnxwwfzeVC+w7ULY1LzdMJnPH1b7gnM6jIkv1tsCpVNUDwp8dqXR/EAXqmPJY
         f1pCeNlBHssAa6bpJxuA1OcrBW/+R/m+Op/p9P8FnFlL0RTGy1GSI/Ln3Y0UI0AmmyDI
         ytZ6cXPhBTi6/O7qz0zwaGQeRd4DjomW0H/VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qsDOUWrttAOtTMgfVgfJ6BNb84F2aq952xXgM1N5gkdjP7aKtkZPL2mz0l1QPTOSIq
         i5xhgzRkaREflimgNjf+ZFA39uo+iJPseqbPL4eGE6dD8Ce+cbAc+yoKUk+rPI69FhzR
         dO+2EsVf0hWotjC1ZpPpYI0e80rP5oKx5aAQg=
Received: by 10.216.62.206 with SMTP id y56mr12826103wec.59.1281278981266;
        Sun, 08 Aug 2010 07:49:41 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm2005995weq.38.2010.08.08.07.49.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 07:49:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281278967-31376-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152913>

Git now has a smoke testing service at http://smoke.git.nix.is that
anyone can send reports to. Change the t/README file to mention this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index e957d4f..69af05f 100644
--- a/t/README
+++ b/t/README
@@ -574,3 +574,69 @@ Then, at the top-level:
 That'll generate a detailed cover report in the "cover_db_html"
 directory, which you can then copy to a webserver, or inspect locally
 in a browser.
+
+Smoke testing
+-------------
+
+The Git test suite has support for smoke testing. Smoke testing is
+when you submit the results of a test run to a central server for
+analysis and aggregation.
+
+Running a smoke tester is an easy and valuable way of contributing to
+Git development, particularly if you have access to an uncommon OS on
+obscure hardware.
+
+After building Git you can generate a smoke report like this in the
+"t" directory:
+
+    make clean smoke
+
+You can also pass arguments via the environment. This should make it
+faster:
+
+    GIT_TEST_OPTS=3D'--root=3D/dev/shm' TEST_JOBS=3D10 make clean smok=
e
+
+The "smoke" target will run the Git test suite with Perl's
+"TAP::Harness" module, and package up the results in a .tar.gz archive
+with "TAP::Harness::Archive". The former is included with Perl v5.10.1
+or later, but you'll need to install the latter from the CPAN. See the
+"Test coverage" section above for how you might do that.
+
+Once the "smoke" target finishes you'll see a message like this:
+
+    TAP Archive created at <path to git>/t/test-results/git-smoke.tar.=
gz
+
+To upload the smoke report you need to have curl(1) installed, then
+do:
+
+    make smoke_report
+
+To upload the report anonymously. Hopefully that'll return something
+like "Reported #7 added.".
+
+If you're going to be uploading reports frequently please request a
+user account by E-Mailing gitsmoke@v.nix.is. Once you have a username
+and password you'll be able to do:
+
+    SMOKE_USERNAME=3D<username> SMOKE_PASSWORD=3D<password> make smoke=
_report
+
+Once the report is uploaded it'll be made available at
+http://smoke.git.nix.is, here's an overview of Recent Smoke Reports
+for Git:
+
+    http://smoke.git.nix.is/app/projects/smoke_reports/1
+
+The reports will also be mirrored to GitHub every few hours:
+
+    http://github.com/gitsmoke/smoke-reports
+
+The Smolder SQLite database is also mirrored and made available for
+download:
+
+    http://github.com/gitsmoke/smoke-database
+
+Note that the database includes hashed (with crypt()) user passwords
+and E-Mail addresses. Don't use a valuable password for the smoke
+service if you have an account, or an E-Mail address you don't want to
+be publicly known. The user accounts are just meant to be convenient
+labels, they're not meant to be secure.
--=20
1.7.1
