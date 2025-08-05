Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2E259CBC
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422558; cv=none; b=oGfufyeyW12OM48hEI0gZ1BUlGBQ7lRg6DchDpZlrBS6SjISn7NkfLwT0/M2YUjSJhGpdLWBhERoOWp88oGnbXtVHGCiJ1w3Kco6zUk0IxBSmlr3klSBQ48e34j/P5u3mK89npTuV3AL0nOmc8eD2yYfq3EmCBWcIJl1rt2OM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422558; c=relaxed/simple;
	bh=WYdXfe7dsZ/kyLYwfkdT3/m3K76hARpd1YazuUscJjc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GUzRgf9mxFFgr9aeKtwXBqGiKm9nsRw9rdarFqi0BU5hmT5xQ2JxQoEcCjO5ESGkXSC6e8cbKNZ41T7RYI/XLjDQWFf+giTiLE+zjlMWrFpyF8MMrveZOhmfKmFPGkEnAw4EnkoZRyXNFLTFIP9/HT3sVlUN8DR5e6sU2R/gWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DenVp0q7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DenVp0q7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso7545305e9.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422554; x=1755027354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRpeAi8HLriZw9CP6ySlOOxgv1a57ApJcNDQf1beXmE=;
        b=DenVp0q7esLzg3KNQbRJkAUueiKlOIjIMDSi9GLs4gz/d/143HVOZmhquAtR6dOTfO
         BTgGQoJlqBHWu5TfgRXi7mFt+RslNZOqpRB1UIpLNJ//3F4mHHE2by3i2yCp6jjinQ3z
         Mq2OdRrz75Gi54xBqC7xoGpxHlYvmB0ABrrqkDYrVs4rhPz0p7g/UtABlfHMuR/u5oXh
         VcFRFIJwbNTI+7k+fF3a4jIH+gWgSZCfWmecyhgt2C7GJO3HOJOGbGKa0uKjUMNiw8dM
         EmtrBVT2D5atyfGwVhZBqMq22OfyZNVE+QeCbBTd47HjtzWunxiMcb0KtsCVToJ+mvBj
         blRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422554; x=1755027354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRpeAi8HLriZw9CP6ySlOOxgv1a57ApJcNDQf1beXmE=;
        b=wnxK7KqjQm76HMpcurDXeMSnxByotmLbFaTwb8tZiynsggdmAilKMq/Q930PW3dsJw
         5oJWJLQyaFKv21QXUCEY9aOP0hXQEL1XiMCJE8FmWB8DtlPzODa/x5ja0JStREBpCVU9
         pui3jE+z/BpcfDQNoJU8f99n9ZHYbzcxsrR+fVxa2rGnOX82OJkVO1hgvH9H7wnMJBIW
         4qWIUyys8+A6jjw5GmUwBThkuBM8RasZbEhc8SE2qsRjzRsYWUaCOhxW82Wm5aenYSKw
         Z32vbc8ieOKOymjmY675eO15uxgpasJ0rhlW9Dg87dZHtLjWXSfCVZHMA/ZPSX5QbMY7
         LarA==
X-Gm-Message-State: AOJu0YzJ4/wFYe1PinkooAiTfvjrrM/q3r9r0xvNPR+9GVfXG6IExe8B
	c4VWsU9gPbjlFUp6fKAP2hweziLI3iujahoMos0MaT6t+hU1h2MOIA7W4EvZGA==
X-Gm-Gg: ASbGncvVlYcfAhTY3amQDZ16+quaoCOdJeryoEB3Zf+vhMoOitNj9fSz7MyFCsbDkzh
	DvrTuSiUj79NUdor3W3Z0VF+ZFC6OJrJpZXrdrKDiR7OXDT8TvUWWC/5VbBDKF196SujHMbE8KS
	V/RZIkAsv5zpk4ZcMKhRuf7WGyZPWwOMWvjZBdAjs4h89PFmomjuIyM2m5n+8AKk8y3pBR4h8Wa
	M/9qBnTSec2fw2WQO+iP+yQfn0sX1JQTB/FDo5e064bkIxjnEmjdTNWFgLewVtIclwsFWpYxwbj
	+uO9n6BaORW/B1UKBCyGVMmnKfcFyAAIvLFycu76lwjIfukKr8kO20otlNur7GL3m2OcCWc1NOP
	XPJ7PCXC4TijGFIWunwXX6NA=
X-Google-Smtp-Source: AGHT+IE+ErM++bI4VySzfGepMsZWzAfCgNyugjx5gOR3riINR8aRX6N1ZzZM399amBto2enf4KJcyA==
X-Received: by 2002:a05:600c:190d:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-459e7079767mr1258705e9.4.1754422553386;
        Tue, 05 Aug 2025 12:35:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm281282825e9.25.2025.08.05.12.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:52 -0700 (PDT)
Message-Id: <7238c8caf2b3c8c2516a8939c7590566cdaabd03.1754422546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:46 +0000
Subject: [PATCH v2 6/6] merge-ort: fix directory rename on top of source of
 other rename/delete
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

At GitHub, we've got a real-world repository that has been triggering
failures of the form:

    git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.

which comes from the line:

    VERIFY_CI(newinfo);

Unfortunately, this one has been quite complex to unravel, and is a
bit complex to explain.  So, I'm going to carefully try to explain each
relevant piece needed to understand the fix, then carefully build up
from a simple testcase to some of the relevant testcases.

== New special case we need to consider ==

Rename pairs in the diffcore machinery connect the source path of a
rename with the destination path of a rename.  Since we have rename
pairs to consider on both sides of history since the merge base,
merging has to consider a few special cases of possible overlap:

  A) two rename pairs having the same target path
  B) two rename pairs having the same source path
  C) the source path of one rename pair being the target path of a
     different rename pair

Some of these came up often enough that we gave them names:
  A) a rename/rename(2to1) conflict (looks similar to an add/add conflict)
  B) a rename/rename(1to2) conflict, which represents the same path being
     renamed differently on the two sides of history
  C) not yet named

merge-ort is well-prepared to handle cases (A) and (B), as was
merge-recursive (which was merge-ort's predecessor).  Case (C) was
briefly considered during the years of merge-recursive maintenance,
but the full extent of support it got was a few FIXME/TODO comments
littered around the code highlighting some of the places that would
probably need to be fixed to support it.  When I wrote merge-ort I
ignored case (C) entirely, since I believed that case (C) was only
possible if we were to support break detection during merges.  Not
only had break detection never been supported by any merge algorithm,
I thought break detection wasn't worth the effort to support in a
merge algorithm.  However, it turns out that case (C) can be triggered
without break detection, if there's enough moving pieces.

Before I dive into how to trigger case (C) with directory renames plus
other renames, it might be helpful to use a simpler example with break
detection first.  And before we get to that it may help to explain
some more basics of handling renames in the merge algorithm.  So, let
me first backup and provide a quick refresher on each of

  * handling renames
  * what break detection would mean, if supported in merging
  * handling directory renames

From there, I'll build up from a basic directory rename detection case
to one that triggers a failure currently.

== Handling renames ==

In the merge machinery when we have a rename of a path A -> B,
processing that rename needs to remove path A, and make sure that path B
has the relevant information.  Note that if the content was also
modified on both sides, this may mean that we have 3 different stages
that need to be stored at path B instead of having some stored at path
A.

Having all stages stored at path B makes it much easier for users to
investigate and resolve the content conflict associated with a renamed
path.  For example:
  * "git status" doesn't have to figure out how to list paths A & B and
    attempt to connect them for users; it can just list path B.
  * Users can use "git ls-files -u B" (instead of trying to find the
    previous name of the file so they can list both, i.e. "git ls-files
    -u A B")
  * Users can resolve via "git add B" (without needing to "git rm A")

== What break detection would mean ==

If break detection were supported, we might have cases where A -> B
*and* C -> A, meaning that both rename pairs might believe they need to
update A.  In particular, the processing of A -> B would need to be
careful to not clear out all stages of A and mark it resolved, while
both renames would need to figure out which stages of A belong with A
and which belong with B, so that both paths have the right stages
associated with them.

merge-ort (like merge-recursive before it) makes no attempt to handle
break detection; it runs with break detection turned off.  It would
need to be retrofitted to handle such cases.

== Directory rename detection ==

If one side of history renames directory D/ -> E/, and the other side of
history adds new files to D/, then directory rename detection notices
and suggests moving those new files to E/.  A similar thing is done for
paths renamed into D/, causing them to be transitively renamed into E/.

The default in the merge machinery is to report a conflict whenever a
directory rename might modify the location of a path, so that users can
decide whether they wanted the original path or the
directory-rename-induced location.  However, that means the default
codepath still runs through all the directory rename detection logic, it
just supplements it with providing conflict notices when it is done.

== Building up increasingly complex testcases ==

I'll start with a really simple directory rename example, and then
slowly add twists that explain new pieces until we get to the
problematic cases:

=== Testcase 1 ===

Let's start with a concrete example, where particular files/directories of
interest that exist or are changed on each side are called out:

  Original:   <nothing of note>
  our side:   rename B/file -> C/file
  their side: rename C/     -> A/

For this case, we'd expect to see the original B/file appear not at
C/file but at A/file.

(We would also expect a conflict notice that the user will want to
choose between C/file and A/file, but I'm going to ignore conflict
notices from here on by assuming merge.directoryRenames is set to
`true` rather than `conflict`; the only difference that assumption
makes is whether that makes the merge be considered to be conflicted
and whether it prints a conflict notice; what is written to the index
or working directory is unchanged.)

=== Testcase 2 ===

Modify testcase 1 by having A/file exist from the start:

  Original:   A/file exists
  our side:   rename B/file -> C/file
  their side: rename C/     -> A/

In such a case, to avoid user confusion at what looks kind of like an
add/add conflict (even though the original path at A/file was not added
by either side of the merge), we turn off directory rename detection for
this path and print a "in the way" warning to the user:
    CONFLICT (implicit dir rename): Existing file/dir ... in the way ...
The testcases in section 5 of t6423 explore these in more detail.

=== Testcase 3 ===

Let's modify testcase 1 in a slightly different way: have A/file be
added by their side rather than it already existing.

  Original:   <nothing of note>
  our side:   rename B/file -> C/file
  their side: rename C/     -> A/
              add A/file

In this case, the directory rename detection basically transforms our
side's original B/file -> C/file into a B/file -> A/file, and so we
get a rename/add conflict, with one version of A/file coming from the
renamed file, and another coming from the new A/file, each stored as
stages 2 and 3 in conflicts.  This kind of add/add conflict is perhaps
slightly more complex than a regular add/add conflict, but with the
printed messages it makes sense where it came from and we have
different stages of the file to work with to resolve the conflict.

=== Testcase 4 ===

Let's do something similar to testcase 3, but have the opposite side of
history add A/file:

  Original:   <nothing of note>
  our side:   rename B/file -> C/file
              add    A/file
  their side: rename C/     -> A/

Now if we allow directory rename detection to modify C/file to A/file,
then we also get a rename/add conflict, but in this case we'd need both
higher order stages being recorded on side 2, which makes no sense.  The
index can't store multiple stage 2 entries, and even if we could, it
would probably be confusing for users to work with.  So, similar to what
we do when there was an A/file in the original version, we simply turn
off directory rename detection for cases like this and provide the "in
the way" CONFLICT notice to the user.

=== Testcase 5 ===

We're slowly getting closer.  Let's mix it up by having A/file exist at
the beginning but not exist on their side:

  original:   A/file exists
  our side:   rename B/file -> C/file
  their side: rename C/     -> A/
              rename A/file -> D/file

For this case, you could say that since A/file -> D/file, it's no longer
in the way of C/file being moved by directory rename detection to
A/file.  But that would give us a case where A/file is both the source
and the target of a rename, similar to break detection, which the code
isn't currently equipped to handle.

This is not yet the case that causes current failures; to the current
code, this kind of looks like testcase 4 in that A/file is in the way
on our side (since A/file was in the original and was umodified by our
side).  So, it results in a "in the way" notification with directory
rename detection being turned off for A/file so that B/file ends up at
C/file.

Perhaps the resolution could be improved in the future, but our "in
the way" checks prevented such problems by noticing that A/file exists
on our side and thus turns off directory rename detection from
affecting C/file's location.  So, while the merge result could be
perhaps improved, the fact that this is currently handled by giving
the user an "in the way" message gives the user a chance to resolve
and prevents the code from tripping itself up.

=== Testcase 6 ===

Let's modify testcase 5 a bit more, to also delete A/file on our side:

  original:   A/file exists
  our side:   rename B/file -> C/file
              delete A/file
  their side: rename C/     -> A/
              rename A/file -> D/file

Now the "in the way" logic doesn't detect that there's an A/file in
the way (neither side has an A/file anymore), so it's fine to
transitively rename C/file further to A/file...except that we end up
with A/file being both the source of one rename, and the target of a
different rename.  Each rename pair tries to handle the resolution of
the source and target paths of its own rename.  But when we go to
process the second rename pair in process_renames(), we do not expect
either the source or the destination to be marked as handled already;
so, when we hit the sanity checks that these are not handled:

    VERIFY_CI(oldinfo);
    VERIFY_CI(newinfo);

then one of these is going to throw an assertion failure since the
previous rename pair already marked both of its paths as handled.
This will give us an error of the form:

    git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.

This is the failure we're currently triggering, and it fundamentally
depends on:
  * a path existing in the original
  * that original path being removed or renamed on *both* sides
  * some kind of directory rename moving some *other* path into that
    original path

This was added as testcase 12q in t6423.

=== Testcase 7 ===

Bonus bug found while investigating!

Let's go back to the comparison between testcases 2 & 3, and set up a
file present on their side that we need to consider:

  Original:   A/file exists
  our side:   rename B/file -> C/file
              rename A/file -> D/file
  their side: rename C/     -> A/

Here, there is no A/file in the way on our side like testcase 4.
There is an A/file present on their side like testcase 3, which was an
add/add conflict, but that's associated with the file be renamed to
D/file.  So, that really shouldn't be an add/add conflict because we
instead want all modes of the original A/file to be transported to
D/file.

Unfortunately, the current code kind of treats it like an add/add
conflict instead...but even worse.  There is also a valid mode for
A/file in the original, which normally goes to stage 1.  However, an
add/add conflict should be represented in the index with no mode at
stage 1 (for the original side), only modes at stages 2 and 3 (for our
and their side), so for an add/add we'd expect that mode for A/file in
the original version to be cleared out (or be transported to D/file).

Unfortunately, the code currently leaves not only the stage 3 entry
for A/file intact, it also leaves the stage 1 entry for A/file.  This
results in `git ls-files -u A/file` output of the form:

    100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 1	A/file
    100644 0cfbf08886fca9a91cb753ec8734c84fcbe52c9f 2	A/file
    100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 3	A/file

This would likely cause users to believe this isn't an add/add
conflict; rather, this would lead them to believe that A/file was only
modified on our side and that therefore it should not have been a
conflict in the first place.  And while resolving the conflict in
favor of our side is the correct resolution (because stages 1 and 3
should have been cleared out in the first place), this is certainly
likely to cause confusion for anyone attempting to investigate why
this path was marked as conflicted.

This was added as testcase 12p in t6423.

== Attempted solutions that I discarded ==

1) For each side of history, create a strset of the sources of each
   rename on the other side of history.  Then when using directory
   renames to modify existing renames, verify that we aren't renaming
   to a source of another rename.

   Unfortunately, the "relevant renames" optimization in merge-ort
   means we often don't detect renames -- we just see a delete and an
   add -- which is easy to forget and makes debugging testcases harder,
   but it also turns out that this solution in insufficient to solve
   the related problems in the area (more on that below).

2) Modify the code to be aware of the possibility of renaming to
   the source of another side's rename, and make all the conflict
   resolution logic for each case (including existing
   rename/rename(2to1) and rename/rename(1to2) cases) handle the
   additional complexity.  It turns out there was much more code to
   audit than I wanted, for a really niche case.  I didn't like how
   many changes were needed, and aborted.

== Solution ==

We do not want the stages of unrelated files appearing at the same path
in the index except when dealing with an add/add conflict.  While we
previously handled this for stages 2 & 3, we also need to worry about
stage 1.  So check for a stage 1 index entry being in the way of a
directory rename.

However, if we can detect that the stage 1 index entry is actually from
a related file due to a directory-rename-causes-rename-to-self
situation, then we can allow the stage 1 entry to remain.

From this wording, you may note that it's not just rename cases that
are a problem; bugs could be triggered with directory renames vs simple
adds.  That leads us to...

== Testcases 8+ ==

Another bonus bug, found via understanding our final solutions (and the
failure of our first attempted solution)!

Let's tweak testcase 7 a bit:

  Original:   A/file exists
  our side:   delete A/file
              add -> C/file
  their side: delete A/file
              rename C/     -> A/

Here, there doesn't seem to be a big problem.  Sure C/file gets modified
via the directory rename of C/ -> A/ so that it becomes A/file, but
there's no file in the way, right?  Actually, here we have a problem
that the stage 1 entry of A/file would be combined with the stage 2
entry of C/file, and make it look like a modify/delete conflict.
Perhaps there is some extra checking that could be added to the code to
make it attempt to clear out the stage 1 entry of A/file, but the
various rename-to-self-via-directory-rename testcases make that a bit
more difficult.  For now, it's easier to just treat this as a
path-in-the-way situation and not allow the directory rename to modify
C/file.

That sounds all well and good, but it does have an interesting side
effect.  Due to the "relevant renames" optimizations in merge-ort (i.e.
only detect the renames you need), 100% renames whose files weren't
modified on the other side often go undetected.  This means that if we
modify this testcase slightly to:

  Original:   A/file exists
  our side:   A/file -> C/file
  their side: rename C/ -> A/

Then although this looks like where the directory rename just moves
C/file back to A/file and there's no problem, we may not detect the
A/file -> C/file rename.  Instead it will look like a deletion of A/file
and an addition of C/file.  The directory rename then appears to be
moving C/file to A/file, which is on top of an "unrelated" file (or at
least a file it doesn't know is related).  So, we will report
path-in-the-way conflicts now in cases where we didn't before.  That's
better than silently and accidentally combining stages of unrelated
files and making them look like a modify/delete; users can investigate
the reported conflict and simply resolve it.

This means we tweak the expected solution for testcases 12i, 12j, and
12k.  (Those three tests are basically the same test repeated three
times, but I was worried when I added those that subtle differences in
parent/child, sibling/sibling, and toplevel directories might mess up
how rename-to-self testcases actually get handled.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         |  18 +-
 t/t6423-merge-rename-directories.sh | 357 ++++++++++++++++++++++++++--
 2 files changed, 355 insertions(+), 20 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index feb06720c7e1..8f6118163849 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2313,14 +2313,20 @@ static char *apply_dir_rename(struct strmap_entry *rename_info,
 	return strbuf_detach(&new_path, NULL);
 }
 
-static int path_in_way(struct strmap *paths, const char *path, unsigned side_mask)
+static int path_in_way(struct strmap *paths,
+		       const char *path,
+		       unsigned side_mask,
+		       struct diff_filepair *p)
 {
 	struct merged_info *mi = strmap_get(paths, path);
 	struct conflict_info *ci;
 	if (!mi)
 		return 0;
 	INITIALIZE_CI(ci, mi);
-	return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
+	return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
+	  /* See testcases 12{n,p,q} for more details on this next condition */
+			 || ((ci->filemask & 0x01) &&
+			     strcmp(p->one->path, path));
 }
 
 /*
@@ -2332,6 +2338,7 @@ static int path_in_way(struct strmap *paths, const char *path, unsigned side_mas
 static char *handle_path_level_conflicts(struct merge_options *opt,
 					 const char *path,
 					 unsigned side_index,
+					 struct diff_filepair *p,
 					 struct strmap_entry *rename_info,
 					 struct strmap *collisions)
 {
@@ -2366,7 +2373,7 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 	 */
 	if (c_info->reported_already) {
 		clean = 0;
-	} else if (path_in_way(&opt->priv->paths, new_path, 1 << side_index)) {
+	} else if (path_in_way(&opt->priv->paths, new_path, 1 << side_index, p)) {
 		c_info->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &c_info->source_files);
@@ -2573,6 +2580,7 @@ static void free_collisions(struct strmap *collisions)
 static char *check_for_directory_rename(struct merge_options *opt,
 					const char *path,
 					unsigned side_index,
+					struct diff_filepair *p,
 					struct strmap *dir_renames,
 					struct strmap *dir_rename_exclusions,
 					struct strmap *collisions,
@@ -2629,7 +2637,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
 		return NULL;
 	}
 
-	new_path = handle_path_level_conflicts(opt, path, side_index,
+	new_path = handle_path_level_conflicts(opt, path, side_index, p,
 					       rename_info,
 					       &collisions[side_index]);
 	*clean_merge &= (new_path != NULL);
@@ -3428,7 +3436,7 @@ static int collect_renames(struct merge_options *opt,
 		}
 
 		new_path = check_for_directory_rename(opt, p->two->path,
-						      side_index,
+						      side_index, p,
 						      dir_renames_for_side,
 						      rename_exclusions,
 						      collisions,
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 49eb10392bed..533ac85dc834 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4759,10 +4759,29 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 
 		git checkout A^0 &&
 
-		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
-
-		test_path_is_missing source/subdir &&
-		test_path_is_file source/bar &&
+		# NOTE: A potentially better resolution would be for
+		#     source/bar -> source/subdir/bar
+		# to use the directory rename to become
+		#     source/bar -> source/bar
+		# (a rename to self), and thus we end up with bar with
+		# a path conflict (given merge.directoryRenames=conflict).
+		# However, since the relevant renames optimization
+		# prevents us from noticing
+		#     source/bar -> source/subdir/bar
+		# as a rename and looking at it just as
+		#     delete source/bar
+		#     add source/subdir/bar
+		# the directory rename of source/subdir/bar -> source/bar does
+		# not look like a rename-to-self situation but a
+		# rename-on-top-of-other-file situation.  We do not want
+		# stage 1 entries from an unrelated file, so we expect an
+		# error about there being a file in the way.
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
+
+		grep "CONFLICT (implicit dir rename).*source/bar in the way" out &&
+		test_path_is_missing source/bar &&
+		test_path_is_file source/subdir/bar &&
 		test_path_is_file source/baz &&
 
 		git ls-files >actual &&
@@ -4771,8 +4790,8 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
-		UU source/bar
 		M  source/baz
+		R  source/bar -> source/subdir/bar
 		EOF
 		test_cmp expect actual
 	)
@@ -4882,10 +4901,29 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 
 		git checkout A^0 &&
 
-		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
-
-		test_path_is_missing subdir &&
-		test_path_is_file bar &&
+		# NOTE: A potentially better resolution would be for
+		#     bar -> subdir/bar
+		# to use the directory rename to become
+		#     bar -> bar
+		# (a rename to self), and thus we end up with bar with
+		# a path conflict (given merge.directoryRenames=conflict).
+		# However, since the relevant renames optimization
+		# prevents us from noticing
+		#     bar -> subdir/bar
+		# as a rename and looking at it just as
+		#     delete bar
+		#     add subdir/bar
+		# the directory rename of subdir/bar -> bar does not look
+		# like a rename-to-self situation but a
+		# rename-on-top-of-other-file situation.  We do not want
+		# stage 1 entries from an unrelated file, so we expect an
+		# error about there being a file in the way.
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
+		grep "CONFLICT (implicit dir rename).*bar in the way" out &&
+
+		test_path_is_missing bar &&
+		test_path_is_file subdir/bar &&
 		test_path_is_file baz &&
 
 		git ls-files >actual &&
@@ -4894,8 +4932,8 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
-		UU bar
 		M  baz
+		R  bar -> subdir/bar
 		EOF
 		test_cmp expect actual
 	)
@@ -4942,10 +4980,29 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 
 		git checkout A^0 &&
 
-		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
-
-		test_path_is_missing dirB &&
-		test_path_is_file dirA/bar &&
+		# NOTE: A potentially better resolution would be for
+		#     dirA/bar -> dirB/bar
+		# to use the directory rename (dirB/ -> dirA/) to become
+		#     dirA/bar -> dirA/bar
+		# (a rename to self), and thus we end up with bar with
+		# a path conflict (given merge.directoryRenames=conflict).
+		# However, since the relevant renames optimization
+		# prevents us from noticing
+		#     dirA/bar -> dirB/bar
+		# as a rename and looking at it just as
+		#     delete dirA/bar
+		#     add dirB/bar
+		# the directory rename of dirA/bar -> dirB/bar does
+		# not look like a rename-to-self situation but a
+		# rename-on-top-of-other-file situation.  We do not want
+		# stage 1 entries from an unrelated file, so we expect an
+		# error about there being a file in the way.
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
+		grep "CONFLICT (implicit dir rename).*dirA/bar in the way" out &&
+
+		test_path_is_missing dirA/bar &&
+		test_path_is_file dirB/bar &&
 		test_path_is_file dirA/baz &&
 
 		git ls-files >actual &&
@@ -4954,8 +5011,8 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
-		UU dirA/bar
 		M  dirA/baz
+		R  dirA/bar -> dirB/bar
 		EOF
 		test_cmp expect actual
 	)
@@ -5258,6 +5315,276 @@ test_expect_success '12n2: Directory rename transitively makes rename back to se
 	)
 '
 
+# Testcase 12o, Directory rename hits other rename source; file still in way on same side
+#   Commit O:  A/file1_1
+#              A/stuff
+#              B/file1_2
+#              B/stuff
+#              C/other
+#   Commit A:  A/file1_1
+#              A/stuff
+#              B/stuff
+#              C/file1_2
+#              C/other
+#   Commit B:  D/file2_1
+#              A/stuff
+#              B/file1_2
+#              B/stuff
+#              A/other
+#   In words:
+#     A: rename B/file1_2 -> C/file1_2
+#     B: rename C/ -> A/
+#        rename A/file1_1 -> D/file2_1
+#   Rationale:
+#       A/stuff is unmodified, it shows up in final output
+#       B/stuff is unmodified, it shows up in final output
+#       C/other touched on one side (rename to A), so A/other shows up in output
+#       A/file1 is renamed to D/file2
+#       B/file1 -> C/file1 and even though C/ -> A/, A/file1 is
+#               "in the way" so we don't do the directory rename
+#   Expected:  A/stuff
+#              B/stuff
+#              A/other
+#              D/file2
+#              C/file1
+#              + CONFLICT (implicit dir rename): A/file1 in way of C/file1
+#
+
+test_setup_12o () {
+	git init 12o &&
+	(
+		cd 12o &&
+
+		mkdir -p A B C &&
+		echo 1 >A/file1 &&
+		echo 2 >B/file1 &&
+		echo other >C/other &&
+		echo Astuff >A/stuff &&
+		echo Bstuff >B/stuff &&
+		git add . &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv B/file1 C/ &&
+		git add . &&
+		git commit -m "A" &&
+
+		git switch B &&
+		mkdir -p D &&
+		git mv A/file1 D/file2 &&
+		git mv C/other A/other &&
+		git add . &&
+		git commit -m "B"
+	)
+}
+
+test_expect_success '12o: Directory rename hits other rename source; file still in way on same side' '
+	test_setup_12o &&
+	(
+		cd 12o &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
+
+		test_stdout_line_count = 5 git ls-files -s &&
+		test_stdout_line_count = 1 git ls-files -s A/other &&
+		test_stdout_line_count = 1 git ls-files -s A/stuff &&
+		test_stdout_line_count = 1 git ls-files -s B/stuff &&
+		test_stdout_line_count = 1 git ls-files -s D/file2 &&
+
+		grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
+		test_stdout_line_count = 1 git ls-files -s C/file1
+	)
+'
+
+# Testcase 12p, Directory rename hits other rename source; file still in way on other side
+#   Commit O:  A/file1_1
+#              A/stuff
+#              B/file1_2
+#              B/stuff
+#              C/other
+#   Commit A:  D/file2_1
+#              A/stuff
+#              B/stuff
+#              C/file1_2
+#              C/other
+#   Commit B:  A/file1_1
+#              A/stuff
+#              B/file1_2
+#              B/stuff
+#              A/other
+#   Short version:
+#     A: rename A/file1_1 -> D/file2_1
+#        rename B/file1_2 -> C/file1_2
+#     B: Rename C/ -> A/
+#   Rationale:
+#       A/stuff is unmodified, it shows up in final output
+#       B/stuff is unmodified, it shows up in final output
+#       C/other touched on one side (rename to A), so A/other shows up in output
+#       A/file1 is renamed to D/file2
+#       B/file1 -> C/file1 and even though C/ -> A/, A/file1 is
+#               "in the way" so we don't do the directory rename
+#   Expected:  A/stuff
+#              B/stuff
+#              A/other
+#              D/file2
+#              C/file1
+#              + CONFLICT (implicit dir rename): A/file1 in way of C/file1
+#
+
+test_setup_12p () {
+	git init 12p &&
+	(
+		cd 12p &&
+
+		mkdir -p A B C &&
+		echo 1 >A/file1 &&
+		echo 2 >B/file1 &&
+		echo other >C/other &&
+		echo Astuff >A/stuff &&
+		echo Bstuff >B/stuff &&
+		git add . &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		mkdir -p D &&
+		git mv A/file1 D/file2 &&
+		git mv B/file1 C/ &&
+		git add . &&
+		git commit -m "A" &&
+
+		git switch B &&
+		git mv C/other A/other &&
+		git add . &&
+		git commit -m "B"
+	)
+}
+
+test_expect_success '12p: Directory rename hits other rename source; file still in way on other side' '
+	test_setup_12p &&
+	(
+		cd 12p &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
+
+		test_stdout_line_count = 5 git ls-files -s &&
+		test_stdout_line_count = 1 git ls-files -s A/other &&
+		test_stdout_line_count = 1 git ls-files -s A/stuff &&
+		test_stdout_line_count = 1 git ls-files -s B/stuff &&
+		test_stdout_line_count = 1 git ls-files -s D/file2 &&
+
+		grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
+		test_stdout_line_count = 1 git ls-files -s C/file1
+	)
+'
+
+# Testcase 12q, Directory rename hits other rename source; file removed though
+#   Commit O:  A/file1_1
+#              A/stuff
+#              B/file1_2
+#              B/stuff
+#              C/other
+#   Commit A:  A/stuff
+#              B/stuff
+#              C/file1_2
+#              C/other
+#   Commit B:  D/file2_1
+#              A/stuff
+#              B/file1_2
+#              B/stuff
+#              A/other
+#   In words:
+#     A: delete A/file1_1, rename B/file1_2 -> C/file1_2
+#     B: Rename C/ -> A/, rename A/file1_1 -> D/file2_1
+#   Rationale:
+#       A/stuff is unmodified, it shows up in final output
+#       B/stuff is unmodified, it shows up in final output
+#       C/other touched on one side (rename to A), so A/other shows up in output
+#       A/file1 is rename/delete to D/file2, so two stages for D/file2
+#       B/file1 -> C/file1 and even though C/ -> A/, A/file1 as a source was
+#               "in the way" (ish) so we don't do the directory rename
+#   Expected:  A/stuff
+#              B/stuff
+#              A/other
+#              D/file2 (two stages)
+#              C/file1
+#              + CONFLICT (implicit dir rename): A/file1 in way of C/file1
+#              + CONFLICT (rename/delete): D/file2
+#
+
+test_setup_12q () {
+	git init 12q &&
+	(
+		cd 12q &&
+
+		mkdir -p A B C &&
+		echo 1 >A/file1 &&
+		echo 2 >B/file1 &&
+		echo other >C/other &&
+		echo Astuff >A/stuff &&
+		echo Bstuff >B/stuff &&
+		git add . &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git rm A/file1 &&
+		git mv B/file1 C/ &&
+		git add . &&
+		git commit -m "A" &&
+
+		git switch B &&
+		mkdir -p D &&
+		git mv A/file1 D/file2 &&
+		git mv C/other A/other &&
+		git add . &&
+		git commit -m "B"
+	)
+}
+
+test_expect_success '12q: Directory rename hits other rename source; file removed though' '
+	test_setup_12q &&
+	(
+		cd 12q &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
+
+		grep "CONFLICT (rename/delete).*A/file1.*D/file2" out &&
+		grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
+
+		test_stdout_line_count = 6 git ls-files -s &&
+		test_stdout_line_count = 1 git ls-files -s A/other &&
+		test_stdout_line_count = 1 git ls-files -s A/stuff &&
+		test_stdout_line_count = 1 git ls-files -s B/stuff &&
+		test_stdout_line_count = 2 git ls-files -s D/file2 &&
+
+		# This is a slightly suboptimal resolution; allowing the
+		# rename of C/ -> A/ to affect C/file1 and further rename
+		# it to A/file1 would probably be preferable, but since
+		# A/file1 existed as the source of another rename, allowing
+		# the dir rename of C/file1 -> A/file1 would mean modifying
+		# the code so that renames do not adjust both their source
+		# and target paths in all cases.
+		! grep "CONFLICT (file location)" out &&
+		test_stdout_line_count = 1 git ls-files -s C/file1
+	)
+'
 
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
-- 
gitgitgadget
