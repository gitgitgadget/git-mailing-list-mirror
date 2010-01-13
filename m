From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 0/7] Gitweb caching v4
Date: Wed, 13 Jan 2010 01:34:35 -0800
Message-ID: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 10:34:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzcq-0004Oi-73
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab0AMJer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268Ab0AMJeq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:34:46 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57264 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab0AMJep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:34:45 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0D9Yg1R018510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 01:34:44 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 01:34:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136796>

Evening everyone,
 
This is the latest incarnation of gitweb w/ caching.  This is
finally at the point where it should probably start either being
considered for inclusion or mainline, or I need to accept that this
will never get in and more perminantely fork (as is the case with
Fedora where this is going in as gitweb-caching as a parrallel rpm
package).

That said this brings the base up to mainline (again), it updates a
number of elements in the caching engine, and this is a much cleaner
break-out of the tree vs. what I am currently developing against.

v4:
	- major re-working of the caching layer to use file handle
	  redirection instead of buffering output
	- other minor improvements
v3:
	- various minor re-works based on mailing list feedback,
	  this series was not sent to the mailing list.
v2:
	- Better breakout
	- You can actually disable the cache now

- John 'Warthog9' Hawley 


John 'Warthog9' Hawley (7):
  gitweb: Load checking
  gitweb: Add option to force version match
  gitweb: Makefile improvements
  gitweb: Optionally add "git" links in project list page
  gitweb: Convert output to using indirect file handle
  gitweb: add a get function to compliment print_local_time
  gitweb: File based caching layer (from git.kernel.org)

 Makefile           |   91 ++---
 gitweb/Makefile    |  129 +++++++
 gitweb/README      |   14 +-
 gitweb/cache.pm    |  283 +++++++++++++++
 gitweb/gitweb.css  |    6 +
 gitweb/gitweb.perl | 1021 ++++++++++++++++++++++++++++++----------------------
 6 files changed, 1052 insertions(+), 492 deletions(-)
 create mode 100644 gitweb/Makefile
 create mode 100644 gitweb/cache.pm
