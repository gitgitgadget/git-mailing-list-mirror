From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 4/5] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 09:19:53 +0200
Message-ID: <500CFB19.6010905@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:30:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StD5s-0001dz-8x
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab2GWHaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:30:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:49529 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2GWHaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:30:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1StD5h-0001WR-W5
	for git@vger.kernel.org; Mon, 23 Jul 2012 09:30:06 +0200
Received: from p5ddb0653.dip0.t-ipconnect.de ([93.219.6.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:30:05 +0200
Received: from sschuberth by p5ddb0653.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:30:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0653.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <500CF9D2.30102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201918>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/araxis | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5..aeba1b9 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -16,5 +16,11 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	echo compare
+	# Make sure to use Araxis' "compare" and not e.g. ImageMagick's.
+	if ls "$(dirname "$(which compare)")"/Araxis* >/dev/null 2>&1
+	then
+		echo compare
+	else
+		echo "$1"
+	fi
 }
-- 
1.7.11.msysgit.2
