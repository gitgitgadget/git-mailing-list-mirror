From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/2] add support for per branch merge policy
Date: Thu, 20 Sep 2007 14:53:07 +0200
Message-ID: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 14:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLWr-0001bz-79
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 14:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbXITMxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 08:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755104AbXITMxF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 08:53:05 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:61100 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936AbXITMxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 08:53:04 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8KCqe62013119;
	Thu, 20 Sep 2007 14:52:40 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58773>

These two patches extends git-merge with the options --ff and --no-ff,
and uses the configuration setting branch.<name>.integrationonly to
select the default policy per branch (it obviously defaults to --ff), as
mentioned in http://article.gmane.org/gmane.comp.version-control.git/41980

This can also be used as a clean solution to the problem related to
fast-forward merges between git-svn tracking branches, especially if
git-svn could be taught to set integrationonly=true on all relevant
branches whenever this setting is undefined.

Diffstat:

 Documentation/config.txt        |    7 +++
 Documentation/git-svn.txt       |   17 ++++++
 Documentation/merge-options.txt |   13 +++++
 git-merge.sh                    |   30 ++++++++++-
 t/t6029-merge-integration.sh    |  108 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 3 deletions(-)
