From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 0/7] Enhance TkCVS interoperability
Date: Mon, 24 Mar 2008 23:48:39 +0100
Message-ID: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:49:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvTn-0002Lt-Rd
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYCXWsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbYCXWsm
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:48:42 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:55703 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753449AbYCXWsm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:48:42 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id AF91B1E4F74;
	Mon, 24 Mar 2008 23:48:40 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 916391B8E4B;
	Mon, 24 Mar 2008 23:48:40 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id EA06B8C468;
	Mon, 24 Mar 2008 23:48:39 +0100 (CET)
X-From-Line: 01e5947cde524f4eb97a86785d0e1f28e2d040e0 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78114>


This series was developed to improve interoperability between
git-cvsserver and TkCVS, a CVS client that is fairly popular at least
in some corporate environments.

Patches 1-6 are "obvious" improvements, implementing missing features
or fixing incorrect behaviour.  7 is more questionable, but likely to
result in more intelligible log output in a majority of cases.

Bear in mind that my perl-fu is not very high when reviewing this
series; suggestions are more than welcome!

        Damien

Damien Diederen (7):
  cvsserver: Respond to the 'editors' command.
  cvsserver: Only print the file part of filename in status header.
  cvsserver: Do not include status output for subdirectories if -l is
    passed.
  cvsserver: Add a few tests for 'status' command.
  cvsserver: Implemented update -p (print to stdout)
  cvsserver: Added test for update -p
  cvsserver: Use the user part of the email in log and annotate results

 git-cvsserver.perl              |   67 ++++++++++++++++++++++++++++++--------
 t/t9400-git-cvsserver-server.sh |   50 +++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 14 deletions(-)
