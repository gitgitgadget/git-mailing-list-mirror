From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Thu, 09 Mar 2006 15:20:16 -0800
Message-ID: <7vslpr2ojz.fsf@assigned-by-dhcp.cox.net>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	<20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com>
	<20060301145105.GB3313@spearce.org>
	<b0943d9e0603010708l72cb14d1w@mail.gmail.com>
	<20060301155043.GA3706@spearce.org>
	<b0943d9e0603091400o2cd0291h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 10 00:20:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHUQh-0005yu-R3
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 00:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCIXUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 18:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWCIXUU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 18:20:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47557 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932090AbWCIXUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 18:20:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309231856.CRVG15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 18:18:56 -0500
To: "Catalin Marinas" <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0603091400o2cd0291h@mail.gmail.com> (Catalin Marinas's
	message of "Thu, 9 Mar 2006 22:00:25 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17440>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> Trying to implement this, I've just noticed that git-read-tree has a
> --aggressive option which takes care of the file removals. Adding this
> option lowered the pushing time in StGIT from ~2 min to under 2
> seconds (merges between 2.6.14 and the latest kernel). There's
> probably no need to deal with file removals in pg--merge-all anymore.

Yup, it was originally done to improve the performance of
resolve merge strategy, but I am glad somebody else has found
use for it.
