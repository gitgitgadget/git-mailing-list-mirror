From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH v2 0/2] post-receive-email configurable rev display
Date: Mon,  3 Nov 2008 23:19:52 -0800
Message-ID: <1225783194-24640-1-git-send-email-pgit@pcharlan.com>
References: <7v7i7kthkc.fsf@gitster.siamese.dyndns.org>
Cc: Pete Harlan <pgit@pcharlan.com>
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 08:21:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxGED-0007yx-VF
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 08:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYKDHT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 02:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbYKDHT4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 02:19:56 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:46332 "EHLO
	swarthymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752028AbYKDHT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2008 02:19:56 -0500
Received: from localhost.localdomain (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a6.g.dreamhost.com (Postfix) with ESMTP id C4E471063D7;
	Mon,  3 Nov 2008 23:19:54 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.533.ge0502
In-Reply-To: <7v7i7kthkc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100047>

This is the second version of the user-configurable revision display
patch.  The first version decreased the efficiency of the default
case, while this avoids it thanks to a suggestion by Junio.

The first version of this patch also failed to customize the display
of revisions included in newly-created branches; this version displays
those revisions in the same manner as for updated branches.

The two places (new vs. updated branches) where the original code
displayed revisions used similar code.  The first patch in this series
factors that out to a separate routine that handles both cases, in
order to avoid duplicating the code introduced in the second patch.

Pete Harlan (2):
  contrib/hooks/post-receive-email: Put rev display in separate
    function
  contrib/hooks/post-receive-email: Make revision display configurable

 contrib/hooks/post-receive-email |   57 ++++++++++++++++++++++++++++++++------
 1 files changed, 48 insertions(+), 9 deletions(-)
