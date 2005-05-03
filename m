From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 18:29:21 -0700
Message-ID: <20050503012921.GD22038@waste.org>
References: <3YQn9-8qX-5@gated-at.bofh.it> <3ZLEF-56n-1@gated-at.bofh.it> <3ZM7L-5ot-13@gated-at.bofh.it> <3ZN3P-69A-9@gated-at.bofh.it> <3ZNdz-6gK-9@gated-at.bofh.it> <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 03:25:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSmAO-0003Ez-1a
	for gcvg-git@gmane.org; Tue, 03 May 2005 03:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVECBb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 21:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVECB3r
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 21:29:47 -0400
Received: from waste.org ([216.27.176.166]:47545 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261282AbVECB3k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 21:29:40 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j431TMnj008338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 May 2005 20:29:22 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j431TMa1008333;
	Mon, 2 May 2005 20:29:22 -0500
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Content-Disposition: inline
In-Reply-To: <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 03:16:26AM +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> > On Mon, 2 May 2005, Ryan Anderson wrote:
> >> On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> 
> >> > That said, I think the /usr/bin/env trick is stupid too. It may be more
> >> > portable for various Linux distributions, but if you want _true_
> >> > portability, you use /bin/sh, and you do something like
> >> > 
> >> > #!/bin/sh
> >> > exec perl perlscript.pl "$@"
> >> if 0;
> 
> exec may fail.
> 
> #!/bin/sh
> exec perl -x $0 ${1+"$@"} || exit 127
> #!perl
> 
> >> You don't really want Perl to get itself into an exec loop.
> > 
> > This would _not_ be "perlscript.pl" itself. This is the shell-script, and
> > it's not called ".pl".
> 
> In this thread, it originally was.

In this thread, it was originally a Python script. In particular, one
aimed at managing the Linux kernel source. I'm going to use
/usr/bin/env, systems where that doesn't exist can edit the source.

--
Mathematics is the supreme nostalgia of our time.
