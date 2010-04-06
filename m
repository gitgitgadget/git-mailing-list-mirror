From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 0/6] Make the string_list API consistent
Date: Tue, 06 Apr 2010 02:11:32 +0100
Message-ID: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 03:29:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyxbY-0001M8-Mt
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab0DFB3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:29:01 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:45402 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756545Ab0DFB2q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 21:28:46 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id D6FE1819C455;
	Tue,  6 Apr 2010 02:28:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 4032320C8F0;
	Tue,  6 Apr 2010 02:28:44 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id E+EcYuvJVO8X; Tue,  6 Apr 2010 02:28:43 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id E3C5617773B;
	Tue,  6 Apr 2010 02:28:43 +0100 (BST)
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144081>

Currently most, but not all, string_list functions take the list as the first
argument.  This series changes the remaining functions to also take the
string_list as the first argument which should make it easier to use the API.

The extensive use of string_lists does make this series both a bit large and a
bit fragile for an API clean-up though.  Perhaps making it more trouble than
it's worth?

BTW: The basis for this series was the tip of pu at the time (f5e0e0a7), there
didn't seem much point in trying to do it for master or next ...

Julian Phillips (6):
  string_list: Fix argument order for print_string_list
  string_list: Fix argument order for for_each_string_list
  string_list: Fix argument order for string_list_insert
  string_list: Fix argument order for string_list_insert_at_index
  string_list: Fix argument order for string_list_lookup
  string_list: Fix argument order for string_list_append

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
 wt-status.c                                 |    8 ++--
 29 files changed, 147 insertions(+), 147 deletions(-)
