From: Vicent Marti <vicent@github.com>
Subject: [Announce] libgit2 v0.17.0
Date: Sat, 19 May 2012 02:00:02 +0200
Message-ID: <CAFFjANQ_kfRc8LhZD4nxeYmRML6i5dQEskUv3Caz7GmnvZi2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: libgit2@librelist.org, git-dev@github.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 02:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVX5x-00010l-Jn
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946137Ab2ESAAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:00:25 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61686 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab2ESAAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:00:23 -0400
Received: by vbbff1 with SMTP id ff1so2801636vbb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=YgTLg+cHoAP08lKZBY0dtdipej/qzIgRtK5mxaJQbRw=;
        b=XkDI/AQgFxaQtD9NvHQGVCWb7nFZ8WOFnyVTCRU1qhFv1rIwmG72jzfXCpA+d7g423
         ka8CbZPw+PckzDehpjUDMBUI4gkNNpk0wp4+yqBR4sv2lQisMttsH058CKWJEQhwGosa
         vQ271OGT3ZHafedEIfG0RH5Xz3JTqTzKhKDbWCuenVFE9qfBAHbAFCdwjFx0gT6CkQBE
         wpAn4+tVpDYXCaQ0S/CMhjR1AiW7s02LpnY4H7B3t6YznVcvPuR0aFmRd721aNvAHeCX
         mpYVdpqUzQ47aAiuRABkUVlYNwwkWeA0anSrwFJZi0Q4Za4v1SwaxWaDCGKV4dNpDvGT
         xDog==
Received: by 10.52.28.71 with SMTP id z7mr6061752vdg.105.1337385622646; Fri,
 18 May 2012 17:00:22 -0700 (PDT)
Received: by 10.52.181.229 with HTTP; Fri, 18 May 2012 17:00:02 -0700 (PDT)
X-Google-Sender-Auth: 5QJlNlkZkf8m5GAgq2Zxn-rmC3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197996>

Hello everyone,

A new libgit2 release is here. This one is huge (most new features to
date). Check out the diff API. It's shiny.

We're nearing the 1.0.0 milestone, and things are moving much faster
now. Stay tuned for more features and more projects using the library.

The release has been tagged at:

 https://github.com/libgit2/libgit2/tree/v0.17.0

A dist package can be found at:

 https://github.com/downloads/libgit2/libgit2/libgit2-0.17.0.tar.gz

Updated documentation can be found at:

 http://libgit2.github.com/libgit2/

The full change log follows after the message.

Cheers,
Vicent

=======================

libgit2 v0.17.0 "Lord of Diffstruction"

Welcome to yet another libgit2 release, this one being the
biggest we've shipped so far. Highlights on this release
include diff, branches, notes and submodules support. The new
diff API is shiny and powerful. Check it out.

Apologies, one more time, to all the early adopters for the
breaking API changes. We've been iterating on the error
handling for the library until we reached its current state,
which we believe it's significantly more usable both for normal
users and for developers of bindings to other languages.
Also, we've renamed a few legacy calls to ensure that the whole
external API uses a consistent naming scheme.

As always, check the API docs for the full list of new API calls
and backwards-incompatible changes.

	http://libgit2.github.com/libgit2/

Changelog of new features follows:

Attributes:
	- Added function macros to check attribute values instead of having
	to manually compare them
	- Added support for choosing the attribute loading order (workdir files
	vs index) and to skip the systems' default `.gitattributes`
	- Fixed issues when fetching attribute data on bare repositories

Blob:
	- Added support for creating blobs from any file on disk (not
	restricted to the repository's working directory)
	- Aded support for smudge filters when writing blobs to the ODB
		- So far only CRLF normalization is available

Branches:
	- Added a high-level branch API:
		- git_branch_create
		- git_branch_delete
		- git_branch_list
		- git_branch_move

Commit:
	- Commit messages are now filtered to match Git rules (stripping
	comments and adding proper whitespacing rules)

Config:
	- Added support for setting and getting multivars
	- Added `git_config_get_mapped` to map the value of a config
	variable based on its defaults

Diff:
	- Added full diff API:
		- tree to tree
		- index to tree
		- workdir to index
		- workdir to tree
		- blob to blob

	- Added helper functions to print the diffs as valid patchfiles

Error handling:
	- New design for the error handling API, taking into consideration
	the requirements of dynamic languages

Indexer:
	- Added streaming packfile indexer

Merge:
	- Added support for finding the merge base between two commits

Notes:
	- Full git-notes support:
		- git_note_read
		- git_note_message/git_note_oid
		- git_note_create
		- git_note_remove
		- git_note_free
		- git_note_foreach

References:
	- Added `git_reference_name_to_oid` helper to resolve
	a reference to its final OID

	- Added `git_reference_cmp` to compare two references with
	a stable order

Remotes:
	- Added support for writing and saving remotes
		- `git_remote_add`
		- `git_remote_save`
		- Setters for all the attributes of a remote
	- Switched remote download to the new streaming packfile indexer
	- Fixed fetch on HTTP and Git under Windows
	- Added `git_remote_supported_url` helper to check if a protocol
	can be accessed by the library
	- Added `git_remote_list`

Repository:
	- Made `git_repository_open` smarter when finding the `.git` folder.
	- Added `git_repository_open_ext` with extra options when
	opening a repository

Revwalk:
	- Added support for pushing/hiding several references through a glob
	- Added helper to push/hide the current HEAD to the walker
	- Added helper to push/hide a single reference to the walker

Status:
	- Greatly improved Status implementation using the new `diff` code
	as a backend

Submodules:
	- Added a partial submodules API to get information about a
	submodule and list all the submodules in a repository
		- git_submodule_foreach
		- git_submodule_lookup

Tag:
	- Added `git_tag_peel` helper to peel a tag to its pointed object
	- Tag messages are now filtered to match Git rules (stripping comments
	and adding proper whitespacing rules)

Tree:
	- Killed the old `git_tree_diff` API, which is replaced by the
	new diff code.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
