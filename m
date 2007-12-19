From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] clone: fix options '-o' and '--origin' to be recognised
	again
Date: Wed, 19 Dec 2007 10:15:15 +0100
Message-ID: <20071219091515.GA20707@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 10:26:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4vBq-0001MU-Hn
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbXLSJZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 04:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbXLSJZm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:25:42 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:1452 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbXLSJZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 04:25:40 -0500
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2007 04:25:40 EST
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [213.84.224.214])
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBJ9FGIK051337;
	Wed, 19 Dec 2007 10:15:21 +0100 (CET)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.67)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1J4v1H-0005R3-UZ; Wed, 19 Dec 2007 10:15:15 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68872>

Due to a subtle typo in a shell case pattern neither alternative worked.

Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>
---

 This is a regression in 'next', introduced on Nov 4th by commit 94362599
 "Migrate git-clone to use git-rev-parse --parseopt". Added Kristian as
 he works on the builtin version; perhaps nice for a test case (!).

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9a160ee..b4e858c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -152,7 +152,7 @@ do
 		die "clones are always made with separate-remote layout" ;;
 	--reference)
 		shift; reference="$1" ;;
-	-o,--origin)
+	-o|--origin)
 		shift;
 		case "$1" in
 		'')
-- 
1.5.4.rc0.1162.g3bfea
