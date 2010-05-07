From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/6] Move t6000lib.sh to lib-*
Date: Fri,  7 May 2010 19:37:01 +0000
Message-ID: <1273261025-31523-2-git-send-email-avarab@gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:40:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATPO-0003CZ-2R
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab0EGTkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:40:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43680 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab0EGTj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:39:57 -0400
Received: by fxm10 with SMTP id 10so1043881fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BVHGW5SGtlXe+3e5yZTTj1pLtfxUy9nIAl9BWArBRhU=;
        b=RtF0l/3RJT/Uk0rCRmMQJC3oOInaz/C4rbCtilYOYSjPeCudATyEGEOYWp4ckKstcI
         9zju4OJA0TSJ/tbpvuTKs4d230BtxcTG42RxSMRP2tZCVfPNOiJhdNK94orEAK8FxUND
         TTzHprCY68yuoICE1hVkyWJFuzywJuM0XhxjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oUBp+DXrgrWeG8S0ddqBeX4gnEyNSphhVkUIk6x61rEBNY0bWUdQkLZe5JMVFSq28j
         oheyIJiQ82o9JuGs7lHMAQn5KmIN7o3s5IlND4gqmX8LECIoIS7pVJk3iKdYSMeXorE7
         fZukDKg2cq6N6DvrXwSA4jvk8kw5F67hmuA8w=
Received: by 10.223.99.156 with SMTP id u28mr553036fan.53.1273261195807;
        Fri, 07 May 2010 12:39:55 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm8000128faj.5.2010.05.07.12.39.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:39:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146565>

The naming of this test library conflicted with the recommendation in
t/README's "Naming Tests" section. Now it's possible to na=C3=AFvely te=
st
t[0-9]*.sh with prove(1) without running into errors.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/{t6000lib.sh =3D> lib-t6000.sh} |    0
 t/t6002-rev-list-bisect.sh      |    2 +-
 t/t6003-rev-list-topo-order.sh  |    2 +-
 t/t6101-rev-parse-parents.sh    |    2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename t/{t6000lib.sh =3D> lib-t6000.sh} (100%)

diff --git a/t/t6000lib.sh b/t/lib-t6000.sh
similarity index 100%
rename from t/t6000lib.sh
rename to t/lib-t6000.sh
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index b4e8fba..fb07536 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -5,7 +5,7 @@
 test_description=3D'Tests git rev-list --bisect functionality'
=20
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/t6000lib.sh # t6xxx specific functions
+. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
=20
 # usage: test_bisection max-diff bisect-option head ^prune...
 #
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-ord=
er.sh
index 2c73f2d..e4c52b0 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -6,7 +6,7 @@
 test_description=3D'Tests git rev-list --topo-order functionality'
=20
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/t6000lib.sh # t6xxx specific functions
+. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
=20
 list_duplicates()
 {
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.s=
h
index f105fab..e673c25 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -6,7 +6,7 @@
 test_description=3D'Test git rev-parse with different parent options'
=20
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/t6000lib.sh # t6xxx specific functions
+. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
=20
 date >path0
 git update-index --add path0
--=20
1.7.1.dirty
