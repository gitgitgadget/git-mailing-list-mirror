From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/72] gettextize: git-add "no files added" message
Date: Sat, 19 Feb 2011 19:23:52 +0000
Message-ID: <1298143495-3681-10-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:26:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsRn-0002Ii-ER
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab1BST0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:26:23 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42014 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BST0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:26:22 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1969964ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=OgV4oMchV4L1hDHAho0U/DorcQuObhXOoqZwOstIHNw=;
        b=U8x8rO9SERkHf71/KCKKb3Z+8NDH/2GFnUvfxUxFh5FGcH1oaZR6anxVzwANKl7b/l
         8ztJZG+IFMdlqXiXauXvAMGG5zLeNLEb3YHqJxFTlwOyLn+LI0vxgfiBvOWJSozAocEh
         /C72ZKQ/+ghp81KlJdB577TvRx3BxXPZyLkWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wBI1jwPnGcR29cBZUTkDCx1UJ0GOIMaheJWE1jIpi7PpotOAAY7HckPm8dTJdECOJc
         NQlfPssIy8NQ51AqR5gKa1iAwwE1oXyPlToFnE6cIkCFs45YlAa8D+Unf4nsfCl/l+Yn
         Z0FBtoIXLvOGtQDu5Ko6C2t9FLl+r4n5iDfHs=
Received: by 10.213.19.207 with SMTP id c15mr460118ebb.76.1298143581727;
        Sat, 19 Feb 2011 11:26:21 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.56
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:26:20 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167316>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/add.c  |    2 +-
 t/t3700-add.sh |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a9a78f4..df56429 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -348,7 +348,7 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 		for (i =3D 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
 		fprintf(stderr, "Use -f if you really want to add them.\n");
-		die("no files added");
+		die(_("no files added"));
 	}
=20
 	for (i =3D 0; i < dir->nr; i++)
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ec71083..d4fc563 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -283,7 +283,10 @@ add 'track-this'
 EOF
=20
 test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file' '
-	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err &&
+	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err
+'
+
+test_expect_success NO_GETTEXT_POISON 'git add --dry-run --ignore-miss=
ing of non-existing file output' '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
--=20
1.7.2.3
