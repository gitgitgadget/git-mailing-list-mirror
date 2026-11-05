Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864606;
	b=gN4cLVA/ewnNgRqxR0ka0wvNKun1DYU3d0mCdYsl6UB6qgZCBEwU2fNohQJuNrKycvpo
	 lnLsu2ahngXBjD/htd7n8WEY2FIFBXOgvxLl3NMrrF/ko1tlejRyQ+hvmXkd2GBdPqjbT
	 6YoJ2ZzaPrhnurau/Z7uZ5d+BiTrAvbBEB18fxffck0mc88bwp3nK6Jgk48zan+p6ccHs
	 Ij6iEYg7peBnIdGdi9MrQctgzSUl2fIoQMKr1jicSrJD/+ohFSlwotqnfqO9PQHg6Prtf
	 yCJDL6CUBJv4eZWXH+KjVTrLJOH90y3uCR4hSbRh+3NzP4k0mn0P84G5rw9yKGg1vYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=68VzJbJnuyEnxtIDAocLaoCHb8UGSgBXfSsBnTiGqg4=;
	b=dXkImo70bdcxHl8ifjwnA38aLw9R+tiI4CX1g6vwL3IeKerGnxaNEu9k9I0yTjSxDffN
	 OgJTGTNw782ig7SqJQK1WhoqrIzmTD54FH/GyZDP4fcfr+Dhhrwr8IuitmYTALyvYt4Z/
	 8+eKRx1u5NMWxDArJZbVp4+I0ePsw3oHXVXiiMWpqv/jr5Pg/mCyfYCX7bzja0bI1BH9+
	 QHiiz5mqtp0BE9R8WPRmaYlbr5PYEp/xxTZqjddAuNeWpTuy0LLImJtzKKULqKRA2Y5AU
	 8JHvOSSAyJPbV6BOxcWWpyi7UuH2zcvT2r9x3hOm80Zog3FsSB2taOq35QGGoeexfIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsqmboa9;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE89606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BE89606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsqmboa9
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-70bf1671c21so999128eaf.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 23:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793864605; x=1794469405; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=68VzJbJnuyEnxtIDAocLaoCHb8UGSgBXfSsBnTiGqg4=;
        b=xsqmboa90PkFa/H/KHIuhNYUL8edNyGIT4uR/bPfgSdM7qx1V+OCFwUPFVeFx+Y4OQ
         8iJjMn7dCU453qx63b+7wGYW2/kRyTNVqbJs+EUzlbqsD92wh1C0ronQwdQgtsqLA3Eb
         xyLmsbKwH63lwHdvFDrsppwrPAxcMC6urzeMZy9JQDmgEbTMQwHYzyKvlM2Ns8HwR7yn
         emd2qRyS7evfz/1rfsnKd2nIJKVOh5YNRiaXph5YGGVH/juHXy5DzD1oTXqHQTEmQyBE
         ezKov17UiDokkcMKeOCk6E4Yu9EwT06h5m17vAi3Oy8DuW9ze1gNeNYHgx2yMvrVVQ2w
         GKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864605; x=1794469405;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68VzJbJnuyEnxtIDAocLaoCHb8UGSgBXfSsBnTiGqg4=;
        b=z7MBAJvMxR3xFdQoI5FmXXYsB2qaccg26ijUX840R2Wh4xT843XhZhK27sh1Arm0bl
         AVKQh51/OepejGjIOOazf/8zntV8sYLnDkIdNI1TqP4k5gN7TSUECC21jpANsyKKnqtf
         0NLpLPWin7TTkXwEJ9Sp5MIxSdsZ9dYc6JyMSDCV4HODDjqu/RXKgUsSBYpJ28MtqHH3
         REO2FuDc3EI+jokTCgwwePcnFjExcwsVZun68OfCog7nU7ro8HnlLKstLzTaDoMVLmYU
         4yWjKQ22VozZ8x9Af8hacGS5jD8SNngQx9E+M4Mcktwrw/HcIwdOkDxMGa4tV7bKubXM
         qIgA==
X-Gm-Message-State: APuU4Z8DEvcBHuQEC+zwe8bIjt+4c6mB/c+tcBBb3w152VjFq3NANBZ6
	EJdWlk9UjTN4lSkX5ixHafbgLH3W3C21lXqCOSihG5ol5kMNxM2WlCiq/HjQbYVDhATjKg==
X-Gm-Gg: AYBFou09hh/ubGNh4R9mUqUPyMXpoc5oYA+Tq4gSBhCo51IhpiF8t+FnBBNZBEgspX7
	5OWhz35Wfqc7oEkwNQgEsJtEAMzpnsPLJ4mQmXw0M67EYpo2aCqzQdUbPzo0gO6JtGqUUU840JS
	ZkxCCAZEQbOUyTq/X6Z/rDG2j8n4rLlBJIFscVKnVdVsTLRfVf9xB38kTBov0jYF7gjWuTs131q
	LT1W245Vs1/7sM88wXWjQg21KfoOxuEokdMERrUFSviZ4n8l5eV60ovW9tkuOrxHZLlJvDfvEar
	1aNHZy4IOx2aLvXt3lLlA695NadGUjaAIPwzaqHebeZuSJ21zwOB7Cgy3UJTssd0yBm7U4vyira
	NjJ/q2hikiM80cSbr+/8i4f3NMYXaE/2tGNH3JJopRzhnqRW4M/IVUBl4lV41+VIZsV6dduq8+b
	fCaLreOd1ywwGzykakwIRlKEt+EM5X+ZinNomquyHq5OYU09eEWvLPBBHxLjXuA6Xxw8BM2vBuR
	LxrBnVe/Une6E9BN/z9N0m7tNywMujTcjVDdk/FjN/UjRsE4gQTpQMSP6K2XguPX6N17tlda5Io
	sBC7EtmTP+XFzSjiwPbXB4rJKhMUHgXA
X-Received: by 2002:a05:6820:3397:10b0:716:d48a:ee93 with SMTP id 006d021491bc7-716d48b1058mr543941eaf.61.1793864604670;
        Wed, 04 Nov 2026 23:43:24 -0800 (PST)
Received: from [127.0.0.1] ([20.15.230.243])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c1020ea2sm3526671eaf.2.2026.11.04.23.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 23:43:24 -0800 (PST)
Message-Id: <pull.2285.v3.git.1793864602482.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Nov 2026 07:43:22 +0000
Subject: [PATCH v3] odb: do not list our own refs as alternate refs
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
temporary object directory.  Child processes see it as their primary
object directory, and tmp-objdir passes the repository's own object
directory to them via GIT_ALTERNATE_OBJECT_DIRECTORIES.

The connectivity check passes --alternate-refs to rev-list since
39b44ba771 (check_everything_connected: assume alternate ref tips are
valid, 2019-07-01).  Inside the quarantine, the repository's own object
directory is one of the alternates, so --alternate-refs runs
for-each-ref on the repository itself and lists all of its refs.

That includes hidden refs.  bcec6780b2 (receive-pack: only use visible
refs for connectivity check, 2022-11-17) added --exclude-hidden=receive
to the check so that repositories with many hidden refs do not have to
load all of them on each push.  The hidden refs are excluded from --all,
but they all come back through --alternate-refs.

Our own repository is not a source of alternate refs: its refs are our
own refs, which the caller already lists as it sees fit.  So skip an
alternate whose repository is our own when listing alternate refs.
This does not depend on how the alternate came about, so it also covers
an environment that makes our own object directory an alternate by
hand.

Since --alternate-refs is a rev-list option, callers other than the
connectivity check may use it too, so this tightens what it means
rather than only fixing the connectivity check.  It is in line with
what we already do when loading alternates, where listing the object
directory itself is ignored as a common mistake; inside the quarantine
that check compares against the quarantine instead of our own object
directory, so our own object directory slips through.  Document the
tightened meaning, too.

Add tests that our own refs are no longer listed, by the connectivity
check, by rev-list run from a pre-receive hook, and by rev-list with
our own object directory passed in as an alternate by hand, and that
the refs of a real alternate still are.  Add a perf test pushing a
single commit into a repository with a visible branch and about
200,000 refs hidden by receive.hideRefs, and into a copy of it that
hides nothing:

    Test                           HEAD~1            HEAD
    -----------------------------------------------------------------------
    5552.2: push, hidden refs      0.29(0.31+0.06)   0.10(0.07+0.03) -65.5%
    5552.3: push, no hidden refs   1.20(1.02+0.68)   1.00(0.83+0.59) -16.7%

With hidden refs, most of the time went to the for-each-ref child that
listed the alternate refs.  Without hidden refs, every ref was listed
twice, once for --all and once for --alternate-refs.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    odb: do not list our own refs as alternate refs
    
    When a repository hides refs with receive.hideRefs, every push still
    loads all of the hidden refs in the connectivity check, even though
    bcec6780b2 (receive-pack: only use visible refs for connectivity check,
    2022-11-17) excludes them from it. With many hidden refs, that is most
    of the time spent on a small push.
    
    I stumbled across this while working on the boundary walk of the
    connectivity check (the follow-up to kk/connectivity-check-incremental),
    when the walk loaded every ref during a push even though it should only
    have looked at a few of them.
    
    Changes since v2:
    
     * Went back to the approach of v1, as Peff suggested: skip our own
       repository in the alternate refs code itself, with no special
       handling of the quarantine. The "borrowed" flag and the check for the
       parent of GIT_QUARANTINE_PATH are gone.
    
     * The commit message now describes this as a tightening of what
       --alternate-refs means, in line with how loading alternates already
       ignores the object directory itself.
    
     * Kept the documentation note and the tests from v2, except the one for
       a quarantine outside of the commondir.
    
    Changes since v1:
    
     * Changed the rule to "an alternate that is ourselves is not a source
       of alternate refs", as Peff described it.
    
     * Added a "borrowed" flag to alternates, set when they are loaded,
       which says whether they come from another repository, and used it for
       --alternate-refs. Our own object directory is recognized either as
       commondir/objects or as the parent of GIT_QUARANTINE_PATH.
    
     * Documented this for --alternate-refs.
    
     * Added tests for rev-list --alternate-refs in a pre-receive hook, for
       our own object directory set up as an alternate by hand, and for a
       quarantine outside of the commondir.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2285%2Fspkrka%2Fquarantine-altrefs-bugreport-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2285/spkrka/quarantine-altrefs-bugreport-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2285

Range-diff vs v2:

 1:  bac15042c0 ! 1:  35ab373cd4 odb: do not list our own refs as alternate refs in the quarantine
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    odb: do not list our own refs as alternate refs in the quarantine
     +    odb: do not list our own refs as alternate refs
      
          Since 722ff7f876 (receive-pack: quarantine objects until pre-receive
          accepts, 2016-10-03), receive-pack writes incoming objects to a
     -    temporary object directory. Child processes see it as their primary
     +    temporary object directory.  Child processes see it as their primary
          object directory, and tmp-objdir passes the repository's own object
          directory to them via GIT_ALTERNATE_OBJECT_DIRECTORIES.
      
          The connectivity check passes --alternate-refs to rev-list since
          39b44ba771 (check_everything_connected: assume alternate ref tips are
     -    valid, 2019-07-01). Inside the quarantine, the repository's own object
     +    valid, 2019-07-01).  Inside the quarantine, the repository's own object
          directory is one of the alternates, so --alternate-refs runs
          for-each-ref on the repository itself and lists all of its refs.
      
     -    That includes hidden refs. bcec6780b2 (receive-pack: only use visible
     +    That includes hidden refs.  bcec6780b2 (receive-pack: only use visible
          refs for connectivity check, 2022-11-17) added --exclude-hidden=receive
          to the check so that repositories with many hidden refs do not have to
     -    load all of them on each push. The hidden refs are excluded from --all,
     +    load all of them on each push.  The hidden refs are excluded from --all,
          but they all come back through --alternate-refs.
      
     -    An alternate that is ourselves is not a source of alternate refs: its
     -    refs are our own refs, which the caller already lists as it sees fit.
     -    Mark each object directory added via alternates with whether it is
     -    borrowed from another repository, and list alternate refs only from
     -    those. Within one process this needs no guessing, as tmp-objdir
     -    links our own object directory in itself. But a child process rebuilds
     -    its object store from the environment, so when an alternate is added,
     -    recognize ourselves in two ways:
     -
     -     - as our <commondir>/objects, which also covers an environment that
     -       makes our own object directory an alternate by hand;
     -
     -     - as the parent of GIT_QUARANTINE_PATH, as the quarantine is created
     -       directly inside our object directory (see "QUARANTINE ENVIRONMENT"
     -       in git-receive-pack(1)); this also works when the object directory
     -       is not under the commondir.
     -
     -    Document in --alternate-refs that our own object directory does not
     -    count as an alternate repository.
     -
     -    This is safe: alternate refs only serve as negative tips that are
     -    assumed to be complete, so dropping some can only make the traversal
     -    walk further, never make it accept a missing object.
     +    Our own repository is not a source of alternate refs: its refs are our
     +    own refs, which the caller already lists as it sees fit.  So skip an
     +    alternate whose repository is our own when listing alternate refs.
     +    This does not depend on how the alternate came about, so it also covers
     +    an environment that makes our own object directory an alternate by
     +    hand.
     +
     +    Since --alternate-refs is a rev-list option, callers other than the
     +    connectivity check may use it too, so this tightens what it means
     +    rather than only fixing the connectivity check.  It is in line with
     +    what we already do when loading alternates, where listing the object
     +    directory itself is ignored as a common mistake; inside the quarantine
     +    that check compares against the quarantine instead of our own object
     +    directory, so our own object directory slips through.  Document the
     +    tightened meaning, too.
      
          Add tests that our own refs are no longer listed, by the connectivity
     -    check, by rev-list run from a pre-receive hook, by rev-list with our
     -    own object directory passed in as an alternate by hand, and by rev-list
     -    in a quarantine whose parent is not under the commondir, and that the
     -    refs of a real alternate still are. Add a perf test pushing a
     +    check, by rev-list run from a pre-receive hook, and by rev-list with
     +    our own object directory passed in as an alternate by hand, and that
     +    the refs of a real alternate still are.  Add a perf test pushing a
          single commit into a repository with a visible branch and about
          200,000 refs hidden by receive.hideRefs, and into a copy of it that
          hides nothing:
      
              Test                           HEAD~1            HEAD
              -----------------------------------------------------------------------
     -        5552.2: push, hidden refs      0.31(0.33+0.08)   0.09(0.06+0.03) -71.0%
     -        5552.3: push, no hidden refs   1.23(1.06+0.68)   1.01(0.83+0.61) -17.9%
     +        5552.2: push, hidden refs      0.29(0.31+0.06)   0.10(0.07+0.03) -65.5%
     +        5552.3: push, no hidden refs   1.20(1.02+0.68)   1.00(0.83+0.59) -16.7%
      
          With hidden refs, most of the time went to the for-each-ref child that
     -    listed the alternate refs. Without hidden refs, every ref was listed
     +    listed the alternate refs.  Without hidden refs, every ref was listed
          twice, once for --all and once for --alternate-refs.
      
          Helped-by: Jeff King <peff@peff.net>
     @@ Documentation/rev-list-options.adoc: explicitly.
       
      
       ## odb.c ##
     -@@ odb.c: static int refs_from_alternate_cb(struct odb_files_dir *alternate,
     - 	size_t base_len;
     - 	struct alternate_refs_data *cb = payload;
     - 
     -+	if (!alternate->borrowed)
     -+		goto out;
     -+
     - 	if (!strbuf_realpath(&path, alternate->abspath, 0))
     - 		goto out;
     - 	if (!strbuf_strip_suffix(&path, "/objects"))
     -
     - ## odb/source-files.c ##
      @@
     - #include "blob.h"
     - #include "chdir-notify.h"
     + #include "abspath.h"
     + #include "commit-graph.h"
       #include "config.h"
      +#include "dir.h"
     -+#include "environment.h"
     + #include "environment.h"
       #include "gettext.h"
     - #include "hex.h"
     - #include "lockfile.h"
     -@@ odb/source-files.c: static void odb_source_files_free(struct odb_source *source)
     - 		files->dirs = next;
     - 	}
     - 	hashmap_clear(&files->dirs_by_path);
     -+	free(files->quarantine_path);
     - 
     - 	odb_source_release(&files->base);
     - 	free(files);
     -@@ odb/source-files.c: static int read_alternates(const char *object_dir, struct strvec *out)
     - 	return 0;
     - }
     + #include "hashmap.h"
     +@@ odb.c: static int refs_from_alternate_cb(struct odb_files_dir *alternate,
     + 				  void *payload)
     + {
     + 	struct strbuf path = STRBUF_INIT;
     ++	struct strbuf repo = STRBUF_INIT;
     + 	size_t base_len;
     + 	struct alternate_refs_data *cb = payload;
       
     -+/*
     -+ * Our own object directory is <commondir>/objects, or the parent of
     -+ * GIT_QUARANTINE_PATH, as an object quarantine is created directly
     -+ * inside it (see tmp_objdir_create()). Anything else, including a path
     -+ * that cannot be resolved, is borrowed.
     -+ */
     -+static bool is_borrowed_object_dir(struct odb_source_files *files,
     -+				   const char *path)
     -+{
     -+	struct strbuf real = STRBUF_INIT;
     -+	struct strbuf objdir = STRBUF_INIT;
     -+	struct strbuf self = STRBUF_INIT;
     -+	bool ret = true;
     -+
     -+	if (!strbuf_realpath(&real, path, 0))
     -+		goto out;
     -+
     -+	strbuf_addf(&objdir, "%s/objects", files->base.odb->repo->commondir);
     -+	if (strbuf_realpath(&self, objdir.buf, 0) &&
     -+	    !fspathcmp(real.buf, self.buf)) {
     -+		ret = false;
     -+		goto out;
     -+	}
     -+
     -+	if (files->quarantine_path &&
     -+	    strbuf_realpath(&self, files->quarantine_path, 0)) {
     -+		strbuf_strip_file_from_path(&self);
     -+		strbuf_trim_trailing_dir_sep(&self);
     -+		if (!fspathcmp(real.buf, self.buf))
     -+			ret = false;
     -+	}
     -+
     -+out:
     -+	strbuf_release(&real);
     -+	strbuf_release(&objdir);
     -+	strbuf_release(&self);
     -+	return ret;
     -+}
     -+
     - static void odb_add_alternate_recursively(struct odb_source_files *files,
     - 					  const char *path,
     - 					  int depth)
     -@@ odb/source-files.c: static void odb_add_alternate_recursively(struct odb_source_files *files,
     +@@ odb.c: static int refs_from_alternate_cb(struct odb_files_dir *alternate,
       		goto out;
     + 	strbuf_setlen(&path, base_len);
       
     - 	alternate = odb_files_dir_new(files->base.odb, path, false);
     -+	alternate->borrowed = is_borrowed_object_dir(files, alternate->abspath);
     - 
     - 	/* add the alternate entry */
     - 	*files->dirs_tail = alternate;
     -@@ odb/source-files.c: struct odb_source_files *odb_source_files_new(struct object_database *odb,
     - 	struct odb_source_files *files;
     - 	char *object_dir = NULL;
     - 	char *alternates = NULL;
     -+	char *quarantine_path = NULL;
     - 
     - 	if (flags & ODB_NEW_HONOR_ENV) {
     - 		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
     - 		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
     -+		quarantine_path =
     -+			xstrdup_or_null(getenv(GIT_QUARANTINE_ENVIRONMENT));
     - 	}
     - 	if (!object_dir)
     - 		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
     - 
     - 	CALLOC_ARRAY(files, 1);
     -+	files->quarantine_path = quarantine_path;
     - 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir);
     - 
     - 	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);
     -
     - ## odb/source-files.h ##
     -@@ odb/source-files.h: struct odb_files_dir {
     - 	 * repository. Directories added via alternates are not local.
     - 	 */
     - 	bool local;
     ++	/* Our own repository is not a source of alternate refs. */
     ++	if (strbuf_realpath(&repo, cb->repo->commondir, 0) &&
     ++	    !fspathcmp(path.buf, repo.buf))
     ++		goto out;
      +
     -+	/*
     -+	 * Whether this directory is borrowed from another repository, so
     -+	 * that its refs are alternate refs. Not every directory added via
     -+	 * alternates is borrowed: inside an object quarantine, our own
     -+	 * object directory is passed to us as an alternate, too. Only set
     -+	 * for directories added via alternates.
     -+	 */
     -+	bool borrowed;
     - };
     + 	read_alternate_refs(cb->repo, path.buf, cb->fn, cb->payload);
       
     - struct odb_files_dir *odb_files_dir_new(struct object_database *odb,
     -@@ odb/source-files.h: struct odb_source_files {
     - 	 * determined by "core.ignoreCase".
     - 	 */
     - 	int dirs_paths_icase;
     -+
     -+	/*
     -+	 * The value of GIT_QUARANTINE_PATH when this source was set up from
     -+	 * the environment (see ODB_NEW_HONOR_ENV), or NULL.
     -+	 */
     -+	char *quarantine_path;
     - };
     + out:
     + 	strbuf_release(&path);
     ++	strbuf_release(&repo);
     + 	return 0;
     + }
       
     - /* Allocate and initialize a new object source. */
      
       ## t/perf/p5552-push-hidden-refs.sh (new) ##
      @@
     @@ t/t5618-alternate-refs.sh: test_expect_success 'log --source shows .alternate ma
      +		git rev-list --alternate-refs >actual &&
      +	test_cmp expect actual
      +'
     -+
     -+# A quarantine is created inside our object directory, so its parent is
     -+# ourselves, even when that is not under our commondir.
     -+test_expect_success 'parent of the quarantine is not listed as an alternate' '
     -+	test_when_finished "rm -rf store.git" &&
     -+	git init --bare store.git &&
     -+	git push store.git refs/remotes/origin/one:refs/heads/one &&
     -+	quarantine="$(pwd)/store.git/objects/tmp_objdir-test" &&
     -+	mkdir "$quarantine" &&
     -+
     -+	git rev-parse origin/one >expect &&
     -+	GIT_OBJECT_DIRECTORY="$quarantine" \
     -+	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/store.git/objects" \
     -+		git rev-list --no-walk --alternate-refs --stdin </dev/null >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	GIT_QUARANTINE_PATH="$quarantine" \
     -+	GIT_OBJECT_DIRECTORY="$quarantine" \
     -+	GIT_ALTERNATE_OBJECT_DIRECTORIES="$(pwd)/store.git/objects" \
     -+		git rev-list --no-walk --alternate-refs --stdin </dev/null >actual &&
     -+	test_must_be_empty actual
     -+'
      +
       test_done


 Documentation/rev-list-options.adoc |  5 +++-
 odb.c                               |  8 ++++++
 t/perf/p5552-push-hidden-refs.sh    | 37 ++++++++++++++++++++++++++++
 t/t5547-push-quarantine.sh          | 38 +++++++++++++++++++++++++++++
 t/t5618-alternate-refs.sh           | 12 +++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)
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
index 2c93a9490c..0f78ffed6a 100644
--- a/odb.c
+++ b/odb.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "commit-graph.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hashmap.h"
@@ -183,6 +184,7 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf repo = STRBUF_INIT;
 	size_t base_len;
 	struct alternate_refs_data *cb = payload;
 
@@ -198,10 +200,16 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
+	/* Our own repository is not a source of alternate refs. */
+	if (strbuf_realpath(&repo, cb->repo->commondir, 0) &&
+	    !fspathcmp(path.buf, repo.buf))
+		goto out;
+
 	read_alternate_refs(cb->repo, path.buf, cb->fn, cb->payload);
 
 out:
 	strbuf_release(&path);
+	strbuf_release(&repo);
 	return 0;
 }
 
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
index 2fb6d549d3..e64e190c48 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,4 +58,16 @@ test_expect_success 'log --source shows .alternate marker' '
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
 test_done

base-commit: 750f5de7dfe9a4062f95088212b063f189d50e91
-- 
gitgitgadget
