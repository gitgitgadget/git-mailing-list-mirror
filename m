From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/3] jp/get-ref-dir-unsorted fixups
Date: Fri,  7 Oct 2011 22:20:19 -0500
Message-ID: <5WORKOGzj9pUA6-WazYHWoC73c8I1v5CksR-XJ592FHo27VoGczYpfodVAo5IkHADGEX_Z99bE2ZW-oMcjJ4UGTn2ajXlQjUPh1nRi12BF_tCkwU1qQ6JRoANGVSBwr8n-Q7tv0O4rA@cipher.nrlssc.navy.mil>
Cc: julian@quantumfyre.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 05:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCNTP-0002NB-8o
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 05:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1JHDU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 23:20:57 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:52790 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752898Ab1JHDU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 23:20:56 -0400
Received: by mail3.nrlssc.navy.mil id p983Knbi006444; Fri, 7 Oct 2011 22:20:49 -0500
X-OriginalArrivalTime: 08 Oct 2011 03:20:48.0369 (UTC) FILETIME=[4641F610:01CC8569]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183134>

Here are a few fixups I found while investigating a segfault on IRIX.

The first patch fixes a potential segfault due to an uninitialized
variable, but it has already been made moot by Michael Haggerty's
updates to refs.c that are merged in next.  So, not sure if it's worth
applying or not.

The second one fixes the segfault on IRIX and is a valid thing to do
anyway.

The third one plugs a little memory leak that may never occur.

Built on top of jp/get-ref-dir-unsorted e9c4c111.

-Brandon

Brandon Casey (3):
  refs.c: ensure struct whose member may be passed to realloc is
    initialized
  refs.c: abort ref search if ref array is empty
  refs.c: free duplicate entries in the ref array instead of leaking
    them

 refs.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

-- 
1.7.7
