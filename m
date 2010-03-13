From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 00/12] docs: use metavariables consistently
Date: Fri, 12 Mar 2010 23:52:52 -0500
Message-ID: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMf-0007qX-Ne
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab0CMExa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:30 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:41193 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab0CMExP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:15 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447877qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YOF/gIRCrBEdUjezK6OLFYbYtIB9ar+NDJaDSEZN7V0=;
        b=YonFQFXlo02BIWnIHFEOh5nQeAAf9JmkKuURTSw7dp5aM4lZfCDIb76q1kSQtFPQTP
         uLduT1jzfOBOx6ggj2FqpabPd4vm5nhQDwNUoUgd6yjiKFgWcDc+Dl6OoclWYGcspjkW
         zkqAGyrtga24B//U2hQrzThUNCC9FNk3dnd50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UMYeO2Opkn3jolC00lKc1TR5sQCGoiwEpi27Zq6fxAR6RmRjDyB04VwUZXU998hCbg
         gQb7Now9xsdD6PBgF5GiqYGVqiAKUGij52BWF2UbiqOw8FOrDgivYQLv2yFylc6RUubE
         XptkYxTPpIhIflB01lvV4nOqz6BTg9jf9AVQM=
Received: by 10.229.26.135 with SMTP id e7mr3026999qcc.58.1268455992107;
        Fri, 12 Mar 2010 20:53:12 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:11 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142078>

Based on master, 90a2bf9ca155c8e0e43d9e30197d9562dd02ea96.

This patch series is an attempt to make the documentation and usage
statements consistent in how metavariables [1], such as <commit>, are
used.  The biggest changes are to get rid of the terms <commit-ish> and
<tree-ish>, and instead prefer simple <commit> and <tree>.  It ends up
that almost all commands, with the exception of git-commit-tree, accept
the -ish versions of these objects.  The first patch --- which should be
the only non-trivial change to actual code --- modifies commit-tree to
accept any tree-ish.  The rest of the patches should all be confined to
documentation, usage statements, or code comments.

I submit this as an "RFC" because I don't expect this to be accepted
right away.  The change set is fairly large, and I imagine some of these
changes will meet resistance.  My overall goal is to make the
documentation consistent and readable throughout, and I hope that this
series makes progress toward that end.

[1] I say "metavariable", from Python's optparse, for lack of a better
term.

Mark Lodato (12):
  commit-tree: allow indirect tree references
  grep docs: grep accepts a <tree-ish>, not a <tree>
  fsck docs: remove outdated and useless diagnostic
  docs: use <sha1> to mean unabbreviated ID
  docs: differentiate between <tag> and <tagname>
  docs: clarify <object>, <commit>, <tree-ish>, etc
  docs: use <tree> instead of <tree-ish>
  http-fetch docs: use <commit-id> consistently
  docs: use <commit> instead of <commit-ish>
  diff: use brackets for optional args in usage
  docs: use ... instead of * for multiplicity
  diff docs: remove <rev>{0,2} notation

 Documentation/RelNotes-1.6.2.4.txt           |    2 +-
 Documentation/diff-format.txt                |    8 ++--
 Documentation/diff-generate-patch.txt        |    2 +-
 Documentation/git-archive.txt                |    4 +-
 Documentation/git-checkout-index.txt         |    2 +-
 Documentation/git-checkout.txt               |   14 ++++----
 Documentation/git-commit-tree.txt            |    2 +-
 Documentation/git-describe.txt               |   14 ++++----
 Documentation/git-diff-index.txt             |    4 +-
 Documentation/git-diff-tree.txt              |   18 +++++-----
 Documentation/git-diff.txt                   |    4 +-
 Documentation/git-difftool.txt               |    2 +-
 Documentation/git-fast-import.txt            |   22 ++++++------
 Documentation/git-for-each-ref.txt           |    2 +-
 Documentation/git-fsck.txt                   |    5 +--
 Documentation/git-http-fetch.txt             |    4 +-
 Documentation/git-ls-files.txt               |    8 ++--
 Documentation/git-ls-tree.txt                |    4 +-
 Documentation/git-merge-index.txt            |    2 +-
 Documentation/git-mergetool.txt              |    2 +-
 Documentation/git-name-rev.txt               |    2 +-
 Documentation/git-pack-objects.txt           |    2 +-
 Documentation/git-push.txt                   |    2 +-
 Documentation/git-read-tree.txt              |    4 +-
 Documentation/git-rebase.txt                 |    2 +-
 Documentation/git-relink.txt                 |    2 +-
 Documentation/git-shortlog.txt               |    2 +-
 Documentation/git-tar-tree.txt               |    4 +-
 Documentation/git-update-index.txt           |    4 +-
 Documentation/git.txt                        |   45 ++++++++++++++----------
 Documentation/gitcli.txt                     |    2 +-
 Documentation/howto/revert-branch-rebase.txt |    2 +-
 Documentation/pull-fetch-param.txt           |    2 +-
 archive.c                                    |    4 +-
 builtin/commit-tree.c                        |   15 +++++---
 builtin/describe.c                           |    4 +-
 builtin/diff-index.c                         |    2 +-
 builtin/diff-tree.c                          |    2 +-
 builtin/diff.c                               |    2 +-
 builtin/ls-files.c                           |    4 +-
 builtin/ls-tree.c                            |    2 +-
 builtin/merge-index.c                        |    2 +-
 builtin/merge.c                              |    2 +-
 builtin/pack-objects.c                       |    2 +-
 builtin/push.c                               |    2 +-
 builtin/revert.c                             |    4 +-
 builtin/tar-tree.c                           |    2 +-
 contrib/examples/git-merge.sh                |    2 +-
 contrib/examples/git-reset.sh                |    2 +-
 contrib/examples/git-revert.sh               |    4 +-
 fast-import.c                                |   16 ++++----
 git-svn.perl                                 |    2 +-
 remote.c                                     |    4 +-
 t/t1101-commit-tree-indirect.sh              |   49 ++++++++++++++++++++++++++
 t/t4100/t-apply-3.patch                      |    8 ++--
 t/t4100/t-apply-7.patch                      |    8 ++--
 56 files changed, 200 insertions(+), 144 deletions(-)
 create mode 100755 t/t1101-commit-tree-indirect.sh
