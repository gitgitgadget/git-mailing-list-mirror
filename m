From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH 0/2] Add support for GIT_ONE_FILESYSTEM (resubmission)
Date: Tue, 16 Mar 2010 15:04:59 -0700
Message-ID: <1268777101-22122-1-git-send-email-lars@pixar.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 23:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nretk-00059Q-Vp
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 23:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab0CPWFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 18:05:10 -0400
Received: from nmx.pixar.com ([199.108.77.23]:56101 "EHLO nmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab0CPWFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 18:05:08 -0400
X-PixarMID: 1918612
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.49,652,1262592000"; 
   d="scan'208";a="1918612"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by nimbus.pixar.com with ESMTP; 16 Mar 2010 15:05:03 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2GM520S022158
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 15:05:02 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2GM52HI022156
	for git@vger.kernel.org; Tue, 16 Mar 2010 15:05:02 -0700
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142356>


Hi all,

I incorporated the feedback I got into a new patch for
GIT_ONE_FILESYSTEM. It uses git_env_bool, doesn't do getenv calls within
the loop, and reports better error messages.

git_env_bool was marked static in config.c, so I had to remove that to
make it available in setup.c.

Lars R. Damerow (2):
      config.c: remove static keyword from git_env_bool()
      Add support for GIT_ONE_FILESYSTEM

 Documentation/git.txt |    3 +++
 cache.h               |    1 +
 config.c              |    2 +-
 setup.c               |   17 ++++++++++++++++-
 4 files changed, 21 insertions(+), 2 deletions(-)
