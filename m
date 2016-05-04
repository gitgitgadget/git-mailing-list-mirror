From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v5 2/4] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Wed,  4 May 2016 20:18:46 +0000
Message-ID: <1462393128-26762-3-git-send-email-avarab@gmail.com>
References: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
 <1462393128-26762-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 22:19:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3Gj-0005Iu-OR
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbcEDUTd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 16:19:33 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37007 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbcEDUT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:19:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id a17so113735659wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLlU9QtKdMxA8KBqX0HLr1h6sOPiRkIXyGY2uMEeL9c=;
        b=VR8QNVZ+3v5cPc82MQ6ncUVqb4Fo4noJqp60AKk+8R6DnF2oCBIzaUgk7D5b9XpIp5
         Xp0rDqdNZRGpOHH/Ta4niilvuk7BEpeEB9xbr+PGlwGzWYDhGnHVNKM3SLTLE6R/xyP8
         YGappHgBWfX+Z9wRWFJje2aUIkrZ9Tkzz4EeQ68tvTJQlRJRMtJ2rN2GqLz7getKwDTY
         WYLgtsbKEF1RwbijT37jJgm8SWtwESMvmKyRkeOB1CC4W4iX4gPh+fK3tddFFW9qLaFz
         +U1roWBNQU7lszRypt1nuqeC3sFgaCQ02vbDVpw5JLPVyIeQXd25nTfpe/1uPTMEfZkU
         abow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLlU9QtKdMxA8KBqX0HLr1h6sOPiRkIXyGY2uMEeL9c=;
        b=ZBVKSeXN/mYYT69Bptsq3Cfk4kpCFL0o42j/Q3IavFORvbToU+M4PoppvpZnmaYpqg
         Q0MPLKLeYcJlSmgo5DZ81sQ4rE2SZIMpmwdX49J44B2CtqIkFjN7iEKBIXSSq45oC5zB
         DaEZ17YHuL+Pt1vRV4Radyj3KxvT7j8JqB65x+MWYPasyuLWa8mde4BaHDHtUJ+KHQLg
         niXlXY9xI7OLGjUn0DFiYjPC9/MXvPPWzv7gKiyRRHWzsvmTA3G7oUUjgjA7I8jw0Rbx
         IRB7IcIUqM3v171Y1tHjUZl0uZTVO8ohK68i0zCOKoLhulZ4lmqaL0gQPFfe63mpDFlF
         yeCg==
X-Gm-Message-State: AOPr4FW8y7HpSQIJaCRf5XoEtcNyt4xw7gRiYIvAZWPzZlGdlDj8wIkprcor0hb93indUw==
X-Received: by 10.28.25.67 with SMTP id 64mr32542555wmz.10.1462393168325;
        Wed, 04 May 2016 13:19:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w79sm6795893wme.19.2016.05.04.13.19.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 13:19:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462393128-26762-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293585>

Any ACL you implement via an 'update' hook isn't actual access control
if the user has login access to the machine running git, because they
can trivially just build their own git version which doesn't run the
hook.

Change the documentation to take this dangerous edge case into account,
and remove the mention of the advice originating on the mailing list,
the users reading this don't care where the idea came up.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index cc082d2..d28dc4c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -276,9 +276,11 @@ does not know the entire set of branches, so it wo=
uld end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
=20
-Another use suggested on the mailing list is to use this hook to
-implement access control which is finer grained than the one
-based on filesystem group.
+In an environment that restricts the users' access only to git
+commands over the wire, this hook can be used to implement access
+control without relying on filesystem ownership and group
+membership. See linkgit:git-shell[1] for how you might use the login
+shell to restrict the user's access to only git commands.
=20
 Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
--=20
2.1.3
