From: Vicent Marti <vicent@github.com>
Subject: [ANNOUNCE] libgit2 v0.14.0 "watermelon wheat"
Date: Thu, 14 Jul 2011 03:34:33 +0200
Message-ID: <CAFFjANRSVJvex9v_2E_QRdJW951+CZF_w4KS_w=afYU+F9H46g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-dev@github.com
To: git@vger.kernel.org, libgit2@librelist.org
X-From: git-owner@vger.kernel.org Thu Jul 14 03:35:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhApR-0000UH-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 03:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab1GNBe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 21:34:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50249 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab1GNBe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 21:34:56 -0400
Received: by wyg8 with SMTP id 8so512397wyg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=XgEJ9ZBse4Iw7fTUANnH/6+iEgqDRZM2V49nP4jP1cg=;
        b=CrDgkRtCCf2R2t6Hig6MopEPEtUrQ+x0icp461oI8HqT64D5fk7hBQFjN/nLuuLkLJ
         Y7BV5ZcPaz0hlezaymJ3JIg5yUIJqh6x5Gaj440QjA5AwskeEDJNAQPuuZJnjEYVH7ES
         sr69NPrc32P8nMYmBGen9oDoLothDvm4ICL7s=
Received: by 10.227.208.148 with SMTP id gc20mr1496654wbb.95.1310607294000;
 Wed, 13 Jul 2011 18:34:54 -0700 (PDT)
Received: by 10.227.156.82 with HTTP; Wed, 13 Jul 2011 18:34:33 -0700 (PDT)
X-Google-Sender-Auth: Aj2p852pobBsZ0PcLG4nukUPxvI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177095>

Hello everyone,

 this minor release of libgit2 comes very feature packed. Exciting.

The release has been tagged at:

  https://github.com/libgit2/libgit2/tree/v0.14.0

A dist package can be found at:

  https://github.com/downloads/libgit2/libgit2/libgit2-0.14.0.tar.gz

Updated documentation can be found at:

   http://libgit2.github.com/libgit2/

The full change log follows after the message.

Thanks as always,
Vicent

========================

libgit2 v0.14.0, "watermelon wheat"

This a very packed minor release. The usual guilty parties have been
working harder than usual during the holidays -- thanks to everyone
involved!

As always, the updated API docs can be found at:

	http://libgit2.github.com/libgit2/

NEW FEATURES:

	- New OS abstraction layer. This should make all POSIX calls much
	more reliable under Windows.

	- Much faster writes of simple objects (commits, tags, trees) to the
	ODB via in-memory buffering and direct writes, instead of streaming.

	- Unified & simplified API for object creation. All the `create`
	methods now take Objects instead of OIDs to ensure that corrupted
	(dangling) objects cannot be created on the repository.

	- Fully Git-compilant reference renaming (finally!), with
	the already existing `git_reference_rename`.

	- Deletion of config keys with `git_config_delete`

	- Greatly improved index performance when adding new entries

	- Reflog support with the `git_reflog` API

	- Remotes support with the `git_remote` API

	- First parts of the Networking API, including refspecs and
	the transport abstraction layer. (Note that there are no actual
	transports implemented yet)

	- Status support with the `git_status_foreach` and `git_status_file`
	functions.

	- Tons of bugfixes, including the outstanding bug #127 (wrong sort
	ordering when querying tree entries).

KNOWN ISSUES:

	- The reference renaming code leaks memory. This is being worked on
	as part of a reference handling overhaul.

	- The tree-from-index builder has abysmal performance because it
	doesn't handle the Treecache extension yet. This is also being
	worked on.

FULL API CHANGELOG:

	- removed, * modified, + added

	- git_commit_create_o
	- git_commit_create_ov
	- git_reference_create_oid_f
	- git_reference_create_symbolic_f
	- git_reference_rename_f
	- git_tag_create_f
	- git_tag_create_fo
	- git_tag_create_o

	* git_commit_create
	* git_commit_create_v
	* git_config_foreach
	* git_reference_create_oid
	* git_reference_create_symbolic
	* git_reference_rename
	* git_tag_create
	* git_tag_create_frombuffer

	+ git_clearerror
	+ git_config_delete
	+ git_index_uniq
	+ git_odb_hashfile
	+ git_oid_fromstrn
	+ git_reflog_entry_byindex
	+ git_reflog_entry_committer
	+ git_reflog_entry_msg
	+ git_reflog_entry_oidnew
	+ git_reflog_entry_oidold
	+ git_reflog_entrycount
	+ git_reflog_free
	+ git_reflog_read
	+ git_reflog_write
	+ git_refspec_src_match
	+ git_refspec_transform
	+ git_remote_connect
	+ git_remote_fetchspec
	+ git_remote_free
	+ git_remote_get
	+ git_remote_ls
	+ git_remote_name
	+ git_remote_url
	+ git_repository_head_detached
	+ git_repository_head_orphan
	+ git_status_file
	+ git_status_foreach
	+ git_tag_create_lightweight
	+ git_tag_list_match
	+ git_transport_new
