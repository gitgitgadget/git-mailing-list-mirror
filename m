Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243491F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeDYJyN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:36065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeDYJyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:06 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MZlEg-1exTMh1HKw-00LT78; Wed, 25 Apr 2018 11:53:57 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 00/11] Deprecate .git/info/grafts
Date:   Wed, 25 Apr 2018 11:53:49 +0200
Message-Id: <cover.1524650028.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:8TH1M+DBGv/OJ1hnlTlbtPdG7GSeFo/fMiEzIRfiDPR0z3eIcPt
 ghFAsWqn+05hdJyu/5FSNCoM3DlUDo8EHJmEvD2KbSvqFgD9jko+gR95toUxFS0dUQGKbR3
 Uz1OxFvKsn+2LNVQxWVzPTXW6h9HtdYUM7PSKKfBaAOYvL7R9R1P9y3XVDmxztKHbkduuxA
 I41Dl5E+0GGvqa2Z9lsMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YZmnWWypwk0=:dyePo7rSrQe2YOS46jaLCY
 YNXah9Y77iyO5nDqBnkjFVMDtSetpawBuixumQqfBaDf24Qx/wQyMkXroWutzJ16+3N+e0nx9
 K3urLf5lIFOX7dqkugTFxWqR+pbdOihuaXZ66+HIgZ+Hzaw8QBNlJ0/XL0797FP1GLC6kXFWB
 4YXnTMWfLJnnn5ssBb6MxrHjaXdxPjIiWsMwGr38YhB+I33BSTOtnLQfLp576lVFfunkR30zm
 QEIpKe7nrK0280SyV1oNaXTWR8/5Pdlc0L0Kw/pnku1f9G3Fktt6bpeRoKT3SfR3U4JAwqeDm
 jgzuMDjWx9DJZH4AcGmx7BNsp04EBw2XnDAB1ZiiqFoFXMI7RHiMYpAbha26TLvXoNyui1D4w
 7ZieJ197sG3FFjfY6G1XyRQHSxRyDIRPg4npWgVoD6J92rx9PW9nhG0HXeV4xEg7WbOt052YO
 s3784q14mxczCP/xvluIovH3ak32LhRX1tZi+0oszYBJJt/Ly+pM33zawXIZZVLR6mgi/D0s7
 LuIYYn04a07NjmQuFNDplXSCxwgLS/x/SJMLbta7oxWip8iyHpULFLZSFiAnAF7z2Px81erOP
 Vf4m2JVuG9A6Y/CaotcNp03upET1ujlK85k+lZlzVYyVqtE9Fv/th+Bxx3idYZfLnS5tHyjwY
 8iHsQbZum1VaxKffzG88jZtDfPAWLR2D9MyZmy0CTtfsjiZa5/eTJljHhSyAmtYHJ/dqAa4oE
 kUkwQ20qjRH4vtuRU82wJsKoZsfNVZQnS7t5dz+WClhALsj9rHaeKpiFHhixQU9OD5CPgzy7I
 GnC1wrcFg0hlP4aOV6DU/unFqNkYWGWSCis1C2zam5MCzj5G1OoQdaUSjWoZrBLefZXsU6P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is fragile, as there is no way for the revision machinery to say "but
now I want to traverse the graph ignoring the graft file" e.g. when
pushing commits to a remote repository (which, as a consequence, can
miss commits).

And we already have a better solution with `git replace --graft <comit>
[<parent>...]`.

Changes since v4:

- Fixed resource leaks (missing free() and strbuf_release() calls when
  returning an error).

- Avoided error_errno() mistakenly using close()'s errno.

- Actually close the handle to the graft file after converting it.

- Changed the description of Documentation/technical/shallow to not even
  bother to describe how it might be construed to be similar to replace
  refs.


Johannes Schindelin (11):
  argv_array: offer to split a string by whitespace
  commit: Let the callback of for_each_mergetag return on error
  replace: avoid using die() to indicate a bug
  replace: "libify" create_graft() and callees
  replace: introduce --convert-graft-file
  Add a test for `git replace --convert-graft-file`
  Deprecate support for .git/info/grafts
  filter-branch: stop suggesting to use grafts
  technical/shallow: stop referring to grafts
  technical/shallow: describe why shallow cannot use replace refs
  Remove obsolete script to convert grafts to replace refs

 Documentation/git-filter-branch.txt       |   2 +-
 Documentation/git-replace.txt             |  11 +-
 Documentation/technical/shallow.txt       |  20 +-
 advice.c                                  |   2 +
 advice.h                                  |   1 +
 argv-array.c                              |  20 ++
 argv-array.h                              |   2 +
 builtin/replace.c                         | 218 +++++++++++++++-------
 commit.c                                  |  18 +-
 commit.h                                  |   4 +-
 contrib/convert-grafts-to-replace-refs.sh |  28 ---
 log-tree.c                                |  13 +-
 t/t6001-rev-list-graft.sh                 |   9 +
 t/t6050-replace.sh                        |  20 ++
 14 files changed, 253 insertions(+), 115 deletions(-)
 delete mode 100755 contrib/convert-grafts-to-replace-refs.sh


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v5
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v5

Interdiff vs v4:
 diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
 index cb79181c2bb..01dedfe9ffe 100644
 --- a/Documentation/technical/shallow.txt
 +++ b/Documentation/technical/shallow.txt
 @@ -8,18 +8,10 @@ repo, and therefore grafts are introduced pretending that
  these commits have no parents.
  *********************************************************
  
 -The basic idea is to write the SHA-1s of shallow commits into
 -$GIT_DIR/shallow, and handle its contents similar to replace
 -refs (with the difference that shallow does not actually
 -create those replace refs) and very much like the deprecated
 -graft file (with the difference that shallow commits will
 -always have their parents grafted away, not replaced by
 -different parents).
 -
 -This information is stored in a special-purpose file because the
 -user should not touch that file at all (even throughout
 -development of the shallow clone, it was never manually
 -edited!).
 +$GIT_DIR/shallow lists commit object names and tells Git to
 +pretend as if they are root commits (e.g. "git log" traversal
 +stops after showing them; "git fsck" does not complain saying
 +the commits listed on their "parent" lines do not exist).
  
  Each line contains exactly one SHA-1. When read, a commit_graft
  will be constructed, which has nr_parent < 0 to make it easier
 diff --git a/builtin/replace.c b/builtin/replace.c
 index 6b3e0301e90..acd30e3d824 100644
 --- a/builtin/replace.c
 +++ b/builtin/replace.c
 @@ -175,8 +175,10 @@ static int replace_object_oid(const char *object_ref,
  			     object_ref, type_name(obj_type),
  			     replace_ref, type_name(repl_type));
  
 -	if (check_ref_valid(object, &prev, &ref, force))
 +	if (check_ref_valid(object, &prev, &ref, force)) {
 +		strbuf_release(&ref);
  		return -1;
 +	}
  
  	transaction = ref_transaction_begin(&err);
  	if (!transaction ||
 @@ -264,9 +266,10 @@ static int import_object(struct object_id *oid, enum object_type type,
  		}
  
  		if (strbuf_read(&result, cmd.out, 41) < 0) {
 +			error_errno("unable to read from mktree");
  			close(fd);
  			close(cmd.out);
 -			return error_errno("unable to read from mktree");
 +			return -1;
  		}
  		close(cmd.out);
  
 @@ -285,8 +288,9 @@ static int import_object(struct object_id *oid, enum object_type type,
  		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
  
  		if (fstat(fd, &st) < 0) {
 +			error_errno("unable to fstat %s", filename);
  			close(fd);
 -			return error_errno("unable to fstat %s", filename);
 +			return -1;
  		}
  		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
  			return error("unable to write object to database");
 @@ -302,7 +306,7 @@ static int import_object(struct object_id *oid, enum object_type type,
  
  static int edit_and_replace(const char *object_ref, int force, int raw)
  {
 -	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 +	char *tmpfile;
  	enum object_type type;
  	struct object_id old_oid, new_oid, prev;
  	struct strbuf ref = STRBUF_INIT;
 @@ -315,17 +319,20 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
  		return error("unable to get object type for %s",
  			     oid_to_hex(&old_oid));
  
 -	if (check_ref_valid(&old_oid, &prev, &ref, force))
 +	if (check_ref_valid(&old_oid, &prev, &ref, force)) {
 +		strbuf_release(&ref);
  		return -1;
 +	}
  	strbuf_release(&ref);
  
 -	if (export_object(&old_oid, type, raw, tmpfile))
 -		return -1;
 -	if (launch_editor(tmpfile, NULL, NULL) < 0)
 -		return error("editing object file failed");
 -	if (import_object(&new_oid, type, raw, tmpfile))
 +	tmpfile = git_pathdup("REPLACE_EDITOBJ");
 +	if (export_object(&old_oid, type, raw, tmpfile) ||
 +	    (launch_editor(tmpfile, NULL, NULL) < 0 &&
 +	     error("editing object file failed")) ||
 +	    import_object(&new_oid, type, raw, tmpfile)) {
 +		free(tmpfile);
  		return -1;
 -
 +	}
  	free(tmpfile);
  
  	if (!oidcmp(&old_oid, &new_oid))
 @@ -351,11 +358,15 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
  	/* prepare new parents */
  	for (i = 0; i < argc; i++) {
  		struct object_id oid;
 -		if (get_oid(argv[i], &oid) < 0)
 +		if (get_oid(argv[i], &oid) < 0) {
 +			strbuf_release(&new_parents);
  			return error(_("Not a valid object name: '%s'"),
  				     argv[i]);
 -		if (!lookup_commit_reference(&oid))
 +		}
 +		if (!lookup_commit_reference(&oid)) {
 +			strbuf_release(&new_parents);
  			return error(_("could not parse %s"), argv[i]);
 +		}
  		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
  	}
  
 @@ -432,20 +443,26 @@ static int create_graft(int argc, const char **argv, int force)
  	strbuf_add(&buf, buffer, size);
  	unuse_commit_buffer(commit, buffer);
  
 -	if (replace_parents(&buf, argc - 1, &argv[1]) < 0)
 +	if (replace_parents(&buf, argc - 1, &argv[1]) < 0) {
 +		strbuf_release(&buf);
  		return -1;
 +	}
  
  	if (remove_signature(&buf)) {
  		warning(_("the original commit '%s' has a gpg signature."), old_ref);
  		warning(_("the signature will be removed in the replacement commit!"));
  	}
  
 -	if (check_mergetags(commit, argc, argv))
 +	if (check_mergetags(commit, argc, argv)) {
 +		strbuf_release(&buf);
  		return -1;
 +	}
  
 -	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
 +	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid)) {
 +		strbuf_release(&buf);
  		return error(_("could not write replacement commit for: '%s'"),
  			     old_ref);
 +	}
  
  	strbuf_release(&buf);
  
 @@ -474,9 +491,9 @@ static int convert_graft_file(int force)
  			strbuf_addf(&err, "\n\t%s", buf.buf);
  		argv_array_clear(&args);
  	}
 +	fclose(fp);
  
  	strbuf_release(&buf);
 -	argv_array_clear(&args);
  
  	if (!err.len)
  		return unlink_or_warn(graft_file);
-- 
2.17.0.windows.1.33.gfcbb1fa0445

