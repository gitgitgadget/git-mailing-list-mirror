From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] RFC: proxy-command support for git://
Date: Thu, 03 Nov 2005 10:54:43 -0800
Message-ID: <7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 19:57:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXkF5-0001jE-3P
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 19:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbVKCSyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVKCSyq
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 13:54:46 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59317 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030439AbVKCSyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 13:54:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103185421.STRK4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 13:54:21 -0500
To: Paul Collins <paul@briny.ondioline.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11084>

Paul Collins <paul@briny.ondioline.org> writes:

> I spend some of my time using a network that only allows outgoing TCP
> connections to certain ports, and the git-daemon port is not one of them.
> This patch below implements an analogue to ssh's ProxyCommand feature
> for git, as a less messy alternative to ssh port forwarding.

Wonderful.

> Questions:
>
> * Can git already do this and I just failed to notice?

Maybe I just failed to notice this too, but I do not think so.

> * Where should git_use_proxy() look?  Some git configuration file?
>   An environment variable?  Both?  Somewhere else?

My preference is put something in .git/config to describe which
proxy command (maybe the same one with different argument) to
use depending on where you are going.  When you have internal
hosts and external hosts you would want this to apply only to
external hosts.  Maybe you have two or more gateways and
depending on which external host you are going you may want to
use different proxied connection.  On top of the config file,
making it overridable from an environment variable would be
sensible.
