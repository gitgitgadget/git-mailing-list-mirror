From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to make "pull" always pulling the matching branch?
Date: Wed, 13 May 2009 15:12:23 +0200
Message-ID: <4A0AC737.7030202@drmicha.warpmail.net>
References: <20090512192140.GK31826@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 13 15:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4EGZ-0002JA-Hc
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 15:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbZEMNMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 09:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbZEMNMd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 09:12:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51762 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753311AbZEMNMc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 09:12:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 9BDFF3456A8;
	Wed, 13 May 2009 09:12:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 13 May 2009 09:12:32 -0400
X-Sasl-enc: YpTZOi/pNEhpb8xuWncgKtpzi1UCIhZ2KJ07OWNYx6pX 1242220352
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 00FACE9CA;
	Wed, 13 May 2009 09:12:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090512192140.GK31826@cs-wsok.swansea.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119046>

Oliver Kullmann venit, vidit, dixit 12.05.2009 21:21:
> Hello,
> 
> until some time ago,
> 
> git pull remote-repo
> 
> worked like that; alright, at some time
> warning messages appeared, so I used
> 
> git pull remote-repo master
> 
> I attempted several times to understand the
> strange message issued by pull:
> --------------------
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch.master.merge' in
> your configuration file does not tell me either.        Please
> specify which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details.
> 
> If you often merge with the same branch, you may want to
> configure the following variables in your configuration
> file:
> 
>     branch.master.remote = <nickname>
>     branch.master.merge = <remote-ref>
>     remote.<nickname>.url = <url>
>     remote.<nickname>.fetch = <refspec>
> 
> See git-config(1) for details.
> --------------------
> but neither do I understand what could be meant here, nor
> do I understand the details of git-pull or git-config w.r.t.
> this issue (the above doesn't give a hint about the meaning
> of the possible actions).
> 
> So well, now the same thing happened with "git push", but here
> the message actually is better and tells the reader what to do
> (nearly); so I specified "matching" for the config-variable 
> push.default, and that's fine.
> 
> I was hoping that there would also be a pull.default, which I could
> set to matching, but apparently there is nothing like that? How
> do I achieve this?
> 
> It seems rather sensible to me to have this as the default: just
> pull a matching branch, not more, not less --- what else could/should
> it be if nothing else is specified?

Is "remote-repo" in your case a URL or a remote config? For the latter
you should have remote.foo.{url,fetch} config already.

The branch.foo.{remote,merge} is set up automatically in many cases. Do
you have any of these?

Michael
