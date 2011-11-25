From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 0/3] fast-import: Fix incremental use of notes
Date: Fri, 25 Nov 2011 01:09:44 +0100
Message-ID: <1322179787-4422-1-git-send-email-johan@herland.net>
References: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, johan@herland.net
To: grubba@grubba.org
X-From: git-owner@vger.kernel.org Fri Nov 25 02:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTkJ1-0006dq-Tj
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 02:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab1KYBKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 20:10:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55121 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab1KYBKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 20:10:04 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2011 20:10:04 EST
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600HCOWGOGC60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:00 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 0C8E61799062_ECEDCD8B	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:00 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id EA61E1796257_ECEDCD7F	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:09:59 +0000 (GMT)
Received: from alpha.herland ([84.208.177.71]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600D70WGNSC30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:09:59 +0100 (MET)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185921>

Hi,

This is a first attempt at fixing the bug reported by Henrik.

The first two patches provide testcases for the bug, and the last patch
provides a fix.

Have fun! :)

...Johan


Johan Herland (3):
  t9301: Fix testcase covering up a bug in fast-import's notes fanout handling
  t9301: Add 2nd testcase exposing bugs in fast-import's notes fanout handling
  fast-import: Fix incorrect fanout level when modifying existing notes refs

 fast-import.c                |   28 ++++++++++++++++--
 t/t9301-fast-import-notes.sh |   63 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 83 insertions(+), 8 deletions(-)

-- 
1.7.5.rc1.3.g4d7b
