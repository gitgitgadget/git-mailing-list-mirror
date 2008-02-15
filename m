From: Len Brown <lenb@kernel.org>
Subject: Re: warning: no common commits - slow pull
Date: Fri, 15 Feb 2008 16:43:30 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200802151643.30232.lenb@kernel.org>
References: <200802102007.38838.lenb@kernel.org> <7v4pcgcimw.fsf@gitster.siamese.dyndns.org> <20080211035501.GB26205@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 22:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8N6-0004G7-Ih
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYBOVoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 16:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbYBOVoy
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:44:54 -0500
Received: from hera.kernel.org ([140.211.167.34]:51048 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbYBOVox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2008 16:44:53 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1FLhZ4w024788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Feb 2008 21:43:37 GMT
User-Agent: KMail/1.9.5
In-Reply-To: <20080211035501.GB26205@mit.edu>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/5832/Fri Feb 15 16:26:21 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,TRACKER_ID autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73985>

it happened again.

this morning I pulled linus' tree up through 
4ee29f6a52158cea526b16a44ae38643946103ec

then during the day, linus declared "rc2".

and now I pulled linus' tree again,
which has a HEAD now of 

101142c37be8e5af9b847860219217e6b958c739

and the pull sucked down 172 MB even though the uncompressed
diff between the two is 0.3 MB.

-Len

[lenb@d975xbx2 linus (master)]$ git pull
remote: Counting objects: 649, done.
remote: Compressing objects: 100% (106/106), done.
remote: Total 513 (delta 417), reused 503 (delta 407)
Receiving objects: 100% (513/513), 116.67 KiB, done.
Resolving deltas: 100% (417/417), completed with 103 local objects.
warning: no common commits
remote: Counting objects: 710725, done.
remote: Compressing objects: 100% (125738/125738), done.
remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
Resolving deltas: 100% (589584/589584), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2
Updating 4ee29f6..101142c
Fast forward
 Makefile                               |    4 +-
 drivers/bluetooth/hci_ldisc.c          |    1 +
 drivers/net/8139too.c                  |    2 +-
 drivers/net/Kconfig                    |   18 +
 drivers/net/Makefile                   |    3 +-
 drivers/net/cxgb3/l2t.c                |    2 +-
 drivers/net/cxgb3/sge.c                |   35 +-
 drivers/net/dm9000.c                   |  654 +++++---
 drivers/net/e1000/e1000_main.c         |   18 +-
 drivers/net/forcedeth.c                |  132 +-
 drivers/net/netconsole.c               |    4 +-
 drivers/net/ni52.c                     | 1142 +++++++-------
 drivers/net/ni52.h                     |  158 +-
 drivers/net/pcnet32.c                  |   48 +-
 drivers/net/phy/fixed.c                |    4 +-
 drivers/net/ps3_gelic_net.c            | 1215 ++++++++------
 drivers/net/ps3_gelic_net.h            |  415 ++++--
 drivers/net/ps3_gelic_wireless.c       | 2753 ++++++++++++++++++++++++++++++++
 drivers/net/ps3_gelic_wireless.h       |  329 ++++
 drivers/net/r6040.c                    |  233 ++--
 drivers/net/sis190.c                   |    3 +-
 drivers/s390/net/claw.h                |   19 +-
 drivers/s390/net/lcs.c                 |    2 +-
 drivers/s390/net/lcs.h                 |   16 +-
 drivers/s390/net/netiucv.c             |   29 +-
 fs/compat.c                            |    3 -
 fs/nfs/callback.c                      |   18 +-
 fs/nfs/dir.c                           |    8 +-
 fs/nfs/nfs4state.c                     |    4 +-
 fs/nfs/super.c                         |    4 +
 include/linux/dm9000.h                 |    2 +
 include/linux/netdevice.h              |    8 +-
 include/net/ax25.h                     |    2 +
 include/net/ndisc.h                    |    1 -
 include/net/xfrm.h                     |    5 +-
 net/ax25/af_ax25.c                     |   12 +-
 net/ax25/ax25_dev.c                    |    2 +-
 net/ax25/ax25_ds_timer.c               |   12 +-
 net/ax25/ax25_route.c                  |   28 +-
 net/ax25/ax25_timer.c                  |   60 +-
 net/core/dev.c                         |    4 +-
 net/core/neighbour.c                   |   12 +-
 net/core/rtnetlink.c                   |   36 +-
 net/core/skbuff.c                      |    3 +-
 net/ipv4/ah4.c                         |    2 +-
 net/ipv4/arp.c                         |    3 -
 net/ipv4/esp4.c                        |    5 +-
 net/ipv4/fib_trie.c                    |   99 +-
 net/ipv4/inet_hashtables.c             |    3 -
 net/ipv4/ip_sockglue.c                 |    5 -
 net/ipv6/ah6.c                         |    2 +-
 net/ipv6/esp6.c                        |    5 +-
 net/ipv6/ip6_output.c                  |    6 +-
 net/ipv6/xfrm6_output.c                |    2 +-
 net/key/af_key.c                       |    1 +
 net/netfilter/nf_conntrack_proto_tcp.c |    2 +-
 net/netfilter/xt_SECMARK.c             |    2 +-
 net/netlabel/netlabel_domainhash.c     |    6 +-
 net/netlabel/netlabel_unlabeled.c      |   30 +-
 net/netlabel/netlabel_user.c           |    3 +-
 net/netlink/genetlink.c                |    6 +-
 net/socket.c                           |    3 +
 net/xfrm/Kconfig                       |    2 +-
 net/xfrm/xfrm_input.c                  |    4 +-
 net/xfrm/xfrm_output.c                 |    2 +-
 net/xfrm/xfrm_user.c                   |    1 +
 66 files changed, 5686 insertions(+), 1971 deletions(-)
 create mode 100644 drivers/net/ps3_gelic_wireless.c
 create mode 100644 drivers/net/ps3_gelic_wireless.h
[lenb@d975xbx2 linus (master)]$            
[lenb@d975xbx2 linus (master)]$ git --version
git version 1.5.4.1.122.gaa8d
                
