Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619938;
	b=iMQFwBWTOmgLCw0gZiAUdMsVFfD9UC3j07qmfqxogX1YTrxWoJtXreIddARZzIHYp5z/
	 uHhAbvOsAFzAAvz/bl+v9oq23+ZjB2aG+26ZLU+GNI0v2ydUw1WeiELkXefqBReUt/E+h
	 vOKgo/CvfHTBthb2NCpsPg3dMyBL49A3iGIR/ZlbAJKZGbcySZQzx3SCNR3jWjgbjhg8b
	 oISNDBDuHLZBzT0h2lyu4kuZF2Zo5IjXk2POK4xu0N/ql+YQWDlqWSSVJfKRa5kWwdQ7e
	 1dV21Db/pubGM/WWdmQKBfcl/KeBIvRhb71ODp7hh6DNzZKqiC8BxPtFWsWXXINQmiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2WuIPac0kZm5hg63oDvYaKLD/2I4+yGNsq+fMWsdzQ4=;
	b=lI3gVosr8ECDtSLzIXQwbXERad96atBKMW+zLfz1nIfVEj+/O3wzJrH3KQhk2442xAXt
	 50gTLHZjM9zWEu95fkoSabOfHHN/imIcA1q5av4C1hzB6fqTYTPIZVItJg5V/hznjiuM1
	 5+vA9Q20s89sBJlFHpKCB29p4V4q0CHM7zZZBUe5E97tAMTC3eZVC8TbDf2ilLgX4ykUT
	 a6PpoXJWiWwZjwVFqYVbBcJicutzPhUP+ILF6I2kFvt3dHSE/Zr87/BAn1uYlcDSt/viH
	 Se4QAh4WOiQdw94NX2tn56LrLjkpTAZ3TqsWOPxTRc5lDWaluGZAVeS/RIq+IGQKSMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5JnHkUU;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F12606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F12606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5JnHkUU
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aa9606ddadso2268394eaf.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 03:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793619936; x=1794224736; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2WuIPac0kZm5hg63oDvYaKLD/2I4+yGNsq+fMWsdzQ4=;
        b=Z5JnHkUUdkXjtA+lqk585wRAfG2Fgf3YIUjPl1ORq8RKzYXdboLqYWnCAcW1QmW22r
         VKZETDD9A0+i+csHiBMhVYqxijWC2bZA/sKGiyFz3C9UB/c6Ls/9FTW66CH5RtrIyMgV
         Ht7oxnJBLhFaoho0Opd8fflqx4uxhJoB4hkopg2DCqc0n7uv8AFg1LeeHrYsHRFFNjd2
         1Jk78txZ7zGaekGR11+c6fsmBiQLeBVvCcwM50jXYmrNeGAKdt5yM20VneXn78XAdxwG
         lof58tCWKvAp5zIIMjeU7Ueeg/IE/WYJfCe5yvOgot/tS9vkDKgKVFAZmO9EfuSyo9He
         d/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619936; x=1794224736;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WuIPac0kZm5hg63oDvYaKLD/2I4+yGNsq+fMWsdzQ4=;
        b=I03/4bDCBOcig+y7+6OzDaVrRVDdK3p09bujyRVedTjzKBpRxtJOwAqFqxrNgD4kiG
         td+tHW7EKKKtIxnSNdmKzSSqH55eOmZKmlvTNEIEYVszbtJjCA5z6Lanv2v3qS+hwBnX
         nwwXp+3/cW8CKkFYK3eOOQfuBnyOU7esWIx9NRR4LdOo3bYYZEUAf0tAgMYy8i0SbFUE
         4T1UbidXXhbpxK3Km5hopu/+pvhLSLQHGERCflGXffxIY1Q9+InKiy/xwbFpFQxMO/nx
         AZzaVGii8P8MczrHXt8m7mCcr3TH4p+70Wq7c8rRrRq1p36G5tjSITzQl9DbdMoRaXcW
         Sbmw==
X-Gm-Message-State: AFq9FYIbv/t8d5mFJBTkSUpmtY3CdT6hfLfTBMcWLP/tesMDezZJW3os
	V2xAwurIxkie0Y8GE9HJGKupCxJclPGAl/P2BXGUoglaY+MzEoIiShK06cPuAFrNJcQ=
X-Gm-Gg: AYBFou3bEqgoMb3DpxO54J+C+DDMWNDTpMJoUhtjTEXToIBuW6daTwAH3wAi6398LAJ
	xEpRHCGu0aXGtn6tDLav1OwYwpJaCGkMen+E+2Yds1ax6kowYaS0ZsZM+q7kHewxKYX/wLqqrSA
	1R5klNd7ihZJL9bC3Apz7ReGYmk5P8n7sYT00GYEumoIqa4eyF8atxc5P9N0JKnIzpe6VxStfPH
	sv4uq2zPpHlBwhBP5CsHCkPN2dQwsiQ8veYenIcGu+vB8wbZ+xOXexN1WYcPDeETREAqmjCWqzh
	P26hrv7zOCdTinxPN9kA4S5xO0L3ZxurE/BJRm8xzVxlDIzGK8/QfOTaCREcDw8FvMpENabGE//
	6OFK93IArb2QFrDsIrnyWfIYPJ6x6aGfkQamvG8X47EbgK+j05K3pyjg4x+cT9XNmO64T+ahYlG
	nQBMq0MW8FEriseA/U3LuAIThbSO1I8scUmq80lkNxba2ep0lp7Ql4N+IY8pdh8FCdcL+VJBXll
	m12ODf6mAYCgmVj/+tjbdoys43Ukz5savN0SW2j6x8Yl+mF1ERQOiJkLzmvtD6VX7DbiAQy5I47
	VVwaV5eUBzpPk6hEOp9EiFz6RsAGKpP/YS0=
X-Received: by 2002:a05:6820:603:b0:702:3087:ca56 with SMTP id 006d021491bc7-714f6e7ffafmr4728650eaf.26.1793619936145;
        Mon, 02 Nov 2026 03:45:36 -0800 (PST)
Received: from [127.0.0.1] ([172.183.133.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm8678339eaf.4.2026.11.02.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:45:34 -0800 (PST)
Message-Id: <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 11:45:33 +0000
Subject: [PATCH v2] odb: do not list our own refs as alternate refs in the
 quarantine
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Justin Tobler <jltobler@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Since 722ff7f876 (receive-pack: quarantine objects until pre-receive
accepts, 2016-10-03), receive-pack writes incoming objects to a
temporary object directory. Child processes see it as their primary
object directory, and tmp-objdir passes the repository's own object
directory to them via GIT_ALTERNATE_OBJECT_DIRECTORIES.

The connectivity check passes --alternate-refs to rev-list since
39b44ba771 (check_everything_connected: assume alternate ref tips are
valid, 2019-07-01). Inside the quarantine, the repository's own object
directory is one of the alternates, so --alternate-refs runs
for-each-ref on the repository itself and lists all of its refs.

That includes hidden refs. bcec6780b2 (receive-pack: only use visible
refs for connectivity check, 2022-11-17) added --exclude-hidden=receive
to the check so that repositories with many hidden refs do not have to
load all of them on each push. The hidden refs are excluded from --all,
but they all come back through --alternate-refs.

An alternate that is ourselves is not a source of alternate refs: its
refs are our own refs, which the caller already lists as it sees fit.
Mark each object directory added via alternates with whether it is
borrowed from another repository, and list alternate refs only from
those. Within one process this needs no guessing, as tmp-objdir
links our own object directory in itself. But a child process rebuilds
its object store from the environment, so when an alternate is added,
recognize ourselves in two ways:

 - as our <commondir>/objects, which also covers an environment that
   makes our own object directory an alternate by hand;

 - as the parent of GIT_QUARANTINE_PATH, as the quarantine is created
   directly inside our object directory (see "QUARANTINE ENVIRONMENT"
   in git-receive-pack(1)); this also works when the object directory
   is not under the commondir.

Document in --alternate-refs that our own object directory does not
count as an alternate repository.

This is safe: alternate refs only serve as negative tips that are
assumed to be complete, so dropping some can only make the traversal
walk further, never make it accept a missing object.

Add tests that our own refs are no longer listed, by the connectivity
check, by rev-list run from a pre-receive hook, by rev-list with our
own object directory passed in as an alternate by hand, and by rev-list
in a quarantine whose parent is not under the commondir, and that the
refs of a real alternate still are. Add a perf test pushing a
single commit into a repository with a visible branch and about
200,000 refs hidden by receive.hideRefs, and into a copy of it that
hides nothing:

    Test                           HEAD~1            HEAD
    -----------------------------------------------------------------------
    5552.2: push, hidden refs      0.31(0.33+0.08)   0.09(0.06+0.03) -71.0%
    5552.3: push, no hidden refs   1.23(1.06+0.68)   1.01(0.83+0.61) -17.9%

With hidden refs, most of the time went to the for-each-ref child that
listed the alternate refs. Without hidden refs, every ref was listed
twice, once for --all and once for --alternate-refs.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    odb: do not list our own refs as alternate refs in the quarantine
    
    When a repository hides refs with receive.hideRefs, every push still
    loads all of the hidden refs in the connectivity check, even though
    bcec6780b2 (receive-pack: only use visible refs for connectivity check,
    2022-11-17) excludes them from it. With many hidden refs, that is most
    of the time spent on a small push.
    
    I stumbled across this while working on the boundary walk of the
    connectivity check (the follow-up to kk/connectivity-check-incremental),
    when the walk loaded every ref during a push even though it should only
    have looked at a few of them.
    
    Changes since v1:
    
     * Changed the rule to "an alternate that is ourselves is not a source
       of alternate refs", as Peff described it.
    
     * Added a "borrowed" flag to alternates, set when they are loaded,
       which says whether they come from another repository, and used it for
       --alternate-refs. Our own object directory is recognized either as
       /objects or as the parent of GIT_QUARANTINE_PATH.
    
     * Documented this for --alternate-refs.
    
     * Added tests for rev-list --alternate-refs in a pre-receive hook, for
       our own object directory set up as an alternate by hand, and for a
       quarantine outside of the commondir.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2285%2Fspkrka%2Fquarantine-altrefs-bugreport-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2285/spkrka/quarantine-altrefs-bugreport-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2285

Range-diff vs v1:

 1:  1b1de6eee1 ! 1:  bac15042c0 odb: do not list our own refs as alternate refs in the quarantine
     @@ Commit message
          load all of them on each push. The hidden refs are excluded from --all,
          but they all come back through --alternate-refs.
      
     -    Skip an alternate whose repository is our own when listing alternate
     -    refs. This is done by comparing paths, which is a hack: it is mainly
     -    here to measure the cost of the bug, and a proper fix would have the
     -    quarantine tell its children which directory is ours. It is safe,
     -    though: alternate refs only serve as negative tips that are assumed to
     -    be complete, so dropping some can only make the traversal walk further,
     -    never make it accept a missing object.
     -
     -    Add a test that our own refs are no longer listed, a test that the refs
     -    of a real alternate still are, and a perf test pushing a single commit
     -    into a repository with a visible branch and about 200,000 refs hidden
     -    by receive.hideRefs, and into a copy of it that hides nothing:
     +    An alternate that is ourselves is not a source of alternate refs: its
     +    refs are our own refs, which the caller already lists as it sees fit.
     +    Mark each object directory added via alternates with whether it is
     +    borrowed from another repository, and list alternate refs only from
     +    those. Within one process this needs no guessing, as tmp-objdir
     +    links our own object directory in itself. But a child process rebuilds
     +    its object store from the environment, so when an alternate is added,
     +    recognize ourselves in two ways:
     +
     +     - as our <commondir>/objects, which also covers an environment that
     +       makes our own object directory an alternate by hand;
     +
     +     - as the parent of GIT_QUARANTINE_PATH, as the quarantine is created
     +       directly inside our object directory (see "QUARANTINE ENVIRONMENT"
     +       in git-receive-pack(1)); this also works when the object directory
     +       is not under the commondir.
     +
     +    Document in --alternate-refs that our own object directory does not
     +    count as an alternate repository.
     +
     +    This is safe: alternate refs only serve as negative tips that are
     +    assumed to be complete, so dropping some can only make the traversal
     +    walk further, never make it accept a missing object.
     +
     +    Add tests that our own refs are no longer listed, by the connectivity
     +    check, by rev-list run from a pre-receive hook, by rev-list with our
     +    own object directory passed in as an alternate by hand, and by rev-list
     +    in a quarantine whose parent is not under the commondir, and that the
     +    refs of a real alternate still are. Add a perf test pushing a
     +    single commit into a repository with a visible branch and about
     +    200,000 refs hidden by receive.hideRefs, and into a copy of it that
     +    hides nothing:
      
              Test                           HEAD~1            HEAD
              -----------------------------------------------------------------------
     -        5552.2: push, hidden refs      0.31(0.32+0.08)   0.10(0.06+0.03) -67.7%
     -        5552.3: push, no hidden refs   1.25(1.08+0.68)   1.03(0.84+0.62) -17.6%
     +        5552.2: push, hidden refs      0.31(0.33+0.08)   0.09(0.06+0.03) -71.0%
     +        5552.3: push, no hidden refs   1.23(1.06+0.68)   1.01(0.83+0.61) -17.9%
      
          With hidden refs, most of the time went to the for-each-ref child that
          listed the alternate refs. Without hidden refs, every ref was listed
          twice, once for --all and once for --alternate-refs.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     + ## Documentation/rev-list-options.adoc ##
     +@@ Documentation/rev-list-options.adoc: explicitly.
     + 	Pretend as if all objects mentioned as ref tips of alternate
     + 	repositories were listed on the command line. An alternate
     + 	repository is any repository whose object directory is specified
     +-	in `objects/info/alternates`.  The set of included objects may
     ++	in `objects/info/alternates`.  The repository's own object
     ++	directory does not count, even when it is passed in as an
     ++	alternate, as happens inside the object quarantine of
     ++	linkgit:git-receive-pack[1].  The set of included objects may
     + 	be modified by `core.alternateRefsCommand`, etc. See
     + 	linkgit:git-config[1].
     + 
     +
       ## odb.c ##
      @@ odb.c: static int refs_from_alternate_cb(struct odb_files_dir *alternate,
     - 				  void *payload)
     - {
     - 	struct strbuf path = STRBUF_INIT;
     -+	struct strbuf self = STRBUF_INIT;
       	size_t base_len;
       	struct alternate_refs_data *cb = payload;
       
     -@@ odb.c: static int refs_from_alternate_cb(struct odb_files_dir *alternate,
     ++	if (!alternate->borrowed)
     ++		goto out;
     ++
     + 	if (!strbuf_realpath(&path, alternate->abspath, 0))
       		goto out;
       	if (!strbuf_strip_suffix(&path, "/objects"))
     +
     + ## odb/source-files.c ##
     +@@
     + #include "blob.h"
     + #include "chdir-notify.h"
     + #include "config.h"
     ++#include "dir.h"
     ++#include "environment.h"
     + #include "gettext.h"
     + #include "hex.h"
     + #include "lockfile.h"
     +@@ odb/source-files.c: static void odb_source_files_free(struct odb_source *source)
     + 		files->dirs = next;
     + 	}
     + 	hashmap_clear(&files->dirs_by_path);
     ++	free(files->quarantine_path);
     + 
     + 	odb_source_release(&files->base);
     + 	free(files);
     +@@ odb/source-files.c: static int read_alternates(const char *object_dir, struct strvec *out)
     + 	return 0;
     + }
     + 
     ++/*
     ++ * Our own object directory is <commondir>/objects, or the parent of
     ++ * GIT_QUARANTINE_PATH, as an object quarantine is created directly
     ++ * inside it (see tmp_objdir_create()). Anything else, including a path
     ++ * that cannot be resolved, is borrowed.
     ++ */
     ++static bool is_borrowed_object_dir(struct odb_source_files *files,
     ++				   const char *path)
     ++{
     ++	struct strbuf real = STRBUF_INIT;
     ++	struct strbuf objdir = STRBUF_INIT;
     ++	struct strbuf self = STRBUF_INIT;
     ++	bool ret = true;
     ++
     ++	if (!strbuf_realpath(&real, path, 0))
     ++		goto out;
     ++
     ++	strbuf_addf(&objdir, "%s/objects", files->base.odb->repo->commondir);
     ++	if (strbuf_realpath(&self, objdir.buf, 0) &&
     ++	    !fspathcmp(real.buf, self.buf)) {
     ++		ret = false;
     ++		goto out;
     ++	}
     ++
     ++	if (files->quarantine_path &&
     ++	    strbuf_realpath(&self, files->quarantine_path, 0)) {
     ++		strbuf_strip_file_from_path(&self);
     ++		strbuf_trim_trailing_dir_sep(&self);
     ++		if (!fspathcmp(real.buf, self.buf))
     ++			ret = false;
     ++	}
     ++
     ++out:
     ++	strbuf_release(&real);
     ++	strbuf_release(&objdir);
     ++	strbuf_release(&self);
     ++	return ret;
     ++}
     ++
     + static void odb_add_alternate_recursively(struct odb_source_files *files,
     + 					  const char *path,
     + 					  int depth)
     +@@ odb/source-files.c: static void odb_add_alternate_recursively(struct odb_source_files *files,
       		goto out;
     + 
     + 	alternate = odb_files_dir_new(files->base.odb, path, false);
     ++	alternate->borrowed = is_borrowed_object_dir(files, alternate->abspath);
     + 
     + 	/* add the alternate entry */
     + 	*files->dirs_tail = alternate;
     +@@ odb/source-files.c: struct odb_source_files *odb_source_files_new(struct object_database *odb,
     + 	struct odb_source_files *files;
     + 	char *object_dir = NULL;
     + 	char *alternates = NULL;
     ++	char *quarantine_path = NULL;
     + 
     + 	if (flags & ODB_NEW_HONOR_ENV) {
     + 		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
     + 		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
     ++		quarantine_path =
     ++			xstrdup_or_null(getenv(GIT_QUARANTINE_ENVIRONMENT));
     + 	}
     + 	if (!object_dir)
     + 		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
     + 
     + 	CALLOC_ARRAY(files, 1);
     ++	files->quarantine_path = quarantine_path;
     + 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir);
     + 
     + 	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);
     +
     + ## odb/source-files.h ##
     +@@ odb/source-files.h: struct odb_files_dir {
     + 	 * repository. Directories added via alternates are not local.
     + 	 */
     + 	bool local;
      +
      +	/*
     -+	 * NEEDSWORK: this is a hack, mainly here to measure the cost of
     -+	 * the bug. Inside an object quarantine, tmp-objdir passes our own
     -+	 * object directory to child processes as an alternate, so we would
     -+	 * list our own refs as alternate refs, including the hidden refs
     -+	 * that the connectivity check of receive-pack deliberately skips.
     -+	 * Comparing paths papers over that; the quarantine should rather
     -+	 * tell its children which directory is ours.
     ++	 * Whether this directory is borrowed from another repository, so
     ++	 * that its refs are alternate refs. Not every directory added via
     ++	 * alternates is borrowed: inside an object quarantine, our own
     ++	 * object directory is passed to us as an alternate, too. Only set
     ++	 * for directories added via alternates.
      +	 */
     -+	if (cb->repo->commondir &&
     -+	    strbuf_realpath(&self, cb->repo->commondir, 0) &&
     -+	    !strcmp(path.buf, self.buf))
     -+		goto out;
     - 	base_len = path.len;
     - 
     - 	/* Is this a git repository with refs? */
     -@@ odb.c: static int refs_from_alternate_cb(struct odb_files_dir *alternate,
     ++	bool borrowed;
     + };
       
     - out:
     - 	strbuf_release(&path);
     -+	strbuf_release(&self);
     - 	return 0;
     - }
     + struct odb_files_dir *odb_files_dir_new(struct object_database *odb,
     +@@ odb/source-files.h: struct odb_source_files {
     + 	 * determined by "core.ignoreCase".
     + 	 */
     + 	int dirs_paths_icase;
     ++
     ++	/*
     ++	 * The value of GIT_QUARANTINE_PATH when this source was set up from
     ++	 * the environment (see ODB_NEW_HONOR_ENV), or NULL.
     ++	 */
     ++	char *quarantine_path;
     + };
       
     + /* Allocate and initialize a new object source. */
      
       ## t/perf/p5552-push-hidden-refs.sh (new) ##
      @@
     @@ t/perf/p5552-push-hidden-refs.sh (new)
      +test_done
      
       ## t/t5547-push-quarantine.sh ##
     -@@ t/t5547-push-quarantine.sh: test_expect_success '.keep file is removed after push' '
     - 	test_path_is_missing "$keep"
     +@@ t/t5547-push-quarantine.sh: test_expect_success '.keep file created outside of process is not removed' '
     + 	test_path_is_missing "${keep%.keep}.pack"
       '
       
      +test_expect_success 'quarantine does not list own refs as alternate refs' '
     @@ t/t5547-push-quarantine.sh: test_expect_success '.keep file is removed after pus
      +	sort -u alternate-refs.log >actual &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'rev-list --alternate-refs in a hook skips own refs' '
     ++	test_when_finished "rm -rf altref.git" &&
     ++	git init --bare altref.git &&
     ++	git push altref.git HEAD:refs/heads/main &&
     ++	test_hook -C altref.git pre-receive <<-\EOF &&
     ++	git rev-list --no-walk --alternate-refs --stdin </dev/null \
     ++		>../hook-alternate-refs
     ++	EOF
     ++	test_commit altref-push &&
     ++	git push altref.git HEAD:refs/heads/new &&
     ++	test_must_be_empty hook-alternate-refs
     ++'
     ++
     + test_done
     +
     + ## t/t5618-alternate-refs.sh ##
     +@@ t/t5618-alternate-refs.sh: test_expect_success 'log --source shows .alternate marker' '
     + 	test_cmp expect actual
     + '
     + 
     ++# Our own object directory as an alternate is not a source of alternate
     ++# refs, but the alternates it brings in with it still are.
     ++test_expect_success 'own object directory as alternate lists only real alternates' '
     ++	test_when_finished "rm -rf other-objects" &&
     ++	mkdir other-objects &&
     ++	git rev-list --remotes=origin >expect &&
     ++	GIT_OBJECT_DIRECTORY="$(pwd)/other-objects" \
     ++	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/.git/objects" \
     ++		git rev-list --alternate-refs >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++# A quarantine is created inside our object directory, so its parent is
     ++# ourselves, even when that is not under our commondir.
     ++test_expect_success 'parent of the quarantine is not listed as an alternate' '
     ++	test_when_finished "rm -rf store.git" &&
     ++	git init --bare store.git &&
     ++	git push store.git refs/remotes/origin/one:refs/heads/one &&
     ++	quarantine="$(pwd)/store.git/objects/tmp_objdir-test" &&
     ++	mkdir "$quarantine" &&
     ++
     ++	git rev-parse origin/one >expect &&
     ++	GIT_OBJECT_DIRECTORY="$quarantine" \
     ++	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/store.git/objects" \
     ++		git rev-list --no-walk --alternate-refs --stdin </dev/null >actual &&
     ++	test_cmp expect actual &&
     ++
     ++	GIT_QUARANTINE_PATH="$quarantine" \
     ++	GIT_OBJECT_DIRECTORY="$quarantine" \
     ++	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/store.git/objects" \
     ++		git rev-list --no-walk --alternate-refs --stdin </dev/null >actual &&
     ++	test_must_be_empty actual
     ++'
      +
       test_done


 Documentation/rev-list-options.adoc |  5 ++-
 odb.c                               |  3 ++
 odb/source-files.c                  | 47 +++++++++++++++++++++++++++++
 odb/source-files.h                  | 15 +++++++++
 t/perf/p5552-push-hidden-refs.sh    | 37 +++++++++++++++++++++++
 t/t5547-push-quarantine.sh          | 38 +++++++++++++++++++++++
 t/t5618-alternate-refs.sh           | 34 +++++++++++++++++++++
 7 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p5552-push-hidden-refs.sh

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 285fb3809f..6e4c487d1e 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -223,7 +223,10 @@ explicitly.
 	Pretend as if all objects mentioned as ref tips of alternate
 	repositories were listed on the command line. An alternate
 	repository is any repository whose object directory is specified
-	in `objects/info/alternates`.  The set of included objects may
+	in `objects/info/alternates`.  The repository's own object
+	directory does not count, even when it is passed in as an
+	alternate, as happens inside the object quarantine of
+	linkgit:git-receive-pack[1].  The set of included objects may
 	be modified by `core.alternateRefsCommand`, etc. See
 	linkgit:git-config[1].
 
diff --git a/odb.c b/odb.c
index 2c93a9490c..646a498052 100644
--- a/odb.c
+++ b/odb.c
@@ -186,6 +186,9 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 	size_t base_len;
 	struct alternate_refs_data *cb = payload;
 
+	if (!alternate->borrowed)
+		goto out;
+
 	if (!strbuf_realpath(&path, alternate->abspath, 0))
 		goto out;
 	if (!strbuf_strip_suffix(&path, "/objects"))
diff --git a/odb/source-files.c b/odb/source-files.c
index 5b4277fbfd..223af45dd9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -3,6 +3,8 @@
 #include "blob.h"
 #include "chdir-notify.h"
 #include "config.h"
+#include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -73,6 +75,7 @@ static void odb_source_files_free(struct odb_source *source)
 		files->dirs = next;
 	}
 	hashmap_clear(&files->dirs_by_path);
+	free(files->quarantine_path);
 
 	odb_source_release(&files->base);
 	free(files);
@@ -348,6 +351,45 @@ static int read_alternates(const char *object_dir, struct strvec *out)
 	return 0;
 }
 
+/*
+ * Our own object directory is <commondir>/objects, or the parent of
+ * GIT_QUARANTINE_PATH, as an object quarantine is created directly
+ * inside it (see tmp_objdir_create()). Anything else, including a path
+ * that cannot be resolved, is borrowed.
+ */
+static bool is_borrowed_object_dir(struct odb_source_files *files,
+				   const char *path)
+{
+	struct strbuf real = STRBUF_INIT;
+	struct strbuf objdir = STRBUF_INIT;
+	struct strbuf self = STRBUF_INIT;
+	bool ret = true;
+
+	if (!strbuf_realpath(&real, path, 0))
+		goto out;
+
+	strbuf_addf(&objdir, "%s/objects", files->base.odb->repo->commondir);
+	if (strbuf_realpath(&self, objdir.buf, 0) &&
+	    !fspathcmp(real.buf, self.buf)) {
+		ret = false;
+		goto out;
+	}
+
+	if (files->quarantine_path &&
+	    strbuf_realpath(&self, files->quarantine_path, 0)) {
+		strbuf_strip_file_from_path(&self);
+		strbuf_trim_trailing_dir_sep(&self);
+		if (!fspathcmp(real.buf, self.buf))
+			ret = false;
+	}
+
+out:
+	strbuf_release(&real);
+	strbuf_release(&objdir);
+	strbuf_release(&self);
+	return ret;
+}
+
 static void odb_add_alternate_recursively(struct odb_source_files *files,
 					  const char *path,
 					  int depth)
@@ -359,6 +401,7 @@ static void odb_add_alternate_recursively(struct odb_source_files *files,
 		goto out;
 
 	alternate = odb_files_dir_new(files->base.odb, path, false);
+	alternate->borrowed = is_borrowed_object_dir(files, alternate->abspath);
 
 	/* add the alternate entry */
 	*files->dirs_tail = alternate;
@@ -1256,15 +1299,19 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	struct odb_source_files *files;
 	char *object_dir = NULL;
 	char *alternates = NULL;
+	char *quarantine_path = NULL;
 
 	if (flags & ODB_NEW_HONOR_ENV) {
 		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+		quarantine_path =
+			xstrdup_or_null(getenv(GIT_QUARANTINE_ENVIRONMENT));
 	}
 	if (!object_dir)
 		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
 
 	CALLOC_ARRAY(files, 1);
+	files->quarantine_path = quarantine_path;
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir);
 
 	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);
diff --git a/odb/source-files.h b/odb/source-files.h
index 837e890304..b404937fa1 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -33,6 +33,15 @@ struct odb_files_dir {
 	 * repository. Directories added via alternates are not local.
 	 */
 	bool local;
+
+	/*
+	 * Whether this directory is borrowed from another repository, so
+	 * that its refs are alternate refs. Not every directory added via
+	 * alternates is borrowed: inside an object quarantine, our own
+	 * object directory is passed to us as an alternate, too. Only set
+	 * for directories added via alternates.
+	 */
+	bool borrowed;
 };
 
 struct odb_files_dir *odb_files_dir_new(struct object_database *odb,
@@ -66,6 +75,12 @@ struct odb_source_files {
 	 * determined by "core.ignoreCase".
 	 */
 	int dirs_paths_icase;
+
+	/*
+	 * The value of GIT_QUARANTINE_PATH when this source was set up from
+	 * the environment (see ODB_NEW_HONOR_ENV), or NULL.
+	 */
+	char *quarantine_path;
 };
 
 /* Allocate and initialize a new object source. */
diff --git a/t/perf/p5552-push-hidden-refs.sh b/t/perf/p5552-push-hidden-refs.sh
new file mode 100755
index 0000000000..e9aa206298
--- /dev/null
+++ b/t/perf/p5552-push-hidden-refs.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='speed of push into a repository with many hidden refs'
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+test_expect_success 'set up repository with many hidden refs' '
+	git init --bare dst.git &&
+	test_commit_bulk --ref=refs/hidden/base --id=hidden 1000 &&
+	git rev-list refs/hidden/base >commits &&
+	for i in $(test_seq 200)
+	do
+		sed "s|^\(.*\)$|create refs/hidden/$i/\1 \1|" commits || return 1
+	done >input &&
+	git push dst.git refs/hidden/base &&
+	git -C dst.git update-ref --stdin <input &&
+	git -C dst.git pack-refs --all &&
+	cp -R dst.git dst-visible.git &&
+	git -C dst.git config receive.hideRefs refs/hidden &&
+	git symbolic-ref HEAD refs/heads/main &&
+	test_commit_bulk --id=visible 1 &&
+	git push dst.git main &&
+	git push dst-visible.git main
+'
+
+test_perf 'push, hidden refs' '
+	git commit --allow-empty -m new &&
+	git push -f dst.git HEAD:refs/heads/new
+'
+
+test_perf 'push, no hidden refs' '
+	git commit --allow-empty -m new &&
+	git push -f dst-visible.git HEAD:refs/heads/new
+'
+
+test_done
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 6c14dfc42b..3426aec531 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -125,4 +125,42 @@ test_expect_success '.keep file created outside of process is not removed' '
 	test_path_is_missing "${keep%.keep}.pack"
 '
 
+test_expect_success 'quarantine does not list own refs as alternate refs' '
+	git init --bare hidden.git &&
+	git push hidden.git HEAD:refs/heads/main HEAD:refs/hidden/one &&
+	git -C hidden.git config receive.hideRefs refs/hidden &&
+	write_script hidden.git/alternate-refs <<-EOF &&
+	echo "\$1" >>"$(pwd)/alternate-refs.log"
+	EOF
+	git -C hidden.git config core.alternateRefsCommand ./alternate-refs &&
+	test_commit hidden-push &&
+	git push hidden.git HEAD:refs/heads/new &&
+	test_path_is_missing alternate-refs.log
+'
+
+test_expect_success 'quarantine lists refs of other alternates' '
+	test_when_finished "rm -f alternate-refs.log" &&
+	git init --bare other.git &&
+	git push other.git HEAD:refs/heads/other &&
+	echo "$(pwd)/other.git/objects" >hidden.git/objects/info/alternates &&
+	test_commit hidden-push-2 &&
+	git push hidden.git HEAD:refs/heads/new2 &&
+	(cd other.git && pwd -P) >expect &&
+	sort -u alternate-refs.log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --alternate-refs in a hook skips own refs' '
+	test_when_finished "rm -rf altref.git" &&
+	git init --bare altref.git &&
+	git push altref.git HEAD:refs/heads/main &&
+	test_hook -C altref.git pre-receive <<-\EOF &&
+	git rev-list --no-walk --alternate-refs --stdin </dev/null \
+		>../hook-alternate-refs
+	EOF
+	test_commit altref-push &&
+	git push altref.git HEAD:refs/heads/new &&
+	test_must_be_empty hook-alternate-refs
+'
+
 test_done
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 2fb6d549d3..d52e426db1 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,4 +58,38 @@ test_expect_success 'log --source shows .alternate marker' '
 	test_cmp expect actual
 '
 
+# Our own object directory as an alternate is not a source of alternate
+# refs, but the alternates it brings in with it still are.
+test_expect_success 'own object directory as alternate lists only real alternates' '
+	test_when_finished "rm -rf other-objects" &&
+	mkdir other-objects &&
+	git rev-list --remotes=origin >expect &&
+	GIT_OBJECT_DIRECTORY="$(pwd)/other-objects" \
+	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/.git/objects" \
+		git rev-list --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
+# A quarantine is created inside our object directory, so its parent is
+# ourselves, even when that is not under our commondir.
+test_expect_success 'parent of the quarantine is not listed as an alternate' '
+	test_when_finished "rm -rf store.git" &&
+	git init --bare store.git &&
+	git push store.git refs/remotes/origin/one:refs/heads/one &&
+	quarantine="$(pwd)/store.git/objects/tmp_objdir-test" &&
+	mkdir "$quarantine" &&
+
+	git rev-parse origin/one >expect &&
+	GIT_OBJECT_DIRECTORY="$quarantine" \
+	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/store.git/objects" \
+		git rev-list --no-walk --alternate-refs --stdin </dev/null >actual &&
+	test_cmp expect actual &&
+
+	GIT_QUARANTINE_PATH="$quarantine" \
+	GIT_OBJECT_DIRECTORY="$quarantine" \
+	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/store.git/objects" \
+		git rev-list --no-walk --alternate-refs --stdin </dev/null >actual &&
+	test_must_be_empty actual
+'
+
 test_done

base-commit: ebdc087dc99d68bb340c282b2ba5f722def28d19
-- 
gitgitgadget
