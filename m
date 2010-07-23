From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/2] make git installation footprint smaller
Date: Fri, 23 Jul 2010 12:50:43 -0500
Message-ID: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 19:51:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMOp-0004qA-TC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab0GWRvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:51:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55136 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab0GWRu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:50:59 -0400
Received: by mail.nrlssc.navy.mil id o6NHovNF018595; Fri, 23 Jul 2010 12:50:58 -0500
X-OriginalArrivalTime: 23 Jul 2010 17:50:57.0372 (UTC) FILETIME=[9AAA19C0:01CB2A8F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151558>

Ever wonder where that extra 5MB of disk space went that you thought you
had?  Well, it turns out that git isn't being quite as space-efficient as
it could be.  Some files that could be installed as links are instead being
installed as full copies of the original.

With these two patches, we shrink the installation footprint of git by
making hard or symbolic links for non-builtin programs and for those binaries
installed in the bin directory.  We already do this for binaries installed
in libexec.  This can reduce the size of a git installation on the order of
10-30%.  Probably about 5-10MB.  Whoopee!!!

Enjoy.

Brandon Casey (2):
  Makefile: link builtins residing in bin directory to main git binary
    too
  Makefile: make hard/symbolic links for non-builtins too

 Makefile |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.7.2
