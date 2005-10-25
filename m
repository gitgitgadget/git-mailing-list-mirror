From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Add usage string to git-update-index
Date: Tue, 25 Oct 2005 17:26:25 +0200
Message-ID: <20051025152625.17299.10333.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 17:30:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUQh6-0005vI-Br
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 17:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVJYP03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJYP03
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 11:26:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42700 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932184AbVJYP02 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 11:26:28 -0400
Received: (qmail 17311 invoked from network); 25 Oct 2005 17:26:25 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 25 Oct 2005 17:26:25 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10591>

This patch adds usage string to git-update-index, can be printed by the -h
or --help parameter.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 update-index.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/update-index.c b/update-index.c
index a84836b..661b86a 100644
--- a/update-index.c
+++ b/update-index.c
@@ -392,6 +392,9 @@ static void read_index_info(int line_ter
 	}
 }
 
+static const char update_index_usage[] =
+"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--cacheinfo] [--chmod=(+|-)x] [--info-only] [--force-remove] [--stdin] [--index-info] [--ignore-missing] [-z] [--version] [--] <file>...";
+
 int main(int argc, const char **argv)
 {
 	int i, newfd, entries, has_errors = 0, line_termination = '\n';
@@ -489,6 +492,8 @@ int main(int argc, const char **argv)
 				verbose = 1;
 				continue;
 			}
+			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
+				usage(update_index_usage);
 			die("unknown option %s", path);
 		}
 		update_one(path, prefix, prefix_length);
