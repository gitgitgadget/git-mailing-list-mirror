From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v8 0/3] gitweb: refactor If-Modified-Since handling
Date: Thu, 29 Mar 2012 08:45:46 -0400
Message-ID: <cover.1333024238.git.wking@drexel.edu>
References: <201203282328.08876.jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 15:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFgV-0003Nh-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860Ab2C2Nqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:46:30 -0400
Received: from vms173009pub.verizon.net ([206.46.173.9]:40347 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579Ab2C2NqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:46:21 -0400
X-Greylist: delayed 3610 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2012 09:46:21 EDT
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1N0042WCSGBEA0@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 29 Mar 2012 07:45:53 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 2FE4043C287; Thu,
 29 Mar 2012 08:45:51 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Thu, 29 Mar 2012 08:46:03 -0400
X-Mailer: git-send-email 1.7.3.4
In-reply-to: <201203282328.08876.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194253>

Changes since v7:
* Fix git_snapshot `-last_modified =>` switching.
* Case insensitive Last-Modified match for tree snapshot test.
* gitweb.output -> gitweb.headers in the new tests.


W. Trevor King (3):
  gitweb: add `status` headers to git_feed() responses.
  gitweb: refactor If-Modified-Since handling
  gitweb: add If-Modified-Since handling to git_snapshot().

 gitweb/gitweb.perl                       |   65 ++++++++++++++++++------------
 t/t9501-gitweb-standalone-http-status.sh |   60 +++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 27 deletions(-)

-- 
1.7.3.4
