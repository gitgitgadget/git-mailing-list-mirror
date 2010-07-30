From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 2/2] t/README: Document the Smoke testing
Date: Fri, 30 Jul 2010 22:43:27 +0000
Message-ID: <1280529807-23677-3-git-send-email-avarab@gmail.com>
References: <1280529807-23677-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 00:44:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeyJA-00059b-PL
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 00:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934Ab0G3Wnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 18:43:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39482 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0G3Wns (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 18:43:48 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so2062883wwj.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CCNNiEDJmuSrufzDpL16XeIWBUj5pNfja2t0q3zNCT8=;
        b=bVy/inbRi99Ocf4fE2zX1BsiVrjJpghQbXNAI9IJ1IazSdoxPatxWAPkNVr+6TcAQr
         PJYKWKSn9H/oHUNbgWA0APiVR1cXKHJfiGO9+MVtLIn8e6RlDonS0Nbd5p9Ljyh6gR/c
         9YWvcadSdfWk1m6CUX3dDjJixDMQOdpnd1wp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oeID+CnKX4cJfhESOmp46Cg2qVkwmfNEsDRpocctJJO7uqnk4tOP8oLiaSKRlEZejm
         eT3rOVrJTMnW1rhlJZpcz8u2JsuLnggQmb4diu9DVfk1f6wGLqAIz4CsoFX2/8c83aqY
         sg1+R4KhBMVJz7TS/69N9fVFz/531Y6kSDoIs=
Received: by 10.227.155.135 with SMTP id s7mr2273695wbw.100.1280529827106;
        Fri, 30 Jul 2010 15:43:47 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id i25sm2309162wbi.22.2010.07.30.15.43.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 15:43:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1280529807-23677-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152271>

Git now has a smoke testing service at http://smoke.git.nix.is that
anyone can send reports to. Change the t/README file to mention this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index e957d4f..48418e9 100644
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
+when you submit the results of a test run to a central sever for
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
