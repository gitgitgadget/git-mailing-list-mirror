From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 006/144] git-stash.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:11 -0700
Message-ID: <1395735989-3396-7-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:38:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMsE-0003Nl-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbaCYIiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:38:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62028 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaCYI0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so124476pab.37
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MlzZzKQW0OwNNnsJBHN9y0i2iwOzrB3sEguti4pVr2s=;
        b=Y9aslI/n9h0yRkRn60st0Nl3u4g0ZFfECqZ3RDh+mwyI2zyCvln8+gjVK3LTYZg/hf
         U0OeQyMWnx6cqmJxjCaO27G7Rj+Nrevlfc8d8Nw3SoAtdNoe6rC39vfJB4h9lNyId0Uq
         5iCqOL3nXWcW2PKg6wUoRVzM+lFP/Tx6g7y2vZKkGCcYtrL7m6R0437nuVv/DV74GUJX
         oh6eHlJJ/dsCvgPeog+LZu+D1CkhQYCT81CT9UDOIRim9853ihscj44W1WPIp2DFVMjD
         /Z3/ZppxsT/r18buXmyfxpq6oETfRvTg6Y8WF1WHv0dRJYDn8s5ayOXTRenXU90OUg0S
         Dhfw==
X-Received: by 10.68.12.10 with SMTP id u10mr76620837pbb.39.1395736002052;
        Tue, 25 Mar 2014 01:26:42 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245011>

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
 git-stash.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4798bcf..af549c7 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -13,7 +13,7 @@ USAGE=3D"list [<options>]
=20
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
-START_DIR=3D`pwd`
+START_DIR=3D$(pwd)
 . git-sh-setup
 . git-sh-i18n
 require_work_tree
--=20
1.7.10.4
