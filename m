Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362375;
	b=WaDp+dU9LqxXzfvR5XfVsO1GirY9aYm3Mxw2CsXeL6aY9hdqtdTVDDBk4zKFpwyrWynA
	 N9Ymt7WUvZUFuTuTMmSVqWzuim3T0y1XbBkOcOiSzPdnNMtOLWacq/0qfxCJDoRhFiMBv
	 sbTNSkVWrvv24T2/AsxTNI4ScgJ2ODBRggc4NbvzWgnksyl0I/nHzznEqcyVNxXzykAWa
	 /auWxzRmbIdVWMoJrJESOUtWXh40lxESvBajCa51M6aX9KV/MUI2XS1cEte2S2GM7N4F7
	 3M3Mq/uHklUFJp1doZJPnOno02rve2iG4IJx+9yo+4Wh8KKUXEohHkpViGXvmfc9DZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=gcs0SU5Tt4kK6PvhjpM7vpYKOCZDC+Rb512J3XwUPWo=;
	b=SaM6Yrr9QzXq8saVtURHFXlXk3jd5mg9f06l4gBFek5QACih8RoYYNiK2u/RX+Hr8jSJ
	 bNqWqi/JvZvRNCs/MyYSPpkQU8Ms7svGngDLgOHOUCFwJTh/8QMNUXOMa8L4F7ArojdfC
	 vHJZ5tMkUStH+kznsTdpVyzV1GpAnsnL4cdWbK0JbOGsc85mzDuBxfo/no6ofRXQlLQRD
	 qQ9pdCAH0pHysk4CzpNkuUaKmRIgs6RG5X7TXN6rfkYFgLyTgV1H1UjJsVZTIJcw/5+SJ
	 QEcT4Zww9xNmxOMzjlo1ZTzA7mM2SekcIppKi9s8kWrc8aQIJgKGohh7KUr5crs1DCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDyZriZZ;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD35606A329
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 12:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD35606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDyZriZZ
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-844a8bf7e25so484798a34.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793362374; x=1793967174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gcs0SU5Tt4kK6PvhjpM7vpYKOCZDC+Rb512J3XwUPWo=;
        b=kDyZriZZekcRmjbmmH2Ovhay1sbqZzLwkq0tyYcyPtfTN80rgYGT0NPTC0B7etqP+d
         CBM6zQDcmGcNCnvg5mo4KWjxSQZluzNMhNaxMdNLTV3PrxlJIHWNdCtPcTOpybDp90TX
         PONS9ikxYeeHZUWVESz395ChyLmqF22jLLAZcWMmOasq7gYi02GlxliMn7hVqY2EHGmz
         KejLwNQVPWwd5cCWSnnYZIzE84UUhw1K6A4iuovpL1y1dBzHRORFUZcwYkeykwChdWgX
         4GOU84mYnPjpfULvL0mogwFNLY+DW+8csBp6UGAraW93IgVLIG387yARPScNMLgt+YZV
         +g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362374; x=1793967174;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gcs0SU5Tt4kK6PvhjpM7vpYKOCZDC+Rb512J3XwUPWo=;
        b=dTJPf9VUzIBK3Bas52Tk4cyCmDwb2zwZ406xZ5Y7NNDsWaDfCxsn35Sdvwub5fJ+E0
         qG6mAdSGKYCvEJnIZlgLMtfojlfKpHQ9W2TCiuVoJ5lTmZFCGXKYjz74Hj3dPKOLI6MM
         a0ZwAF3SAtNL+U1bri8MxTjfYGa2IOzT2av5nTJK+rPhPWp5cB5gBySw24LLfcAjP3OI
         Ri5BPU/8SmoCb7B/cDgpsyizSGLbUKpgIIlSwL6IEJFaxT1iQhNxCD/hsTDOg8DaINZv
         yIHyerWJw23jkEJzi1qhHZdsTu3hAqHKsJadpYD69DflfFKYL2RM5R7l1v1D0Y6ISTNd
         wsDg==
X-Gm-Message-State: AFq9FYJUncz7CdG60Oqh0EVJlgC5VQ6wQv137LL4ZJ4oP7tpxM3aElwt
	Mjx2GRbnXFeGGMcej5R74nqTzvonwRPnrW9u6KiY0TEkfcKIPlF2vgVAahV+kZjmcdI=
X-Gm-Gg: AYBFou1v+d3UdqCfGRxT90Mu0Gln9IcNchODxPr2BmMTINnVsEBl/kmpt6q3DafbG4V
	ahUwZqA/dC2cMkiZADqNCX7ABYODVX+nsAxtXTJJZNqjZwWMyxYL/2hAe8pH47UnoBTcoWuhKbv
	jPQEgObIythGPFXp/dzTpDfOO7k0aEATSHK7g7eA0H5SqsnGXnPh66Bk/MPTN41IzxWY+857pRU
	lpFV7EgMnw9kNu+SGvKUHOllSGWEl031vXwTlk9MadcjudQqAv0XTkyf+2T4ZXcv4IsoIz8rp7I
	gJ/m7yp66xKUpfFGf/SoZQTK6saJvS7QlhdHDVQSIMN+Duy/aJaUa8Da/GMZ9sg2r/pWA89VG6k
	0d5ko2o2Z5Z+3ukD5KyfW6l86YWFybNWJYbtCVpEAYvWnq47C+v/My8gg/cUf3u9DSMmpYKBD52
	d/s+Jmhv19Jg85OVbVpVD7w1KwNbWSHfdl3JN7VATT4r7JUnRMU2S5mYQRDvGMg1wkOeq0HyRy7
	e4Jcw9p5Zk6+HP2VdSOuj/oaTZ5M4rx1E/SrMSwtLB4/g33YnJ0tngi3VZClU9IONWYTpMWRNzi
	BfWvXzMadO8RD9iW99/8zAUOpGySwhzf
X-Received: by 2002:a05:6830:44ac:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-85d3614253fmr1451678a34.1.1793362373908;
        Fri, 30 Oct 2026 05:12:53 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.164.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d35499153sm1857155a34.9.2026.10.30.05.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:12:52 -0700 (PDT)
Message-Id: <pull.2286.git.1793362370899.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 12:12:50 +0000
Subject: [PATCH] Documentation: clarify Git's security boundary
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
    Junio C Hamano <gitster@pobox.com>,
    Toon Claes <toon@iotcl.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Toon Claes <toon@iotcl.com>

From: Toon Claes <toon@iotcl.com>

Like so many other open source projects, the Git project has seen an
ever-increasing flood of security reports. Many of those reports
describe valid bugs yet are redirected from the git-security mailing
list because they are deemed "not vulnerabilities". While some Git
contributors seem to have a very concrete idea how to discern between
bugs that constitute vulnerabilities (and hence must be fixed in secret,
to keep Git users safe) from bugs that can be fixed in the open, most
reporters must be quite puzzled because the Git project provides no
clear document to help define the security boundaries Git tries to
guarantee.

Of course, there _are_ hints and bits and pieces of documentation: Git's
security guidance has accumulated across individual fixes. Some might be
tempted to describe the boundary as "before clone" versus "after clone",
but history establishes a more precise distinction. e69ac42fcc8 (docs:
document security issues around untrusted .git dirs, 2024-04-16)
explains why cloned content can generally be inspected with `git log`:
repository-local hooks and configuration are not copied, whereas an
untrusted `.git` directory remains unsafe. 779ea9303a7 (Documentation:
define protected configuration, 2022-07-14) likewise ties trust to
configuration scope rather than timing alone.

State the governing principle in one place: Git's security boundary
concerns unexpected or implicit execution of attacker-controlled code. A
theoretical opportunity to inspect repository contents is not consent to
execute them. Conversely, explicitly choosing an execution-capable
mechanism is materially different. Execution after clone is therefore
not inherently a vulnerability.

This distinction underlies 4cd1cf31efe (Git 2.20.2, 2019-12-04), which
describes CVE-2019-19604 as code running during recursive clone plus a
submodule update "without the user explicitly having asked for that".
a1d4f67c12ac (transport: make protocol.file.allow be user by default,
2022-07-29) likewise contrasts direct user action with recursion lacking
user input. e4930e86c0d (t5510: verify that D/F confusion cannot lead to
an RCE, 2024-03-24) similarly frames remote code execution as code run
by an operation not expected to run it.

Timing remains relevant when it removes any meaningful choice.
873a466ea3f (clone: drop the protections where hooks aren't run,
2024-05-20) notes that clone-time hook execution leaves no chance to
inspect first. Conversely, 8d1a7448206 (setup.c: create
safe.bareRepository, 2022-07-14) addresses post-clone use of embedded
bare repositories. Together these cases show why timing alone cannot
define the boundary.

Assisted-by: GPT-5.6 Sol
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Documentation: clarify Git's security boundary
    
    This documents Git's security boundary, a topic that came up on the
    git-security mailing list. Since the discussion there has run its course
    and nobody objected to making it public, here it is as a regular series.
    
    Toon rewrote the document almost from scratch after reviewing it, and
    Patrick and Junio both shaped it substantially; the trailers carry the
    formal credit.
    
    Patrick floated the idea of a git --safe mode. I think this is a good
    idea, but since this document describes the status quo, it deliberately
    leaves that idea out.
    
    It is related to a discussion that Stolee tried to start on the
    git-security list years ago (but which unfortunately did not get any
    traction, something that now bites us with the onslaught of AI-assisted,
    reports, and I don't mean the easily dismissed slop, I mean
    well-crafted, well-argued reports that would have benefited from a clear
    documentation of Git's security boundary, something that I hereby aim to
    provide).
    
    A --safe flag would have to enumerate every execution-capable mechanism
    -- hooks, core.fsmonitor, core.sshCommand, core.pager, core.editor,
    core.hooksPath, uploadpack.packObjectsHook, protocol.*.allow,
    safe.bareRepository, safe.directory, submodule recursion,
    include.path/includeIf, aliases, and so on. That list would be a
    snapshot of today's attack surface, and it would rot as new mechanisms
    appear; the failure mode therefore would provide a false sense of
    safety. Instead, the --safe mode would require substantial refactoring
    so that there is a central registry of config settings and hooks, all
    with documented safety levels.
    
    Git's history bears this out: the set of execution-capable things is
    discovered incrementally (CVE-2019-19604, protocol.file.allow,
    safe.bareRepository, the clone-time hook protections dropped in
    873a466ea3f), so a flag promising safety would need re-auditing each
    time one is found.
    
    An alternative would be a narrower variant that is more defensible:
    per-operation switches that refuse execution-capable configuration, each
    with a narrow, auditable contract. The LOCAL DISK ACCESS and PROTECTED
    CONFIGURATION sections already point at what a user can do today
    (--no-local, safe.directory, safe.bareRepository).
    
    I am sure that listing these options invites a lengthy discussion, and I
    hope that it will not distract from getting this security boundary
    documentation from being finalized in a timely manner so that we have
    firmer ways to deal with security reports. It is easier to point to an
    official document stating that a Git config modified in one's worktree
    by an attacker is outside of what Git promises (if such a document
    exists) than trying to argue based on historical (public) record what
    constitutes a vulnerability in Git or not. Therefore having this
    document will be quite helpful, I expect, in dealing with the reports on
    the git-security mailing list.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2286%2Fdscho%2Fgit-security-boundary-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2286/dscho/git-security-boundary-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2286

 Documentation/Makefile                 |   1 +
 Documentation/git.adoc                 |   3 +
 Documentation/gitsecurityboundary.adoc | 184 +++++++++++++++++++++++++
 Documentation/meson.build              |   1 +
 SECURITY.md                            |   4 +
 command-list.txt                       |   1 +
 6 files changed, 194 insertions(+)
 create mode 100644 Documentation/gitsecurityboundary.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..577673221e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -62,6 +62,7 @@ MAN7_TXT += gitpacking.adoc
 MAN7_TXT += gitnamespaces.adoc
 MAN7_TXT += gitremote-helpers.adoc
 MAN7_TXT += gitrevisions.adoc
+MAN7_TXT += gitsecurityboundary.adoc
 MAN7_TXT += gitsubmodules.adoc
 MAN7_TXT += gittutorial-2.adoc
 MAN7_TXT += gittutorial.adoc
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6f0075f918..dfea97025d 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -1124,6 +1124,9 @@ unmerged version of a file when a merge is in progress.
 SECURITY
 --------
 
+See linkgit:gitsecurityboundary[7] for a broader discussion of Git's
+security model.
+
 Some configuration options and hook files may cause Git to run arbitrary
 shell commands. Because configuration and hooks are not copied using
 `git clone`, it is generally safe to clone remote repositories with
diff --git a/Documentation/gitsecurityboundary.adoc b/Documentation/gitsecurityboundary.adoc
new file mode 100644
index 0000000000..fd67824d23
--- /dev/null
+++ b/Documentation/gitsecurityboundary.adoc
@@ -0,0 +1,184 @@
+gitsecurityboundary(7)
+======================
+
+NAME
+----
+gitsecurityboundary - Git's security boundary
+
+SYNOPSIS
+--------
+gitsecurityboundary
+
+DESCRIPTION
+-----------
+
+Git encounters data in repositories that is not controlled by the user. That
+data must be treated as untrusted. It is considered safe to clone an untrusted
+Git repository and inspect its contents using Git commands like
+linkgit:git-log[1].
+
+Git repository configuration and hooks are not covered by this guarantee: the
+user is responsible for reviewing them to determine whether they are trusted.
+
+Crucially, copies of untrusted repositories (e.g. obtained via `.zip` or other
+archives) **must** be sanitized first and Git commands must only be run on this
+sanitized clone.
+
+SANITIZED CLONE
+---------------
+
+A `.git` directory contains active metadata, not merely repository content. It
+may contain configuration and hooks that cause Git to run arbitrary commands.
+Most Git commands should therefore *not* be run in an untrusted `.git` directory
+or the working tree that surrounds it.
+
+This distinction matters for repositories retrieved as filesystem copies or
+archives. A repository obtained through git-clone(1) sanitizes this metadata,
+while extracting an archive that contains a `.git` directory doesn't have these
+protections. To create a sanitized copy, clone the untrusted repository with:
+
+------------
+git clone --no-local <untrusted-repository> <clean-copy>
+------------
+
+This creates a full clone of the untrusted repository, but excludes all
+configuration and hooks that might cause harmful code to run when some Git
+commands are executed.
+
+Note that `--no-local` is required here: a local clone (the default when the
+source is given as a path) bypasses the transport layer and hardlinks the
+source repository's object database instead of copying it, so it does not
+sanitize the repository.
+
+This is also the way to turn an untrusted local repository into a trusted one:
+there is no way to verify by inspection that the binary files in an untrusted
+object database are safe, so the repository must be re-cloned through the
+transport layer rather than trusted in place.
+
+Serving an untrusted repository to `git clone` still exposes
+linkgit:git-upload-pack[1] to that repository. For additional isolation,
+`upload-pack` can be run as an unprivileged user where the platform permits it.
+
+REPOSITORY CONTENTS UNTRUSTED
+-----------------------------
+
+Creating a sanitized clone avoids copying configuration and hooks from the
+potentially evil repository. But it does not make contents in the repository
+trustworthy. The user is still responsible for inspecting the repository data
+before executing or installing any of the data inside.
+
+After cloning, Git commands intended to inspect repository contents should not
+unexpectedly execute those contents. If the user reviews and explicitly enables
+a hook, filter, helper, or other program supplied by the repository, the user
+has extended trust to that program.
+
+UNEXPECTED CODE EXECUTION
+-------------------------
+
+Git protects against remote code execution, thus an attacker shall not be able
+to run malicious code as part of a Git operation (that is not expected to run
+that code). For example, it is considered a security vulnerability when a bug in
+git-clone(1) writes an executable hook into the new repository and runs that
+hook.
+
+It doesn't matter at which point this code runs. Whether it's at the end of the
+clone, or another Git command that's used on the repository.
+
+By using Git commands on a repository to inspect its contents, the user does not
+consent to execute that content. Explicitly running a checked-out script is
+different from passing a repository-supplied filename to a Git command that is
+expected only to inspect it.
+
+This principle is not new; it has guided individual fixes over the years:
+
+* e69ac42fcc8 (docs: document security issues around untrusted .git dirs,
+  2024-04-16) explains why cloned content can generally be inspected with
+  `git log`: repository-local hooks and configuration are not copied, whereas
+  an untrusted `.git` directory remains unsafe.
+
+* 779ea9303a7 (Documentation: define protected configuration, 2022-07-14) ties
+  trust to configuration scope rather than to when the code runs.
+
+* 4cd1cf31efe (Git 2.20.2, 2019-12-04) describes CVE-2019-19604 as code running
+  during recursive clone plus a submodule update "without the user explicitly
+  having asked for that".
+
+* a1d4f67c12ac (transport: make protocol.file.allow be user by default,
+  2022-07-29) contrasts direct user action with recursion lacking user input.
+
+* e4930e86c0d (t5510: verify that D/F confusion cannot lead to an RCE,
+  2024-03-24) frames remote code execution as code run by an operation not
+  expected to run it.
+
+* 873a466ea3f (clone: drop the protections where hooks aren't run, 2024-05-20)
+  notes that clone-time hook execution leaves no chance to inspect first.
+
+* 8d1a7448206 (setup.c: create `safe.bareRepository`, 2022-07-14) addresses
+  post-clone use of embedded bare repositories.
+
+Together these cases show why the point at which code runs cannot by itself
+define the boundary.
+
+READING AND WRITING OUTSIDE THE REPOSITORY
+------------------------------------------
+
+Git also protects against repository contents causing Git to read from or write
+to paths outside the repository's working tree. This is not about files the user
+or platform explicitly asks Git to use, such as configuration files or paths
+given on the command line. It is about paths stored in the repository payload
+that lead Git outside the worktree, for example through a symlink or a
+path-traversing filename.
+
+This differs from LOCAL DISK ACCESS: there, the attacker already controls the
+local disk. Here, the attacker uses Git's processing of untrusted repository
+contents to reach paths the user did not intend to expose.
+
+By inspecting repository contents, the user does not consent to these side
+effects.
+
+USER INTENT AND RECURSION
+-------------------------
+
+Some potentially dangerous mechanisms are allowed when selected directly by the
+user but restricted when reached indirectly. For example, a protocol may be
+configured with the `user` policy so that it can be used directly but not by
+recursive submodule initialization, which runs clone or fetch operations
+without additional user input. See `protocol.allow` in linkgit:git-config[1].
+User input establishes intent only when the user selects the mechanism that can
+execute code. A repository-controlled argument does not become trusted merely
+because it is passed through a command the user invoked.
+
+PROTECTED CONFIGURATION
+-----------------------
+
+Git treats system, global, and command-scope configuration as protected
+configuration, and assumes that the user or a trusted administrator controls
+these scopes. Repository-local configuration does not receive that
+presumption, so options that affect security may be respected only in
+protected configuration and ignored otherwise. See "Protected configuration"
+in linkgit:git-config[1] for the authoritative list.
+
+LOCAL DISK ACCESS
+-----------------
+
+Git does not consider an adversary who can already write to the local disk to
+be within its security boundary. Such an attacker can modify the Git
+executable, the user's configuration, or the repository itself, and can
+therefore cause harm without exploiting Git. The boundary described here
+concerns data that Git consumes from a repository the user does not control,
+not data that an attacker can place on the user's own filesystem.
+
+SEE ALSO
+--------
+
+linkgit:git[1],
+linkgit:git-clone[1],
+linkgit:git-config[1],
+linkgit:git-upload-pack[1],
+linkgit:githooks[5],
+linkgit:gitmodules[5]
+
+GIT
+---
+
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..f5b1c03627 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -205,6 +205,7 @@ manpages = {
   'gitnamespaces.adoc' : 7,
   'gitremote-helpers.adoc' : 7,
   'gitrevisions.adoc' : 7,
+  'gitsecurityboundary.adoc' : 7,
   'gitsubmodules.adoc' : 7,
   'gittutorial-2.adoc' : 7,
   'gittutorial.adoc' : 7,
diff --git a/SECURITY.md b/SECURITY.md
index c720c2ae7f..1a21e4c9d1 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -10,6 +10,10 @@ vulnerability, it is recommended to send the report to
 git-security@googlegroups.com (and obviously not to discuss the
 issue anywhere else).
 
+See the [security boundary
+documentation](https://git-scm.com/docs/gitsecurityboundary) for a
+discussion of what Git considers to be within its security boundary.
+
 Vulnerabilities are expected to be discussed _only_ on that
 list, and not in public, until the official announcement on the
 Git mailing list on the release date.
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..4dfba75150 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -242,6 +242,7 @@ gitprotocol-v2                          developerinterfaces
 gitremote-helpers                       guide
 gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
+gitsecurityboundary                     guide
 gitsubmodules                           guide
 gittutorial                             guide
 gittutorial-2                           guide

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
