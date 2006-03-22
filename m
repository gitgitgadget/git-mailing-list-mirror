From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Wed, 22 Mar 2006 08:21:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603220820090.26286@g5.osdl.org>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net> <86y7z3mdcz.fsf@blue.stonehenge.com>
 <86hd5rma75.fsf@blue.stonehenge.com> <7vacbjawyu.fsf@assigned-by-dhcp.cox.net>
 <867j6nm47b.fsf@blue.stonehenge.com> <7v64m7av6o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 17:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM65Y-0003oX-Pa
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 17:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWCVQVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 11:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWCVQVd
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 11:21:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751350AbWCVQVd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 11:21:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2MGLSDZ018376
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 08:21:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2MGLNKp006188;
	Wed, 22 Mar 2006 08:21:25 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64m7av6o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17816>



On Tue, 21 Mar 2006, Junio C Hamano wrote:

> merlyn@stonehenge.com (Randal L. Schwartz) writes:
> 
> >>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> >
> >>> But this wastes a commit.  Is there any way to get an index that simply
> >>> includes the file from that other branch?
> >
> > Junio>         $ git checkout master
> > Junio>         $ git checkout next git-cvsimport.perl
> >
> > Yow.  How simple is *that*?  Thanks.
> 
> There is one thing you would want to be careful about.
> This updates the index.

Yes. Btw, I've been bitten by that. I think it might be better to _not_ 
update the index when we check out a file from another branch than the one 
we're on (or rather, we should perhaps update the index with the value 
from the current branch every time, even though the _working_tree_ is 
updated from another branch)

		Linus
