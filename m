From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/3] gitk: save only changed configuration on exit
Date: Thu, 11 Sep 2014 08:21:25 +0300
Message-ID: <1410412888-10187-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 07:22:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRwpe-0002U7-Eo
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 07:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbaIKFWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 01:22:05 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:51632
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992AbaIKFWE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 01:22:04 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id phMx1o00J5B68XE01hN1b7; Wed, 10 Sep 2014 22:22:03 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256832>

gitk rewrites whole its config on exit. This is inconvenient when there are
several instances running - if user changes something in one instance, it may
be discarded depending of the order of closing that instances.

Change saving so that it saves only changed data and tried to preserve other
existing data in configuration.

Max Kirillov (3):
  gitk refactor: remove boilerplate for configuration variables
  gitk: write only changed configuration variables
  gitk: merge views with existing ones

 gitk | 159 ++++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 86 insertions(+), 73 deletions(-)

-- 
2.0.1.1697.g73c6810
