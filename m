From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 34/73] gettextize: git-fetch update_local_ref messages
Date: Tue, 22 Feb 2011 23:41:53 +0000
Message-ID: <1298418152-27789-35-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w8-0000rs-D1
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab1BVXq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:27 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1BVXoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:06 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=j6SU6QZS+0fMEzOh7DVKUspJyI2ydjaiTMnmExVdEM8=;
        b=ARrmD1d1ziAn7wQXml0dfUbuiL76tnNZzjpOQp3Nr02RGY+pVIJJEqaI9rtHEaJu8Z
         Zs7UTQZ/yJ2Cw9cU1sTn9fnglpCuKxMG+2KwtrW9jpOdXAP7rcBTLJm3WZ9SOR/oTQWf
         X19JX57F+cTf1PtGCBP5S9ca20vhndhDw/fsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UvtQInajw4QTvV5C0ID3cMMBokHPCGgqmC7B6Esk8xCKCmwJGSmfi+SAbYfLZZ5D7n
         zsrg2lDrjh5PqFn1xP9Jx+SsB4V7OluATvbRsP+Labz8BolGFh+Vl9XjfLrgmQiL9qxV
         GvR59Hka66h+6x5VxRRhV90H1C8Xwk16zTato=
Received: by 10.204.117.10 with SMTP id o10mr3060078bkq.10.1298418245128;
        Tue, 22 Feb 2011 15:44:05 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.04
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:04 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167632>

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
