From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH v3 0/3] Improve use of select in http backend
Date: Fri,  4 Nov 2011 15:19:24 +0100
Message-ID: <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se, peff@peff.net,
	Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 15:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMKd4-0005K4-3s
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 15:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab1KDOUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 10:20:05 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:44608 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab1KDOUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 10:20:04 -0400
Received: from localhost.localdomain (krlh-5f71f726.pool.mediaWays.net [95.113.247.38])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 3060F249C2BB;
	Fri,  4 Nov 2011 15:20:02 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.35.gd9f16.dirty
In-Reply-To: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184770>

Changes since v2:
- Properly signed off
- Incorporated Jeff's suggestion of getting rid of data_received
  altogether

And yes, this is just a performance improvement, not a bugfix.

Mika Fischer (3):
  http.c: Use curl_multi_fdset to select on curl fds instead of just
    sleeping
  http.c: Use timeout suggested by curl instead of fixed 50ms timeout
  http.c: Rely on select instead of tracking whether data was received

 http.c |   42 +++++++++++++++++++++++-------------------
 http.h |    1 -
 2 files changed, 23 insertions(+), 20 deletions(-)

-- 
1.7.8.rc0.35.gd9f16.dirty
