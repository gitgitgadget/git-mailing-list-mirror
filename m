Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8F61FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431330AbdDYNv5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:51:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:59075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1431325AbdDYNvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:51:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSx9-1d004m014F-0036Y2; Tue, 25
 Apr 2017 15:51:47 +0200
Date:   Tue, 25 Apr 2017 15:51:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 0/9] The final building block for a faster rebase -i
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XjNvQK1z/vtdeJ/oRXX6b/DmS4OIAgMCRVVsT/4PuRms05HmKSw
 fVkv3WurSaH28cDdFUyXVCwMigR5JozpzGEO3kQb4zffY4jj36gNmihp9HmTnVgArVqIOso
 eCtF7KAplv//UNJUo8K+amxOldsdTH/aHlKDa3jLlTsKBt40nxQl8Gqb3QLw4zmVcj9v1JJ
 mH2FcLLC9O8FnhTrsPstA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FnZY8/9Gr/g=:SC2EjHsylo7nDJfB0v+Grg
 +cwfyOymIfFB2YmzEKHA/0qoTbwkg6P+43Bs9ny5qlSqgtFGMMDQCtFQ+n2HozJpaIEJxnIxq
 FRZJOUhlCf9ShxVMO/uvPABcvrWVRyb2cVURxt7ALdFaj3C8DeppdrrzBllZKtFhfscO0Jmvz
 Ha5ty+AGBM3h2NELA1UupjHAM3helATrsIrUma3AcyjgDnwPgbCnI9JyoHYzx6lKeEqLIMcT1
 lo4aYENuRa5kAHDerGvYnwqvCLuI65jg/O/iiUIyuI1BVQeIjkDv8Vtr6X5uizJ6Br+eQb3E3
 t1uJ1HUxUeJD+3sql/7ueQo/XyHWvCcpH5KSP6yuoOsBGwem6XZUZQDSeX7QbcbpiDC4vyYKI
 9/gm8RolUPjRHnbU+aUZdoebVieLlFnj4OgNQSfQF1onJJiSG27wENYZ3Xs+PxTWrsTOx+FT9
 Z+YO++zvWhDwEbVe0i5Ee6wGGWLSpljR1ql1RX7or3Kd2aWN8JY17O76/qURdX2yJQOaFMc3u
 kpqXxinWqseEfESJtAHKgmb05nMNmhLyXjTUymOkARaeYK51ChtltkG5A6asQf+A+UJR+1D9T
 NMfBug62XH4h/f62RMEijhaoHQsSBCP3Zi+jfw/xQiPt1tk6EzqIfGeOWmE3DBbzwDl7wFkig
 WKcVDTo+rdwFiW+5mZckUs8PuhcSrELIzEm4pxquyFofVMlSnzeEh3XdpC/Z7V7z46n0d67LS
 h7J1h0UOqTQByXB6MnPVrc3Hp9S8wzoN9lcwqgPKauuRXT3bNOF1lUAeUbv9MH5ITLb3jXzCc
 COQeXhi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series reimplements the expensive pre- and post-processing of
the todo script in C.

And it concludes the work I did to accelerate rebase -i.

Changes since v1:

- rebased to the current `master` (which advanced quite a bit since v1
  was sent to the list on September 2nd, 2016)

- downcased error messages

- marked error messages for translation

- moved an "else" onto the same line as the preceding closing brace

- described the priorities of `fixup! <something>` in the man page, as
  suggested by Philip Oakley


Johannes Schindelin (9):
  rebase -i: generate the script via rebase--helper
  rebase -i: remove useless indentation
  rebase -i: do not invent onelines when expanding/collapsing SHA-1s
  rebase -i: also expand/collapse the SHA-1s via the rebase--helper
  t3404: relax rebase.missingCommitsCheck tests
  rebase -i: check for missing commits in the rebase--helper
  rebase -i: skip unnecessary picks using the rebase--helper
  t3415: test fixup with wrapped oneline
  rebase -i: rearrange fixup/squash lines using the rebase--helper

 Documentation/git-rebase.txt  |  16 +-
 builtin/rebase--helper.c      |  29 ++-
 git-rebase--interactive.sh    | 362 ++++-------------------------
 sequencer.c                   | 515 ++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                   |   8 +
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3415-rebase-autosquash.sh  |  16 +-
 7 files changed, 625 insertions(+), 343 deletions(-)


base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
Based-On: rebase--helper at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v2
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v2

Interdiff vs v1:

 diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
 index 67d48e68831..da79fbda5b3 100644
 --- a/Documentation/git-rebase.txt
 +++ b/Documentation/git-rebase.txt
 @@ -425,13 +425,15 @@ without an explicit `--interactive`.
  --autosquash::
  --no-autosquash::
  	When the commit log message begins with "squash! ..." (or
 -	"fixup! ..."), and there is a commit whose title begins with
 -	the same ..., automatically modify the todo list of rebase -i
 -	so that the commit marked for squashing comes right after the
 -	commit to be modified, and change the action of the moved
 -	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
 -	"fixup! " or "squash! " after the first, in case you referred to an
 -	earlier fixup/squash with `git commit --fixup/--squash`.
 +	"fixup! ..."), and there is already a commit in the todo list that
 +	matches the same `...`, automatically modify the todo list of rebase
 +	-i so that the commit marked for squashing comes right after the
 +	commit to be modified, and change the action of the moved commit
 +	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
 +	the commit subject matches, or if the `...` refers to the commit's
 +	hash. As a fall-back, partial matches of the commit subject work,
 +	too.  The recommended way to create fixup/squash commits is by using
 +	the `--fixup`/`--squash` options of linkgit:git-commit[1].
  +
  This option is only valid when the `--interactive` option is used.
  +
 diff --git a/sequencer.c b/sequencer.c
 index 5502b9006ed..2b07fb9e0ce 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2416,10 +2416,10 @@ int sequencer_make_script(int keep_empty, FILE *out,
  	pp.output_encoding = get_log_output_encoding();
  
  	if (setup_revisions(argc, argv, &revs, NULL) > 1)
 -		return error("make_script: unhandled options");
 +		return error(_("make_script: unhandled options"));
  
  	if (prepare_revision_walk(&revs) < 0)
 -		return error("make_script: error preparing revisions");
 +		return error(_("make_script: error preparing revisions"));
  
  	while ((commit = get_revision(&revs))) {
  		strbuf_reset(&buf);
 @@ -2445,23 +2445,23 @@ int transform_todo_ids(int shorten_sha1s)
  	strbuf_reset(&todo_list.buf);
  	fd = open(todo_file, O_RDONLY);
  	if (fd < 0)
 -		return error_errno(_("Could not open '%s'"), todo_file);
 +		return error_errno(_("could not open '%s'"), todo_file);
  	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
  		close(fd);
 -		return error(_("Could not read %s."), todo_file);
 +		return error(_("could not read '%s'."), todo_file);
  	}
  	close(fd);
  
  	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
  	if (res) {
  		todo_list_release(&todo_list);
 -		return error(_("Unusable instruction sheet: %s"), todo_file);
 +		return error(_("unusable instruction sheet: '%s'"), todo_file);
  	}
  
  	out = fopen(todo_file, "w");
  	if (!out) {
  		todo_list_release(&todo_list);
 -		return error(_("Unable to open '%s' for writing"), todo_file);
 +		return error(_("unable to open '%s' for writing"), todo_file);
  	}
  	for (i = 0; i < todo_list.nr; i++) {
  		struct todo_item *item = todo_list.items + i;
 @@ -2508,8 +2508,8 @@ static enum check_level get_missing_commit_check_level(void)
  		return CHECK_WARN;
  	if (!strcasecmp("error", value))
  		return CHECK_ERROR;
 -	warning(_("Unrecognized setting $check_level for option"
 -			"rebase.missingCommitsCheck. Ignoring."));
 +	warning(_("unrecognized setting %s for option"
 +		  "rebase.missingCommitsCheck. Ignoring."), value);
  	return CHECK_IGNORE;
  }
  
 @@ -2530,12 +2530,12 @@ int check_todo_list(void)
  	strbuf_addstr(&todo_file, rebase_path_todo());
  	fd = open(todo_file.buf, O_RDONLY);
  	if (fd < 0) {
 -		res = error_errno(_("Could not open %s"), todo_file.buf);
 +		res = error_errno(_("could not open '%s'"), todo_file.buf);
  		goto leave_check;
  	}
  	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
  		close(fd);
 -		res = error(_("Could not read %s."), todo_file.buf);
 +		res = error(_("could not read '%s'."), todo_file.buf);
  		goto leave_check;
  	}
  	close(fd);
 @@ -2556,12 +2556,12 @@ int check_todo_list(void)
  	strbuf_addstr(&todo_file, ".backup");
  	fd = open(todo_file.buf, O_RDONLY);
  	if (fd < 0) {
 -		res = error_errno(_("Could not open %s"), todo_file.buf);
 +		res = error_errno(_("could not open '%s'"), todo_file.buf);
  		goto leave_check;
  	}
  	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
  		close(fd);
 -		res = error(_("Could not read %s."), todo_file.buf);
 +		res = error(_("could not read '%s'."), todo_file.buf);
  		goto leave_check;
  	}
  	close(fd);
 @@ -2610,9 +2610,10 @@ int check_todo_list(void)
  
  	if (raise_error)
  		fprintf(stderr,
 -			_("You can fix this with 'git rebase --edit-todo'.\n"
 -			"Or you can abort the rebase with 'git rebase"
 -			" --abort'.\n"));
 +			_("You can fix this with 'git rebase --edit-todo' "
 +			  "and then run 'git rebase --continue'.\n"
 +			  "Or you can abort the rebase with 'git rebase"
 +			  " --abort'.\n"));
  
  	return res;
  }
 @@ -2627,20 +2628,20 @@ int skip_unnecessary_picks(void)
  	int fd, i;
  
  	if (!read_oneliner(&buf, rebase_path_onto(), 0))
 -		return error("Could not read 'onto'");
 +		return error(_("could not read 'onto'"));
  	if (get_sha1(buf.buf, onto_oid.hash)) {
  		strbuf_release(&buf);
 -		return error("Need a HEAD to fixup");
 +		return error(_("need a HEAD to fixup"));
  	}
  	strbuf_release(&buf);
  
  	fd = open(todo_file, O_RDONLY);
  	if (fd < 0) {
 -		return error_errno(_("Could not open '%s'"), todo_file);
 +		return error_errno(_("could not open '%s'"), todo_file);
  	}
  	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
  		close(fd);
 -		return error(_("Could not read '%s'."), todo_file);
 +		return error(_("could not read '%s'."), todo_file);
  	}
  	close(fd);
  	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 @@ -2657,7 +2658,7 @@ int skip_unnecessary_picks(void)
  			break;
  		if (parse_commit(item->commit)) {
  			todo_list_release(&todo_list);
 -			return error(_("Could not parse commit '%s'"),
 +			return error(_("could not parse commit '%s'"),
  				oid_to_hex(&item->commit->object.oid));
  		}
  		if (!item->commit->parents)
 @@ -2677,7 +2678,7 @@ int skip_unnecessary_picks(void)
  		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
  		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
  			todo_list_release(&todo_list);
 -			return error_errno(_("Could not write to '%s'"),
 +			return error_errno(_("could not write to '%s'"),
  				done_path);
  		}
  		close(fd);
 @@ -2686,12 +2687,12 @@ int skip_unnecessary_picks(void)
  		if (write_in_full(fd, todo_list.buf.buf + offset,
  				todo_list.buf.len - offset) < 0) {
  			todo_list_release(&todo_list);
 -			return error_errno(_("Could not write to '%s'"),
 +			return error_errno(_("could not write to '%s'"),
  				rebase_path_todo());
  		}
  		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
  			todo_list_release(&todo_list);
 -			return error_errno(_("Could not truncate '%s'"),
 +			return error_errno(_("could not truncate '%s'"),
  				rebase_path_todo());
  		}
  		close(fd);
 @@ -2738,10 +2739,10 @@ int rearrange_squash(void)
  
  	fd = open(todo_file, O_RDONLY);
  	if (fd < 0)
 -		return error_errno(_("Could not open %s"), todo_file);
 +		return error_errno(_("could not open '%s'"), todo_file);
  	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
  		close(fd);
 -		return error(_("Could not read %s."), todo_file);
 +		return error(_("could not read '%s'."), todo_file);
  	}
  	close(fd);
  	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
 @@ -2778,7 +2779,7 @@ int rearrange_squash(void)
  
  		if (is_fixup(item->command)) {
  			todo_list_release(&todo_list);
 -			return error(_("The script was already rearranged."));
 +			return error(_("the script was already rearranged."));
  		}
  
  		item->commit->util = item;
 @@ -2832,8 +2833,7 @@ int rearrange_squash(void)
  			else
  				next[tail[i2]] = i;
  			tail[i2] = i;
 -		}
 -		else if (!hashmap_get_from_hash(&subject2item,
 +		} else if (!hashmap_get_from_hash(&subject2item,
  						strhash(subject), subject)) {
  			FLEX_ALLOC_MEM(entry, subject, buf.buf, buf.len);
  			entry->i = i;
 @@ -2883,11 +2883,12 @@ int rearrange_squash(void)
  
  		fd = open(todo_file, O_WRONLY);
  		if (fd < 0)
 -			res |= error_errno(_("Could not open %s"), todo_file);
 +			res = error_errno(_("could not open '%s'"), todo_file);
  		else if (write(fd, buf.buf, buf.len) < 0)
 -			res |= error_errno(_("Could not read %s."), todo_file);
 +			res = error_errno(_("could not read '%s'."), todo_file);
  		else if (ftruncate(fd, buf.len) < 0)
 -			res |= error_errno(_("Could not finish %s"), todo_file);
 +			res = error_errno(_("could not finish '%s'"),
 +					   todo_file);
  		close(fd);
  		strbuf_release(&buf);
  	}

-- 
2.12.2.windows.2.406.gd14a8f8640f

