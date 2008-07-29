From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/5] Allow custom merge strategies, take 3
Date: Tue, 29 Jul 2008 17:24:58 +0200
Message-ID: <cover.1217344802.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 17:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNr5I-0001WP-38
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 17:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbYG2PYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYG2PYi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 11:24:38 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46520 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbYG2PYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 11:24:37 -0400
Received: from vmobile.example.net (dsl5400FA31.pool.t-online.hu [84.0.250.49])
	by yugo.frugalware.org (Postfix) with ESMTP id C57251DDC5C;
	Tue, 29 Jul 2008 17:24:34 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2CC341AA738; Tue, 29 Jul 2008 17:25:04 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90648>

Hi,

Changes from 'take 2':

- the testcase now makes sure the trees are the same for 'theirs' as
  well.

- patch 4 and 5 are squashed so there is no compile error after applying
  only some of the patches. (or when bisecting)

- using FLEX_ARRAY in help.h

- the first two patches are unchanged

Miklos Vajna (5):
  builtin-help: make is_git_command() usable outside builtin-help
  builtin-help: make list_commands() a bit more generic
  builtin-help: make it possible to exclude some commands in
    list_commands()
  builtin-merge: allow using a custom strategy
  Add a new test for using a custom merge strategy

 Makefile                |    1 +
 builtin-merge.c         |   32 ++++++++++++++++++++-----
 help.c                  |   57 ++++++++++++++++++++++++-----------------------
 help.h                  |   19 +++++++++++++++
 t/t7606-merge-custom.sh |   46 +++++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 35 deletions(-)
 create mode 100644 help.h
 create mode 100755 t/t7606-merge-custom.sh
