From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 0/2] Speedup fetch with large numbers of refs
Date: Sun, 25 Oct 2009 21:28:10 +0000
Message-ID: <20091025212449.48498.23208.julian@quantumfyre.co.uk>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 22:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Agy-0007uZ-IK
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbZJYVbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 17:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbZJYVbu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 17:31:50 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52683 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753733AbZJYVbt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 17:31:49 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0353534BFA1
	for <git@vger.kernel.org>; Sun, 25 Oct 2009 21:31:53 +0000 (GMT)
Received: (qmail 11288 invoked by uid 103); 25 Oct 2009 21:28:25 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9936. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.024015 secs); 25 Oct 2009 21:28:25 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 25 Oct 2009 21:28:25 +0000
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131237>

This is the same as v1, except that this time the tests pass on Linux
as well as on MacOS.

Julian Phillips (2):
  remote: Make ref_remove_duplicates faster for large numbers of refs
  fetch: Speed up fetch of large numbers of refs

 builtin-fetch.c |   17 ++++++++++++++---
 remote.c        |   42 +++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 22 deletions(-)
