From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 047/144] t4057-diff-combined-paths.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:52 -0700
Message-ID: <1395735989-3396-48-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMoD-0006qq-TO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbaCYId4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:56 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47502 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCYI1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:30 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so133350pdj.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q38xcCF3dWTwwQBD6Vy5dejNFwcUicW9dDiJ04aWPqc=;
        b=gzLyMH59Hv0b3JPbb5qs5vIlLe2MRxk6ggRNPpU8qskqMr5KwbFUdyoWzSmoFd4g60
         zMAj1AWFnbBT3hUYXYRNkJBx1ctiSQVIiYzL4jrBqvMKFl8TtzOLIUvJLviJDzzsSb0i
         pqdKnRdtrKStVx1MmznCSi8M/32D/JBo9K44h6UJbxueaTgWevTgz3Trm9vY4SJBsYXF
         otIoAs3HLla4DNt+l8lAMDxJXsW82QJ7/Af+p7wedzDo3VbyTgFdn37wejZsrLW7rAhF
         WVmQ/MghEo6u6CaVuAmIPQVi0if3E1k9RcGzcJTHrSgJSD+Hk1xs9tldF7ZvsVzcD1+I
         wPEw==
X-Received: by 10.68.12.10 with SMTP id u10mr76624619pbb.39.1395736050253;
        Tue, 25 Mar 2014 01:27:30 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244981>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t4057-diff-combined-paths.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-pat=
hs.sh
index 097e632..dff36b7 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -5,7 +5,7 @@ test_description=3D'combined diff show only paths that =
are different to all parent
 . ./test-lib.sh
=20
 # verify that diffc.expect matches output of
-# `git diff -c --name-only HEAD HEAD^ HEAD^2`
+# $(git diff -c --name-only HEAD HEAD^ HEAD^2)
 diffc_verify () {
 	git diff -c --name-only HEAD HEAD^ HEAD^2 >diffc.actual &&
 	test_cmp diffc.expect diffc.actual
--=20
1.7.10.4
