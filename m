From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 16:02:18 -0700
Message-ID: <7v8xwjx2f9.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231427230.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 01:02:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETorA-0002Q4-71
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 01:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVJWXCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 19:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJWXCU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 19:02:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1260 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750828AbVJWXCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 19:02:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023230151.XCYP29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 19:01:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 23 Oct 2005 14:30:45 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10513>

Linus Torvalds <torvalds@osdl.org> writes:

> It's incomplete and almost certainly buggy and generally broken, but 
> here's somethign that you _could_ install as "git-shell", and then put 
> that as somebodys shell in /etc/passwd, and it's a start. A very rough 
> start.
>
> Somebody else gets to test it out ;)
>
> +		if (c != '\'') {
> +			*dst++ = c;
> +			continue;
> +		}
> +		switch (*++src) {
> +		case '\0':
> +			*dst = 0;
> +			return arg;
> +		case '\\':
> +			if (*++src == '\'' &&
> +			    *++src == '\'') {
> +				*dst = '\'';
> +				continue;
> +			}
> +		/* Fallthrough */
> +		default:

I think this misses HPA's addition to minimally suppport csh
braindamage (bang bang).
