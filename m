From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 67/72] gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
Date: Sat, 19 Feb 2011 19:24:50 +0000
Message-ID: <1298143495-3681-68-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUX-0003dU-LS
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab1BST2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:52 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46654 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab1BST2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:23 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347171eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=CrfSDQbSF+0Frq815JVbaqChaPTMsDvOf6fdnjgWNPs=;
        b=OoLocrtzZ8Kr43ZUjDqDR1ruQThnbIAIyfxcFrtvMTPExLry9xTkXZUd6m8mzE0aRo
         +BaaUY6hI7S6xSbp5G3NKwhXASUgVPmCHCyWDb4F/720eAoa39K7/yO1NYZ9X5H+/ZUQ
         0+EsNpSYfmxfs5hNNV/DesonhTl81a8Ji+IhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NEuT8aPbbzGWX62ljAbyZ6R0rpUYagq61GdSqW0niTfH4xqsneqnL8OC+f3g1Em3XY
         NDLwZkhyB6pkEXSRqdXcXLVLqQlaJfv91nnhzltDFczfTpGPCC1T3rTglfV4QGvQS8u9
         5n27enNdK50l62pWxRJqoR9t2yNzIqYk4/lWs=
Received: by 10.14.37.7 with SMTP id x7mr2411180eea.48.1298143703232;
        Sat, 19 Feb 2011 11:28:23 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.22
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:22 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167351>

Use sprintf format for the error message that's displayed if
GIT_NOTES_REWRITE_MODE is invalid, and leave a note in a TRANSLATORS
comment indicating what the message means.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 4c6cf85..a0aa995 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -382,8 +382,10 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewr=
ite(const char *cmd)
 		c->mode_from_env =3D 1;
 		c->combine =3D parse_combine_notes_fn(rewrite_mode_env);
 		if (!c->combine)
-			error("Bad " GIT_NOTES_REWRITE_MODE_ENVIRONMENT
-			      " value: '%s'", rewrite_mode_env);
+			/* TRANSLATORS: The first %s is the name of the
+			   environment variable, the second %s is its value */
+			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
+					rewrite_mode_env);
 	}
 	if (rewrite_refs_env) {
 		c->refs_from_env =3D 1;
--=20
1.7.2.3
