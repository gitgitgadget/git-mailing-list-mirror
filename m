From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Fix two buffer overflows and remove a redundant var
Date: Tue, 17 Dec 2013 14:43:55 +0100
Message-ID: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 14:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsv3d-0001Bn-3m
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 14:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab3LQNv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 08:51:29 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57486 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726Ab3LQNv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 08:51:28 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2013 08:51:28 EST
X-AuditID: 1207440c-b7f566d000004272-03-52b05539fe18
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.14.17010.93550B25; Tue, 17 Dec 2013 08:44:25 -0500 (EST)
Received: from michael.fritz.box (p57A24733.dip0.t-ipconnect.de [87.162.71.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBHDiIKs024888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Dec 2013 08:44:24 -0500
X-Mailer: git-send-email 1.8.5.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsUixO6iqGsZuiHIoP+wvEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGf8/nKXseAxS8Xrk5wNjHeZ
	uxg5OCQETCQmrvXvYuQEMsUkLtxbz9bFyMUhJHCZUeL2o9+sEM5xJolHb9ezgFSxCehKLOpp
	ZgKxRQTUJCa2HQKLMws4SGz+3MgIYgsLeEgc/P8XLM4ioCqx6+IJMJtXwEViyY17rBDbFCT2
	XTrJNIGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MEM/z7GD8tk7m
	EKMAB6MSD++GGeuDhFgTy4orcw8xSnIwKYnynnXZECTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJ
	hPdBIFCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTBqxIC1ChYlJqe
	WpGWmVOCkGbi4AQRXCAbeIA23AwG2VBckJhbnJkOUXSKUVFKnPc3SEIAJJFRmgc3ABajrxjF
	gf4R5lUA2cMDjG+47ldAg5mABj9fsw5kcEkiQkqqgbGjeGnCpjWL2ENiL7lsOeczp1G2iq3v
	+WzNIwaNRQwrX808zN8RtK5L9GtDZ9KawwZ27w7X/lTi3ZBS0f57Yu7Tvz8k+lbteqaxgsn4
	m+Pq3MIahXlWZ3irW/23Cxxkz+5TTEqYmsX9TbD/wK6Geb+ihOQmMv76atmzzF8igtX3/IGj
	9jxtG5VYijMSDbWYi4oTAfukwyCsAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239386>

These patches fix three things I found when I was puttering around.
The first two patches fix buffer overflows.  (They don't seem to be
exploitable.)

The third removes a redundant local variable.

The patches apply to master.

Michael Haggerty (3):
  prune-packed: fix a possible buffer overflow
  prune_object_dir(): verify that path fits in the temporary buffer
  cmd_repack(): remove redundant local variable "nr_packs"

 builtin/prune-packed.c | 4 ++--
 builtin/prune.c        | 4 +++-
 builtin/repack.c       | 6 ++----
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.8.5.1
