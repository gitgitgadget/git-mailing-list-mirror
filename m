From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 14/73] gettextize: git-add "Unstaged changes" message
Date: Tue, 22 Feb 2011 23:41:33 +0000
Message-ID: <1298418152-27789-15-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wy-0001H8-36
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab1BVXrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:47:20 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab1BVXnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:45 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RAHdOeGCNUJB5bV+wPN2MM3kiB2H1SHjF7edX5zNesk=;
        b=iK3fQUcARf1f12ByIDpiaQjtOlgDcJIOm14Q7R9GVBAihhIko7OBmHmUjRFKJMRj29
         n4PjDbEQo2arVNYIs1GmHMxePTxxL5hicerzD7RwfTDqQI6b1kp8ADKmSOroNcDXmAOG
         jvSuyhtbeL2clZE8T20D4a6nhCsL9MXi021QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qgB63S2ZH5yjB7wT4fFmM12MrPHxuEU/rzMCgLdrUG0fOCdrTRjPoTKu/nQOHJxOgI
         OCFvQONZIP7UxkON1zLu1+6kUMxpr6lEe1rlEkyKOFukLcC1QXvoc9geNIrqYu6yON13
         suRKOi6JtU3tIBF6RzCKIfzygsPD5vKgGekRU=
Received: by 10.204.68.65 with SMTP id u1mr3103499bki.193.1298418224578;
        Tue, 22 Feb 2011 15:43:44 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.43
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:44 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167653>

Make the "Unstaged changes after refreshing the index:"
translatable. It's displayed under `git add --refresh --verbose`.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 33b9970..a512597 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -188,7 +188,7 @@ static void refresh(int verbose, const char **paths=
pec)
 		/* nothing */;
 	seen =3D xcalloc(specs, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QU=
IET,
-		      pathspec, seen, "Unstaged changes after refreshing the index:"=
);
+		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
 	for (i =3D 0; i < specs; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"), pathspec[i]);
--=20
1.7.2.3
