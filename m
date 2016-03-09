From: David Turner <dturner@twopensource.com>
Subject: [PATCH 08/19] index-helper: add --detach
Date: Wed,  9 Mar 2016 13:36:11 -0500
Message-ID: <1457548582-28302-9-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyr-0007PD-L2
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933865AbcCISg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:58 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35914 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933811AbcCISgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:41 -0500
Received: by mail-qg0-f41.google.com with SMTP id u110so49367793qge.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7bT/glrziBxamIsdBbw0K6Mbx0en1hm15gNmwEM4Wkw=;
        b=F347QjYny9A6Rlr8SWRowKTjdGu9tfhMEJGXcG46k5bpiqq01FzFNGU0L19N47xl/d
         orFrSfTnca+39etoUJp2WK2/5QNOz8qiqVOHvBMmfxgYLZp0edw7B63LDTokqrzekhUX
         FnQUZ8XRuMnndTwkXz45QGyewmU3a9fgAJo2+XTPnLUwoffhTY/my5WuExcCDDR1W5bH
         akwOcHldleuOGmnyjUGXcbimSupHLp4HnabQviTuru6oHHJ3fOlGd8qPHApGdMutMecK
         YhVlzMFAiKQNz2eSiV6gmdOz5MtGW7JO7yKljriYy9ZGOWESRgyrqYBIV+tpmGKCnQgc
         iZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bT/glrziBxamIsdBbw0K6Mbx0en1hm15gNmwEM4Wkw=;
        b=FAeoMH4imcfksF9E+JcOOkrN7tTSsAwYIP0lGPKXDuIZKM9B8E85VfrWbFZd6ngcUX
         q8/bH/d+3RfNluX/iuJCfOiXAe0daM/dZIzKzT2dURU3eIEV22VP8ktI0j48bEUZPSu1
         j8cj5s6EMRnQGBLKUhJqIgfl2I+eF83bWvce6QJV2su94LE3xVFsyNKMEWZNFYYLa7AC
         tUEUNP3ju7udokXbQ/SHhgzRNE7P1+++nOdNNKLte//C92QwQaG/mzV2b05LcfvVVRi8
         UdvggRFNsJxJbozcFxim7RBOMnzXGc54ukSneYvjRXwCLD9sa+UEbEHcB/zMHSF4vxjf
         D5cw==
X-Gm-Message-State: AD7BkJKU3k/oC0Jwi121o0QqYa3b5yMZg2qJIXUQYLbL3BecD9ylGK/rxs33ZgM4e8kelA==
X-Received: by 10.140.224.18 with SMTP id u18mr43891478qhb.10.1457548600518;
        Wed, 09 Mar 2016 10:36:40 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288560>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index ad40366..9ced091 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -31,6 +31,9 @@ OPTIONS
 	for reading an index, but because it will happen in the
 	background, it's not noticable. `--strict` is enabled by default.
=20
+--detach::
+	Detach from the shell.
+
 NOTES
 -----
 On UNIX-like systems, $GIT_DIR/index-helper.pid contains the process
diff --git a/index-helper.c b/index-helper.c
index 1140bc0..4dd9656 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -14,7 +14,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -33,6 +33,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.pid"));
 	cleanup_shm();
 }
@@ -172,12 +174,13 @@ int main(int argc, char **argv)
 	static struct lock_file lock;
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *prefix;
-	int fd, idle_in_minutes =3D 10;
+	int fd, idle_in_minutes =3D 10, detach =3D 0;
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
 			    N_("exit if not used after some minutes")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -202,6 +205,9 @@ int main(int argc, char **argv)
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
+	if (detach && daemonize(&daemonized))
+		die_errno("unable to detach");
+
 	if (!idle_in_minutes)
 		idle_in_minutes =3D 0xffffffff / 60;
 	loop(sb.buf, idle_in_minutes * 60);
--=20
2.4.2.767.g62658d5-twtrsrc
