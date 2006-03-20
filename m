From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 17:30:19 +0100
Message-ID: <200603201730.19373.Josef.Weidendorfer@gmx.de>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us> <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net> <7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 17:30:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLNH4-00014N-VZ
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 17:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWCTQa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 11:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWCTQa0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 11:30:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:8074 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964975AbWCTQaY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 11:30:24 -0500
Received: (qmail invoked by alias); 20 Mar 2006 16:30:22 -0000
Received: from fauia100.informatik.uni-erlangen.de (EHLO fauia100.informatik.uni-erlangen.de) [131.188.67.100]
  by mail.gmx.net (mp032) with SMTP; 20 Mar 2006 17:30:22 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17757>

On Monday 20 March 2006 09:54, you wrote:
>  * A new flag --use-separate-remote stops contaminating local
>    branch namespace by upstream branch names.  The upstream
>    branch heads are copied in .git/refs/remotes/ instead of

Shouldn't this be .git/refs/remotes/origin/?
Ie. different namespaces for different remotes?

Linus wanted to still be able to say "origin" which automatically
would map to "remotes/origin/master", where the name of the remote
branch (here "master") is the first mentioned in the Pull line of
the .git/remotes file in eg.

	git diff origin..master

I am not sure whether we really want "take first refspec mentioned on Pull
line", as there can be multiple tracked remote branches with their own local
developments...
Ie. I want to be able to specify: "The local development branch X is based on
the following remote branch Y , which is tracked locally as Z.".
This way, you also could warn/prohobit accidential nonsense merges because of wrong use
of "git-pull". 

Josef
