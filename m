From: Dave Nicolson <david.nicolson@gmail.com>
Subject: [PATCH 1/2] Do not output whitespace on blank lines
Date: Sun, 29 May 2016 15:36:21 +0000
Message-ID: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 18:13:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b73LV-00005a-U1
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 18:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcE2QNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 12:13:39 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:35261
	"EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932244AbcE2QNi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 12:13:38 -0400
X-Greylist: delayed 2235 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 May 2016 12:13:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1464536181;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=FW1D5SBDTcR5Ktil6Orbd3mJhSoCcid2yn/ZeyRL98A=;
	b=EAYh3oEhGCYK1NqyepHQJ/TCEk4Bm5gd1IkwTxS7zb8STu4XN9wEpPhPlW2OXWfd
	n1d1K8PspvT60QgBW4+6XvO6n5phOaHuYNlmwrB8fELL1FqqOix1KxLDChT3TCqv7k8
	e9PKeitSEPROr6b9QqtdJT0LiZRvXcNxTxm5a3FY=
X-SES-Outgoing: 2016.05.29-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295834>

---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index d3734d3..459b36a 100644
--- a/diff.c
+++ b/diff.c
@@ -471,7 +471,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
 		if (has_trailing_carriage_return)
 			len--;
-		nofirst = 0;
+		nofirst = len == 0 && (char)first == ' ' ? 1 : 0;
 	}
 
 	if (len || !nofirst) {

--
https://github.com/git/git/pull/245
