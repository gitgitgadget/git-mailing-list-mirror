From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v7 0/3] gitweb: refactor If-Modified-Since handling
Date: Wed, 28 Mar 2012 13:44:15 -0400
Message-ID: <cover.1332956550.git.wking@drexel.edu>
References: <20120328164513.GA4389@odin.tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 19:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCwuz-00061X-7S
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355Ab2C1RoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 13:44:16 -0400
Received: from vms173017pub.verizon.net ([206.46.173.17]:54327 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158Ab2C1RoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 13:44:16 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L00LL6VXOWJ60@vms173017.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 12:44:13 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id C8BCE43B264; Wed,
 28 Mar 2012 13:44:10 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 28 Mar 2012 13:44:27 -0400
X-Mailer: git-send-email 1.7.3.4
In-reply-to: <20120328164513.GA4389@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194149>

Changed since v6:
* Don't set a Last-Modified header when it has no value.


p.s. the `From` issues with v6 were due to a missing

  FromLineOverride=YES

in my sSMTP config ;).


W. Trevor King (3):
  gitweb: add `status` headers to git_feed() responses.
  gitweb: refactor If-Modified-Since handling
  gitweb: add If-Modified-Since handling to git_snapshot().

 gitweb/gitweb.perl                       |   65 ++++++++++++++++++------------
 t/t9501-gitweb-standalone-http-status.sh |   60 +++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 27 deletions(-)

-- 
1.7.3.4
