Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF33BBD6
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710023254; cv=none; b=bGzrsjIWwLciU+76sCs1M89PDHVXisIEMWXzzdasLCgeMIFNVV0p/UzuRlwlkV7RRjoQXze+ytA78kC748aRbkpUa20dSlSF1oqDC+/nXfWrUlPxMqfvW/jJzUInMPp0EsDYEpEp/Eue6oHbNAYq6h1MkD/oWCntOE24Xtxo+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710023254; c=relaxed/simple;
	bh=Qf6r/ivTvUJQsyNsEXNG9HfA3AscDyCYIWheGgUCp6I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z/wkialZFxkiayGJJGrO54agKv1gccR9luqIimLs0JoU4ceZfjpHv3wwdk99bRzaAYGSxAuEtDyYaDJa6WEWK+C1f2dZw4QVBhMGoozaZNkjZ+JZu5qGDySpvorgj/OZW6TJY6By/QHs1isAUSX4y1qEqbCLAP/RgNQa0aOt8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=AT61j30W; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="AT61j30W"
Received: from localhost (ip-109-42-178-223.web.vodafone.de [109.42.178.223])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 429MRJGH030659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 9 Mar 2024 23:27:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710023239; bh=Qf6r/ivTvUJQsyNsEXNG9HfA3AscDyCYIWheGgUCp6I=;
	h=From:To:Subject:Date;
	b=AT61j30W9WO/srkztMinJAHWO+atA1vS9G+Af/imJAYTPUG+DIEkPUeEF+AuLJCD2
	 6tIKQBd+2Q84nwfTgKudbEL7pt0bPpmA1/6qWdH0mlG49Fhn6fd4usc5iM73RalUHm
	 9TDDDIK4uZ5QfQGjpgqSSyks0g2ktdxAc9kJVXHY=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Subject: Informative: git-options.txt
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 09 Mar 2024 23:27:13 +0100
Message-ID: <ghedcj11oe.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Recently, I followed the discussion [1] and I thought: let's look at the
manual pages to see what options Git currently uses -- just out of
curiosity and for learning about Git.

That were 160 manual pages to visit and if I counted correctly, there
are 1160 different option strings -- some of them related and only
differing in details.

The attached file doesn't always say anything about semantics that
sometimes is totally different (for -h, for example).

I thought that could be interesting to some of you, as well, so I send
it to the list.

Some points I noticed:

- SYNOPSIS not always matches OPTIONS (e.g. git(1)) and in those cases
  [<options>] would probably a better solution.

- Options that require arguments are often listed without those
  arguments in OPTIONS but those arguments are talked about and one has
  to go to SYNOPSIS to come to know the order of those arguments
  (e.g. git branch -m)

Should you wonder about the sorting, I tried to stick to the following
rules:

- Take the strings as they appear in the OPTIONS sections -- no splitting.
- Primarily sort by letters and numbers.
- Sort by the first option, then by the second.
  Arguments are only used within those groups.
- I changed the rules on the way, so there may be errors.

Disclaimer: because manually created this file isn't 100% correct but I
            gave my best.  On the way I noticed that sometimes options
            appear at unexpected places, so I for sure missed some.



At least this perhaps serves amusing purposes ;-)

Who knows, perhaps you think git-options(7) would be a valuable
addition.  I think it can be automatically generated with a moderate
amount of work.

Or the attached file could be used for some SoC micro-procect or the
like...

Dirk

[1] https://lore.kernel.org/git/ef5958e1-af3f-4869-b0e3-ff1448c0d73c@gmail.com/T/#t


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=git-options.txt
Content-Description: git-options.txt

<args>...
        git-rev-parse(1)

<archive>/<branch>
        git-archimport(1)

base-name
        git-pack-objects(1)

<base> <rev1> <rev2>
        git-range-diff(1)

<branch>
        git-checkout(1)
        git-rebase(1)

<branchname>
        git-branch(1)

<command> [<args>]
        git(1)

<commit>...
        git-cherry-pick(1)
        git-merge(1)
        git-revert(1)

commit-id
        git-http-fetch(1)

<commit-ish>...
        git-describe(1)

<CVS-module>
        git-cvsimport(1)

<directory>
        git-clone(1)
        git-cvsserver(1)
        git-daemon(1)

<end>
        git-request-pull(1)

<file>
        git-ls-files(1)

<git-dir>
        git-receive-pack(1)

[<git-rev-list-args>...]
        git-fast-export(1)

<git-rev-list-args>
        git-bundle(1)

<group>
        git-fetch(1)

<head>
        git-cherry(1)

<head>...
        git-prune(1)

<limit>
        git-cherry(1)

<Maildir>
        git-mailsplit(1)

<mbox>
        git-mailsplit(1)

(<mbox>|<Maildir>)...
        git-am(1)

<msg>
        git-mailinfo(1)

<new-branch>
        git-checkout(1)

<newbranch>
        git-branch(1)

<object>
        git-cat-file(1)
        git-fsck(1)

<oldbranch>
        git-branch(1)

<patch>
        git-mailinfo(1)

<patch>...
        git-apply(1)

<pathspec>...
        git-add(1)
        git-checkout(1)
        git-commit(1)
        git-grep(1)
        git-reset(1)
        git-restore(1)
        git-rm(1)

<path>
        git-archive(1)

[<path>...]
        git-ls-tree(1)

<path>...
        git-diff(1)
        git-diff-tree(1)
        gitk(1)
        git-log(1)
        git-reflog(1)

<paths>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

<pattern>...
        git-for-each-ref(1)

<patterns>...
        git-ls-remote(1)

<range1> <range2>
        git-range-diff(1)

[<refname>...]
        git-bundle(1)

<ref>...
        git-http-push(1)

<refs>...
        git-fetch-pack(1)

<refspec>
        git-fetch(1)
        git-pull(1)

<refspec>...
        git-push(1)

<repository>
        git-clone(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-ls-remote(1)
        git-pull(1)
        git-push(1)

<rev1>...<rev2>
        git-range-diff(1)

<revision range>
        gitk(1)
        git-log(1)
        git-reflog(1)

<rev-list options>...
        git-filter-branch(1)

<socket-path>
        git-credential-cache--daemon(1)

<split options>
        git-commit-graph(1)

<start>
        git-request-pull(1)

<start-point>
        git-branch(1)
        git-checkout(1)

<tree>
        git-commit-tree(1)

<tree>...
        git-grep(1)

<tree-ish>
        git-archive(1)
        git-checkout(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-ls-tree(1)

<tree-ish#>
        git-read-tree(1)

<type>
        git-cat-file(1)

<URL>
        git-request-pull(1)

<upstream>
        git-cherry(1)
        git-rebase(1)

-<n>
        git-format-patch(1)

-/ <path>
        git-p4(1)

-<num>, -C <num>, --context <num>
        git-grep(1)

-<number>, -n <number>, --max-count=<number>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

-0
        git-diff(1)

-1 --base, -2 --ours, -3 --theirs
        git-diff(1)
        git-diff-files(1)

-3, --3way
        git-apply(1)

-3, --3way, --no-3way
        git-am(1)

-4, --ipv4
        git-fetch(1)
        git-pull(1)
        git-push(1)

-6, --ipv6
        git-fetch(1)
        git-pull(1)
        git-push(1)

--8bit-encoding=<encoding>
        git-send-email(1)

-A
        git-repack(1)

-A <author-conv-file>
        git-cvsimport(1)

-A <num>, --after-context <num>
        git-grep(1)

-A, --all, --no-ignore-removal
        git-add(1)

-a
        git-archimport(1)
        git-cvsexportcommit(1)
        git-cvsimport(1)
        git-merge-index(1)
        git-repack(1)

-a, -c, -t
        git-http-fetch(1)

-a, --all
        git-branch(1)
        git-check-attr(1)
        git-checkout-index(1)
        git-commit(1)
        git-help(1)
        git-merge-base(1)

-a, --append
        git-fetch(1)
        git-pull(1)

-a, --text
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-grep(1)
        git-log(1)
        git-reflog(1)

--abbrev[=<n>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-ls-files(1)
        git-ls-tree(1)

--abbrev=<n>
        git-blame(1)
        git-branch(1)
        git-describe(1)
        git-log(1)
        git-reflog(1)

--abbrev-commit
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--abbrev-ref[=(strict|loose)]
        git-rev-parse(1)

--abort
        git-am(1)
        git-cherry-pick(1)
        git-merge(1)
        git-notes(1)
        git-rebase(1)
        git-revert(1)

--absolute-git-dir
        git-rev-parse(1)

--access-hook=<path>
        git-daemon(1)

--active-branches=<n>
        git-fast-import(1)

--add
        git-config(1)

--add-file=<file>
        git-archive(1)

--add-header=<header>
        git-format-patch(1)

--add-virtual-file=<path>:<content>
        git-archive(1)

--aggressive
        git-gc(1)
        git-read-tree(1)

--all
        git-describe(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-http-push(1)
        gitk(1)
        git-log(1)
        git-reflog(1)
        git-name-rev(1)
        git-pack-objects(1)
        git-pack-redundant(1)
        git-pack-refs(1)
        git-pull(1)
        git-reflog(1)
        git-rev-list(1)
        git-rev-parse(1)

--all, --branches
        git-push(1)

--all-match
        git-grep(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--all-progress
        git-pack-objects(1)

--all-progress-implied
        git-pack-objects(1)

--allow-binary-replacement, --binary
        git-apply(1)

--allow-empty
        git-am(1)
        git-apply(1)
        git-cherry-pick(1)
        git-commit(1)
        git-notes(1)

--allow-empty-message
        git-cherry-pick(1)
        git-commit(1)
        git-rebase(1)

--[no-]allow-onelevel
        git-check-ref-format(1)

--allow-override=<service>, --forbid-override=<service>
        git-daemon(1)

--allow-unknown-type
        git-cat-file(1)

--allow-unrelated-histories
        git-merge(1)
        git-merge-tree(1)
        git-pull(1)

--allow-unsafe-features
        git-fast-import(1)

--also-filter-submodules
        git-clone(1)

--alternate-refs
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--alt-odb
        git-pack-redundant(1)

--always
        git-describe(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-name-rev(1)

--amend
        git-commit(1)

--ancestry-path
        gitk(1)

--ancestry-path[=<commit>]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--anchored=<text>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--and, --or, --not, ( ... )
        git-grep(1)

--annotate
        git-send-email(1)

--annotate-stdin
        git-name-rev(1)

--anonymize
        git-fast-export(1)

--anonymize-map=<from>[:<to>]

--append
        git-commit-graph(1)

--apply
        git-apply(1)
        git-rebase(1)

--argscmd=<command>
        gitk(1)

--atomic
        git-fetch(1)
        git-pull(1)

--[no-]atomic
        git-push(1)

--attach[=<boundary>]
        git-format-patch(1)

--attr-source=<tree-ish>
        git(1)

--auto
        git-gc(1)

--author Author Name <Author Email>
        git-quiltimport(1)

--author=<author>
        git-commit(1)

--author=<pattern>, --committer=<pattern>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--author-date-order
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--[no-]auto-maintenance, --[no-]auto-gc
        git-fetch(1)

--autosquash, --no-autosquash
        git-rebase(1)

--autostash, --no-autostash
        git-merge(1)
        git-pull(1)
        git-rebase(1)

-B <new-branch>
        git-checkout(1)

-B <num>, --before-context <num>
        git-grep(1)

-B[<n>][/<m>], --break-rewrites[=[<n>][/<m>]]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-b
        git-annotate(1)
        git-blame(1)
        git-mailinfo(1)
        git-mailsplit(1)

-b <branch-name>, --initial-branch=<branch-name>
        git-init(1)

-b <name>, --branch <name>
        git-clone(1)

-b <new-branch>
        git-checkout(1)

-b, --browser
        git-instaweb(1)

-b, --ignore-space-change
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-b, --write-bitmap-index
        git-repack(1)

--bare
        git(1)
        git-clone(1)
        git-init(1)
        git-p4(1)

--[no-]base[=<commit>]
        git-format-patch(1)

--base-path=<path>
        git-daemon(1)

--base-path <path>
        git-cvsserver(1)

--base-path-relaxed
        git-daemon(1)

--basic-regexp
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--bcc=<address>,...
        git-send-email(1)

--branch <branch>
        git-p4(1)

--branch <ref>
        git-p4(1)

--branches[=<pattern>]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--branches[=<pattern>], --tags[=<pattern>], --remotes[=<pattern>]
        gitk(1)
        git-rev-parse(1)
        
--break
        git-grep(1)

--batch
        git-mktree(1)

--batch, --batch=<format>
        git-cat-file(1)

--batch-all-objects
        git-cat-file(1)

--batch-check, --batch-check=<format>
        git-cat-file(1)

--batch-command, --batch-command=<format>
        git-cat-file(1)

--big-file-threshold=<n>
        git-fast-import(1)

--binary
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--bisect
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--bisect-all
        git-rev-list(1)

--bisect-vars
        git-rev-list(1)

--[no-]bitmap
        git-multi-pack-index(1)

--blob <blob>
        git-config(1)

--bool, --int, --bool-or-int, --path, --expiry-date
        git-config(1)

--boundary
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--branch
        git-commit(1)

--buffer
        git-cat-file(1)

--build-fake-ancestor=<file>
        git-apply(1)

--bundle-uri=<uri>
        git-clone(1)

-C
        git-branch(1)

-C[<n>], --find-copies[=<n>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-C<n>
        git-apply(1)
        git-rebase(1)

-C[<num>]
        git-annotate(1)
        git-blame(1)

-C <commit>, --reuse-message=<commit>
        git-commit(1)

-C <object>, --reuse-message=<object>
        git-notes(1)

-C <path>
        git(1)

-C <target-dir>
        git-cvsimport(1)

-c
        git-blame(1)
        git-cvsexportcommit(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-c <commit>, --reedit-message=<commit>
        git-commit(1)

-c <key>=<value>, --config <key>=<value>
        git-clone(1)

-c <object>, --reedit-message=<object>
        git-notes(1)

-c <name>=<value>
        git(1)

-c, --cached
        git-ls-files(1)

-c, --cc
        git-diff-files(1)

-c, --config
        git-help(1)

-c, --copy
        git-branch(1)

-c, --count
        git-grep(1)

-c, --scissors
        git-am(1)

--cache
        git-fsck(1)

--cached
        git-apply(1)
        git-check-attr(1)
        git-diff-index(1)
        git-grep(1)
        git-rm(1)

--candidates=<n>
        git-describe(1)

--cat-blob-fd=<fd>
        git-fast-import(1)

--cc
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--cc=<address>,...
        git-send-email(1)

--cc=<email>
        git-format-patch(1)

--changed-paths
        git-commit-graph(1)

--changes-block-size <n>
        git-p4(1)

--changesfile <file>
        git-p4(1)

--check
        git-apply(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--check-self-contained-and-connected
        git-fetch-pack(1)
        git-index-pack(1)

--cherry
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--cherry-mark
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--cherry-pick
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--chmod=(+|-)x

--children
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--cleanup=<mode>
        git-cherry-pick(1)
        git-commit(1)
        git-merge(1)
        git-pull(1)
        git-revert(1)

--clear-decorations
        git-log(1)
        git-reflog(1)

--color[=<when>]
        git-branch(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-for-each-ref(1)
        git-grep(1)
        git-log(1)
        git-reflog(1)

--color-by-age
        git-annotate(1)
        git-blame(1)

--color-moved[=<mode>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--color-moved-ws=<modes>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--color-lines
        git-annotate(1)
        git-blame(1)

--color-words[=<regex>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--column
        git-grep(1)

--column[=<options>], --no-column
        git-branch(1)

--combined-all-paths
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--command=<name>
        git-column(1)

--commit
        git-notes(1)

--commit (<sha1>|<sha1>..<sha1>)
        git-p4(1)

--commit, --no-commit
        git-merge(1)
        git-pull(1)

--commit-filter <command>
        git-filter-branch(1)

--commit-header
        git-rev-list(1)

--committer-date-is-author-date
        git-am(1)
        git-rebase(1)

--compact-summary
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--compose
        git-send-email(1)

--compose-encoding=<encoding>
        git-send-email(1)

--compression=<n>
        git-pack-objects(1)

--connectivity-only
        git-fsck(1)

--config=<config>
        git-for-each-repo(1)

--config-env=<name>=<envvar>
        git(1)

--conflict=(ask|skip|quit)
        git-p4(1)

--conflict=<style>
        git-checkout(1)
        git-restore(1)

--contains
        git-describe(1)

--contains [<commit>]
        git-branch(1)

--contains[=<object>]
        git-for-each-ref(1)

--contents <file>
        git-annotate(1)
        git-blame(1)

--continue
        git-cherry-pick(1)
        git-merge(1)
        git-rebase(1)
        git-revert(1)

--continue, -r, --resolved
        git-am(1)

--convert-graft-file
        git-replace(1)

--count
        git-rev-list(1)

--count=<count>
        git-for-each-ref(1)

--cover-from-description=<mode>
        git-format-patch(1)

--[no-]cover-letter
        git-format-patch(1)

--create-reflog
        git-branch(1)

--creation-factor=<percent>
        git-format-patch(1)
        git-range-diff(1)

--cruft
        git-pack-objects(1)
        git-repack(1)

--[no-]cruft
        git-gc(1)

--cruft-expiration=<approxidate>
        git-pack-objects(1)
        git-repack(1)

--cumulative
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--curl
        git-imap-send(1)

-D
        git-branch(1)

-D <depth>
        git-archimport(1)

-D, --irreversible-delete
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-d
        git-clean(1)
        git-cvsexportcommit(1)
        git-ls-tree(1)
        git-repack(1)

-d <CVSROOT>
        git-cvsimport(1)

-d <directory>
        git-filter-branch(1)

-d<prec>
        git-mailsplit(1)

-d, -D
        git-http-push(1)

-d, --delete
        git-branch(1)
        git-push(1)
        git-replace(1)

-d, --deleted
        git-ls-files(1)

-d, --detach
        git-checkout(1)

-d, --dir-diff
        git-difftool(1)

-d, --httpd
        git-instaweb(1)

--[no-]dangling
        git-fsck(1)

--date=<date>
        git-commit(1)

--date=<format>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--date <format>
        git-annotate(1)
        git-blame(1)

--date-format=<fmt>
        git-fast-import(1)

--date-order
        gitk(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--dd
        git-log(1)
        git-reflog(1)

--debug
        git-credential-cache--daemon(1)
        git-describe(1)
        git-ls-files(1)

--deduplicate
        git-ls-files(1)

--no-decorate, --decorate[=short|full|auto|no]
        git-log(1)
        git-reflog(1)

--decorate-refs=<pattern>, --decorate-refs-exclude=<pattern>
        git-log(1)
        git-reflog(1)

--deepen=<depth>
        git-fetch(1)
        git-pull(1)

--deepen-relative
        git-fetch-pack(1)

--default <arg>
        git-rev-parse(1)

--default <value>
        git-config(1)

--default-prefix
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--delta-base-offset
        git-pack-objects(1)

--delta-islands
        git-pack-objects(1)

--dense
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--depth <depth>
        git-clone(1)
        git-fetch(1)

--depth=<depth>
        git-pull(1)

--depth=<n>
        git-fast-import(1)
        git-fetch-pack(1)

--description-file=<file>
        git-format-patch(1)

--destination <directory>
        git-p4(1)

--detach
        git-daemon(1)

--detect-branches
        git-p4(1)

--detect-labels
        git-p4(1)

--developer-interfaces
        git-help(1)

--diff3
        git-merge-file(1)

--diff-algorithm={patience|minimal|histogram|myers}
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--diff-merges=<format>
        git-log(1)
        git-reflog(1)

--directory
        git-ls-files(1)

--directory=<root>
        git-apply(1)

--dirstat-by-file[=<param1,param2>...]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--dirty[=<mark>], --broken[=<mark>]
        git-describe(1)

--disable-p4sync
        git-p4(1)

--disable-rebase
        git-p4(1)

--disambiguate=<prefix>
        git-rev-parse(1)

--disk-usage, --disk-usage=human
        git-rev-list(1)

--dissociate
        git-clone(1)

--done
        git-fast-import(1)

--do-walk
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--dry-run
        git-commit(1)
        git-fetch(1)
        git-http-push(1)
        git-pull(1)

--dst-prefix=<prefix>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-E, --extended-regexp
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

-E, --extended-regexp, -G, --basic-regexp
        git-grep(1)

-e
        git-cat-file(1)
        git-cherry-pick(1)
        git-grep(1)

-e, --edit
        git-add(1)
        git-commit(1)
        git-config(1)
        git-revert(1)

-e, --show-email
        git-blame(1)

-e <pattern>, --exclude=<pattern>
        git-clean(1)

--edit <object>
        git-replace(1)

--edit, -e, --no-edit
        git-merge(1)
        git-pull(1)

--edit-description
        git-branch(1)

--edit-todo
        git-rebase(1)

--empty
        git-read-tree(1)

--empty=(drop|keep|ask)
        git-rebase(1)

--empty=(stop|drop|keep)
        git-am(1)

--enable=<service>, --disable=<service>
        git-daemon(1)

--encode-email-headers, --no-encode-email-headers
        git-format-patch(1)

--encoding=<encoding>
        git-annotate(1)
        git-blame(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-mailinfo(1)
        git-rev-list(1)

--env-filter <command>
        git-filter-branch(1)

--eol
        git-ls-files(1)

--error-unmatch
        git-ls-files(1)

--exact-match
        git-describe(1)

--exclude <pattern>
        git-describe(1)
        git-pack-refs(1)

--exclude=<glob-pattern>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)
        git-rev-parse(1)

--exclude=<path-pattern>
        git-apply(1)

--exclude=<pattern>
        git-for-each-ref(1)
        git-name-rev(1)

--exclude-first-parent-only
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--exclude-hidden=[fetch|receive|uploadpack]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)
        git-rev-parse(1)

--exclude-per-directory=<file>
        git-ls-files(1)

--exclude-promisor-objects
        git-pack-objects(1)
        git-rev-list(1)

--exclude-standard
        git-grep(1)
        git-ls-files(1)

--exec=<git-upload-archive>
        git-archive(1)

--exec=<git-upload-pack>
        git-fetch-pack(1)

--exec-path[=<path>]
        git(1)

--exit-code
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-ls-remote(1)

--expand-tabs=<n>, --expand-tabs, --no-expand-tabs
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--expire <time>
        git-prune(1)

--expire=<time>
        git-reflog(1)

--expire-to=<dir>
        git-repack(1)

--expire-unreachable=<time>
        git-reflog(1)

--export-all
        git-cvsserver(1)
        git-daemon(1)

--export-labels
        git-p4(1)

--export-marks=<file>
        git-fast-export(1)
        git-fast-import(1)

--export-pack-edges=<file>
        git-fast-import(1)

--ext-diff
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-F
        git-repack(1)

-F <file>
        git-commit-tree(1)

-F <file>, --file <file>
        git-fmt-merge-msg(1)
        git-merge(1)

-F <file>, --file=<file>
        git-commit(1)
        git-notes(1)

-F, --fixed-strings
        git-grep(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

-f
        git-archimport(1)
        git-cvsexportcommit(1)
        git-ls-files(1)
        git-repack(1)

-f <file>
        git-grep(1)

-f<nn>
        git-mailsplit(1)

-f, --force
        git-add(1)
        git-branch(1)
        git-checkout(1)
        git-checkout-index(1)
        git-clean(1)
        git-fetch(1)
        git-filter-branch(1)
        git-mv(1)
        git-notes(1)
        git-pull(1)
        git-push(1)
        git-replace(1)
        git-rm(1)

-f, --show-name
        git-blame(1)

-f <config-file>, --file <config-file>
        git-config(1)

--fake-missing-tagger
        git-fast-export(1)

--ff
        git-cherry-pick(1)

--ff, --no-ff, --ff-only
        git-merge(1)

--ff, --no-ff
        git-pull(1)

--ff-only
        git-pull(1)

--file=<path>
        git-credential-store(1)

--filter=<filter-spec>
        git-clone(1)
        git-pack-objects(1)
        git-repack(1)
        git-rev-list(1)

--filename-max-length=<n>
        git-format-patch(1)

--filter-print-omitted
        git-rev-list(1)

--filter-provided-objects
        git-rev-list(1)

--filters
        git-cat-file(1)

--filter-to=<dir>
        git-repack(1)

--find-copies-harder
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--find-object=<object-id>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--first-parent
        git-bisect(1)
        git-blame(1)
        git-annotate(1)
        git-describe(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--fixed-value
        git-config(1)

--fix-thin
        git-index-pack(1)

--fixup=[(amend|reword):]<commit>
        git-commit(1)

--flags
        git-rev-parse(1)

--follow
        git-log(1)
        git-reflog(1)

--follow-symlinks
        git-cat-file(1)

--follow-tags
        git-push(1)

--force
        git-fast-import(1)
        git-gc(1)
        git-http-push(1)

--[no-]force-if-includes
        git-push(1)

--[no-]force-in-body-from
        git-format-patch(1)

--[no-]force-with-lease, --force-with-lease=<refname>, --force-with-lease=<refname>:<expect>
        git-push(1)

--fork-point
        git-merge-base(1)

--fork-point, --no-fork-point
        git-rebase(1)

--format <format>
        git-branch(1)

--format=<fmt>
        git-archive(1)

--format=<format>
        git-for-each-ref(1)
        git-ls-files(1)
        git-ls-tree(1)
        git-replace(1)

--from, --from=<ident>
        git-format-patch(1)

--from=<address>
        git-send-email(1)

--fsck-objects
        git-index-pack(1)

--full
        git-fsck(1)

--full-diff
        git-log(1)
        git-reflog(1)

--full-history
        gitk(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--full-index
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--full-name
        git-grep(1)
        git-ls-files(1)
        git-ls-tree(1)

--full-tree
        git-fast-export(1)
        git-ls-tree(1)

-G<regex>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-g<factor>, --geometric=<factor>
        git-repack(1)

-g, --gui
        git-mergetool(1)

-g, --[no-]gui
        git-difftool(1)

-g, --guides
        git-help(1)

-g, --walk-reflogs
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--get
        git-config(1)

--get-all
        git-config(1)

--get-color <name> [<default>]
        git-config(1)

--get-colorbool <name> [<stdout-is-tty>]
        git-config(1)

--get-regexp
        git-config(1)

--get-url
        git-ls-remote(1)

--get-urlmatch <name> <URL>
        git-config(1)

--git-dir
        git-rev-parse(1)

--git-dir <dir>
        git-p4(1)

--git-dir=<path>
        git(1)

--git-common-dir
        git-rev-parse(1)

--git-path <path>
        git-rev-parse(1)

--glob=<glob-pattern>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--glob=pattern
        git-rev-parse(1)

--glob-pathspecs
        git(1)

--global
        git-config(1)

--graft <commit> [<parent>...]
        git-replace(1)

--graph
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--grep=<pattern>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--grep-reflog=<pattern>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--guess, --no-guess
        git-checkout(1)

-H, --human-readable
        git-count-objects(1)

-h
        git-annotate(1)
        git-archimport(1)
        git-blame(1)
        git-cvsimport(1)

-h, -H
        git-grep(1)

-h, --heads, -t, --tags
        git-ls-remote(1)

-h, --help
        git(1)

-h, -H, --help
        git-cvsserver(1)

--header
        git-rev-list(1)

--heading
        git-grep(1)

--histogram
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--honor-pack-keep
        git-pack-objects(1)

--html-path
        git(1)

--http-backend-info-refs
        git-receive-pack(1)

-I
        git-grep(1)

-I<regex>, --ignore-matching-lines=<regex>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-i
        git-cvsimport(1)
        git-read-tree(1)

-i, --delta-islands
        git-repack(1)

-i, --ignore-case
        git-branch(1)
        git-grep(1)

-i, --ignored
        git-ls-files(1)

-i, --include
        git-commit(1)

-i, --info
        git-help(1)

-i, --interactive
        git-add(1)
        git-am(1)
        git-clean(1)
        git-rebase(1)

-i, --regexp-ignore-case
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--icase-pathspecs
        git(1)

--if-exists <action>, --no-if-exists
        git-interpret-trailers(1)

--if-missing <action>, --no-if-missing
        git-interpret-trailers(1)

--ignore-blank-lines
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--ignore-case
        git-for-each-ref(1)

--ignore-cr-at-eol
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--ignore-date
        git-am(1)

--ignore-date, --reset-author-date
        git-rebase(1)

--ignore-errors
        git-add(1)

--ignore-if-in-upstream
        git-format-patch(1)

--ignore-missing
        git-add(1)
        git-hook(1)
        git-log(1)
        git-notes(1)
        git-reflog(1)
        git-rev-list(1)

--ignore-other-worktrees
        git-checkout(1)

--ignore-rev <rev>
        git-annotate(1)
        git-blame(1)

--ignore-revs-file <file>
        git-annotate(1)
        git-blame(1)

--ignore-skip-worktree-bits
        git-checkout(1)
        git-checkout-index(1)
        git-restore(1)

--ignore-space-at-eol
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--ignore-space-change, --ignore-whitespace
        git-apply(1)

--ignore-submodules[=<when>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--ignore-unmatch
        git-rm(1)

--ignore-unmerged
        git-restore(1)

--ignore-whitespace
        git-rebase(1)

--import-labels
        git-p4(1)

--import-local
        git-p4(1)

--import-marks=<file>
        git-fast-export(1)
        git-fast-import(1)

--import-marks-if-exists=<file>
        git-fast-import(1)

--inaccurate-eof
        git-apply(1)

--include <pattern>
        git-pack-refs(1)

--include=<path-pattern>
        git-apply(1)

--include-tag
        git-fetch-pack(1)
        git-pack-objects(1)

--[no-]includes
        git-config(1)

--in-commit-order
        git-rev-list(1)

--incremental
        git-annotate(1)
        git-blame(1)
        git-pack-objects(1)

--indent=<string>
        git-column(1)

--indent-heuristic
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--independent
        git-merge-base(1)

--index
        git-apply(1)

--indexed-objects
        git-rev-list(1)

--index-filter <command>
        git-filter-branch(1)

--index-output=<file>
        git-read-tree(1)

--index-pack-args=<args>
        git-http-fetch(1)

--index-version=<version>[,<offset>]
        git-index-pack(1)
        git-pack-objects(1)

--inetd
        git-daemon(1)

--info-path
        git(1)

--[no-]informative-errors
        git-daemon(1)

--init-timeout=<n>
        git-daemon(1)

--inline[=<boundary>]
        git-format-patch(1)

--in-place
        git-interpret-trailers(1)

--in-reply-to=<identifier>
        git-send-email(1)

--in-reply-to=<message id>
        git-format-patch(1)

--intent-to-add
        git-apply(1)

--interdiff=<previous>
        git-format-patch(1)

--inter-hunk-context=<lines>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--interpolated-path=<pathtemplate>
        git-daemon(1)

--into-name <branch>
        git-fmt-merge-msg(1)
        git-merge(1)

--invert-grep
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--is-ancestor
        git-merge-base(1)

--is-bare-repository
        git-rev-parse(1)

--is-inside-git-dir
        git-rev-parse(1)

--is-inside-work-tree
        git-rev-parse(1)

--is-shallow-repository
        git-rev-parse(1)

--ita-invisible-in-index
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-j, --jobs=<n>
        git-fetch(1)
        git-pull(1)

-j <n>, --jobs <n>
        git-clone(1)

-k
        git-cvsexportcommit(1)
        git-cvsimport(1)
        git-mailinfo(1)
        git-mv(1)

-k, --keep
        git-am(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-pull(1)

-k, --keep-subject
        git-format-patch(1)

-k, --keep-unreachable
        git-repack(1)

-k, --killed
        git-ls-files(1)

--keep
        git-index-pack(1)

--keep=<msg>
        git-index-pack(1)

--keep-base
        git-rebase(1)

--keep-cr
        git-mailsplit(1)

--[no-]keep-cr
        git-am(1)

--keep-dashdash
        git-rev-parse(1)

--keep-largest-pack
        git-gc(1)

--keep-non-patch
        git-am(1)
        git-quiltimport(1)

--keep-pack=<pack-name>
        git-pack-objects(1)
        git-repack(1)

--keep-path
        git-p4(1)

--keep-redundant-commits
        git-cherry-pick(1)

--keep-true-parents
        git-pack-objects(1)

--keep-unreachable
        git-pack-objects(1)

-L <start>,<end>, -L :<funcname>
        git-annotate(1)
        git-blame(1)

-L<start>,<end>:<file>, -L:<funcname>:<file>
        gitk(1)
        git-log(1)
        git-reflog(1)

-L <label>
        git-merge-file(1)

-L <limit>
        git-cvsimport(1)

-l
        git-annotate(1)
        git-blame(1)
        git-checkout(1)
        git-repack(1)

-l<num>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-l, --list
        git-archive(1)
        git-branch(1)
        git-config(1)

-l <pattern>, --list <pattern>
        git-replace(1)

-l, --local
        git-clone(1)
        git-instaweb(1)

-l, --long
        git-ls-tree(1)

-l, --files-with-matches, --name-only, -L, --files-without-match
        git-grep(1)

--left-only
        git-range-diff(1)

--left-only, --right-only
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--left-right
        gitk(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--line-porcelain
        git-annotate(1)
        git-blame(1)

--line-prefix=<prefix>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--list-cmds=group[,group...]
        git(1)

--listen=<host_or_ipaddr>
        git-daemon(1)

--literally
        git-hash-object(1)

--literal-pathspecs
        git(1)

--local
        git-config(1)
        git-pack-objects(1)

--local-env-vars
        git-rev-parse(1)

--log[=<n>]
        git-fmt-merge-msg(1)

--log[=<n>], --no-log
        git-merge(1)
        git-pull(1)

--log-destination=<destination>
        git-daemon(1)

--log-size
        git-log(1)
        git-reflog(1)

--long
        git-commit(1)
        git-describe(1)

--lost-found
        git-fsck(1)

-M
        git-branch(1)
        git-p4(1)

-M[<n>], --find-renames[=<n>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-M[<num>]
        git-annotate(1)
        git-blame(1)

-M <regex>
        git-cvsimport(1)

-M, -C
        git-fast-export(1)

-m
        git-cvsexportcommit(1)
        git-cvsimport(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-read-tree(1)

-m <msg>
        git-merge(1)

-m <message>
        git-commit-tree(1)

-m parent-number, --mainline parent-number
        git-revert(1)

-m <parent-number>, --mainline <parent-number>
        git-cherry-pick(1)

-m, --man
        git-help(1)

-m <num>, --max-count <num>
        git-grep(1)

-m, --merge
        git-checkout(1)
        git-rebase(1)
        git-restore(1)

-m <message>, --message <message>
        git-fmt-merge-msg(1)

-m <msg>, --message=<msg>
        git-commit(1)
        git-notes(1)

-m, --message-id
        git-am(1)
        git-mailinfo(1)

-m, --modified
        git-ls-files(1)

-m, --module-path
        git-instaweb(1)

-m, --move
        git-branch(1)

-m, --write-midx
        git-repack(1)

--[no-]mailmap, --[no-]use-mailmap
        git-cat-file(1)
        git-log(1)
        git-reflog(1)

--man-path
        git(1)

--mark-tags
        git-fast-export(1)

--match <pattern>
        git-describe(1)

--max-age=<timestamp>, --min-age=<timestamp>
        git-rev-list(1)

--max-changes <n>
        git-p4(1)

--max-connections=<n>
        git-daemon(1)

--max-cruft-size=<n>
        git-gc(1)
        git-repack(1)

--max-depth <depth>
        git-grep(1)

--max-input-size=<size>
        git-index-pack(1)

--[no-]max-new-filters <n>
        git-commit-graph(1)

--max-pack-size=<n>
        git-fast-import(1)
        git-pack-objects(1)
        git-repack(1)

--mboxrd
        git-mailsplit(1)

--merge
        gitk(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--merge-base
        git-diff-index(1)
        git-diff-tree(1)

--merge-base=<commit>
        git-merge-tree(1)

--merged [<commit>]
        git-branch(1)

--merged[=<object>]

--merges
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--[no-]messages
        git-merge-tree(1)

--minimal
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--min-parents=<number>, --max-parents=<number>, --no-min-parents, --no-max-parents
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--mirror
        git-clone(1)
        git-push(1)

--missing
        git-mktree(1)

--missing=<missing-action>
        git-pack-objects(1)
        git-rev-list(1)

--mode=<mode>
        git-column(1)

--mode=(stats|all)
        git-diagnose(1)

--msg-filter <command>
        git-filter-branch(1)

--mtime=<time>
        git-archive(1)

--multiple
        git-fetch(1)

-N, --intent-to-add
        git-add(1)

-N, --no-numbered
        git-format-patch(1)

-n
        git-mailinfo(1)
        git-repack(1)

-n, --dry-run
        git-add(1)
        git-clean(1)
        git-mv(1)
        git-notes(1)
        git-p4(1)
        git-prune(1)
        git-prune-packed(1)
        git-push(1)
        git-quiltimport(1)
        git-read-tree(1)
        git-reflog(1)
        git-rm(1)

-n, --line-number
        git-grep(1)

-n, --no-checkout
        git-clone(1)

-n, --no-commit
        git-cherry-pick(1)
        git-revert(1)

-n, --no-create
        git-checkout-index(1)

--non-empty
        git-pack-objects(1)

-n, --non-matching
        git-check-ignore(1)

-n, --no-stat
        git-rebase(1)

-n, --no-tags
        git-fetch(1)

-n, --[no-]verify
        git-commit(1)

-n, --no-verify
        git-am(1)

-n, --numbered
        git-format-patch(1)

-n, --show-number
        git-blame(1)

--name-objects
        git-fsck(1)

--name-only
        git-config(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-merge-tree(1)
        git-name-rev(1)

--name-only, --name-status
        git-ls-tree(1)

--name-status
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--namespace=<path>
        git(1)

--negotiate-only
        git-fetch(1)
        git-pull(1)

--negotiation-tip=<commit|glob>
        git-fetch(1)
        git-pull(1)

--nl=<string>
        git-column(1)

--no-abbrev
        git-branch(1)

--no-abbrev-commit
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--no-add
        git-apply(1)

--no-all, --ignore-removal
        git-add(1)

--no-aliases
        git-help(1)

--no-attach
        git-format-patch(1)

--no-binary
        git-format-patch(1)

--no-checkout
        git-bisect(1)

--no-color
        git-branch(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-grep(1)
        git-log(1)
        git-reflog(1)

--no-color-moved
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--no-color-moved-ws
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--no-commit-header
        git-rev-list(1)

--no-commit-id
        git-diff-tree(1)

--no-contains [<commit>]
        git-branch(1)

--no-contains[=<object>]
        git-for-each-ref(1)

--no-curl
        git-imap-send(1)

--no-data
        git-fast-export(1)

--no-diagnose, --diagnose[=<mode>]
        git-bugreport(1)

--no-diff-merges
        git-log(1)
        git-reflog(1)

--no-divider
        git-interpret-trailers(1)

--no-dual-color
        git-range-diff(1)

--no-edit
        git-commit(1)
        git-revert(1)

--no-empty-directory
        git-ls-files(1)

--no-exclude-standard
        git-grep(1)

--no-ext-diff
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--no-external-commands
        git-help(1)

--no-ff, --force-rebase, -f
        git-rebase(1)

--no-filter
        git-pack-objects(1)
        git-rev-list(1)

--no-filters
        git-hash-object(1)

--no-flags
        git-rev-parse(1)

--noglob-pathspecs
        git(1)

--no-gui
        git-mergetool(1)

--no-hardlinks
        git-clone(1)

--no-indent-heuristic
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--no-index
        git-check-ignore(1)
        git-grep(1)

--no-keep-empty, --keep-empty
        git-rebase(1)

--no-log
        git-fmt-merge-msg(1)

--no-merged [<commit>]
        git-branch(1)

--no-merged[=<object>]
        git-for-each-ref(1)

--no-merges
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--no-message-id
        git-am(1)

--no-notes
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--no-object-names
        git-rev-list(1)

--no-optional-locks
        git(1)

--no-post-rewrite
        git-commit(1)

--no-prefix
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--no-progress
        git-fetch-pack(1)

--no-prune
        git-gc(1)
        git-pack-refs(1)

--no-rebase
        git-pull(1)

--no-recurse-submodules
        git-fetch(1)

--no-recurse-submodules, --recurse-submodules=check|on-demand|only|no
        git-push(1)

--no-recursive
        git-grep(1)

--no-reuse-delta
        git-pack-objects(1)

--no-reuse-object
        git-pack-objects(1)

--no-reflogs
        git-fsck(1)

--no-renames
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--no-replace-objects
        git(1)

--no-revs
        git-rev-parse(1)

--no-scissors
        git-am(1)
        git-mailinfo(1)

--no-show-forced-updates
        git-fetch(1)
        git-pull(1)

--no-sparse-checkout
        git-read-tree(1)

--no-status
        git-commit(1)

--no-tags
        git-clone(1)
        git-pull(1)

--no-textconv
        git-grep(1)

--no-track
        git-branch(1)
        git-checkout(1)

--no-type
        git-config(1)

--no-undefined
        git-name-rev(1)

--no-utf8
        git-am(1)

--no-verify
        git-rebase(1)

--no-walk[=(sorted|unsorted)]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--no-warn-embedded-repo
        git-add(1)

--normalize
        git-check-ref-format(1)

--not
        git-log(1)
        git-reflog(1)
        git-rev-list(1)
        git-rev-parse(1)

--notes[=<ref>]
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--[no-]notes[=<ref>]
        git-range-diff(1)

--notes[=<ref>], --no-notes
        git-format-patch(1)

--numbered-files
        git-format-patch(1)

--numstat
        git-apply(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-o<directory>
        git-mailsplit(1)

-O<orderfile>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)
        git-mergetool(1)

-O[<pager>], --open-files-in-pager[=<pager>]
        git-grep(1)

-o
        git-archimport(1)
        git-merge-index(1)

-o <branch-for-HEAD>
        git-cvsimport(1)

-o <index-file>
        git-index-pack(1)

-o, --only
        git-commit(1)

-o, --only-matching
        git-grep(1)

-o <dir>, --output-directory <dir>
        git-format-patch(1)

-o <name>, --origin <name>
        git-clone(1)

-o, --others
        git-ls-files(1)

-o <file>, --output=<file>
        git-archive(1)

-o <option>, --push-option=<option>
        git-push(1)

-o <option>, --server-option=<option>
        git-fetch(1)
        git-ls-remote(1)
        git-pull(1)

-o <path>, --output-directory <path>
        git-bugreport(1)
        git-diagnose(1)

--object-dir
        git-commit-graph(1)

--object-dir=<dir>
        git-multi-pack-index(1)

--object-format=<format>
        git-init(1)

--object-format=<hash-algorithm>
        git-index-pack(1)

--object-id
        git-merge-file(1)

--object-names
        git-rev-list(1)

--object-only
        git-ls-tree(1)

--objects
        git-rev-list(1)

--objects-edge
        git-rev-list(1)

--objects-edge-aggressive
        git-rev-list(1)

--octopus
        git-merge-base(1)

--omit-empty
        git-branch(1)
        git-for-each-ref(1)

--oneline
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--only-input
        git-interpret-trailers(1)

--only-trailers
        git-interpret-trailers(1)

--onto
        git-rebase(1)

--origin <commit>
        git-p4(1)

--original <namespace>
        git-filter-branch(1)

--orphan <new-branch>
        git-checkout(1)

--ours, --theirs
        git-checkout(1)
        git-restore(1)

--ours, --theirs, --union
        git-merge-file(1)

--output=<file>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--output-indicator-new=<char>, --output-indicator-old=<char>, --output-indicator-context=<char>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--overlay, --no-overlay
        git-checkout(1)
        git-restore(1)

--overwrite-ignore, --no-overwrite-ignore
        git-checkout(1)
        git-merge(1)

-P
        git-cvsexportcommit(1)

-P <cvsps-output-file>
        git-cvsimport(1)

-P, --no-pager
        git(1)

-P, --perl-regexp
        git-grep(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

-P, --prune-tags
        git-fetch(1)

-p
        git-cat-file(1)
        git-cvsexportcommit(1)
        git-merge-file(1)
        git-request-pull(1)

-p <options-for-cvsps>
        git-cvsimport(1)

-p <parent>
        git-commit-tree(1)

-p, --no-stat
        git-format-patch(1)

-p, --patch
        git-add(1)
        git-checkout(1)
        git-commit(1)
        git-restore(1)

-p, -u, --patch
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-p, --paginate
        git(1)

-p<n>
        git-apply(1)

-p, --porcelain
        git-annotate(1)
        git-blame(1)

-p, --port
        git-instaweb(1)

-p, --prune
        git-fetch(1)
        git-pull(1)

-p, --show-function
        git-grep(1)

--packfile=<hash>
        git-http-fetch(1)

--pack-kept-objects
        git-repack(1)

--pack-loose-unreachable
        git-pack-objects(1)

--padding=<N>
        git-column(1)

--parent-filter <command>
        git-filter-branch(1)

--parents
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--parse
        git-interpret-trailers(1)

--parseopt
        git-rev-parse(1)

--patches <dir>
        git-quiltimport(1)

--patch-format
        git-am(1)

--patch-with-raw
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--patch-with-stat
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--patience
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--path
        git-hash-object(1)

--path=<path>
        git-cat-file(1)

--path-format=(absolute|relative)
        git-rev-parse(1)

--pathspec-file-nul
        git-add(1)
        git-checkout(1)
        git-commit(1)
        git-reset(1)
        git-restore(1)
        git-rm(1)

--pathspec-from-file=<file>
        git-add(1)
        git-checkout(1)
        git-commit(1)
        git-reset(1)
        git-restore(1)
        git-rm(1)

--pickaxe-all
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--pickaxe-regex
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--pid-file=<file>
        git-daemon(1)

--points-at <object>
        git-branch(1)

--points-at=<object>

--porcelain
        git-commit(1)
        git-fetch(1)
        git-pull(1)
        git-push(1)

--port=<n>
        git-daemon(1)

--preferred-pack=<pack>
        git-multi-pack-index(1)

--prefetch
        git-fetch(1)
        git-pull(1)

--prefix <arg>
        git-rev-parse(1)

--prefix=<prefix>/
        git-archive(1)

--prefix=<prefix>
        git-read-tree(1)

--prefix=<string>
        git-checkout-index(1)

--prepare-p4-only
        git-p4(1)

--preserve-user
        git-p4(1)

--pretty[=<format>], --format=<format>
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--progress
        git-bundle(1)
        git-clone(1)
        git-fetch(1)
        git-format-patch(1)
        git-pack-objects(1)
        git-prune(1)
        git-pull(1)
        git-push(1)

--[no-]progress
        git-annotate(1)
        git-blame(1)
        git-commit-graph(1)
        git-commit-graph(1)
        git-fsck(1)
        git-multi-pack-index(1)

--progress=<header>
        git-rev-list(1)

--progress=<n>
        git-fast-export(1)

--progress, --no-progress
        git-checkout(1)
        git-merge(1)
        git-restore(1)

--progress-title
        git-index-pack(1)

--promisor[=<message>]
        git-index-pack(1)

--prompt
        git-difftool(1)
        git-mergetool(1)

--prune
        git-push(1)

--prune=<date>
        git-gc(1)

--prune-empty
        git-filter-branch(1)

-q
        git-diff-files(1)
        git-merge-file(1)
        git-merge-index(1)
        git-pack-objects(1)

-q, --quiet
        git-am(1)
        git-apply(1)
        git-branch(1)
        git-bundle(1)
        git-check-ignore(1)
        git-checkout(1)
        git-checkout-index(1)
        git-clean(1)
        git-clone(1)
        git-commit(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-format-patch(1)
        git-grep(1)
        git-imap-send(1)
        git-init(1)
        git-ls-remote(1)
        git-merge(1)
        git-notes(1)
        git-prune-packed(1)
        git-pull(1)
        git-push(1)
        git-read-tree(1)
        git-rebase(1)
        git-repack(1)
        git-reset(1)
        git-restore(1)
        git-rev-parse(1)
        git-rm(1)

--quiet
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-fast-import(1)
        git-gc(1)
        git-rev-list(1)

--quit
        git-am(1)
        git-cherry-pick(1)
        git-merge(1)
        git-rebase(1)
        git-revert(1)

--quoted-cr=<action>
        git-am(1)
        git-mailinfo(1)

-R
        git-cvsimport(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-R, --reverse
        git-apply(1)

-r
        git-cherry-pick(1)
        git-diff-tree(1)
        git-ls-tree(1)
        git-rm(1)

-r, --rebase[=false|true|merges|interactive]
        git-pull(1)

-r, --rebase-merges[=(rebase-cousins|no-rebase-cousins)], --no-rebase-merges
        git-rebase(1)

-r, --recursive
        git-grep(1)

-r, --remotes
        git-branch(1)

-r <remote>
        git-cvsimport(1)

--range-diff=<previous>
        git-format-patch(1)

--raw
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-replace(1)

--raw-mode=<n>
        git-column(1)

--reachable
        git-commit-graph(1)

--reapply-cherry-picks, --no-reapply-cherry-picks
        git-rebase(1)

--receive-pack=<git-receive-pack>, --exec=<git-receive-pack>
        git-push(1)

--recount
        git-apply(1)

--recover
        git-http-fetch(1)

--recurse-submodules
        git-branch(1)
        git-grep(1)
        git-ls-files(1)

--[no-]recurse-submodules
        git-read-tree(1)

--recurse-submodules[=<pathspec>]
        git-clone(1)

--recurse-submodules[=yes|on-demand|no]
        git-fetch(1)

--recurse-submodules, --no-recurse-submodule
        git-checkout(1)
        git-restore(1)

--recurse-submodules-default=[yes|on-demand]
        git-fetch(1)

--[no-]recurse-submodules[=yes|on-demand|no]
        git-pull(1)

--reencode=(yes|no|abort)
        git-fast-export(1)

--ref <ref>
        git-notes(1)

--reference
        git-revert(1)

--reference-excluded-parents
        git-fast-export(1)

--reference[-if-able] <repository>
        git-clone(1)

--refetch
        git-fetch(1)
        git-fetch-pack(1)

--reflog
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--refmap=<refspec>
        git-fetch(1)
        git-pull(1)

--refresh
        git-add(1)

--refresh, --no-refresh
        git-reset(1)

--refs
        git-ls-remote(1)

--refs=<pattern>
        git-name-rev(1)

--refspec
        git-fast-export(1)

--refspec-pattern
        git-check-ref-format(1)

--refs-snapshot=<path>
        git-multi-pack-index(1)

--reject
        git-apply(1)

--[no-]reject-shallow
        git-clone(1)

--relative[=<path>], --no-relative
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--relative-date
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--[no-]relative-marks
        git-fast-import(1)

--remerge-diff
        git-log(1)
        git-reflog(1)

--remote=<repo>
        git-archive(1)

--remotes[=<pattern>]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--[no-]remote-submodules
        git-clone(1)

--remove-empty
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--remove-section
        git-config(1)

--[no-]rename-empty
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--rename-section
        git-config(1)

--renormalize
        git-add(1)

--replace-all
        git-config(1)

--reply-to=<address>
        git-send-email(1)

--repo=<repository>
        git-push(1)

--rerere-autoupdate, --no-rerere-autoupdate
        git-am(1)
        git-cherry-pick(1)
        git-merge(1)
        git-rebase(1)
        git-revert(1)

--reschedule-failed-exec, --no-reschedule-failed-exec
        git-rebase(1)

--reset
        git-read-tree(1)

--reset-author
        git-commit(1)

--resolve-git-dir <path>
        git-rev-parse(1)

--resolvemsg=<msg>
        git-am(1)

--resolve-undo
        git-ls-files(1)

--restart
        git-instaweb(1)

--reuseaddr
        git-daemon(1)

--reverse
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--reverse <rev>..<rev>
        git-annotate(1)
        git-blame(1)

--[no-]rev-index
        git-index-pack(1)

--revs
        git-pack-objects(1)

--revs-only
        git-rev-parse(1)

--rewrite
        git-reflog(1)

--rewrite-submodules-from=<name>:<file>, --rewrite-submodules-to=<name>:<file>
        git-fast-import(1)

--rfc
        git-format-patch(1)

--right-only
        git-range-diff(1)

--root
        git-annotate(1)
        git-blame(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-fsck(1)
        git-rebase(1)

--rotate-to=<file>
        git-difftool(1)

-S[<keyid>], --gpg-sign[=<keyid>], --no-gpg-sign
        git-am(1)
        git-cherry-pick(1)
        git-commit(1)
        git-commit-tree(1)
        git-merge(1)
        git-pull(1)
        git-rebase(1)
        git-revert(1)

-S <regex>
        git-cvsimport(1)

-S <revs-file>
        git-annotate(1)
        git-blame(1)

-S<string>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-s
        git-blame(1)
        git-cat-file(1)
        git-diff-tree(1)

-s <subst>
        git-cvsimport(1)

-s, --no-patch
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-s, --shared
        git-clone(1)

-s, --signoff
        git-am(1)
        git-cherry-pick(1)
        git-format-patch(1)
        git-revert(1)

-s, --signoff, --no-signoff
        git-commit(1)

-s, --stage
        git-ls-files(1)

-s <strategy>, --strategy=<strategy>
        git-merge(1)
        git-notes(1)
        git-pull(1)
        git-rebase(1)

-s <format>, --suffix <format>
        git-bugreport(1)
        git-diagnose(1)

-s <tree>, --source=<tree>
        git-restore(1)

--scissors
        git-mailinfo(1)

--score-debug
        git-blame(1)

--select-commit=<ref>
        gitk(1)

--series <file>
        git-quiltimport(1)

--server-option=<option>
        git-clone(1)

--separate-git-dir=<git-dir>
        git-clone(1)
        git-init(1)

--[no-]separator, --separator=<paragraph-break>
        git-notes(1)

--set-upstream
        git-branch(1)
        git-fetch(1)
        git-pull(1)

--setup <command>
        git-filter-branch(1)

--shallow
        git-commit-graph(1)
        git-pack-objects(1)

--shallow-exclude=<revision>
        git-clone(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-pull(1)

--shallow-since=<date>
        git-clone(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-pull(1)

--[no-]shallow-submodules
        git-clone(1)

--shared[=(false|true|umask|group|all|world|everybody|<perm>)]
        git-init(1)

--shared-index-path
        git-rev-parse(1)

--shell, --perl, --python, --tcl
        git-for-each-ref(1)

--shelve
        git-p4(1)

--short
        git-commit(1)

--short[=length]
        git-rev-parse(1)

--shortstat
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--show-cdup
        git-rev-parse(1)

--show-current
        git-branch(1)

--show-current-patch
        git-rebase(1)

--show-current-patch[=(diff|raw)]
        git-am(1)

--show-forced-updates
        git-fetch(1)
        git-pull(1)

--show-linear-break[=<barrier>]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--show-notes[=<ref>], --[no-]standard-notes
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--show-notes-by-default
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--show-object-format[=(storage|input|output)]
        git-rev-parse(1)

--show-origin
        git-config(1)

--show-original-ids
        git-fast-export(1)

--show-prefix
        git-rev-parse(1)

--show-pulls
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--show-scope
        git-config(1)

--show-signature
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--show-stats
        git-annotate(1)
        git-blame(1)

--show-superproject-working-tree
        git-rev-parse(1)

--show-toplevel
        git-rev-parse(1)

--[no-]signature=<signature>
        git-format-patch(1)

--signature-file=<file>
        git-format-patch(1)

--[no-]signed, --signed=(true|false|if-asked)
        git-push(1)

--signed-tags=(verbatim|warn|warn-strip|strip|abort)
        git-fast-export(1)

--signoff
        git-rebase(1)

--signoff, --no-signoff
        git-merge(1)
        git-pull(1)

--silent
        git-p4(1)

--simplify-by-decoration
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--simplify-merges
        gitk(1)
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--since=<date>
        gitk(1)

--since=<date>, --after=<date>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--since=datestring, --after=datestring
        git-rev-parse(1)

--since-as-filter=<date>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--[no-]single-branch
        git-clone(1)

--single-worktree
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--skip
        git-am(1)
        git-cherry-pick(1)
        git-rebase(1)
        git-revert(1)

--skip=<number>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--skip-to=<file>
        git-difftool(1)

--skip-to=<file>, --rotate-to=<file>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--socket <path>
        git-credential-cache(1)

--sort=<key>
        git-branch(1)
        git-for-each-ref(1)
        git-ls-remote(1)

--source
        git-log(1)
        git-reflog(1)

--source=<tree-ish>
        git-check-attr(1)

--sparse
        git-add(1)
        git-clone(1)
        git-log(1)
        git-reflog(1)
        git-ls-files(1)
        git-rev-list(1)
        git-rm(1)

--[no-]sparse
        git-pack-objects(1)

--split[=<strategy>]
        git-commit-graph(1)

--sq
        git-rev-parse(1)

--sq-quote
        git-rev-parse(1)

--squash=<commit>
        git-commit(1)

--squash, --no-squash
        git-merge(1)
        git-pull(1)

--src-prefix=<prefix>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--stable
        git-patch-id(1)

--stage=<number>|all
        git-checkout-index(1)

--stale-fix
        git-reflog(1)

--start
        git-instaweb(1)

--start-number <n>
        git-format-patch(1)

--stat
        git-apply(1)
        git-rebase(1)

--stat[=<width>[,<name-width>[,<count>]]]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--stat, -n, --no-stat
        git-merge(1)
        git-pull(1)

--state-branch <branch>
        git-filter-branch(1)

--stats
        git-fast-import(1)

--status
        git-commit(1)

--stdin
        git-check-attr(1)
        git-check-ignore(1)
        git-check-mailmap(1)
        git-checkout-index(1)
        git-diff-tree(1)
        git-fetch(1)
        git-fetch-pack(1)
        git-fmt-merge-msg(1)
        git-hash-object(1)
        git-http-fetch(1)
        git-index-pack(1)
        git-log(1)
        git-notes(1)
        git-reflog(1)
        git-rev-list(1)
        
--stdin-commits
        git-commit-graph(1)

--stdin-packs
        git-commit-graph(1)
        git-multi-pack-index(1)
        git-pack-objects(1)

--stdin-paths
        git-hash-object(1)

--stdout
        git-format-patch(1)
        git-pack-objects(1)

--stop
        git-instaweb(1)

--stop-at-non-option
        git-rev-parse(1)

--strategy=<strategy>
        git-cherry-pick(1)
        git-revert(1)

--strict
        git-fsck(1)
        git-index-pack(1)
        git-mktag(1)

--strict-paths
        git-cvsserver(1)
        git-daemon(1)

--[no-]stripspace
        git-notes(1)

--stuck-long
        git-rev-parse(1)

--subdirectory-filter <directory>
        git-filter-branch(1)

--subject=<string>
        git-send-email(1)

--subject-prefix=<subject prefix>
        git-format-patch(1)

--submodule[=<format>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--submodule-prefix=<path>
        git-fetch(1)

--suffix=.<sfx>
        git-format-patch(1)

--[no-]summary
        git-fmt-merge-msg(1)

--summary
        git-apply(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--summary, --no-summary
        git-merge(1)
        git-pull(1)

--symbolic
        git-rev-parse(1)

--symbolic-full-name
        git-rev-parse(1)

--[no-]symlinks
        git-difftool(1)

--symref
        git-ls-remote(1)

--syslog
        git-daemon(1)

--system
        git-config(1)

-T
        git-archimport(1)

-t
        git-annotate(1)
        git-blame(1)
        git-cat-file(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)
        git-ls-files(1)
        git-ls-tree(1)

-t <tmpdir>
        git-archimport(1)

-t <type>
        git-hash-object(1)

-t, --track[=(direct|inherit)]
        git-branch(1)
        git-checkout(1)

-t, --tags
        git-fetch(1)
        git-pull(1)

-t <file>, --template=<file>
        git-commit(1)

-t <tool>, --tool=<tool>
        git-difftool(1)
        git-mergetool(1)

--tag-of-filtered-object=(abort|drop|rewrite)
        git-fast-export(1)

--tag-name-filter <command>
        git-filter-branch(1)

--tags
        git-describe(1)
        git-fsck(1)
        git-name-rev(1)
        git-push(1)

--tags[=<pattern>]
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--temp
        git-checkout-index(1)

--template=<template-directory>
        git-clone(1)
        git-init(1)

--textconv
        git-cat-file(1)
        git-grep(1)

--textconv, --no-textconv
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

--thin
        git-fetch-pack(1)
        git-pack-objects(1)

--[no-]thin
        git-push(1)

--thread[=<style>], --no-thread
        git-format-patch(1)

--threads <num>
        git-grep(1)

--threads=<n>
        git-index-pack(1)
        git-pack-objects(1)
        git-repack(1)

--timeout=<n>
        git-daemon(1)

--timeout <seconds>
        git-credential-cache(1)

--timestamp
        git-rev-list(1)

--to=<address>,...
        git-send-email(1)

--to=<email>
        git-format-patch(1)

--topo-order
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--to-stdin
        git-hook(1)

--tool-help
        git-difftool(1)
        git-mergetool(1)

--trailer <key>[(=|:)<value>]
        git-interpret-trailers(1)

--trailer <token>[(=|:)<value>]
        git-commit(1)

--transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)
        git-send-email(1)

--tree-filter <command>
        git-filter-branch(1)

--trim-empty
        git-interpret-trailers(1)

--trivial
        git-read-tree(1)

--[no-]trust-exit-code
        git-difftool(1)

--type <type>
        git-config(1)

-U<n>, --unified=<n>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-u
        git-cvsexportcommit(1)
        git-cvsimport(1)
        git-mailinfo(1)
        git-read-tree(1)

-u, --index
        git-checkout-index(1)

-u, --set-upstream
        git-push(1)

-u, --unmerged
        git-ls-files(1)

-u, --update
        git-add(1)

-u, --update-head-ok
        git-fetch(1)

-u[<mode>], --untracked-files[=<mode>]
        git-commit(1)

-u <upload-pack>, --upload-pack <upload-pack>
        git-clone(1)

-u <upstream>, --set-upstream-to=<upstream>
        git-branch(1)

-u, --utf8
        git-am(1)

--unfold
        git-interpret-trailers(1)

--unidiff-zero
        git-apply(1)

--unordered
        git-cat-file(1)

--unpacked
        git-pack-objects(1)
        git-rev-list(1)

--unpack-unreachable
        git-pack-objects(1)

--unpack-unreachable=<when>
        git-repack(1)

--unreachable
        git-fsck(1)

--unsafe-paths
        git-apply(1)

--unset
        git-config(1)

--unset-all
        git-config(1)

--unset-upstream
        git-branch(1)

--unshallow
        git-fetch(1)
        git-pull(1)

--unstable
        git-patch-id(1)

--until=<date>
        gitk(1)

--until=<date>, --before=<date>
        git-log(1)
        git-reflog(1)
        git-rev-list(1)

--until=datestring, --before=datestring
        git-rev-parse(1)

--untracked
        git-grep(1)

--updateref
        git-reflog(1)

--update-refs, --no-update-refs
        git-rebase(1)

--update-shallow
        git-fetch(1)
        git-pull(1)

--update-shelve CHANGELIST
        git-p4(1)

--upload-pack=<exec>
        git-ls-remote(1)

--upload-pack=<git-upload-pack>
        git-fetch-pack(1)

--upload-pack <upload-pack>
        git-fetch(1)
        git-pull(1)

--use-bitmap-index
        git-rev-list(1)

--use-client-spec
        git-p4(1)

--use-done-feature
        git-fast-export(1)

--user=<user>, --group=<group>
        git-daemon(1)

--user-interfaces
        git-help(1)

--user-path, --user-path=<path>
        git-daemon(1)

-V, --version
        git-cvsserver(1)

-v
        git-archimport(1)
        git-cherry(1)
        git-cvsexportcommit(1)
        git-cvsimport(1)
        git-diff-tree(1)
        git-fetch-pack(1)
        git-http-fetch(1)
        git-index-pack(1)
        git-ls-files(1)
        git-read-tree(1)

-v, --invert-match
        git-grep(1)

-v <n>, --reroll-count=<n>
        git-format-patch(1)

-v, --verbose
        git-add(1)
        git-apply(1)
        git-archive(1)
        git-check-ignore(1)
        git-clone(1)
        git-commit(1)
        git-count-objects(1)
        git-fetch(1)
        git-imap-send(1)
        git-merge(1)
        git-mv(1)
        git-notes(1)
        git-p4(1)
        git-prune(1)
        git-pull(1)
        git-push(1)
        git-rebase(1)
        git-remote(1)

-v, --version
        git(1)

-v, -vv, --verbose
        git-branch(1)

--verbatim
        git-patch-id(1)

--verbose
        git-daemon(1)
        git-help(1)
        git-http-push(1)
        git-pack-redundant(1)
        git-reflog(1)

--verify
        git-rebase(1)
        git-rev-parse(1)

--[no-]verify
        git-merge(1)
        git-pull(1)
        git-push(1)

--verify-signatures, --no-verify-signatures
        git-merge(1)
        git-pull(1)

--version=<version>
        git-bundle(1)

-W
        git-cvsexportcommit(1)

-W, --function-context
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-grep(1)
        git-log(1)
        git-reflog(1)

-W, --worktree, -S, --staged
        git-restore(1)

-w
        git-blame(1)
        git-cvsexportcommit(1)
        git-hash-object(1)

-w <filename>
        git-http-fetch(1)

-w, --ignore-all-space
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-w, --web
        git-help(1)

-w, --word-regexp
        git-grep(1)

--where <placement>, --no-where
        git-interpret-trailers(1)

--whitespace=<action>
        git-apply(1)

--whitespace=<option>
        git-rebase(1)

--width=<width>
        git-column(1)

--window=<n>, --depth=<n>
        git-pack-objects(1)
        git-repack(1)

--window-memory=<n>
        git-pack-objects(1)
        git-repack(1)

--with-tree=<tree-ish>
        git-ls-files(1)

--word-diff[=<mode>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--word-diff-regex=<regex>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

--work-tree=<path>
        git(1)

--worktree
        git-config(1)

--worktree-attributes
        git-archive(1)

--[no-]write-commit-graph
        git-fetch(1)

--[no-]write-fetch-head
        git-fetch(1)

--ws-error-highlight=<kind>
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-log(1)
        git-reflog(1)

-X
        git-clean(1)

-X <file>, --exclude-from=<file>
        git-ls-files(1)

-X<option>, --strategy-option=<option>
        git-cherry-pick(1)
        git-revert(1)

-X <option>, --strategy-option=<option>
        git-merge(1)
        git-pull(1)

-X <strategy-option>, --strategy-option=<strategy-option>
        git-rebase(1)

-X[<param1,param2,...>], --dirstat[=<param1,param2,...>]
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-format-patch(1)
        git-log(1)
        git-reflog(1)

-x
        git-cherry-pick(1)
        git-clean(1)

-x <pattern>, --exclude=<pattern>
        git-ls-files(1)

-x <cmd>, --exec <cmd>
        git-rebase(1)

-x <command>, --extcmd=<command>
        git-difftool(1)

--xmailer, --no-xmailer
        git-send-email(1)

-y, --no-prompt
        git-difftool(1)
        git-mergetool(1)

-Z
        git-cat-file(1)

-z
        git-apply(1)
        git-cat-file(1)
        git-check-attr(1)
        git-check-ignore(1)
        git-checkout-index(1)
        git-diff(1)
        git-diff-files(1)
        git-diff-index(1)
        git-diff-tree(1)
        git-ls-files(1)
        git-ls-tree(1)
        git-merge-tree(1)
        git-mktree(1)

-z, --null
        git-commit(1)
        git-config(1)
        git-grep(1)

-z <fuzz>
        git-cvsimport(1)

--zdiff3
        git-merge-file(1)

--zero-commit
        git-format-patch(1)

--=-=-=--
