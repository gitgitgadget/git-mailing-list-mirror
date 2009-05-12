From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Tue, 12 May 2009 13:11:11 +0200
Message-ID: <4A09594F.4040603@drmicha.warpmail.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 13:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3pts-0000CN-10
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 13:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759633AbZELLLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 07:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759234AbZELLLU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 07:11:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37079 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758932AbZELLLT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 07:11:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 064823422BC;
	Tue, 12 May 2009 07:11:20 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 12 May 2009 07:11:20 -0400
X-Sasl-enc: A3CEmtoHKTSZBu46v8UiRBjnn7xL+WLiBiCHsjssJFbB 1242126679
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 79D8F24C5F;
	Tue, 12 May 2009 07:11:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118888>

Caleb Cushing venit, vidit, dixit 12.05.2009 03:26:
> in the past git push origin would just push all matching branches to
> the remote, and it worked. the new error says that's still the
> default. The new functionality is nice, but is it really the git way
> to yell at you if you haven't explicitly set the default? I think the
> default should remain the default, and it should continue to work
> without yelling at you for not explicitly setting it. if you want to
> change it that's fine.
> 
\begin{rambling}
It is a fall-out from the new user friendliness initiative. Watch out
for parentheses:
it's ( (new user) friendliness ), not ( new (user friendliness) ).

The principle is: if a user is about to do something which is documented
but might not have been intended we throw a half-screen full of text at
them. The idea is that it is virtually impossible to grasp at a glance
from that much text what happened, so that the user is forced to read
the whole text. edugit, so to say.
\end{rambling}

Seriously, we had that discussion when the feature (change of default
behaviour) and warning were introduced, so it's too late for a change.
But it's never too late to do

git config --global push.default matching

and be done with it.

The weird thing is that the default is "matching" already. But it makes
a difference whether you have set the variable to its default value
explicitly or not. No man page says so (neither git-push nor
git-config), and I can't think of other variables with such a behaviour.

Michael
