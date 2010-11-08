From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/7] add description parameter to standard option macros
Date: Mon, 08 Nov 2010 18:53:27 +0100
Message-ID: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 18:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFVug-0007nz-BR
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 18:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab0KHRxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 12:53:45 -0500
Received: from india601.server4you.de ([85.25.151.105]:33819 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab0KHRxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 12:53:44 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id A59502F807B;
	Mon,  8 Nov 2010 18:53:42 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160951>

This patch series is meant to improve the command line help texts
for standard options.

The first three patches add a description parameter to three helper
macros.  This allows command specific help texts to be defined for them
instead of enforcing ones that just repeat the option name.

	[PATCH 1/7] add description parameter to OPT__VERBOSE
	[PATCH 2/7] add description parameter to OPT__DRY_RUN
	[PATCH 3/7] add description parameter to OPT__QUIET

The next patch adds a similar helper macro for -f/--force.  It makes
it easier to define such an option in a consistent way.

	[PATCH 4/7] add OPT__FORCE

The last three patches depend on the first one and replace the standard
help text with a (hopefully) better explanation.

	[PATCH 5/7] archive: improve --verbose description
	[PATCH 6/7] branch: improve --verbose description
	[PATCH 7/7] verify-tag: document --verbose

Further patches to improve the remaining occurrences of "be verbose"
etc. are encouraged. :-)

 Documentation/git-verify-tag.txt              |    4 ++++
 Documentation/technical/api-parse-options.txt |    9 ++++++---
 archive.c                                     |    2 +-
 builtin/add.c                                 |    6 +++---
 builtin/apply.c                               |    2 +-
 builtin/branch.c                              |    5 +++--
 builtin/checkout-index.c                      |    5 ++---
 builtin/checkout.c                            |    4 ++--
 builtin/clean.c                               |    6 +++---
 builtin/commit.c                              |    6 +++---
 builtin/count-objects.c                       |    2 +-
 builtin/fetch.c                               |    3 +--
 builtin/fsck.c                                |    2 +-
 builtin/gc.c                                  |    2 +-
 builtin/grep.c                                |    4 ++--
 builtin/log.c                                 |    2 +-
 builtin/merge-file.c                          |    2 +-
 builtin/mv.c                                  |    4 ++--
 builtin/notes.c                               |    9 ++++-----
 builtin/prune.c                               |    5 ++---
 builtin/read-tree.c                           |    2 +-
 builtin/remote.c                              |    4 ++--
 builtin/reset.c                               |    2 +-
 builtin/rm.c                                  |    6 +++---
 builtin/show-ref.c                            |    2 +-
 builtin/symbolic-ref.c                        |    2 +-
 builtin/tag.c                                 |    2 +-
 builtin/update-server-info.c                  |    3 +--
 builtin/verify-tag.c                          |    2 +-
 parse-options.h                               |    7 ++++---
 test-parse-options.c                          |    6 +++---
 test-sha1.sh                                  |   14 ++++++++------
 32 files changed, 71 insertions(+), 65 deletions(-)
