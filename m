From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 00/12] nd/icase updates
Date: Sun, 14 Feb 2016 18:49:44 +0700
Message-ID: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:51:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDI-0001H9-NN
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbcBNLvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36521 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbcBNLvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id e127so6238561pfe.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0PKRgswtCUHT6Z4sOY+GLdvOifbSl/DZ4eVcF0ZzzTE=;
        b=knTmumtD0goNKkciNWAqxQ7FU+qzVPIwZxMSFEVDSffQGLC0avFZyRMkoGENRs5i6h
         90xyOPiH433WcyGHnedB9u5q1sK+f42Mt/Ill6Uf8kaXA9qo8e++tA2h5lWwUiSori47
         AdxoaOETOB8XI/XePvwxvTpDx44xFO9s5zpOt5URLL4jW6DZRXfpbKHKX0gk/aiguc8G
         SLRvSXGClqyPHj09HQdlPhfMNykw0QtsoBAgyTRb/sq/6wK3ymW9hXRICCYHY2yvYs7e
         pImwC6czkuiEtdM9ahLaCYH2a7mrHK69ivHRdhGqMfjSWiBCy8ACLTY0PypX3Et4tBl8
         P30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=0PKRgswtCUHT6Z4sOY+GLdvOifbSl/DZ4eVcF0ZzzTE=;
        b=YKXVxOHVoq2wh8OLoLo/i/llKIlNqwY+4K606tGG8JXLZNMt3BWUjsstbhjgmcSpHi
         vVJhtJaDsA6EeL7sm1/v8cgBOPOTqj+urQ4QTnJcVQjDeoXy1yivD7Dlm19+jyC4SYrg
         6Ie65c49dlcSDFdnvwcETqLBmXU9GXqYy78xgxTCIggTFQndprZtSZTgqqpHHvcZDmX7
         ObKKK0M5IYK1WpTqotOKshH1ZwWMbCTyckZpcqZBA4FFQ/TJ5NuV5GfLpi2ewGfQtOKu
         XGWcb34nLGByfFer+5V+92YNna+hGtXPPEHdac0Cf1eaztOXgeRpZA7bmCd1wYDvQ3yK
         lRmA==
X-Gm-Message-State: AG10YOQUi5mVoJ23lSSY4bzo/Veb1dLhfmqYOCBFJfH4Pg3Qhhkq3n3sMymNHjcPlBqT4g==
X-Received: by 10.98.89.215 with SMTP id k84mr15842293pfj.66.1455450663017;
        Sun, 14 Feb 2016 03:51:03 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id cf6sm31350093pad.41.2016.02.14.03.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:50:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:51:14 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286137>

v7 addresses two comments from Junio and Eric in v6 and adds an extra
patch, 12/12, which reuses "icase" variable and avoids recalculating
the same thing (which can't be done before v6). Interdiff

diff --git a/grep.c b/grep.c
index aed4fe0..cb058a5 100644
--- a/grep.c
+++ b/grep.c
@@ -432,22 +432,20 @@ static void compile_regexp(struct grep_pat *p, st=
ruct grep_opt *opt)
 	icase	       =3D opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     =3D !has_non_ascii(p->pattern);
=20
-	if ((!icase || ascii_only) && is_fixed(p->pattern, p->patternlen))
-		p->fixed =3D 1;
-	else if (opt->fixed) {
+	if (opt->fixed) {
 		p->fixed =3D !icase || ascii_only;
 		if (!p->fixed) {
 			compile_fixed_regexp(p, opt);
 			return;
 		}
-	} else
+	} else if ((!icase || ascii_only) &&
+		   is_fixed(p->pattern, p->patternlen))
+		p->fixed =3D 1;
+	else
 		p->fixed =3D 0;
=20
 	if (p->fixed) {
-		if (opt->regflags & REG_ICASE || p->ignore_case)
-			p->kws =3D kwsalloc(tolower_trans_tbl);
-		else
-			p->kws =3D kwsalloc(NULL);
+		p->kws =3D kwsalloc(icase ? tolower_trans_tbl : NULL);
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
diff --git a/test-regex.c b/test-regex.c
index d1a952c..eff26f5 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -47,8 +47,8 @@ int main(int argc, char **argv)
 	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
 	else if (argc < 3)
-		die("usage: test-regex --bug\n"
-		    "       test-regex <pattern> <string> [<options>]");
+		usage("test-regex --bug\n"
+		      "test-regex <pattern> <string> [<options>]");
=20
 	argv++;
 	pat =3D *argv++;

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  grep: allow -F -i combination
  grep: break down an "if" stmt in preparation for next changes
  test-regex: isolate the bug test code
  test-regex: expose full regcomp() to the command line
  grep/icase: avoid kwsset on literal non-ascii strings
  grep/icase: avoid kwsset when -F is specified
  grep/pcre: prepare locale-dependent tables for icase matching
  gettext: add is_utf8_locale()
  grep/pcre: support utf-8
  diffcore-pickaxe: "share" regex error handling code
  diffcore-pickaxe: support case insensitive match on non-ascii
  grep.c: reuse "icase" variable

 builtin/grep.c                           |  2 +-
 diffcore-pickaxe.c                       | 27 ++++++++----
 gettext.c                                | 24 ++++++++++-
 gettext.h                                |  1 +
 grep.c                                   | 47 +++++++++++++++++----
 grep.h                                   |  1 +
 quote.c                                  | 37 +++++++++++++++++
 quote.h                                  |  1 +
 t/t0070-fundamental.sh                   |  2 +-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 71 ++++++++++++++++++++++++=
++++++++
 t/t7813-grep-icase-iso.sh (new +x)       | 19 +++++++++
 test-regex.c                             | 59 ++++++++++++++++++++++++=
+-
 12 files changed, 270 insertions(+), 21 deletions(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh
 create mode 100755 t/t7813-grep-icase-iso.sh

--=20
2.7.0.377.g4cd97dd
