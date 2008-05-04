From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 0/3] log --graph and rev-list --graph
Date: Sun,  4 May 2008 03:36:51 -0700
Message-ID: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 12:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsbbk-0006nZ-1f
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 12:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbYEDKh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 06:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbYEDKhW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 06:37:22 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:50467 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455AbYEDKg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 06:36:56 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 86DD21B4037;
	Sun,  4 May 2008 06:36:55 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 61FBC1B4009;
	Sun,  4 May 2008 06:36:55 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 417FB14100C1; Sun,  4 May 2008 03:36:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.128.gc15ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81164>

This patch series adds a new --graph option to the log and rev-list
commands.  This is pretty much the same code that I sent out in early
April, but updated to work with the log entry termination fixes in the
latest master branch.

Adam Simpkins (3):
  revision API: split parent rewriting and parent printing options
  Add history graph API
  log and rev-list: add --graph option

 Documentation/rev-list-options.txt            |   10 +
 Documentation/technical/api-history-graph.txt |  179 +++++
 Makefile                                      |    2 +
 builtin-rev-list.c                            |   52 ++-
 graph.c                                       |  903 +++++++++++++++++++++++++
 graph.h                                       |  121 ++++
 log-tree.c                                    |   80 ++-
 revision.c                                    |   33 +-
 revision.h                                    |    9 +-
 9 files changed, 1369 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/technical/api-history-graph.txt
 create mode 100644 graph.c
 create mode 100644 graph.h
