Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681510;
	b=IVVMqv3AM07iX/iXuXkPWbmyxO7hq2FupTiDKgZrODgqHDc8WIAQLM3wwSqlfJfVjfeo
	 nllcX4OqHuKhsDinwTZeIc0ZW6Apw7DPLWezDx+4s/AaGsoMF2saaVQYsT94/rCAQsC+U
	 tCylQECq6YHnNuAj5XWbp321F3Igs8fazqxjMazKqjwx1uJiTqIzM3QrhtMiewpDBAVI/
	 HaPpsiqdVSN92LzSRwuAkjjWiBe5gaMCPuUMjNGKSBz8x2Vt87ihsU29ardbOBceVXkJ5
	 RP1nQjt3fIEE2zIq3W0jJFoVNzHEAgcxLzih+3DtTo4KUVV/LqUjLiq8M6TvXdJYqfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
	b=fibdWRw/TKLFcuYsfZqLnLXAUwSNAQUYN8aQUpJ7XJRCdcGCoaZYGbP12VUCqfJAXbAg
	 ScVwhMAbz2gCmbGNGmwIWpVI72igFmYuwafxWUV3m6bDDc4SChooq2eIlLwW04DCHQliU
	 V7wBfdeCR8IWeX5I8pWtVfPAAHdCPoFDhLVh5sCTYUxTsOflhWKloUG1b+1s6YEd7lQ2+
	 T0hPPA3koBW0lIAGM/sfKi+KXHrIvDoH1eX1SVLGAr9+gn9Y7llgLie/gMu4jM2vUMfqe
	 f0oyECZPEWJR19tLkSqYkukgzdR5FZEMkJInIbJMNL3kExhK6DvBv+e/f/OuD2r+Sgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XI87Gcgz;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BC606A33D
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E1BC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XI87Gcgz
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb9f760337so1531150a12.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681509; x=1795286309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
        b=XI87GcgzA9Oh9wogVrh3xPZM7GqjnM+ghN1QwyURdV3UKTbWGFwhYhd3b8dm+PoTVJ
         BWjrIpKKVuX/TRBdLf2oEiNePcjNat7939p3x2tlb66043wCSdGSPcDTkj53lwWyLflZ
         cRmTqfBHjCVVQo42IT74OkzR4TX9veoIxr/I2QJBBAedgYTC7dQulNxclao9YqyHeA7f
         75Bx6PYDiyJOQEfb7Zy5cRkZlGZP/eyTkkusZNixMfxssSFDOf78YLPDaaQNyXI6TFji
         WdOfPCRxH+oXRN8jc1SlagIpTV4imOvBrJfsQEeW2lGgOt5g8xnGEmv5mFUou2RZTbcK
         HmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681509; x=1795286309;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
        b=s71Emn7mgDw8Gd9nhHd33ehSIyt0vkGV8B7tf2ZoxYJoTj25JkyKYZFcmwUC6lekXT
         BvTtsi/EeCdkGHxXti+srCWiow6GiyoEVWZz185jysT1gLyPBj8JnJeMhzLuGdAGM+f+
         yDe6cPqdo2D74zIC4JhI4mng1Jv4mYegtNL9jkbXPg18Xyn/Ol+p3zABPLG6RsKHIA3u
         c7IGi4zWv0ZMDzMDWxP0h76e7Ny+4/VVZV55FaL9kPm/IHr12dFSfKYya8MSct9oE3VD
         fXQfGS3nIHvxf+Z3xEgtd4rVTrP69C2nbPtriCmJm2E5zNaDWj6tL6RqCDQgSGaURgNY
         ywdw==
X-Gm-Message-State: APuU4Z92OLP2dnhQNX4WY2klHSvfPqdwvminlj0d+2w96mGqq9QtyAHn
	L7XMT/antMSg+X50Cz5pc4H8/c/9tZ4H9sWcYF6DZOPNWopzVrlb8CItaNMm7Q==
X-Gm-Gg: AYBFou268rVYcfmn8eZ7Ui9ILONcaeeAb0noQW0xFq2tBsRHQ/++dI9Ap6LQxpGyaBB
	wvOGNVtdWe/W1muvDnn+Q8D+pdJLHMXDHT6QcBJEjuAdaTMpBWsZ0WADejM82FGw3fsgfDeYQRj
	XZ0r2va/KaUiq/g5Rm+I4izjX7C5k7EDVRJh7xLujCLR2iL/+jygmM97Mj0dbkMu4xsNdHQyOqC
	ZSsWdW8RPxHRq3uZ746kvL2qmwvBbOhAguceDMAOIbEdw1P7CMapsneR395sBPpAqZWA/aUR/s6
	XI+Rt+HteIJdL2J6NUagFh8t7NVuU/TsFTNYbAohrsl2oE1majYFU3K2G1sxlpBx4QitcNIii7U
	p7FkfAxPn2G1foRMx14Vj9UvGVZoiu9EtV+wS4X8i8K+ZWg/JR/qsT68JNTMGhR6Boha6TeF4eX
	W/jqNQ03A3o4JDRfMfUOaaM61rGvgaUR3psFq2uF30q6BqafUQotABf3Nukq3x7eOAzAYR1QG55
	GgGHI0k8eQBC+JAfVvbLuYlt3bnwLwSL9B9djWmtJF0HIhkcwcEq1CS2ov8mD1eWaujy81j/x7R
	t1+ATVagTWcsGPs5rHLo0SL0wlR6m+j+Tnzc6HRfQJO/RAx2EK71ZxOIomS/rgvt13dBglhHIYT
	FvbA3JoCK
X-Received: by 2002:a17:90b:4c02:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b1b0da3e56mr3998650a91.43.1794681509388;
        Sat, 14 Nov 2026 10:38:29 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-139.us-west-2.compute.amazonaws.com. [3.42.157.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae98151dsm9694318a91.2.2026.11.14.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:38:27 -0800 (PST)
Message-Id: <6cff6786bae51c9a2ab73b522095dc63d1861010.1794681496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 18:38:15 +0000
Subject: [PATCH v14 4/5] remote: add "git remote add --limited-fetch"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A remote added the ordinary way tracks every branch it has, via a
wildcard remote.<name>.fetch refspec. That is wasteful for a remote
whose history is only worth following for the branches actually in
use locally, and it can make "git fetch" negotiate history for
branches nobody asked for.

Give "git remote add" a --limited-fetch option that sets up
remote.<name>.fetchRefmap instead of remote.<name>.fetch, so that
"git fetch <name>" only fetches the branches already tracked, as
described in the previous commit. It is rejected together with
-t/--track or --mirror, since those already say explicitly what to
fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 +++++++-
 builtin/remote.c              | 28 ++++++++++++++++++++++------
 t/t5505-remote.sh             | 16 ++++++++++++++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 315100409d..1f490819ba 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git remote [-v | --verbose]
-git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
+git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] [--[no-]limited-fetch] <name> <URL>
 git remote rename [--[no-]progress] <old> <new>
 git remote remove <name>
 git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
@@ -75,6 +75,12 @@ the `refs/remotes/<name>/` namespace, a refspec to track only _<branch>_
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
+With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
+that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
+refspec-less `git fetch <name>` only fetches branches our local branches
+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
+details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..5f8a8a2f71 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -179,6 +179,7 @@ static int add(int argc, const char **argv, const char *prefix,
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
+	int limited_fetch = -1; /* unspecified */
 	struct string_list track = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
 	struct remote *remote;
@@ -198,6 +199,8 @@ static int add(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
 			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt),
+		OPT_BOOL(0, "limited-fetch", &limited_fetch,
+			N_("fetch only the branches we build on, instead of every branch")),
 		OPT_END()
 	};
 
@@ -211,6 +214,10 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if (limited_fetch == 1 && track.nr)
+		die(_("--limited-fetch does not make sense with -t/--track"));
+	if (limited_fetch == 1 && mirror)
+		die(_("--limited-fetch does not make sense with --mirror"));
 
 	name = argv[0];
 	url = argv[1];
@@ -230,13 +237,22 @@ static int add(int argc, const char **argv, const char *prefix,
 	repo_config_set(the_repository, buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
+		bool use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
+			limited_fetch == 1;
+
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.fetch", name);
-		if (track.nr == 0)
-			string_list_append(&track, "*");
-		for (size_t i = 0; i < track.nr; i++) {
-			add_branch(buf.buf, track.items[i].string,
-				   name, mirror, &buf2);
+		if (use_limited_fetch) {
+			strbuf_addf(&buf, "remote.%s.fetchRefmap", name);
+			strbuf_reset(&buf2);
+			strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s/*", name);
+			repo_config_set(the_repository, buf.buf, buf2.buf);
+		} else {
+			strbuf_addf(&buf, "remote.%s.fetch", name);
+			if (track.nr == 0)
+				string_list_append(&track, "*");
+			for (size_t i = 0; i < track.nr; i++)
+				add_branch(buf.buf, track.items[i].string,
+					   name, mirror, &buf2);
 		}
 	}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..90cba75f93 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,22 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success '--limited-fetch works in a full repository too' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add --limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetchRefmap &&
+		test_must_fail git config get remote.upstream.fetch
+	)
+'
+
+test_expect_success '--limited-fetch conflicts with -t' '
+	test_must_fail git remote add --limited-fetch -t main upstream ../two
+'
+
 test_expect_success 'check remote-tracking' '
 	(
 		cd test &&
-- 
gitgitgadget

