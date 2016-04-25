From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 2/3] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Mon, 25 Apr 2016 14:14:24 +0000
Message-ID: <1461593665-31395-3-git-send-email-avarab@gmail.com>
References: <1461593665-31395-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 16:15:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhI1-00085C-7e
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcDYOOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 10:14:51 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37309 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbcDYOOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 10:14:49 -0400
Received: by mail-wm0-f53.google.com with SMTP id n3so130129966wmn.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=g1X8PIBwSD+Pr6SYWnzPud700qv59gnQMGYkMPT1KTE=;
        b=QehZjFcJeotT5Hu7WQEHhvZsh3Bl9lTOnTeM1iHlt87FAWqhhyJz9DZRJ8veI+smoZ
         5XcMFDaxCNHi1C87W5YSTe/efZ8AU4syY6w32YPacp53BJU+rq+S7e/F3XYSv/Lh2hO3
         HWzI8fSJn+kbsM3bfzk1r67pDJFIB81L7j1QlZCahk5fuH4DseCWKPl7wxyWQYGXDxFX
         rQ4WX7g/r2NNFBP1faAHUc8qY734W+rdaiTD9+Ehnxuh2ggXoIDYFa1Xb7O9n9AY9rxh
         1Efmu+FlZ/b9EU9BXovJx8AXcexsew6puL01EPuKbgkUFhJvKquRNlBherH6t+7+Of0u
         PgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g1X8PIBwSD+Pr6SYWnzPud700qv59gnQMGYkMPT1KTE=;
        b=HPLZIchXnRV+calFfbwcnHOr9hFGWzXn4JziSX2Yaj8nQ22JkCD/t78hbVpP0PdWUt
         Coi8+1y95cDpbt4LUPzNduT7JsLTOdMK9uiAVSnsqDfOKbe4QSEJTLCgb/R0xEEsAV2V
         BU+Wq0KkDSodBL6E0jHIsLem0lHr/j/stfRUla2VX6kILn5mqy/2j+Y/4G1n8UidT2dw
         flltqZ23IVXKQOhF+Tpukpi6aX4Ri4vyiSAq9LZmv1QF1fMW1ebnmTmW/D1gVy6caVAk
         DoQBZjTtn5ZcUqyLkUxQ2YaSaTmbgIrhbimm60viULa+7qE18RbeCAsEmzm4+OD06+MP
         LUog==
X-Gm-Message-State: AOPr4FXeua/Hd6X3ovwM3sGNz1Fn6Vg9EDHQyJaMJj4dA7PaLvR/U8lMS3Y4dZ/rUigSOQ==
X-Received: by 10.28.213.142 with SMTP id m136mr13054249wmg.24.1461593688088;
        Mon, 25 Apr 2016 07:14:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d1sm23768565wjb.47.2016.04.25.07.14.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 07:14:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461593665-31395-1-git-send-email-avarab@gmail.com>
In-Reply-To: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
References: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292483>

Any ACL you implement via an 'update' hook isn't actual access control
if the user has login access to the machine running git, because they
can trivially just built their own git version which doesn't run the
hook.

Change the documentation to take this dangerous edge case into account,
and remove the mention of the advice originating on the mailing list,
the users reading this don't care where the idea came up.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 6db515e..38bea7d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -275,9 +275,13 @@ does not know the entire set of branches, so it wo=
uld end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
=20
-Another use suggested on the mailing list is to use this hook to
-implement access control which is finer grained than the one
-based on filesystem group.
+Another use for this hook to implement access control which is finer
+grained than the one based on filesystem group. Note that if the user
+pushing has a normal login shell on the machine receiving the push
+implementing access control like this can be trivially bypassed by
+just not executing the hook. In those cases consider using
+e.g. linkgit:git-shell[1] as the login shell to restrict the user's
+access.
=20
 Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
--=20
2.1.3
