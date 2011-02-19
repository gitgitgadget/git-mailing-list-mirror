From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 23/72] gettextize: git-checkout "Switched to a .. branch" message
Date: Sat, 19 Feb 2011 19:24:06 +0000
Message-ID: <1298143495-3681-24-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTj-0003Eb-Qc
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002Ab1BST1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:51 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab1BST1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:44 -0500
Received: by ewy5 with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=TOTo01pt4JAWCKe3ICWNlZnntxE5dCuFzMXUMn1FAFo=;
        b=tLJy233DBachDHWtvh15s+AKoOSiXUHlcpudQoHGwkDynVxQhuMfc4uiHMtwJ6Gyls
         Dmss0a5L+W7M6RPkqnaRjy1VvsdX1jLqRwQjYI0u4xli3ZRED6UAAWm00XS2btalGR0h
         6+c3PhHUclOjaAt9YfdvUsOIp3qtNjEUXGr3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AVoHcHFbMNtwaAuNH/MjtqImnC9t0Rm6lWrMOpXyrUqm2jRi0By3aOxTdo7JRHPXEX
         gHlZfhlqXre76jIgGONNaGoki1HuSJWR5+z3qqH3vuyUQArnnzseiho8AWmaBTxK/gJE
         CpjgQzBrV9TEJeiZ9qhIF2vrBM75qtyxDJOXw=
Received: by 10.213.110.18 with SMTP id l18mr2198127ebp.45.1298143663140;
        Sat, 19 Feb 2011 11:27:43 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.42
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:42 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167330>

Split up the "Switched to and reset branch" and "Switched to a new
branch" messages to make them easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f833330..2bb7759 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -550,9 +550,10 @@ static void update_refs_for_switch(struct checkout=
_opts *opts,
 				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
 			else if (opts->new_branch)
-				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->branch_exists ? " and reset" : " a new",
-					new->name);
+				if (opts->branch_exists)
+					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->na=
me);
+				else
+					fprintf(stderr, _("Switched to a new branch '%s'\n"), new->name);
 			else
 				fprintf(stderr, _("Switched to branch '%s'\n"),
 					new->name);
--=20
1.7.2.3
