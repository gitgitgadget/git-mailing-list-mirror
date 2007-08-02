From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 02 Aug 2007 14:43:39 -0700
Message-ID: <7vk5sdtxx0.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
	<Pine.LNX.4.64.0708021636470.14781@racer.site>
	<20070802204909.GA2829@steel.home>
	<Pine.LNX.4.64.0708022204170.14781@racer.site>
	<7vwswdtz98.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708022230070.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:43:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiSP-0002Rn-MI
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbXHBVnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758691AbXHBVnm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:43:42 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36703 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758299AbXHBVnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:43:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802214339.BPPI23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 17:43:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9jf1X00S1kojtg0000000; Thu, 02 Aug 2007 17:43:40 -0400
In-Reply-To: <Pine.LNX.4.64.0708022230070.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 2 Aug 2007 22:36:37 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54620>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Static is supposed to be zeroed and also is supposed to retain
>> the value from the previous call.  I am guessing from the change
>> to make "rel" to non-static that this function is called twice
>> perhaps?
>
> Apparently (but I would feel safer with strlcpy() anyway)...

Yup, send an appliable "final" version, somebody please?

> ...  git-read-tree 
> is the first and only offender which comes up in the test suite:

It is unclear.

Is this an optimization, or enforcing the new world order?  IOW,
is it now banned to call setup twice?
