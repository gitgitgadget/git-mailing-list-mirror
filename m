From: Dave Jones <davej@redhat.com>
Subject: Re: nightly tarballs of git
Date: Sat, 16 Sep 2006 13:58:53 -0400
Message-ID: <20060916175853.GA24124@redhat.com>
References: <20060914172754.GF8013@us.ibm.com> <20060914175116.GB22279@redhat.com> <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net> <20060914193616.GA32735@redhat.com> <7virjq2oyc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 19:59:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOeRT-0000yA-Vy
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 19:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWIPR7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 13:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWIPR7A
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 13:59:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964870AbWIPR66 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 13:58:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8GHwsEM027062;
	Sat, 16 Sep 2006 13:58:54 -0400
Received: from nwo.kernelslacker.org (vpn-248-26.boston.redhat.com [10.13.248.26])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8GHwssa026850;
	Sat, 16 Sep 2006 13:58:54 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.8/8.13.7) with ESMTP id k8GHwrOM024138;
	Sat, 16 Sep 2006 13:58:54 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.8/8.13.8/Submit) id k8GHwrS7024137;
	Sat, 16 Sep 2006 13:58:53 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virjq2oyc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27122>

On Thu, Sep 14, 2006 at 01:06:03PM -0700, Junio C Hamano wrote:

 > If you are using git-tar-tree (which by the way _is_ the right
 > thing to do) and if you are just taking an upstream snapshot
 > without doing your own development (which also is the case
 > here), then you do not even need a working tree in the directory
 > this script runs.  It would save your disk space and time to
 > check out the updated working tree files.
 > 
 > Perhaps...
 > 
 > #!/bin/sh
 > URL=git://git.kernel.org/pub/scm/git/git.git
 > PROJ=git
 > 
 > cd ~/git-trees
 > if test -d "$PROJ"
 > then
 > 	cd "$PROJ" && git fetch
 > else
 > 	git clone -q -n "$URL" "$PROJ" && cd "$PROJ"
 > fi || {
 > 	echo >&2 Something wicked happend.
 >         exit $?
 > }
 > snap=git-snapshot-$(date +"%Y%m%d")
 > git-tar-tree origin $snap | gzip -9 > $PROJ-$DATE.tar.gz

This went well, right up until you checked something in :-)

Generating pack...
Done counting 155 objects.
Result has 126 objects.
Deltifying 126 objects.
   0% (1/126) done
   1% (2/126) done
   2% (3/126) done
   3% (4/126) done
   4% (6/126) done
   5% (7/126) done
   6% (8/126) done
   7% (9/126) done
   8% (11/126) done
   9% (12/126) done
  10% (13/126) done
  11% (14/126) done
  12% (16/126) done
  13% (17/126) done
  14% (18/126) done
  15% (19/126) done
  16% (21/126) done
  17% (22/126) done
  18% (23/126) done
  19% (24/126) done
  20% (26/126) done
  21% (27/126) done
  22% (28/126) done
  23% (29/126) done
  24% (31/126) done
  25% (32/126) done
  26% (33/126) done
  27% (35/126) done
  28% (36/126) done
  29% (37/126) done
  30% (38/126) done
  31% (40/126) done
  32% (41/126) done
  33% (42/126) done
  34% (43/126) done
  35% (45/126) done
  36% (46/126) done
  37% (47/126) done
  38% (48/126) done
  39% (50/126) done
  40% (51/126) done
  41% (52/126) done
  42% (53/126) done
  43% (55/126) done
  44% (56/126) done
  45% (57/126) done
  46% (58/126) done
  47% (60/126) done
  48% (61/126) done
  49% (62/126) done
  50% (63/126) done
  51% (65/126) done
  52% (66/126) done
  53% (67/126) done
  54% (69/126) done
  55% (70/126) done
  56% (71/126) done
  57% (72/126) done
  58% (74/126) done
  59% (75/126) done
  60% (76/126) done
  61% (77/126) done
  62% (79/126) done
  63% (80/126) done
  64% (81/126) done
  65% (82/126) done
  66% (84/126) done
  67% (85/126) done
  68% (86/126) done
  69% (87/126) done
  70% (89/126) done
  71% (90/126) done
  72% (91/126) done
  73% (92/126) done
  74% (94/126) done
  75% (95/126) done
  76% (96/126) done
  77% (98/126) done
  78% (99/126) done
  79% (100/126) done
  80% (101/126) done
  81% (103/126) done
  82% (104/126) done
  83% (105/126) done
  84% (106/126) done
  85% (108/126) done
  86% (109/126) done
  87% (110/126) done
  88% (111/126) done
  89% (113/126) done
  90% (114/126) done
  91% (115/126) done
  92% (116/126) done
  93% (118/126) done
  94% (119/126) done
  95% (120/126) done
  96% (121/126) done
  97% (123/126) done
  98% (124/126) done
  99% (125/126) done
 100% (126/126) done
Unpacking 126 objects
Total 126, written 126 (delta 93), reused 0 (delta 0)
* refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/git/git
  from 38529e28a4f465ad5d5f2fa249ca17da680bac5f to fc2b2be031f44aef0106cf7f872b750cd90b2253
* refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
  not updating.
Something wicked happend.



		Dave

-- 
http://www.codemonkey.org.uk
