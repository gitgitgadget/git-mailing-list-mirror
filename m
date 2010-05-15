From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/6] git-cvsserver: document making a password without htpasswd
Date: Sat, 15 May 2010 02:46:03 +0000
Message-ID: <1273891564-7523-6-git-send-email-avarab@gmail.com>
References: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 04:47:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD7PB-0008Qv-13
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 04:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356Ab0EOCqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 22:46:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:35894 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab0EOCqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 22:46:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so576992fgg.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=x1Y4h/slbBcSJrgmqmjU7CbWPQE4Ob8y3mOhV97Wodc=;
        b=OzRpryPfDK4RsYnLPS9bywH4Zinnasye0BeqVs0I95rBWhtYe/nW4fjS2MCsaevWHU
         I+7iJWHWWYiggmezuayCFreU69INMj5jl/KPoT7Rw3qtQp/8jvyCe4d4rwlnDm/xdZqc
         XkAuBx8NHeAvnu/IxDkehLnymUddpAs4BwFws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j5Gr+2txAMAYVGlFDsybjwjaSE18kEXQ1ZN+AnriJrDED93SXu9jOcCFX0NsL2pPP8
         pQO3a4pOG+L1cqzJ5CpZtsv9yu80+8b5cWYrmwtB21IZXx9UauyrPft8V4b5RWXDpvUx
         IzfPPbg5+P1fa40Zqwc9Fx45eX+JpaV0QPOQI=
Received: by 10.87.63.1 with SMTP id q1mr3908618fgk.38.1273891605440;
        Fri, 14 May 2010 19:46:45 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 22sm4155718fkq.17.2010.05.14.19.46.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:46:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147131>

This perl snippet is useful for quickly making a password without
htpasswd(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-cvsserver.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index bc2da8c..5825787 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -121,6 +121,11 @@ You can use the 'htpasswd' facility that comes wit=
h Apache to make these
 files, but Apache's MD5 crypt method differs from the one used by most=
 C
 library's crypt() function, so don't use the -m option.
=20
+Alternatively you can produce the password with perl's crypt() operato=
r:
+-----
+   perl -e 'my ($user, $pass) =3D @ARGV; printf "%s:%s\n", $user, cryp=
t($user, $pass)' $USER password
+-----
+
 Then provide your password via the pserver method, for example:
 ------
    cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <=
HEAD_name>
--=20
1.7.1.84.gd92f8
