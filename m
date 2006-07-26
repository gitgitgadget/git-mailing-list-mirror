From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 20:39:24 +0200
Message-ID: <200607262039.25155.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org,
	junkio@cox.net, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 26 20:39:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oI9-0000K5-4R
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWGZSja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWGZSja
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:39:30 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:33235 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1161026AbWGZSja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 14:39:30 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 8EA262742;
	Wed, 26 Jul 2006 20:39:28 +0200 (MEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24234>

On Wednesday 26 July 2006 19:41, Johannes Schindelin wrote:
> 
> If dir2 already exists, git-mv should move dir1 _into_dir2/.
> Noticed by Jon Smirl.

Thanks for adding this test.
BTW, the original PERL script passes it quite fine.

I just looked at Jon's problem. Doesn't seem to be related to
git-mv or git at all, but more a cogito problem.
I have some cogito-0.18pre installed, and cg-patch is patching
the stuff all itself, not using git for this. Pasky?

Doing the same with git, i.e. in a rep with existing dir/

 mkdir new
 git mv dir new
 git diff --cached -M -C >patch
 git reset --hard
 git apply <patch

However, "git status" shows the "new/" directory totally
untracked afterwards. Is this expected?

Josef
