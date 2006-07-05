From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-base: update the clean-up postprocessing
Date: Wed, 05 Jul 2006 16:20:15 -0700
Message-ID: <7v4pxvbpw0.fsf@assigned-by-dhcp.cox.net>
References: <44AB0948.9070606@gmail.com>
	<7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607050946390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 01:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyGfN-00085R-RO
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 01:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWGEXUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 19:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWGEXUS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 19:20:18 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30963 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965051AbWGEXUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 19:20:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705232015.FRTW27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Jul 2006 19:20:15 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607050946390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 5 Jul 2006 09:50:53 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23364>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 4 Jul 2006, Junio C Hamano wrote:
>
>> This is "for concepts" only -- it still seems to have bugs
>> somewhere to break other tests, although it passes your new
>> tests.
>
> Doesn't this introduce a nasty O(n*m) performance (where m is the 
> number of merge bases, and n the number of traversed commits)? I think 
> possibly many commits are traversed multiple times.

In practice m is small and the recomputation of bases between
bases does not require the minimalization so O(m^2).  I've given
the numbers from a small real world example on the fixed code.
