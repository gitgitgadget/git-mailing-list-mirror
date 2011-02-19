From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 33/72] gettextize: git-fetch update_local_ref messages
Date: Sat, 19 Feb 2011 19:24:16 +0000
Message-ID: <1298143495-3681-34-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTm-0003Eb-1e
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab1BST17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46654 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab1BST1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:54 -0500
Received: by eye27 with SMTP id 27so2347171eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=j6SU6QZS+0fMEzOh7DVKUspJyI2ydjaiTMnmExVdEM8=;
        b=ZWygva9IVlrnd6X/aOozv7jWSeEQE8PxzxelN44kcA6WQWOjmHHcpcGfYIX1nZJB76
         xpHdnbPuR478wBDjEgTZkYjRnB5UeFfrL9JS2s4flw8wbSOOMNx8fK/5XIC36tvUpWnU
         LvKnbe9fkGEAS4TPM62CYtHd0r0Q6DV3xQAIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XKySUvODor6Uz/qCE2Sqd5uE1zuHsD71CtmTsXqoqZ1OaceyV7MoyalIAbOo/H+Jqu
         jDtrHXkGYGHgLROwFeVmH69z1PkBmzQdcUoe0B7JW3N8UKOj+ee7qufc5YKtFascNlm0
         wCotPwITPhFcg7Av44I2sq/1J/CS7gbXA+crY=
Received: by 10.14.45.16 with SMTP id o16mr2431544eeb.23.1298143673012;
        Sat, 19 Feb 2011 11:27:53 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.52
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:52 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167334>

Translate a "[rejected]" message spotted by Jeff King, and other
things in update_local_ref along with it.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0a73dff..4f622fd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -279,17 +279,17 @@ static int update_local_ref(struct ref *ref,
 		int r;
 		if (!strncmp(ref->name, "refs/tags/", 10)) {
 			msg =3D "storing tag";
-			what =3D "[new tag]";
+			what =3D _("[new tag]");
 		}
 		else {
 			msg =3D "storing head";
-			what =3D "[new branch]";
+			what =3D _("[new branch]");
 		}
=20
 		r =3D s_update_ref(msg, ref, 0);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
 			TRANSPORT_SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
-			r ? "  (unable to update local ref)" : "");
+			r ? _("  (unable to update local ref)") : "");
 		return r;
 	}
=20
@@ -302,7 +302,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : ' ',
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
-			pretty_ref, r ? "  (unable to update local ref)" : "");
+			pretty_ref, r ? _("  (unable to update local ref)") : "");
 		return r;
 	} else if (force || ref->force) {
 		char quickref[84];
@@ -314,7 +314,7 @@ static int update_local_ref(struct ref *ref,
 		sprintf(display, "%c %-*s %-*s -> %s  (%s)", r ? '!' : '+',
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
 			pretty_ref,
-			r ? "unable to update local ref" : "forced update");
+			r ? _("unable to update local ref") : _("forced update"));
 		return r;
 	} else {
 		sprintf(display, "! %-*s %-*s -> %s  (non-fast-forward)",
--=20
1.7.2.3
