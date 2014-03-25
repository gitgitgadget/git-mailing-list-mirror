From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 062/144] t5506-remote-groups.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:07 -0700
Message-ID: <1395735989-3396-63-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmu-0005Cs-5e
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbaCYIci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:32:38 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:60259 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbaCYI1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:46 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so128816pbc.41
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ToXjIBhskBX8hnhRntzmuhdnL/iZGv1CD00SIzkEjSE=;
        b=A1v6VygcOHHLNE2d2rer2Yu3ec7dIWO9g8eQPJK4mXQoQGy2vMxFm0aKp64cEjbOR0
         dDSOQtkWFMhbDwqBb+sy1dGn0xORQvvNe65iQpc87vFNQbh7b7U5t0lSGjuQDE+ofVnD
         TqHjZ2xoc1GLg/F4oeZdMug0TesSZimUDuyaPwXfuy1eSGgTD2MFuSp6LnIEz18glQEM
         mOn0Db+myiPMuGDrytA5eaXo5WDwX3sHd6uzAtzsiKPv3UJllMeZomXNMHWEVrr7BISh
         65S9++H4IG/9ZQtnKx/LeaDQ5tZcOlsUH/yLLnBkPr7CpYtf+1jiTyIdCqpT5jV8H3i7
         GWtA==
X-Received: by 10.68.108.1 with SMTP id hg1mr77257217pbb.80.1395736066099;
        Tue, 25 Mar 2014 01:27:46 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244973>

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
 t/t5506-remote-groups.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 530b016..83d5558 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -20,7 +20,7 @@ update_repos() {
 }
=20
 repo_fetched() {
-	if test "`git log -1 --pretty=3Dformat:%s $1 --`" =3D "`cat mark`"; t=
hen
+	if test "$(git log -1 --pretty=3Dformat:%s $1 --)" =3D "$(cat mark)";=
 then
 		echo >&2 "repo was fetched: $1"
 		return 0
 	fi
--=20
1.7.10.4
