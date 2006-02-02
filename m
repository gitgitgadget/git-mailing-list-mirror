From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Wed, 01 Feb 2006 17:17:05 -0800
Message-ID: <7vr76m36ge.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
	<7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602011528030.28923@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqxqbz9q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602020113200.30910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 02:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4T62-00050d-Fb
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 02:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbWBBBRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 20:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWBBBRI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 20:17:08 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54520 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161034AbWBBBRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 20:17:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202011401.HXYT20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 20:14:01 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602020113200.30910@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 2 Feb 2006 01:48:31 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15475>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If you have such a modified rev-list, yes.  I was having doubts
>> about keeping an obvious correctness guarantee when doing such
>> "rev-list ~A".
>
> I think it would be trivial: just resolve ~A to the tree A points to:

<tired> Hmph.  I thought you meant "have-only A" to mean similar
to "have A" but additionally "do not assume I have things behind
A", and are going to extend rev-list to support ~A syntax to do
that.  I am a bit surprised to see your "rev-list ~A" is to
include A, not exclude A and not what are behind A.  Where is
the connection between this and "have-only A"?  </tired> ;-)

>> > Yes, I agree. But again, the local repo has to know which grafts were 
>> > introduced by making the repo shallow.
>> 
>> I am not sure I understand.  grafts are grafts are grafts.
>
> Exactly. And grafts are grafts are not necessarily cutoffs.
>
> Now, is it possible that a fetch does something unintended, when there are 
> grafts which are not cutoffs? I don't know yet, but I think so.

I think we are disagreeing, so "not Exactly".  I meant "grafts
are grafts, there is no cutoffs, they are also just grafts".  So
the answer to your question is "it does not matter".
