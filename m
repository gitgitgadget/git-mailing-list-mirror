From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/20] worktree: move repo, simple case
Date: Wed,  3 Feb 2016 16:35:49 +0700
Message-ID: <1454492150-10628-20-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsn-0006rZ-Em
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbcBCJhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:43 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33716 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbcBCJhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:39 -0500
Received: by mail-pa0-f47.google.com with SMTP id cy9so10869241pac.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lMv67wtedLKrf63eLgICVJ262L7e/sk2F48HBy62JOA=;
        b=jRYKaf9e1ycrod8Xsc5w5KDlSdsg44/jTrlTAvxmnQkKIofEl/l9vDdanS9JtYiEO8
         l6ooppOvFDWN2ClyOrCunYV8uQNidzRvdd9GEMH4ZJyD3xLugvrUZIu0TRhphfD+QlMH
         whly0ZFWUnma9KTGGFSOjibAx53kbGvpOpkP+yB80aJv6rTu75xjLmUcf6HeXbM62s8A
         WIlvPjiOdZF8LjnPQJSBjrKcVqJ/8xPpteTFJdyqPFTJaJcKJrZcp3fmnq0zvDLSce8H
         pYX0T8ZIGz3q1a5Bq160bXxqoPOs0RQaYiM5IxvK4DZReQaICo0Tty6Elb5K3/MsmU4v
         d56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lMv67wtedLKrf63eLgICVJ262L7e/sk2F48HBy62JOA=;
        b=cdid9X9u7L+s0jEKlHAlfnpq82CD/M8GPLgimfEubGqE3AvI28/q1UOsXoF6R/bMU7
         pCKLpCeoV1701vGc2TSjMRg1UmuThYPgs8gXrzP2h1M4I5FQBEIzoEBmGzRzDINWsG+N
         pXlFf/bwXHhASTXs4ZrO+NGnEoM6AQ8mQm/nwJI0B5OYTw6UB0uElUq6jRRq3k723zHw
         YOcemsFczCSU1pzO1UfyvGp0kUnd+sOpv/8F75Uxg3fjFZHHDybmtSlZrExfYAdUHBxI
         mhnRiOQdT+vbDYbAOS1yvS0LvsU5snv6whVlOZqnkXonwem8J1reW4BrBFAgvN6WfaFf
         35kg==
X-Gm-Message-State: AG10YOT4ZjlHF3P9puXsePeN9bcoJkhiLNJ7N0D+POEPV8HLXyIUFGFb2/6Z5IPjHG1knQ==
X-Received: by 10.66.150.37 with SMTP id uf5mr788704pab.30.1454492259505;
        Wed, 03 Feb 2016 01:37:39 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id mj1sm8326138pab.34.2016.02.03.01.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:50 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285363>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3ebb9e9..80a8b80 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -477,9 +477,52 @@ static int list(int ac, const char **av, const cha=
r *prefix)
 	return 0;
 }
=20
+static int move_gitdir(int ac, const char **av, const char *prefix)
+{
+	struct string_list paths =3D STRING_LIST_INIT_NODUP;
+	struct strbuf dst =3D STRBUF_INIT;
+	struct strbuf src =3D STRBUF_INIT;
+	struct worktree **worktrees, *mwt =3D NULL;
+	int i, ret =3D 0;
+
+	if (ac !=3D 1)
+		die(_("--repository requires one argument"));
+
+	strbuf_addstr(&src, real_path(get_git_common_dir()));
+	strbuf_addstr(&dst, real_path(prefix_filename(prefix, strlen(prefix),=
 av[0])));
+
+	worktrees =3D get_worktrees();
+	for (i =3D 0; worktrees[i]; i++) {
+		if (is_main_worktree(worktrees[i]))
+			mwt =3D worktrees[i];
+		string_list_append(&paths,
+				   get_worktree_git_dir(worktrees[i]));
+	}
+
+	if (mwt)
+		die(_("converting main worktree is not supported"));
+
+	ret =3D copy_dir_recursively(src.buf, dst.buf);
+	if (ret)
+		die(_("failed to copy '%s' to '%s'"), src.buf, dst.buf);
+
+	for (i =3D 0; paths.nr; i++)
+		if (update_worktree_gitfile(paths.items[i].string, dst.buf,
+					    worktrees[i]->id))
+			ret =3D -1;
+
+	if (!ret)
+		ret =3D remove_dir_recursively(&src, 0);
+
+	string_list_clear(&paths, 0);
+	return ret;
+}
+
 static int move(int ac, const char **av, const char *prefix)
 {
+	int move_repo =3D 0;
 	struct option options[] =3D {
+		OPT_BOOL(0, "repository", &move_repo, N_("move repository")),
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
@@ -487,6 +530,8 @@ static int move(int ac, const char **av, const char=
 *prefix)
 	struct strbuf src =3D STRBUF_INIT;
=20
 	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (move_repo)
+		return move_gitdir(ac, av, prefix);
 	if (ac !=3D 2)
 		usage_with_options(worktree_usage, options);
=20
--=20
2.7.0.377.g4cd97dd
