From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Different colours for tags and heads
Date: Fri, 11 Aug 2006 17:58:54 -0700
Message-ID: <7v4pwisrap.fsf@assigned-by-dhcp.cox.net>
References: <20060811151224.177110@gmx.net> <ebi81l$qu$1@sea.gmane.org>
	<7vodurrlg8.fsf@assigned-by-dhcp.cox.net> <ebj6c3$4cj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 12 02:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBhqJ-00048P-8s
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 02:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWHLA66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 20:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWHLA66
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 20:58:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21919 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964806AbWHLA66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 20:58:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812005857.SOPC29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 20:58:57 -0400
To: git@vger.kernel.org
In-Reply-To: <ebj6c3$4cj$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	12 Aug 2006 02:12:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25246>

Jakub Narebski <jnareb@gmail.com> writes:

> But they can be put into anonymous arrayref (e.g. ['heads/next',
> 'heads/autoconf'] at the start of 'autoconf' branch, or ['heads/master',
> 'heads/next', 'tags/v1.4.2'], not 'heads/master:heads/next:tags/v1.4.2'
> my patch did.

Concatenating them with ':' into a single string, only to later
split it, sounds simply stupid; I'd go for arrayref if I were
you.

> By the way, is it really usefull to have shortened ref name, e.g. 'web' for
> 'jn/web'? That is what gitweb does currently (only without giving ling name
> at all). It is probably bad practice, but I've had branches ab/sth and
> zz/sth, with the same shortname.

I think most people tend to use unique refs, so maybe showing
the shortname by default and unique suffix when ambiguous (that
would end up always showing minimal unique suffix) would be
reasonable.
