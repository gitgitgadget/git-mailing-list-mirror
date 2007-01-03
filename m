From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: How to commit removed file?
Date: Wed, 3 Jan 2007 08:06:40 +0200
Message-ID: <20070103060640.GD20259@mellanox.co.il>
References: <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 07:08:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1zIX-0005OV-3k
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 07:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbXACGIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 01:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbXACGIW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 01:08:22 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:58300 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbXACGIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 01:08:21 -0500
Received: from unknown [63.251.237.3]
	by p02c11o145.mxlogic.net (mxl_mta-4.0.1-5)
	with SMTP id 5584b954.2604829616.16592.00-007.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 02 Jan 2007 23:08:21 -0700 (MST)
Received: from mtlexch01.mtl.com ([10.0.8.11]) by mtiexch01.mti.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 2 Jan 2007 22:10:01 -0800
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 3 Jan 2007 08:07:45 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  3 Jan 2007 08:04:30 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 03 Jan 2007 06:07:45.0426 (UTC) FILETIME=[7C884F20:01C72EFD]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14912.001
X-TM-AS-Result: No--14.069000-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35844>

Mutt Label Removed By VIM
> Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: How to commit removed file?
> 
> >> > I'd like to remove a file and commit the removal while
> >> > leaving out other changes in repository/index.
> >> > 
> >> > $git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
> >> > rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'
> >> > 
> >> > $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
> >> > error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did not match
> >> > any file(s) known to git.
> >> > Did you forget to 'git add'?
> >> > 
> >> > A similiar thing works with "git add".
> >> 
> >> Any ideas? Can this be done with git?
> >
> > Did you actually try the "--" thing I suggested in 
> > http://article.gmane.org/gmane.comp.version-control.git/35699/?
> >
> > Besides, I just tested with current "next": 
> >
> > $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
> > Created commit 89a5bb5ac16fb8be9b6e061284e191cafb3e4da2
> >  1 files changed, 0 insertions(+), 22 deletions(-)
> >  delete mode 100644 a234
> 
> The difference is Michael did "git rm" to explicitly tell git to
> forget about that path, while you used the vanilla "/bin/rm".
> 
> Personally I never saw the point of having "git rm".  Maybe we
> should remove it to prevent this confusion from happening.

But won't the same problem appear with

rm file
git-update-index file
git-commit file

-- 
MST
