From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH 0/4] Add git-pack-intersect
Date: Wed, 09 Nov 2005 02:20:59 +0100
Organization: Chalmers
Message-ID: <43714EFB.5070705@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Wed Nov 09 02:20:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZedn-0006w5-6w
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVKIBUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 20:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKIBUk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:20:40 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:1705 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030323AbVKIBUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:20:39 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 436FB1AD000616EE; Wed, 9 Nov 2005 02:20:37 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11377>

This patch series adds git-pack-intersect. It finds redundant packs
by calculating the union of all objects present in .git/objects/pack
and then computing the smallest set of packs which contain all the
objects in this union.

It is quite fast, if I may say so myself. On my AMD3200+ it manages
to minimize a linux-2.6 repository with 9 pack files totaling 430MB
in ~0.7 seconds. The remaining packfiles total 102MB, which is a nice
reduction.

git-fsck-objects reports no errors after pruning, but the algorithm is 
not proven correct so backups might be in order before this gets more
testing.

/Lukas
