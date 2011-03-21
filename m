From: David Barr <david.barr@cordelta.com>
Subject: [PATCHv2 00/11] vcs-svn: purge obsolete data structures and code
Date: Tue, 22 Mar 2011 10:49:49 +1100
Message-ID: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 00:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1oru-0006bP-AS
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 00:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab1CUXuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 19:50:19 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:56169 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754660Ab1CUXuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 19:50:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 438A4C055;
	Tue, 22 Mar 2011 10:46:47 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3CUUwwqaGbNC; Tue, 22 Mar 2011 10:46:37 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id A2540C051;
	Tue, 22 Mar 2011 10:46:37 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169691>

Thanks Jonathan for reviewing the series and for suggesting
a good compromise between readability and performance.

The first patch of the last version has been split into two.
Patch 6 follows the spirit of patches 4 and 5, for a consistent
approach to switching on constant strings.

 .gitignore              |    3 -
 Makefile                |   13 +--
 t/t0080-vcs-svn.sh      |  117 ------------------
 test-obj-pool.c         |  116 ------------------
 test-string-pool.c      |   31 -----
 test-treap.c            |   70 -----------
 vcs-svn/LICENSE         |    3 -
 vcs-svn/fast_export.c   |   64 +++++-----
 vcs-svn/fast_export.h   |   14 +-
 vcs-svn/obj_pool.h      |   61 ---------
 vcs-svn/repo_tree.c     |   36 ++----
 vcs-svn/repo_tree.h     |   12 +--
 vcs-svn/string_pool.c   |  113 -----------------
 vcs-svn/string_pool.h   |   12 --
 vcs-svn/string_pool.txt |   43 -------
 vcs-svn/svndump.c       |  309 ++++++++++++++++++++++++++++-------------------
 vcs-svn/trp.h           |  237 ------------------------------------
 vcs-svn/trp.txt         |  109 -----------------
 18 files changed, 237 insertions(+), 1126 deletions(-)
