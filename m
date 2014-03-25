From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 069/144] t5530-upload-pack-error.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:14 -0700
Message-ID: <1395735989-3396-70-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiW-0008K0-RG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbaCYI14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48834 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbaCYI1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:53 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so136923pad.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xGq4jlV/7VhYS9QbupX0eyfrzCWu+weDHons8tcDHF4=;
        b=JqHZIyEe3t+lvinUBD6mZirk1g8mg+eExMMXIOEKanBUTyzoVwtcjyAzaxSzdm+u+1
         bANpKIsT2GASQRZV0j+fj2DtY/Ez2HZIxLT3IwkOJCSzxjYac3rpiC/Cw8zu2IGjfDiZ
         uCURWYc+gZnfNOrFtGDtOEY60Y9r+m76jyz4oz0Kjgn4bwFWzulk2pIwlqASwB3x/9j2
         PcTYgZxnaI7y6mn3g5HtRmFuy2522oVqj7CcTmz5rQ6RizT4uhLmg3praXy2gbFgvW8e
         crkCPTX0C4Kp86Iyk8X04q4mGcJQrLihqnNWldxLblesHbOw44Hq0GV/9pK4ZsB14dHq
         BTFQ==
X-Received: by 10.68.178.1 with SMTP id cu1mr76148603pbc.34.1395736073010;
        Tue, 25 Mar 2014 01:27:53 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244928>

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
 t/t5530-upload-pack-error.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.s=
h
index 3932e79..4f6e32b 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -4,7 +4,7 @@ test_description=3D'errors in upload-pack'
=20
 . ./test-lib.sh
=20
-D=3D`pwd`
+D=3D$(pwd)
=20
 corrupt_repo () {
 	object_sha1=3D$(git rev-parse "$1") &&
--=20
1.7.10.4
