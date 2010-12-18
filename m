From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2 0/8] docs: use metavariables consistently
Date: Sat, 18 Dec 2010 00:38:37 -0500
Message-ID: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVu-0006oi-F2
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab0LRFi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:38:58 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48114 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab0LRFi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:38:57 -0500
Received: by qyk12 with SMTP id 12so1529959qyk.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pKDpeJxcV9ASUeILMBfGNCDVj4uCKS8JxcGMadfxjZ4=;
        b=TDX2B07EVO7wkT85hxvdEQeDTWf1Uf5aeuxYywuBJl399cIzR3RaFkeHZXSE71L1j8
         IhaAIeba87/md7sXXptdHrgItfutKHFwSJSC6FtTNk0v5qt3segckWf5rSJ5VjVlgXuk
         1J+N4GthhoZXb4E9HSycFFp+yrutKUDxQXeWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iO114mQrYSyR5ESj9OwqbiitXyHdBCUal0Yjh6HnQKuaOn5ESOaLlP7webZohtVUMx
         hU03xu2nqvrGg57EQIKpeAArG3sSVuc+1bVBQg9SyMxEVJFDQKu1sy7fBqiIbvH55W81
         dRFZYFAbQrNLZJ89iUzTuwLJVXL30nKKvAJx8=
Received: by 10.229.228.2 with SMTP id jc2mr1555817qcb.177.1292650737043;
        Fri, 17 Dec 2010 21:38:57 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.38.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:38:56 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163899>

Update the documentation and usage statements to use metavariables, such as
<commit>, more consistently.  The biggest change is to drop the <tree-ish> and
<commit-ish> (or <committish>) notation and just use <tree> or <commit>, since
every command but commit-tree accepts tree-ishes and commit-ishes.  The "-ish"
terms are still kept around in various places where it makes sense to
differentiate between an actual tree or commit and a tree-ish or commit-ish.

This is a rework of my earlier patch set from March [1], with the following
differences:

- Drop the patch to commit-tree that makes it accept a tree-ish.
- Drop the patch dealing with <tag> and <tagname>.
- Leave -ish terms in comments and in places where they make sense.
- Rebase onto master (1b97434).  Some of the patches from before have since
  been accepted from other authors.
- Fix a problem that Junio noticed with the "grep docs" patch.

[1] http://kerneltrap.org/mailarchive/git/2010/3/13/25484

Mark Lodato (8):
  fsck docs: remove outdated and useless diagnostic
  docs: use `...' instead of `*' for multiplicity
  docs: use <sha1> to mean unabbreviated ID
  http-fetch docs: use <commit-id> consistently
  grep docs: grep accepts a <tree-ish>, not a <tree>
  docs: use <tree> instead of <tree-ish>
  docs: use <commit> instead of <commit-ish>
  describe docs: note that <commit> is optional

 Documentation/RelNotes/1.6.2.4.txt    |    2 +-
 Documentation/diff-format.txt         |   10 +++++-----
 Documentation/diff-generate-patch.txt |    2 +-
 Documentation/git-archive.txt         |    4 ++--
 Documentation/git-cat-file.txt        |    2 +-
 Documentation/git-checkout.txt        |   16 ++++++++--------
 Documentation/git-commit-tree.txt     |    3 ++-
 Documentation/git-describe.txt        |   15 ++++++++-------
 Documentation/git-diff-index.txt      |    4 ++--
 Documentation/git-diff-tree.txt       |   18 +++++++++---------
 Documentation/git-fast-import.txt     |   22 +++++++++++-----------
 Documentation/git-fsck.txt            |    5 +----
 Documentation/git-http-fetch.txt      |    4 ++--
 Documentation/git-ls-files.txt        |    6 +++---
 Documentation/git-ls-tree.txt         |    6 +++---
 Documentation/git-merge-index.txt     |    2 +-
 Documentation/git-merge-tree.txt      |    2 +-
 Documentation/git-name-rev.txt        |    2 +-
 Documentation/git-read-tree.txt       |   10 +++++-----
 Documentation/git-rebase.txt          |    2 +-
 Documentation/git-svn.txt             |    6 +++---
 Documentation/git-tar-tree.txt        |    4 ++--
 Documentation/git.txt                 |   27 +++++++++++++--------------
 Documentation/gitcli.txt              |    6 +++---
 Documentation/gittutorial-2.txt       |    6 ++----
 Documentation/glossary-content.txt    |    4 ++++
 archive.c                             |    4 ++--
 builtin/commit-tree.c                 |    2 +-
 builtin/describe.c                    |    4 ++--
 builtin/diff-index.c                  |    2 +-
 builtin/diff-tree.c                   |    2 +-
 builtin/ls-files.c                    |    4 ++--
 builtin/ls-tree.c                     |    2 +-
 builtin/merge-index.c                 |    2 +-
 builtin/read-tree.c                   |    2 +-
 builtin/revert.c                      |    4 ++--
 builtin/tar-tree.c                    |    2 +-
 contrib/examples/git-reset.sh         |    2 +-
 contrib/examples/git-revert.sh        |    4 ++--
 git-svn.perl                          |    6 +++---
 t/t4100/t-apply-3.patch               |    8 ++++----
 t/t4100/t-apply-7.patch               |    8 ++++----
 42 files changed, 124 insertions(+), 124 deletions(-)

-- 
1.7.3.2
