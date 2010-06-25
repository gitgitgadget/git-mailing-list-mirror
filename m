From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 0/7] Make the string_list API consistent
Date: Sat, 26 Jun 2010 00:41:32 +0100
Message-ID: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkG-0004gB-Dr
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab0FYXzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:22 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39015 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756551Ab0FYXzU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:20 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 49F4081A9177;
	Sat, 26 Jun 2010 01:20:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 047D81EC123;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8PxgKbXL2y6M; Sat, 26 Jun 2010 00:45:44 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id CF1841EBDAA;
	Sat, 26 Jun 2010 00:45:43 +0100 (BST)
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149716>

This is an re-roll of the series to make all the string_list functions take the
list as the first argument that I sent back in April.  The first 6 patches are
based on master as of a few minutes ago.  The last patch fixes up the only extra
string_list_...  calls in next, which are from the jn/grep-open topic (they are
all string_list_append so patch 7 could be squashed into patch 6).

Julian Phillips (7):
  string_list: Fix argument order for print_string_list
  string_list: Fix argument order for for_each_string_list
  string_list: Fix argument order for string_list_insert
  string_list: Fix argument order for string_list_insert_at_index
  string_list: Fix argument order for string_list_lookup
  string_list: Fix argument order for string_list_append
  grep: fix string_list_append calls

 Documentation/technical/api-string-list.txt |    4 +-
 builtin/apply.c                             |   10 ++--
 builtin/commit.c                            |    2 +-
 builtin/fast-export.c                       |    4 +-
 builtin/fetch.c                             |   18 ++++----
 builtin/fmt-merge-msg.c                     |   18 ++++----
 builtin/grep.c                              |    6 +-
 builtin/log.c                               |   20 ++++----
 builtin/ls-files.c                          |    2 +-
 builtin/mailsplit.c                         |    2 +-
 builtin/mv.c                                |    2 +-
 builtin/receive-pack.c                      |    4 +-
 builtin/remote.c                            |   68 +++++++++++++-------------
 builtin/rerere.c                            |    2 +-
 builtin/shortlog.c                          |    4 +-
 builtin/show-ref.c                          |    2 +-
 diff-no-index.c                             |    2 +-
 http-backend.c                              |    6 +-
 mailmap.c                                   |    8 ++--
 merge-recursive.c                           |   24 +++++-----
 notes.c                                     |   12 ++--
 reflog-walk.c                               |    4 +-
 remote.c                                    |    6 +-
 rerere.c                                    |   10 ++--
 resolve-undo.c                              |    8 ++--
 revision.c                                  |    4 +-
 string-list.c                               |   18 ++++----
 string-list.h                               |   16 +++---
 transport-helper.c                          |    4 +-
 wt-status.c                                 |   10 ++--
 30 files changed, 150 insertions(+), 150 deletions(-)
