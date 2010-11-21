From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Status of the svn remote helper project (Nov 2010, #2)
Date: Sun, 21 Nov 2010 00:31:49 -0600
Message-ID: <20101121063149.GA15449@burratino>
References: <20101107112129.GA30042@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 07:37:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK3YV-000420-Op
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 07:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab0KUGcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 01:32:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47200 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0KUGcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 01:32:03 -0500
Received: by yxf34 with SMTP id 34so3503256yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 22:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k+2LvxMM27zztcqcdQzRrlfClxfESQEPmP3B+3tQzD4=;
        b=ByYtcFUfgS8v9KVNDm3GC2ABnOhvU6Dg/b2L/yW7Qj9pYYwh+ARYiXurx6skIyDB3W
         d+nGWqC/YdXvh3spg4gA+IVk8V0z/WcbabTSQnaMd/NAYGzu2tllSc+MRNQBtZBaJUnZ
         Z0KHeohTmjwk3sQlhhdT3Pm5VjNwGLB5kMh8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TdNrprlKRlrZLwGg5vfIWb4pYiLCRRw8epZhFbln4V6EcnD7wTM9JhvqnLDGoeSGJP
         ToUrwaBuLp9d3+G65ck8TSt6QSUOEEF/ioPN59eiSE1Wsi3crIG6pBezX9w8bpRYwNv6
         mwQAfShpsiHhi1/zsd7mXeyb6dTUqCJgRo9oQ=
Received: by 10.151.111.12 with SMTP id o12mr3576002ybm.82.1290321120826;
        Sat, 20 Nov 2010 22:32:00 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w5sm2366989ybe.22.2010.11.20.22.31.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 22:31:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101107112129.GA30042@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161859>

Not much to see here.  There are lots of patches waiting for review;
still especially noteworthy are Tomas's fast-import changes.

Incremental updates after a one-shot conversion by svn-fe are not
supported yet.  A map from git revisions to svn revision numbers would
be needed for that, preferrably such that the time to look up the HEAD
commit does not scale with the number of revisions.

A merge of the branches listed below is available as

	git://repo.or.cz/git/jrn.git vcs-svn-pu

and individual topic branches are also available in that repository
in the refs/topics namespace.  Please try to base your work on just
the topic branches you use; vcs-svn-pu itself is rebuilt each time it
is updated.

Complaints of all kinds welcome.

--------------------------------------------------
[Cooking]
* jn/svndiff0 (2010-11-06) 24 commits
 - vcs-svn: Allow deltas to copy from preimage
 - vcs-svn: Reject deltas that read past end of preimage
 - vcs-svn: Let deltas use data from postimage
 - vcs-svn: Reject deltas that do not consume all inline data
 - vcs-svn: Check declared number of output bytes
 - vcs-svn: Implement copyfrom_data delta instruction
 - vcs-svn: Read instructions from deltas
 - vcs-svn: Read inline data from deltas
 - vcs-svn: Read the preimage while applying deltas
 - vcs-svn: Skeleton of an svn delta parser
 - compat: helper for detecting unsigned overflow
 - vcs-svn: Learn to check for SVN\0 magic
 - vcs-svn: Learn to parse variable-length integers
 - vcs-svn: Add code to maintain a sliding view of a file
 - vcs-svn: Allow character-oriented input
 - vcs-svn: Allow input errors to be detected early
 - vcs-svn: Let callers peek ahead to find stream end
 - vcs-svn: Add binary-safe read() function
 - vcs-svn: Improve support for reading large files
 - vcs-svn: Make buffer_skip_bytes() report partial reads
 - vcs-svn: Teach line_buffer to handle multiple input files
 - vcs-svn: Collect line_buffer data in a struct
 - vcs-svn: Replace buffer_read_string() memory pool with a strbuf
 - vcs-svn: Eliminate global byte_buffer[] array

Well tested.  It's a library without a user except test-svn-fe -d, but
aside from that detail, this series should be ready for wide use.

* db/fast-import-cat-blob (2010-11-07) 3 commits
 - fast-import: Allow cat-blob requests at arbitrary points in stream
 - fast-import: let importers retrieve blobs
 - fast-import: clarify documentation of "feature" command
 - fast-import: stricter parsing of integer options

There are plans for an additional command to print information in
ls-tree format about a path.

* db/recognize-v3 (2010-11-20) 2 commits
 - vcs-svn: Allow simple v3 dumps (no deltas yet)
 - vcs-svn: Error out for v3 dumps

A bugfix and the framework for a feature.

* db/prop-delta (2010-11-20) 16 commits
 - vcs-svn: Simplify handling of deleted properties
 - vcs-svn: Implement Prop-delta handling
 - vcs-svn: Sharpen parsing of property lines
 - vcs-svn: Split off function for handling of individual properties
 - vcs-svn: Make source easier to read on small screens
 - vcs-svn: More dump format sanity checks
 - vcs-svn: Reject path nodes without Node-action
 - vcs-svn: Delay read of per-path properties
 - vcs-svn: Combine repo_replace and repo_modify functions
 - vcs-svn: Replace = Delete + Add
 - vcs-svn: handle_node: Handle deletion case early
 - vcs-svn: Use mark to indicate nodes with included text
 - vcs-svn: Unclutter handle_node by introducing have_props var
 - vcs-svn: Eliminate node_ctx.mark global
 - vcs-svn: Eliminate node_ctx.srcRev global
 - vcs-svn: Check for errors from open()
 (this branch uses db/recognize-v3.)

Needs review and testing.

* db/text-delta (2010-11-20) 10 commits
 - svn-fe: Test script for handling of dumps with --deltas
 - vcs-svn: Implement text-delta handling
 - Merge branch 'db/fast-import-cat-blob' into db/text-delta
 - vcs-svn: Teach line_buffer about temporary files
 - vcs-svn: Let caller set up sliding window for delta preimage
 - vcs-svn: Read delta preimage from file descriptor
 - vcs-svn: Introduce fd_buffer routines
 - vcs-svn: Introduce repo_read_path to check the content at a path
 - vcs-svn: Internal fast_export_save_blob helper
 - Merge branch 'jn/svndiff0' into db/text-delta
 (this branch uses db/recognize-v3, db/prop-delta, db/fast-import-cat-blob,
  and jn/svndiff0.)

A delta in r36 of <http://svn.apache.org/repos/asf> does not apply
with this brand of svn-fe.

* rr/svnfe-tests-no-perl (2010-11-07) 1 commit
 - t9010 (svn-fe): Eliminate dependency on svn perl bindings

Sent to list; hopefully will be in jch and we can stop tracking it
soon.

* jn/thinner-wrapper (2010-11-06) 7 commits
 - Remove pack file handling dependency from wrapper.o
 - pack-objects: mark file-local variable static
 - wrapper: give zlib wrappers their own translation unit
 - strbuf: move strbuf_branchname to sha1_name.c
 - path helpers: move git_mkstemp* to wrapper.c
 - wrapper: move odb_* to environment.c
 - wrapper: move xmmap() to sha1_file.c

>From pu.

* xx/thinner-wrapper-svndiff0 (2010-11-07) 2 commits
 - svn-fe: stop linking to libz and libxdiff
 - Merge branch 'jn/svndiff0' into xx/thinner-wrapper-svndiff0
 (this branch uses jn/thinner-wrapper and jn/svndiff0.)

---------------------------------------------------
[Dropped]
* db/svn-fe-dumpfile3 (2010-11-07) 6 commits
 - vcs-svn: apply node text deltas
 - Merge branch 'jn/svndiff0' into db/svn-fe-dumpfile3
 - Merge branch 'db/fast-import-cat-blob' into db/svn-fe-dumpfile3
 - vcs-svn: Add output file param to buffer_copy_bytes()
 - vcs-svn: Find basis for deltified nodes; apply node prop deltas
 - vcs-svn: Teach dump parser about new header types
 (this branch uses jn/svndiff0 and db/fast-import-cat-blob.)

Ejected in favor of db/recognize-v3, db/prop-delta, and db/text-delta.

--------------------------------------------------
[Not picked up yet]

* db/branch-mapper: $gmane/158375
 . contrib/svn-fe: Fast script to remap svn history

Sent comments.  The choices this script makes can be arbitrary at
times.

* tc/remote-helper-usability: $gmane/157860
 . Register new packs after the remote helper is done fetching
 . Properly record history of the notes ref
 . Fix ls-remote output when displaying impure refs
 . Add git-remote-svn
 . Introduce the git fast-import-helper
 . Rename get_mode() to decode_tree_mode() and export it
 . Allow the transport fetch command to add additional refs
 . Allow more than one keepfile in the transport
 . Remote helper: accept ':<value> <name>' as a response to 'list'

The fourth-from-top seems a bit hard to review.  If it really is
necessary to introduce a separate program with a separate interface,
maybe a compile-time flag to choose between them would help?

* rr/remote-helper: http://github.com/artagnon/git
 . remote-svn: Write in fetch functionality
 . run-command: Protect the FD 3 from being grabbed
 . remote-svn: Build a pipeline for the import using svnrdump
 . run-command: Extend child_process to include a backchannel FD
 . Allow the transport fetch command to add additional refs
 . Remote helper: accept ':<value> <name>' as a response to 'list'
 . test-svn-fe: Allow for a dumpfile on stdin
 . contrib/svn-fe: Fast script to remap svn history
 . Add Tom's remote helper for reference
 . Add a stubby remote-svn remote helper
 . Add a correct svndiff applier

Work in progress, waiting on lower levels to be more functional
(in particular, svn-fe does not support incremental imports yet).

* sb/svn-fe-example: $gmane/159054
