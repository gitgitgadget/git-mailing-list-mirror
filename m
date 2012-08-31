From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] i18n: mark more index-pack strings for translation
Date: Fri, 31 Aug 2012 19:13:04 +0700
Message-ID: <1346415184-25685-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 14:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7QDF-00043H-VW
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 14:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab2HaMTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 08:19:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54326 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab2HaMTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 08:19:41 -0400
Received: by pbbrr13 with SMTP id rr13so4755034pbb.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ebLUZX1m72LH7kEeY33GqUX47pyvDEcicaoPEn3IkPo=;
        b=ibo1QFmzcrxIYQOYsOZOBkgFkTy+pn+J+9ONAYZ4zvSxznWVJbDAiZrY/QmRt5Nlmp
         DN8DaixV0uQyckv5j+CbPfB6vQusWCRA3Qe6zJOhPVWleCSo52PI/+yWcRT+UCfBQ+xs
         e0JJL31rtm0RzW+nNNcY0vZrgqFA9zIzZuqz17miMatWHy90FGrV4b93rv6yaVR9BkqU
         FMcpMhqyZV3hsQ11XW/PLmaHnqLko9YkK7MSXlXho1CHhq4L7C7L4mIfwMNlcpxUvAQO
         LhPz7Km7qghjPW6Dx6PybjYQ1aClYeV1EQVbXcLvQSEAeLDVujcKNgGdob4+vwDpkK48
         8SdA==
Received: by 10.68.221.42 with SMTP id qb10mr17007107pbc.155.1346415580947;
        Fri, 31 Aug 2012 05:19:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id os1sm3339348pbc.31.2012.08.31.05.19.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 05:19:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 31 Aug 2012 19:13:06 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204583>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The main string I'm after is "completed with %d local objects", which
 is part of typical UI. The rest is just "while at there..."

 To my surprise, (GNU) gettext does seem to know how to deal with
 PRIu32 macro in the middle of the string.

 builtin/index-pack.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 953dd30..43d364b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -291,7 +291,7 @@ static void parse_pack_header(void)
 	if (hdr->hdr_signature !=3D htonl(PACK_SIGNATURE))
 		die(_("pack signature mismatch"));
 	if (!pack_version_ok(hdr->hdr_version))
-		die("pack version %"PRIu32" unsupported",
+		die(_("pack version %"PRIu32" unsupported"),
 			ntohl(hdr->hdr_version));
=20
 	nr_objects =3D ntohl(hdr->hdr_entries);
@@ -1061,7 +1061,8 @@ static void resolve_deltas(void)
 			int ret =3D pthread_create(&thread_data[i].thread, NULL,
 						 threaded_second_pass, thread_data + i);
 			if (ret)
-				die("unable to create thread: %s", strerror(ret));
+				die(_("unable to create thread: %s"),
+				    strerror(ret));
 		}
 		for (i =3D 0; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
@@ -1108,7 +1109,7 @@ static void conclude_pack(int fix_thin_pack, cons=
t char *curr_pack, unsigned cha
 				   * sizeof(*objects));
 		f =3D sha1fd(output_fd, curr_pack);
 		fix_unresolved_deltas(f, nr_unresolved);
-		sprintf(msg, "completed with %d local objects",
+		sprintf(msg, _("completed with %d local objects"),
 			nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg);
 		sha1close(f, tail_sha1, 0);
@@ -1117,8 +1118,8 @@ static void conclude_pack(int fix_thin_pack, cons=
t char *curr_pack, unsigned cha
 					 curr_pack, nr_objects,
 					 read_sha1, consumed_bytes-20);
 		if (hashcmp(read_sha1, tail_sha1) !=3D 0)
-			die("Unexpected tail checksum for %s "
-			    "(disk corruption?)", curr_pack);
+			die(_("Unexpected tail checksum for %s "
+			      "(disk corruption?)"), curr_pack);
 	}
 	if (nr_deltas !=3D nr_resolved_deltas)
 		die(Q_("pack has %d unresolved delta",
@@ -1327,17 +1328,17 @@ static int git_index_pack_config(const char *k,=
 const char *v, void *cb)
 	if (!strcmp(k, "pack.indexversion")) {
 		opts->version =3D git_config_int(k, v);
 		if (opts->version > 2)
-			die("bad pack.indexversion=3D%"PRIu32, opts->version);
+			die(_("bad pack.indexversion=3D%"PRIu32), opts->version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
 		nr_threads =3D git_config_int(k, v);
 		if (nr_threads < 0)
-			die("invalid number of threads specified (%d)",
+			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
 #ifdef NO_PTHREADS
 		if (nr_threads !=3D 1)
-			warning("no threads support, ignoring %s", k);
+			warning(_("no threads support, ignoring %s"), k);
 		nr_threads =3D 1;
 #endif
 		return 0;
@@ -1510,8 +1511,8 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 					usage(index_pack_usage);
 #ifdef NO_PTHREADS
 				if (nr_threads !=3D 1)
-					warning("no threads support, "
-						"ignoring %s", arg);
+					warning(_("no threads support, "
+						  "ignoring %s"), arg);
 				nr_threads =3D 1;
 #endif
 			} else if (!prefixcmp(arg, "--pack_header=3D")) {
--=20
1.7.12.rc2.18.g61b472e
