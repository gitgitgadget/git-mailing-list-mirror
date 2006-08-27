From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Make git_print_log generic; git_print_simplified_log uses it
Date: Sun, 27 Aug 2006 16:11:51 -0700
Message-ID: <7v4pvxvknc.fsf@assigned-by-dhcp.cox.net>
References: <200608272355.07625.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 01:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHTn0-00073b-Um
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 01:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWH0XLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWH0XLV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 19:11:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16841 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751255AbWH0XLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 19:11:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827231120.SQBC4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 19:11:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FBBH1V00h4Noztg0000000
	Sun, 27 Aug 2006 19:11:18 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608272355.07625.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 27 Aug 2006 23:55:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26128>

Jakub Narebski <jnareb@gmail.com> writes:

> The RFC is about style of git_print_log function. Is it a good idea
> and good implementation to pass miscelaneus options as hash values
> instead of using fixed order of parameters, and passing 1 or undef?
> Is it a good naming of parameters like '-remove_title', or would
> 'remove_title' or 'remove-title' be better?

I do not personally like the line-noise sub prototypes, since I
have not seen it buys you much in real programs.  Although some
cute hacks like rolling your own control structure lookalikes
cannot be done without them, they are just that -- cute hacks --
and tends to obfuscate what is really happening behind the scene
(not that writing anything in Perl is not already obfuscating
things ;-)).  But maybe it is just me.

I think you already use CGI.pm and the argument passing style
using things like "-remove_title" is the norm there, so I do not
have objections against it.  You might even be able to lift the
code CGI.pm uses to implement the hash-style passing with
defaults.
