From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] git-gui--askpass: generalize the window title
Date: Mon, 1 Feb 2016 12:11:05 +0000
Message-ID: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 13:26:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQDYz-00011N-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 13:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbcBAM01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 07:26:27 -0500
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:40021
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754076AbcBAM0X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 07:26:23 -0500
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2016 07:26:23 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1454328665;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=uCxiKTW+YEdw9SO/ypgRgmoNccC8XreNNTFP4qimqYg=;
	b=iuX/TRuOuGybwpFrf3INHa7UYAvJ3fLtXnWcbrRoSwG1ArFl2I1pCw+inNKjJ+6N
	9BKImGGj5To8NMBh8qoWeSzioLQyue5EVaeZNNl6KWZipX4Gxe7hyaGrqQLhPJmUIy8
	3U9K8MTJy0f5+VoxuW7RustgUghAwCuwPp6ZKqyw=
X-SES-Outgoing: 2016.02.01-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285200>

From: Sebastian Schuberth <sschuberth@gmail.com>

git-gui--askpass is not only used for SSH authentication, but also for
HTTPS. In that context it is confusing to have a window title of
"OpenSSH". So generalize the title so that it also says which parent
process, i.e. Git, requires authentication.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-gui/git-gui--askpass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/git-gui--askpass b/git-gui/git-gui--askpass
index 4277f30..1e5c325 100755
--- a/git-gui/git-gui--askpass
+++ b/git-gui/git-gui--askpass
@@ -60,7 +60,7 @@ proc finish {} {
 	set ::rc 0
 }
 
-wm title . "OpenSSH"
+wm title . "Git Authentication"
 tk::PlaceWindow .
 vwait rc
 exit $rc

--
https://github.com/git/git/pull/195
