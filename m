From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 04:01:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060726010358.20964.80443.stgit@machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 04:01:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Yhz-0000rY-DT
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 04:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWGZCBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 22:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGZCBG
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 22:01:06 -0400
Received: from mail.gmx.de ([213.165.64.21]:37097 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030353AbWGZCBF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 22:01:05 -0400
Received: (qmail invoked by alias); 26 Jul 2006 02:01:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 26 Jul 2006 04:01:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060726010358.20964.80443.stgit@machine>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24197>

Hi,

On Wed, 26 Jul 2006, Petr Baudis wrote:

> We used just the blessed() routine so steal it from Scalar/Util.pm. ;-)
> (Unfortunately, Scalar::Util is not bundled with older Perl versions.)
> 
> This is a newer much saner blessed() version by Randal L. Schwarz.

After a lot of fiddling, it works here. Remarks:

- It is not at all easy to run git (Perl scripts) in-place. At least for 
  Python, you can set a variable in config.mak and be done with it.
- private_Error.pm is not used. I had to rename it for Error.pm to be
  picked up.
- It even passes t7001 now. _After_ I spent two hours rewriting it in C.

Ciao,
Dscho
