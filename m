From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 20/20] gettextize: git-am printf(1) message to eval_gettext
Date: Tue,  7 Sep 2010 20:46:21 +0000
Message-ID: <1283892381-29826-1-git-send-email-avarab@gmail.com>
References: <1283878224-20202-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 22:46:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot544-0008Gj-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258Ab0IGUqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 16:46:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41409 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0IGUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 16:46:31 -0400
Received: by wyf22 with SMTP id 22so4678012wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ExuNhKfRB91Xq0A+fpyWosC8NHtVJ+VMyVBcKAWSzDw=;
        b=WEAaHjW5sYbVArP0RbaHAlExSiCtxU1jf0m8CXmGYWNxbPco3gShGtScmqRiUIJ4na
         13ejwMGwyBDEfZK58mVkZnnNOaXDdc5on+E9GhgDe8Fom1cL5Kug8gAOhsMAzWS4c9wx
         Ck+jenxaGHE0zRCmAam8hA52/F2MAbLq1kgaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pFY6KfSgWhBQ5b83lOF5DLoACe4TZ17AE+zN2A0xa5LqAJxIuGIHOrzIP+CF+7ub3s
         ZdsHlvt4UAwDnLU/Eyn1CyUHyRQOR0Yud3O6nIXmGE2Hl2uxRJJ3O06U9Xa0Ay8LyUtJ
         Jmi/c8nYWTQLzlbCutxsNSYXqAZ1Gmi4VFGQ8=
Received: by 10.227.141.84 with SMTP id l20mr218148wbu.119.1283892388460;
        Tue, 07 Sep 2010 13:46:28 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6094068wbb.10.2010.09.07.13.46.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 13:46:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283878224-20202-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155743>

Convert a message that used printf(1) format to use eval_gettext. It's
easier for translators to handle the latter, since the eval format
automatically gives them context via variable names.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Use eval_gettext directly as suggested by Jonathan Nieder.

 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6992d92..bf0258d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -778,7 +778,7 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status !=3D 0
 	then
-		printf 'Patch failed at %s %s\n' "$msgnum" "$FIRSTLINE"
+		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.2.3.313.gcd15
