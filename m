From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH next] t7407: use 'cut' utility rather than bash's substring expansion notation
Date: Wed, 19 Aug 2009 20:24:52 -0500
Message-ID: <QHfHFS_5JGiL-O8GMDfdfscFUdxV1xVObzr6e5LPleagDRd7bCg8I9YUwL9xkbgM64vyf_EVLLg@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 20 03:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdwPC-0005A1-HG
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 03:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZHTBZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 21:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbZHTBZS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 21:25:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55479 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZHTBZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 21:25:17 -0400
Received: by mail.nrlssc.navy.mil id n7K1P9Pj014125; Wed, 19 Aug 2009 20:25:09 -0500
X-OriginalArrivalTime: 20 Aug 2009 01:25:08.0721 (UTC) FILETIME=[0E1C7610:01CA2135]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126599>

From: Brandon Casey <drafnel@gmail.com>

The substring expansion notation is a bashism that we have not so far
adopted.  There is precedence for using the 'cut' utility for extracting
a substring.  So do so here.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7407-submodule-foreach.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index de1730d..44ea8ac 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -207,8 +207,8 @@ cat > expect <<EOF
  $nested2sha1 nested1/nested2 (heads/master)
  $nested3sha1 nested1/nested2/nested3 (heads/master)
  $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
- $sub1sha1 sub1 (${sub1sha1:0:7})
- $sub2sha1 sub2 (${sub1sha1:0:7})
+ $sub1sha1 sub1 ($(echo $sub1sha1 | cut -c 1-7))
+ $sub2sha1 sub2 ($(echo $sub1sha1 | cut -c 1-7))
  $sub3sha1 sub3 (heads/master)
 EOF
 
-- 
1.6.4
