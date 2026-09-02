Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA9F353EDF
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356116; cv=none; b=jKagU0YqWPZJEC5zr0YhC1qrJZuzfbXKBbRv9hVwZ75n1EIM3ArXa1Z8GOrSCyCrr1am9vvYHRfyz+/N4Iqtj1gN4BC8L6uTUBWzpDC/C/RnFOR0773ZuPN7uOWRdAJ9beHg8p1KRSvBNjQdW2Z+aoLkV1PwIOOJ4DHLWF3+rFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356116; c=relaxed/simple;
	bh=sD3hunL0YJwdQ999/P1HR9ZzsHQypHdBE6HliYPSzWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwM+3W3f6Vzs89ieBHKlIYZ2m7W4DHjyQZAdVQZX1RufRby8AvqBjXJ21py7BI6RVRxIA2PdG/bjgh3hmTnU+wv9pBRbGZF4L6sg+O2ZZp63R8a/vMm4eZCqY3lCkVPOVdgMr9LGj2kZsFklk8u/N5IeP2SYie8Qo1A2rNmokDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YqROMOkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9IZrg82; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YqROMOkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9IZrg82"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A69711D00049;
	Wed,  2 Sep 2026 09:35:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 09:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356112;
	 x=1788442512; bh=CagefgvaMetzmlSWYmb83Zfq+txGcKepj2XCUivxaz4=; b=
	YqROMOkI5ek99Z+4MPMyEkDcC3ik1h2kP38Wi2axa9eZ2WoBA3xI9bcH8kvlCa0c
	hHc8bPVS8JROSb0tW81LajHVhHEEskpyfPBJXYxnu29kdSA0z/uVkhAnN1ZVqzkX
	idWVk9RfN/QaPUz7BTqpNUw8MOwalaoqLsycEf0KpAjE9qteSaZEiJiaw2MgNs/x
	Cm3xfI4RIDprdeYeP5TBSXVwIQ8sgDko0Ku0KzgZGzR8zAQuQ4kkcb+xMB1GuEho
	ruvC+0H6wk63QGiIVTeamoprI95B06jYo9y3VxDRa/peB57fJbcNOzI9tQsQcBvI
	aRSXRAXEk7ouIONKMdwY/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356112; x=
	1788442512; bh=CagefgvaMetzmlSWYmb83Zfq+txGcKepj2XCUivxaz4=; b=i
	9IZrg82PJ7PlJR677oBITzbWoVNr27zkw1zDo8XEIaNhibADd2tGhBBy4DN/ShBD
	CMS74im3RCjiq+C4Hirhi1cmNY1/FdjU3GbAy1tK6HQHoIVvKM29OEY9sZTqhD0P
	ddpWmUKrACNGWFSeTz8KqAuBUNcOp+CSM9owW7TRfVwPHvOkf7785jMVKstcL/SB
	tqxrJdYs2YbKYOGTmp00LI4X4ymrUwRgBswZsGltk4V/wGCNbBTJ1Zi99RcWSksb
	lIVrMmV3Em0BAFNP51/1Ggg29gDQXp61OOr059+pZW7j3Z2exZ0SizmxcefkKs3a
	FF4QOI4TvS3pvE/dRUr6Q==
X-ME-Sender: <xms:ECaYaqQk0gqrSmfd16pJ6iwAWX77PGbD3E3z3g6pxGtTNW0vJif4pg>
    <xme:ECaYalyRKEAQLuZiP-m65ViC1ifRuUxJsD8KnpQANN885HarErfdBBMr3DXog85Il
    jhSQk2fiVrr5WzPcS3Cawc8RPu-AxPO7yQ96biapGDphwU3Pd8Pfs0>
X-ME-Received: <xmr:ECaYaleC98AKKuzIG9vdvuavBYmHzgRtKWToGWsyRuXkfVclOKZodovtItovTI40AGOJ8XU>
X-ME-Proxy-Cause: dmFkZTEYhr9e4Ywlb1TBHLwsOW3Qx1tjtKD+uhP71WKh33QJrNZx9AVMt7nD22Jis4lPrv
    MTCD/EPB8RsDNVjlqEtIpjdnI06qWWOaQew+wKEg9KR8NEV3XDj5+C+lq0GNXMUCyo4igS
    5U9v+KFkw0Evpwnc6cWUohg4b6qCrXyvPX0B7hrQw7zRUjz5YwzGQrgU3UxDXxxyR53YC+
    YQIYAIRjLTSjVluUg4RI0n2rU5GvrWBHjQHZRsaSRDQMiPpgohYZUdgz5LN2ECLLwBR9zC
    HYaTCafKUfTxhWvjtOGLyd4VXGi9YWUXrplxaROw1Cvb4DVWcs3zD8ZSMBcPlpw1IaHWqj
    YUJL62ESPmDVJR4Ni+GIjvchyKxkcSvoa7ki9HlvDdbV5JkHUaRVPjWeY7ZUHYrye5MuUU
    AlamrfEnbzquSfppPQDfl9tEEDPo0UP6eE/mEeU1kPbQrEGJ3pfD0iyCt4DobmxGi+1RJ0
    3fRhmm+hiYvldbJlN7PgI6FFWPnLYhZaezvho/HWygpLF4FiVyVomvm4XI3XmSF02IlE+b
    5hhGGjOO2cpoKaNH+whB9PICdl0d+qAGkU2EuvD/nRGbLrQjortnrA3TJBcany9idK2hPb
    ufIJN+1jqPYFz+kSfFsKSiji4zcRN9ObFwsh4KSrtfgrKejg6UPactQGEQNw
X-ME-Proxy: <xmx:ECaYahLyikojo7QIU9HlY_exXy1wMV8p5OKiMEClwzzKVyw3ugo09g>
    <xmx:ECaYamG7A0EzzSKNYS5Qb9QJHx6QOOfaKZ2GJeunVuI65LV4Y7EhhA>
    <xmx:ECaYarrZ84Gub2n8msAib0nbwLwpNUJvGluw-L9pzJVnCrOTsZoL4A>
    <xmx:ECaYavSCfUlMOLNd3rcBPHgrWxXh14gOsZyk3MimgkperoHqMjrXcA>
    <xmx:ECaYatpU6tglLlpe30eCHe95nL6lxwwc3kljj3d4GgWkb-Tdbz1pBnK5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6a5207d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:53 +0200
Subject: [PATCH v2 05/13] submodule-config: stop registering submodule
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-5-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When reading the ".gitmodules" file from a blob in a repository other
than `the_repository`, we register the repository's object database as
an in-memory source of `the_repository`'s object database. This call has
its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
not able to read a blob from an arbitrary repository, but would always
read it via `the_repository`. So even though the blob could be resolved
in the submodule repository via `repo_get_oid()`, the submodule's object
database had to be registered as an in-memory source of `the_repository`
so that the subsequent object read was able to find the blob at all.

That need went away with e3e8bf046e (submodule-config: pass repo
upon blob config read, 2021-08-16), which taught the config machinery
to read the blob from the repository we pass to it. The same series
converted the eager submodule source registration into a lazy mechanism
that only registers submodule sources with the object database when an
object lookup failed. The intent though was that we don't ever have to
fall back to this mechanism in the first place, and to verify that this
is the case we introduced GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB. If set,
then any such lazy registration would cause us to BUG.

At the beginning of this series, we still triggered this bug in t1092.
But now that we have converted the "cache-tree" subsystem to not depend
on `the_repository` anymore it also knows to properly access objects via
the submodule. With that change, GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
does not cause any failures anymore.

Remove the call to `odb_add_submodule_source_by_path()`. This removes
the last user of `the_repository`, so at the same time we can also get
rid of `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 7c73fa108b..37c3be377b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -803,9 +802,6 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
-			if (repo != the_repository)
-				odb_add_submodule_source_by_path(the_repository->objects,
-								 repo->objects->sources->path);
 		} else {
 			goto out;
 		}

-- 
2.55.0.979.g7e5102b832.dirty

