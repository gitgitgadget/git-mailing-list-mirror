From: Daniel Drake <dsd@gentoo.org>
Subject: git-read-tree: fatal: Entry 'Kbuild' not uptodate. Cannot merge.
Date: Wed, 12 Jul 2006 23:35:30 +0100
Message-ID: <44B57932.4090708@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 13 00:30:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0nDU-00051B-9h
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 00:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGLW3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 18:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGLW3l
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 18:29:41 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:16651 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751043AbWGLW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 18:29:40 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060712222938.NCPC27023.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 12 Jul 2006 23:29:38 +0100
Received: from [192.168.0.2] (really [86.14.216.162])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20060712222938.FLGQ17397.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>
          for <git@vger.kernel.org>; Wed, 12 Jul 2006 23:29:38 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23800>

Hi,

I'm having problems trying to merge one branch into another.

$ git --version
git version 1.4.1

$ git branch
* master
   origin
   rf-al7230b
   softmac-experimental

$ git checkout softmac-experimental

$ git diff

$ git pull . master
Merging HEAD with fd0fad8005cb8bfee0225ea04595d915639539e1
Merging:
9b1099f2d6686397ec6b98725afb62051ca6c421 BSS info change handling
fd0fad8005cb8bfee0225ea04595d915639539e1 Merge branch 'wireless-dev'
found 2 common ancestor(s):
a65c077e5fa4ba6d27f87f26b629a5c36ac8181b Justify the existance of 
basic/mandatory rate registers
62fbc2bb68a98d40c53cc07f80e36707e5a84bcc Merge branch 
'softmac-suggest-txrate' into wireless-dev
   Merging:
   a65c077e5fa4ba6d27f87f26b629a5c36ac8181b Justify the existance of 
basic/mandatory rate registers
   62fbc2bb68a98d40c53cc07f80e36707e5a84bcc Merge branch 
'softmac-suggest-txrate' into wireless-dev
   found 1 common ancestor(s):
   19ff9003ab13ff90c55c60a5bb7dd2ddc4d89685 Remove VENDOR_ defines
   Auto-merging zd_mac.c
git-read-tree: fatal: Entry 'Kbuild' not uptodate. Cannot merge.

$ git diff
diff --git a/Kbuild b/Kbuild
diff --git a/zd_chip.c b/zd_chip.c
diff --git a/zd_chip.h b/zd_chip.h
diff --git a/zd_def.h b/zd_def.h
diff --git a/zd_ieee80211.c b/zd_ieee80211.c
diff --git a/zd_ieee80211.h b/zd_ieee80211.h
diff --git a/zd_mac.c b/zd_mac.c
diff --git a/zd_mac.h b/zd_mac.h
diff --git a/zd_netdev.c b/zd_netdev.c
diff --git a/zd_rf.c b/zd_rf.c
diff --git a/zd_rf.h b/zd_rf.h
diff --git a/zd_rf_al2230.c b/zd_rf_al2230.c
diff --git a/zd_rf_rf2959.c b/zd_rf_rf2959.c
diff --git a/zd_usb.c b/zd_usb.c
diff --git a/zd_usb.h b/zd_usb.h
diff --git a/zd_util.c b/zd_util.c
diff --git a/zd_util.h b/zd_util.h

Now, I think I've seen this once or twice before, and I think I solved 
it by checking out all those files listed by "git diff" one by one.

However, when I try this now, the list produced by "git diff" shrinks 
and grows as I check more of them out, and I can't seem to get it down 
to 0 again.

I have also tried the -f flags for checkout and pull, no difference.

What's going on?

Thanks,
Daniel
