From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t0006: specify timezone as EST5 not EST to comply with POSIX
Date: Tue,  6 Jul 2010 18:34:20 -0500
Message-ID: <upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
References: <20100704110017.GA23121@sigill.intra.peff.net>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Wed Jul 07 01:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWHfe-0004S8-Ha
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 01:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab0GFXfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 19:35:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53377 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0GFXfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 19:35:14 -0400
Received: by mail.nrlssc.navy.mil id o66NYTvj014013; Tue, 6 Jul 2010 18:34:29 -0500
In-Reply-To: <20100704110017.GA23121@sigill.intra.peff.net>
X-OriginalArrivalTime: 06 Jul 2010 23:34:28.0984 (UTC) FILETIME=[C71EBF80:01CB1D63]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150418>

From: Brandon Casey <drafnel@gmail.com>

POSIX requires that both the timezone "standard" and "offset" be specified
in the TZ environment variable.  This causes a problem on IRIX which does
not understand the timezone 'EST'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I guess 'EST' is an alias? for EST5EDT?  Linux and Solaris both grok EST
just fine.  POSIX says the offset is required.  I don't see any mention of
aliases.

-brandon


 t/t0006-date.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index b2df4fe..1d4d0a5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -39,7 +39,7 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
-check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST
+check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
 
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
-- 
1.6.6.2
