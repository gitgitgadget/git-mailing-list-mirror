Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503803;
	b=ObZQAvRsCw37ISjcPH0+Pk0gv1kDWU1a5CtWTfdyTZdUpmMQPAhcrooGuBwALWF8qmfP
	 ZI1HkIY0oy8LyhMqb0Fh/izocRDvUk0s8bKf2xL74kfL/FfGmkHTM/tpfv6lcOlcK42Zs
	 1uGCQiNJIfmar6MQUs5NEOHexwpyR7zCbBlrzjOZ+jExkEgOrwdq3RYKB25YvM/PmL24B
	 jNJ1MsU+4ZkWeSpLe/Vob+4lkhjK4cVsPqosCxwNvP0a48DIZiLeT3JFIOxc7gde/XwKf
	 IgjrKjxTGDZp7JpHlvapYKgc05To5AJ16djRfA5CuEEWs5PDjl/sQSY/KSKfJUY0Abg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LsCMLYu4DwjDrjTK5hl+KsOSgxzvtbRxYSU6jXWhdBc=;
	b=g1Kir3J0KWN5w45vNPW9nV9oMCirFRf9j7RfB0/r/t/YQ5aFSX2FiPp1/lLm0uQbfbZQ
	 P9uLbMrby2qtdUKX1wAulpJSIAr/oQc4mCeI/oh80tKUPgVySEMu0KhIrhvzkYYOitQxp
	 XM6G7544iHOv4kijzJUpU00odJccGTr7/GgmQhyxDidD4odlSzxG38OB4yppUK18vMTrP
	 RrRHZeABNrRv8RkGW8m7uswHLULKpB8SahRlwfNCDRXQpfjAXWpgSHKw5FdukWG5y7fpR
	 9Bn91V9VPIxuT/K8/RvibdivXbrVzwlFzTxB74IwnJ/PiRwt7N7J4l41yvy21gyorQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CQ67CqAh;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817C606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6817C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CQ67CqAh
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14fc585291cso680024c88.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503802; x=1793108602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LsCMLYu4DwjDrjTK5hl+KsOSgxzvtbRxYSU6jXWhdBc=;
        b=CQ67CqAhGcizzICtdtgq0EBY26Vzvc7V0Du+cS+CCqmD4cfKELf3pOhr+hl87nUOhj
         78CqSpe2uFmvp1ZQ7fqgLmFokkZyrR48jfgv1x8M+dAzRYkTUgkyYy2f/xN5Id1Hy5q5
         A7PVohfBH/OPA7it9qP4t8kPRrmttGQo5IvTNuge9AcixQHuYU8TcKEj808kFhDvMweS
         2BRxDlO8jAxFrFz96qR6b7f8xs7iEzNnfYUOqnhKF91iJ6CmEVwMMfZLo2VneoFZRg2A
         LKVP7UnjcMMsd9x/LU5kRBtMtTVEjynKHUS07/tcce86XhbLOxuCNzgF6IZDvl1DL5pg
         FUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503802; x=1793108602;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsCMLYu4DwjDrjTK5hl+KsOSgxzvtbRxYSU6jXWhdBc=;
        b=RhLI87NWjiRjKlc4er3DScghThMvbw+ifzksKg2Lcv63kKD//VxmVI3s6VJA8aUt8g
         gk7825KxY15s4gVLwEgESeAeJmwGMDJV+/AJp+uK4pMO8PO4u73W28+VBdMYZLlDA5I2
         qMXD+tqsESZPlKh+/4pLiLtGjeLQGBwKo1SESGz0a/IdXpze0NI7eg3wSnDt34O2w2uO
         tiwyMGS5OYHj2bVjBy0PwcSy/K/KkotwoSsVQXIOTJLeGcpLUEwEP+tAkDToUGiOwelo
         NfnWLqx7P8zc2yh4vHS3J3E1/3J7ScaOpESJNWkrG3cyijMJWqcFnu/PF5yWXQcUs98L
         aC1w==
X-Gm-Message-State: AFq9FYKxK9n4Gf3sm8QalqzUat26H6uPdT1zejTrR+AdeqR/vxPjhTJQ
	9yASB+zvskFaSSiB9eDeI1y3lJwiCOaJB7s8jxPyVTwzmEU32zH+qptTmzhoObDU
X-Gm-Gg: AYBFou2O40btCFp4CJb28q21O0l/KesIwRdcHeQ1/SsRgC3yRXikZvNudPxqfWwhajv
	ARKATqrCTeM0NDpGpR4G/UTLirxbHOpA8S9Og5gLaSEMPxdOnx32VsL4pkd+XiqdpLwT7qm8kA0
	+c9fZ1tWOHhcoWI6VFWq+/A7Iu98MaIqgzvT5ivnUUZGBmbj6sF99ojoB+oD2Db4ngitm63c0zB
	Y3MC908EmvM/6DkWRKyPZ2cjXX/gitU4ajkisFWDELIylWwdNNvp0AL0BBhdbW+1h+iR1J1y5CW
	wFsX2l8PfEWdm6alYPt9jnxVir8lQWnry82iqMFwdEeA6TMye7kx+jXhALFzaA8fKajtt1S4ac5
	jj9JCGS45k5TIpwAWKli45P9FbowZtFlizWyfAAwLOfrsmlzEoSd06g6Lvf1Zzaqu10xmH7r9Q0
	WXhA0Ju1pIq1+hYtObRY157N0SgW3T0acXM2DcR/IvWY9dFoIQleldkqvTsHJ5clRt3/65XaA=
X-Received: by 2002:a05:7022:7f01:b0:178:d38c:eafa with SMTP id a92af1059eb24-18512579328mr14396930c88.21.1792503801381;
        Tue, 20 Oct 2026 06:43:21 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.77.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm32809993c88.20.2026.10.20.06.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:43:19 -0700 (PDT)
Message-Id: <80028d4f8638f766a73b84a5631d21101a413490.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:42:57 +0000
Subject: [PATCH v10 4/5] remote: add "git remote add --limited-fetch"
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A remote added the ordinary way tracks every branch it has, via a
wildcard remote.<name>.fetch refspec. That is wasteful for a remote
whose history is only worth following for the branches actually in
use locally, and it can make "git fetch" negotiate history for
branches nobody asked for.

Give "git remote add" a --limited-fetch option that sets up
remote.<name>.refmap instead of remote.<name>.fetch, so that
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
index 315100409d..f8764394e7 100644
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
+that tracks all branches, `remote.<name>.refmap` is set up so that a
+refspec-less `git fetch <name>` only fetches branches our local branches
+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
+details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..a7c13946d1 100644
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
+		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
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
+			strbuf_addf(&buf, "remote.%s.refmap", name);
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
index 5fbfcb0848..0168d5abfe 100755
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
+			remote.upstream.refmap &&
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

