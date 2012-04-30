From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] [PATCH] The tests should not fail if log.date or log.decorate are set.
Date: Mon, 30 Apr 2012 12:25:49 +0200
Message-ID: <87mx5t349e.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 12:26:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOnnt-00029w-2p
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 12:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab2D3KZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 06:25:55 -0400
Received: from smtp.opera.com ([213.236.208.81]:46357 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab2D3KZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 06:25:55 -0400
Received: from centurion.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3UAPonN015064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 10:25:50 GMT
Received: by centurion.linkoping.osa (Postfix, from userid 1000)
	id 6C97FB9A07F; Mon, 30 Apr 2012 12:25:49 +0200 (CEST)
CC: ceder@lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196547>

Explicitly set log.date and log.decorate to their Git default values,
so that git produces the expected output even if log.date and
log.decorate are set by the user in his .gitconfig.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/scaffold |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/regression/scaffold b/regression/scaffold
index b38a3f0..546d8c6 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -83,6 +83,10 @@ function setup_git_repo
 	git add def
 	git commit -s -m "initial" 2> /dev/null > /dev/null
 	# the commit should be d4850419ccc1146c7169f500725ce504b9774ed0
+
+	# Explicitly set config that the tests rely on.
+	git config log.date default
+	git config log.decorate no
 }
 
 function setup_guilt_repo
-- 
1.7.10
