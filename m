From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/15] init: mark "Initialized [...] repository" for
 translation
Date: Mon, 21 Feb 2011 04:17:54 -0600
Message-ID: <20110221101754.GG32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:18:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSqD-00024k-TC
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab1BUKSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:18:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45892 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1BUKR7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:17:59 -0500
Received: by mail-iy0-f174.google.com with SMTP id 26so556870iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BMDsbj7o+EMs018nzaFkzFeiLBdYJ3LymkMeu8i49Ag=;
        b=UCcZpcvwP5xVVLTYvglHAZjodHLFI/HfBK9lTvnq4roVJdnxquoIeMWpW6NDsmrqRz
         8FdMdjJPi8ZS8E+O/MdYjx6u2TQxtO0xHGifYRkQpd3qpgeiG1U5rQ4n8Z7nAcr/4wDv
         tSyeiJQ7BrcfVgvcKMF+k5MWd7IMo+gs0+v1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A8nZJb1FFbZ8OIj35PyMyknzkU24bTXo0sJa2w50/M8T0sP+YavHKCfotmA67VHlWq
         V8crdhPgvCwgKLzT5T28xppCH9KtkZ+P6oYIwHpxtZNOGZlEItBFEXNPqBkuXoT0c0xs
         kc7u6SGgXItsNBlqDSNZxpqHxbZsngTNnmaKU=
Received: by 10.42.170.200 with SMTP id g8mr1690398icz.436.1298283479296;
        Mon, 21 Feb 2011 02:17:59 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id gy41sm5074199ibb.23.2011.02.21.02.17.57
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:17:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167460>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Sat, 28 Aug 2010 15:32:15 +0000

These messages could benefit from splitting up.  An earlier version of
this patch began like this:

    const char *reinit_shared   =3D _("Reinitialized existing shared Gi=
t repository in %s\n");
    const char *init_shared     =3D _("Initialized empty shared Git rep=
ository in %s\n");
    const char *reinit_noshared =3D _("Reinitialized existing Git repos=
itory in %s\n");
    const char *init_noshared   =3D _("Initialized empty Git repository=
 in %s\n");

But in the first round of gettextization I'm aiming to keep code
changes to a minimum for ease of review.  So just add a comment
explaining to translators how the sprintf format gets used so they
can cope for now if the language's grammar allows.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I heard a rumor that this style of TRANSLATORS comment doesn't pass
unscathed through xgettext, but when I tried it with "make pot" it
worked okay.  Ideas?

 builtin/init-db.c |   12 +++++++++---
 t/t0001-init.sh   |    2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f7ddf5b..e0e5ce3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -354,9 +354,15 @@ int init_db(const char *template_dir, unsigned int=
 flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		const char *git_dir =3D get_git_dir();
 		int len =3D strlen(git_dir);
-		printf("%s%s Git repository in %s%s\n",
-		       reinit ? "Reinitialized existing" : "Initialized empty",
-		       shared_repository ? " shared" : "",
+
+		/*
+		 * TRANSLATORS: The first '%s' is either "Reinitialized
+		 * existing" or "Initialized empty", the second " shared" or
+		 * "", and the last '%s%s' is the verbatim directory name.
+		 */
+		printf(_("%s%s Git repository in %s%s\n"),
+		       reinit ? _("Reinitialized existing") : _("Initialized empty")=
,
+		       shared_repository ? _(" shared") : "",
 		       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
 	}
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f684993..dd4c00d 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -180,7 +180,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
=20
-test_expect_success 'reinit' '
+test_expect_success C_LOCALE_OUTPUT 'reinit' '
=20
 	(
 		sane_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
--=20
1.7.4.1
