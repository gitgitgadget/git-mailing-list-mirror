From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 029/144] t2102-update-index-symlinks.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:34 -0700
Message-ID: <1395735989-3396-30-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqZ-0001L1-As
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaCYIgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:36:25 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43194 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbaCYI1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:11 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so136244pad.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UIZ+sbdk7rE6tqVPqRmFbI0+GuDUnJKyxOYAEZbag54=;
        b=R63HOVKi/y4kSR8Q1RQIMi3dKghZXoZkLoh7xAhn+DNRgGBMZ+5sb7rrpAv3T9C8Iz
         hiKR1PZCAUO7pbxSbymFzfVjTzWTAx0EaH/OD5pHUn/FwblArsMMnmHagkv+Tnu1GBbx
         G3Tzmy6vmKYqI+Gg7ddpqOAwd40RsuaoviDS39lBrjqGfoG4oFgMy2XNfvoi5fcyVCjK
         fhNiux9M0opQL8NURmhwEAqgRVWqjpvix3oxWmm5PmCZlkkzoPYTzZI3t2ZVOmOD4Thv
         xYcXY55FRERy/XgzNQ7bSN8TrXADCuJTt1Z3mL3p8tGb4RRqiNVnWH53aCQW2aLxll9E
         CstQ==
X-Received: by 10.66.142.170 with SMTP id rx10mr76858348pab.117.1395736031172;
        Tue, 25 Mar 2014 01:27:11 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244995>

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
 t/t2102-update-index-symlinks.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-sy=
mlinks.sh
index 4d0d0a3..22f2c73 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -23,7 +23,7 @@ git update-index symlink'
=20
 test_expect_success \
 'the index entry must still be a symbolic link' '
-case "`git ls-files --stage --cached symlink`" in
+case "$(git ls-files --stage --cached symlink)" in
 120000" "*symlink) echo pass;;
 *) echo fail; git ls-files --stage --cached symlink; (exit 1);;
 esac'
--=20
1.7.10.4
