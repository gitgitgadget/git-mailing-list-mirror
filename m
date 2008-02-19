From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 09:11:11 -0600
Message-ID: <47BAF18F.5040709@freescale.com>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRU9X-0002P9-Gx
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 16:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbYBSPM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 10:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbYBSPM1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 10:12:27 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:40518 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbYBSPM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 10:12:26 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m1JFBCc5000248;
	Tue, 19 Feb 2008 08:11:12 -0700 (MST)
Received: from [10.214.72.212] (mvp-10-214-72-212.am.freescale.net [10.214.72.212])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m1JFBBsl004206;
	Tue, 19 Feb 2008 09:11:11 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LNX.1.00.0802182317520.5816@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74414>

Daniel Barkalow wrote:
> This allows users with different preferences for access methods to the
> same remote repositories to rewrite each other's URLs by pattern
> matching across a large set of similiarly set up repositories to each
> get the desired access.
> 
> For example, if you don't have a kernel.org account, you might want
> settings like:
> 
> [host "kernel.org"]
>       base = git://git.kernel.org/pub/
>       rewritebase = master.kernel.org:/pub
> 
> Then, if you give git a URL like:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> 
> it will act like you gave it:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> 
> and you can cut-and-paste pull requests in email without fixing them
> by hand, for example.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---

So, I may be dense, but I'm having a hard time distinguishing
the names "base" and "rewritebase" just from a User Interface
perspective.  It's not clear to me which of those is the A and
which is the B part in s/A/B/.  "Rewritebase" might be the "from"
basis, or it might be the "to" basis.  Can we come up with more
descriptive property names here?

Is the rewrite always just prefix substitution/replacement?
What if there was some generic path rewrite needed? (KISS? :-))

Also, is "host" really the right config key?  Maybe "rewritehost"?
Or is this thought to be the basis of other (perhaps not rewrite
related) properties of the same host as well?

Maybe it's just me.

Thanks,
jdl
