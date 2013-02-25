From: Greg Price <price@MIT.EDU>
Subject: [PATCH] describe: Document --match pattern format
Date: Mon, 25 Feb 2013 00:29:01 -0500
Message-ID: <20130225052900.GH5688@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 06:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9qhs-0006l8-Fe
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab3BYFeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:34:07 -0500
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:56311 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743Ab3BYFeG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 00:34:06 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2013 00:34:06 EST
X-AuditID: 12074422-b7f5c6d000000545-75-512af69f9e9a
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 05.76.01349.F96FA215; Mon, 25 Feb 2013 00:29:03 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id r1P5T3VL025525;
	Mon, 25 Feb 2013 00:29:03 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r1P5T1ih025708;
	Mon, 25 Feb 2013 00:29:02 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixG6nrjv/m1agwc8rJhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfGk+7NLAXN7BWXV05hbWB8ztrFyMEhIWAiseuW
	dBcjJ5ApJnHh3nq2LkYuDiGBfYwSs/60s4MkhAQ2Mkp8+6kCkfjMKHHwYTNYgkVAVWLCx6Os
	IDabgILEj/nrmEFsEQFxibfHZ4LVMAuoSbRvmgJWIyxgJdF54yALyGJeIPvOI0OQMK+AoMTJ
	mU9YIMq1JG78e8kEUsIsIC2x/B8HSFhUQEXi2v52tgmM/LOQdMxC0jELoWMBI/MqRtmU3Crd
	3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2M4CB0UdrB+POg0iFGAQ5GJR5ejeVagUKsiWXF
	lbmHGCU5mJREeW9/BQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4dUMBcrxpiRWVqUW5cOkpDlY
	lMR5r6Xc9BcSSE8sSc1OTS1ILYLJynBwKEnwrgIZKliUmp5akZaZU4KQZuLgBBnOAzT8IUgN
	b3FBYm5xZjpE/hSjopQ470WQhABIIqM0D64XliReMYoDvSLM+xukigeYYOC6XwENZgIZrKMO
	MrgkESEl1cDYWKbIcIS9ePk7T9/7MV4a3EG8l5/r6UezLjx+8PK2A1yZMtcufo73fm0UJrGg
	0qVcpY3FVc7P/dC2mQtfeJkIWPI9rOMVX/zXbZFrvrFsZJdkgp2L74Yv7xYJHhZ4/LDZZHrt
	X46dK8+ITWiSqZjv2s4306k794LIzZWRwXFTF7D7N4p3fFRiKc5INNRiLipOBAAi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217029>

It's not clear in git-describe(1) what kind of "pattern" should be
passed to --match.  Fix that.

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/git-describe.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 72d6bb6..711040d 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -81,8 +81,9 @@ OPTIONS
 	that points at object deadbee....).
 
 --match <pattern>::
-	Only consider tags matching the given pattern (can be used to avoid
-	leaking private tags made from the repository).
+	Only consider tags matching the given `glob(7)` pattern,
+	excluding the "refs/tags/" prefix.  This can be used to avoid
+	leaking private tags from the repository.
 
 --always::
 	Show uniquely abbreviated commit object as fallback.
-- 
1.7.11.3
