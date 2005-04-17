From: Paul Jackson <pj@sgi.com>
Subject: Re: optimize gitdiff-do script
Date: Sat, 16 Apr 2005 17:10:09 -0700
Organization: SGI
Message-ID: <20050416171009.0bedbab4.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com>
	<20050416234344.GQ19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:07:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxJo-000756-Es
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDQALD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVDQALD
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:11:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34521 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261212AbVDQALB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:11:01 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H1oLus011728;
	Sat, 16 Apr 2005 18:50:31 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H0ADlU15249110;
	Sat, 16 Apr 2005 17:10:13 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416234344.GQ19099@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr wrote:
> Please don't reindent the scripts. It violates the current coding style
> and the patch is unreviewable.

Sorry - I had not realized that there was a style in this case.

I am all in favor of such coding styles, and will gladly fit this one.

Do you want the patch resent, or a patch to restore indent on top of
this one?

> the patch is unreviewable.

The section that I indented the wrong way was such a total rewrite, that
you aren't going to be able to review it line by line compared to the
old anyway.  So in this case, it wasn't that I was modifying and
reindenting, rather that I was rewriting a page of code from scratch.

But that's a nit.  Honoring the coding style is necessary in any case.

> The idea behind that was that diffing could take a significant portion
> of disk space,

Here I don't understand, or don't agree, not sure which.

This won't eat more disk space, because the same tmp files are reused,
over and over.  Instead of unlinking them just before reopening them
truncating (O_WRONLY|O_CREAT|O_TRUNC), I just reopen them truncating.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
