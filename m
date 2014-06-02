From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: 2.0.0 regression? request pull does not seem to find head
Date: Tue, 3 Jun 2014 00:01:31 +0300
Message-ID: <20140602210131.GA17171@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:01:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZLy-0007Q6-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbaFBVBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbaFBVBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:01:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s52L127x028605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 2 Jun 2014 17:01:03 -0400
Received: from redhat.com (ovpn-116-42.ams2.redhat.com [10.36.116.42])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s52L1187013088
	for <git@vger.kernel.org>; Mon, 2 Jun 2014 17:01:02 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250595>

Looks like pull requests no longer work for me on linux.
Some other trees (non-linux) work fine but I didn't yet
check whether it's the local or the remote tree that's
at issue.

Or maybe it's a configuration change that I missed?

Note: I have
[push]
        default = matching
configured in .gitconfig.

[mst@robin linux]$ git request-pull net-next/master  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next
warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
warn: Are you sure you pushed 'net-next' there?
The following changes since commit 96b2e73c5471542cb9c622c4360716684f8797ed:

  Revert "net/mlx4_en: Use affinity hint" (2014-06-02 00:18:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next

for you to fetch changes up to 2ae76693b8bcabf370b981cd00c36cd41d33fabc:

  vhost: replace rcu with mutex (2014-06-02 23:47:59 +0300)

----------------------------------------------------------------
Michael S. Tsirkin (2):
      vhost-net: extend device allocation to vmalloc
      vhost: replace rcu with mutex

 drivers/vhost/net.c   | 23 ++++++++++++++++++-----
 drivers/vhost/vhost.c | 10 +++++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)
[mst@robin linux]$ git request-pull net-next/master  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next
warn: No match for commit 2ae76693b8bcabf370b981cd00c36cd41d33fabc found at git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
warn: Are you sure you pushed 'net-next' there?
The following changes since commit 96b2e73c5471542cb9c622c4360716684f8797ed:

  Revert "net/mlx4_en: Use affinity hint" (2014-06-02 00:18:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next

for you to fetch changes up to 2ae76693b8bcabf370b981cd00c36cd41d33fabc:

  vhost: replace rcu with mutex (2014-06-02 23:47:59 +0300)

----------------------------------------------------------------
Michael S. Tsirkin (2):
      vhost-net: extend device allocation to vmalloc
      vhost: replace rcu with mutex

 drivers/vhost/net.c   | 23 ++++++++++++++++++-----
 drivers/vhost/vhost.c | 10 +++++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)
[mst@robin linux]$ git --version
git version 2.0.0.538.gb6dd70f




[mst@robin linux]$ /usr/bin/git request-pull net-next/master  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git net-next
The following changes since commit 96b2e73c5471542cb9c622c4360716684f8797ed:

  Revert "net/mlx4_en: Use affinity hint" (2014-06-02 00:18:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-next

for you to fetch changes up to 2ae76693b8bcabf370b981cd00c36cd41d33fabc:

  vhost: replace rcu with mutex (2014-06-02 23:47:59 +0300)

----------------------------------------------------------------
Michael S. Tsirkin (2):
      vhost-net: extend device allocation to vmalloc
      vhost: replace rcu with mutex

 drivers/vhost/net.c   | 23 ++++++++++++++++++-----
 drivers/vhost/vhost.c | 10 +++++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)
[mst@robin linux]$ /usr/bin/git --version
git version 1.8.3.1


-- 
MST
