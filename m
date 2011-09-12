From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [PATCH v2] git-svn: teach git-svn to populate svn:mergeinfo
Date: Mon, 12 Sep 2011 10:24:22 -0400
Organization: White Oak Technologies
Message-ID: <20110912102422.21aa6570@robyn.woti.com>
References: <20110907133605.07ecad1b@robyn.woti.com>
	<20110909222159.GA6530@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R37Qy-0003Yp-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 16:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab1ILOYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 10:24:25 -0400
Received: from mail02.woti.us ([66.92.158.6]:38043 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757026Ab1ILOYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 10:24:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id A2C80504D37F1;
	Mon, 12 Sep 2011 10:24:23 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohPuPj4waWSv; Mon, 12 Sep 2011 10:24:23 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 0D14D504D37EC;
	Mon, 12 Sep 2011 10:24:23 -0400 (EDT)
In-Reply-To: <20110909222159.GA6530@dcvr.yhbt.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181215>

On Fri, 9 Sep 2011 15:21:59 -0700
Eric Wong <normalperson@yhbt.net> wrote:

> Some comments inline, but I can clean them up myself and push out in a
> bit.
> 
> > --- a/Documentation/git-svn.txt
> > +++ b/Documentation/git-svn.txt
> > @@ -213,6 +213,14 @@ discouraged.
> >  	store this information (as a property), and svn clients
> > starting from version 1.5 can make use of it. 'git svn' currently
> > does not use it and does not set it automatically.
> 
> I noticed this conflicts when applying due to the missing --mergeinfo=
> documentation.  Did you intend to remove --mergeinfo entirely and
> replace it with this?  I think some folks already depend on it (it's
> been around since last year).

No, that was me munging my patch base. Feel free to set the
documentation for mergeinfo however you like, even documenting this
feature if you wish. The functionality of --mergeinfo still should work
with this patch, although obviously if it's provided the
auto-population will be bypassed.

> > +	if (not defined($push_merge_info)
> > +			or $push_merge_info eq "false"
> > +			or $push_merge_info eq "no"
> > +			or $push_merge_info eq "never") {
> 
> I missed this the first time, but "||" and "!" are easier for
> C programmers to understand and higher in precedence (ref: perlop
> manpage)
> 

You're right, "||" and "!" are better here. TMTOWTDI is the Perl motto,
no? A double-edged sword.

Thanks for the help and review. I'll let you do the cleanup and push
the resulting patch when you feel it's ready (as you suggested), rather
than iterating again for these small changes.

Bryan Jacobs
