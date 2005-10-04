From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 15:01:51 -0700
Message-ID: <7vu0fx9c1c.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510031522590.23242@iabervon.org>
	<7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510031709360.23242@iabervon.org>
	<7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510031606550.31407@g5.osdl.org>
	<20051004071210.GA18716@localdomain>
	<Pine.LNX.4.63.0510040321170.23242@iabervon.org>
	<pan.2005.10.04.14.18.59.102722@smurf.noris.de>
	<434296F1.5030006@zytor.com>
	<20051004154640.GC4682@kiste.smurf.noris.de>
	<4342AF4B.7020806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 00:03:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMurY-0007Ts-Pd
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 00:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVJDWCO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 18:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVJDWCO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 18:02:14 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25544 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965004AbVJDWCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 18:02:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004220148.EMEM16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 18:01:48 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9691>

"H. Peter Anvin" <hpa@zytor.com> writes:

> If you have an ssh connection, you're writing over a pipe to the ssh 
> process, and your local buffer is that pipe, which is PIPE_BUF size.

I vaguely recall there was an interesting regression in recent
kernel history when the implementation of the pipe buffer was
changed, with which, writing the same amount of data with
different number of writes made things behave differently and
making the worst case buffer size less than traditional 4K.

I wonder if we are going to be bitten by that one...
