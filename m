From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/6] Turn setup code in t2007-checkout-symlink.sh into a test
Date: Fri,  7 May 2010 19:37:03 +0000
Message-ID: <1273261025-31523-4-git-send-email-avarab@gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:40:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATPQ-0003CZ-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab0EGTkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:40:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43680 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab0EGTkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:40:00 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1043881fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5Z56lucInpdpmC2da/HicRznxg3r58GQWlJ0XrWiYqI=;
        b=tPf1p5tF2ap+4/wwd4fxLPEyY06qTUPtY4d1j3AuAjxJx5Vm904lgb+4Ytye5zWgaH
         T/GJfnJbaChwDcJhFP7+0YHQQHCFZ/lV5MK4SbjZ99Cy5YvBqbtE0SjIe/+iYTxS5caN
         IsNhunxzBgO61Cwe1clSuk8XOKrBRbBc482Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PrBu2HAZkNlZVJRTdIrvx6uqhJvrA5dHeDSg/zd7f11nEscn0c5sW5EhR5huQ8L+Hb
         ekiIlVP1pOHqo78kXFxVHjCGg95TCZlWQip9ZYUJPH+3uYBfbEvGFziJca0fpsEJ2iXl
         hjnvBA0T8iSRMv0zrhbyvWG+eDJwRvW70a2zU=
Received: by 10.223.47.130 with SMTP id n2mr562594faf.55.1273261199509;
        Fri, 07 May 2010 12:39:59 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm8000128faj.5.2010.05.07.12.39.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:39:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146567>

Previously the test would print to stdout which interfered with the
TAP output. Now this scaffolding code is just a normal test.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t2007-checkout-symlink.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 616ca2a..05cc8fd 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -44,8 +44,10 @@ test_expect_success 'switch from symlink to dir' '
=20
 '
=20
-rm -fr frotz xyzzy nitfol &&
-git checkout -f master || exit
+test_expect_success 'Remove temporary directories & switch to master' =
'
+	rm -fr frotz xyzzy nitfol &&
+	git checkout -f master
+'
=20
 test_expect_success 'switch from dir to symlink' '
=20
--=20
1.7.1.dirty
