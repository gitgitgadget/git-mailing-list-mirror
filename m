From: "=?ISO-8859-1?Q?Niklas_H=F6glund?=" <nhoglund@gmail.com>
Subject: git and file name case on cygwin
Date: Sat, 3 Feb 2007 22:00:40 +0000
Message-ID: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 23:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSw8-0002R4-KC
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 23:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXBCWAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXBCWAm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 17:00:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:53380 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbXBCWAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 17:00:42 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1660711nfa
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 14:00:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bppn8NcWbtIRQ8Pn/kcR/G92RxEh/zgSz/4ffFJMx2yFkkzvIBGE/U2r6j0UCGYGKqF8t+AzMKLozVuSGWjIpvDVBwllrieBVbIzaTWt3G3FqkAqJP+gwFQ0KP5QfZaw/n6UumsPAMvPoQKZQjLZ2Ybxb44yYN2WZH7ktNBHrKc=
Received: by 10.82.152.16 with SMTP id z16mr1700225bud.1170540040325;
        Sat, 03 Feb 2007 14:00:40 -0800 (PST)
Received: by 10.82.178.20 with HTTP; Sat, 3 Feb 2007 14:00:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38612>

There's something funny going on with git in cygwin. The following is
in a clone of linux 2.6, with no local modifications (only the
occasional pull from upstream).

Niklas Hoglund@NIKLAS /c/linux-2.6
$ git pull
remote: Generating pack...
remote: Done counting 220 objects.
remote: Result has 154 objects.
remote: Deltifying 154 objects.
remote:  100% (154/154) done
Unpacking 154 objects
remote: Total 154, written 154 (delta 124), reused 105 (delta 86)
 100% (154/154) done
* refs/heads/origin: fast forward to branch 'master' of
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
  old..new: a7ec3f5..05a8057
Updating a7ec3f5..05a8057
include/linux/netfilter/xt_CONNMARK.h: needs update
include/linux/netfilter/xt_DSCP.h: needs update
include/linux/netfilter/xt_MARK.h: needs update
include/linux/netfilter_ipv4/ipt_CONNMARK.h: needs update
include/linux/netfilter_ipv4/ipt_DSCP.h: needs update
include/linux/netfilter_ipv4/ipt_ECN.h: needs update
include/linux/netfilter_ipv4/ipt_MARK.h: needs update
include/linux/netfilter_ipv4/ipt_TCPMSS.h: needs update
include/linux/netfilter_ipv4/ipt_TOS.h: needs update
include/linux/netfilter_ipv4/ipt_TTL.h: needs update
include/linux/netfilter_ipv6/ip6t_HL.h: needs update
include/linux/netfilter_ipv6/ip6t_MARK.h: needs update
net/ipv4/netfilter/ipt_ECN.c: needs update
net/ipv4/netfilter/ipt_TOS.c: needs update
net/ipv4/netfilter/ipt_TTL.c: needs update
net/ipv6/netfilter/ip6t_HL.c: needs update
net/netfilter/xt_CONNMARK.c: needs update
net/netfilter/xt_DSCP.c: needs update
net/netfilter/xt_mark.c: needs update
Fast forward
 MAINTAINERS                         |    6 +-
 arch/i386/kernel/acpi/boot.c        |    2 +-
 drivers/acpi/ec.c                   |    2 +-
 drivers/hid/Kconfig                 |   18 +++-
 drivers/net/Space.c                 |   11 --
 drivers/net/ifb.c                   |    4 +-
 drivers/net/loopback.c              |    4 +-
 drivers/net/sungem.c                |    3 +-
 drivers/net/sungem_phy.c            |  179 ++++++++++++++++++++++++++++++-----
 drivers/net/sungem_phy.h            |    7 +-
 drivers/usb/input/Kconfig           |    6 +-
 drivers/video/backlight/corgi_bl.c  |    2 +-
 drivers/video/backlight/hp680_bl.c  |    2 +-

Niklas Hoglund@NIKLAS /c/linux-2.6
$ git status
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
#       modified:   include/linux/netfilter/xt_MARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_CONNMARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_DSCP.h
#       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
#       modified:   include/linux/netfilter_ipv4/ipt_MARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TOS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_MARK.h
#       modified:   net/ipv4/netfilter/ipt_ECN.c
#       modified:   net/ipv4/netfilter/ipt_TOS.c
#       modified:   net/ipv4/netfilter/ipt_TTL.c
#       modified:   net/ipv6/netfilter/ip6t_HL.c
#       modified:   net/netfilter/xt_CONNMARK.c
#       modified:   net/netfilter/xt_DSCP.c
#       modified:   net/netfilter/xt_mark.c
#
nothing to commit

Niklas Hoglund@NIKLAS /c/linux-2.6
$ git reset --hard

Niklas Hoglund@NIKLAS /c/linux-2.6
$ git pull
Already up-to-date.

Niklas Hoglund@NIKLAS /c/linux-2.6
$ git status
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   include/linux/netfilter/xt_connmark.h
#       modified:   include/linux/netfilter/xt_dscp.h
#       modified:   include/linux/netfilter/xt_mark.h
#       modified:   include/linux/netfilter_ipv4/ipt_connmark.h
#       modified:   include/linux/netfilter_ipv4/ipt_dscp.h
#       modified:   include/linux/netfilter_ipv4/ipt_ecn.h
#       modified:   include/linux/netfilter_ipv4/ipt_mark.h
#       modified:   include/linux/netfilter_ipv4/ipt_tcpmss.h
#       modified:   include/linux/netfilter_ipv4/ipt_tos.h
#       modified:   include/linux/netfilter_ipv4/ipt_ttl.h
#       modified:   include/linux/netfilter_ipv6/ip6t_hl.h
#       modified:   include/linux/netfilter_ipv6/ip6t_mark.h
#       modified:   net/ipv4/netfilter/ipt_ecn.c
#       modified:   net/ipv4/netfilter/ipt_tos.c
#       modified:   net/ipv4/netfilter/ipt_ttl.c
#       modified:   net/ipv6/netfilter/ip6t_hl.c
#       modified:   net/netfilter/xt_MARK.c
#       modified:   net/netfilter/xt_connmark.c
#       modified:   net/netfilter/xt_dscp.c
#
nothing to commit

Notice how all the files in the above list changed case since the
previous invocation of git status.

The above has the unfortunate effect that the merge in a pull often
refuses to run, requiring "git reset --hard origin" to update the
working tree.
