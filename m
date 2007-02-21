From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Wed, 21 Feb 2007 00:46:31 -0500
Message-ID: <20070221004631.q4npyww808k88s0o@webmail.spamcop.net>
References: <20070221050336.26431.46485.stgit@dv.roinet.com>
	<7vwt2ct79x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 06:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJkJP-0000ww-0C
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 06:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbXBUFqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 00:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbXBUFqc
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 00:46:32 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:38664 "HELO
	mailgate.cesmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932338AbXBUFqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 00:46:32 -0500
Received: (qmail 18579 invoked from network); 21 Feb 2007 05:46:31 -0000
Received: from unknown (HELO delta.cesmail.net) (192.168.1.30)
  by mailgate.cesmail.net with SMTP; 21 Feb 2007 05:46:31 -0000
Received: (qmail 14985 invoked by uid 99); 21 Feb 2007 05:46:31 -0000
Received: from c-71-230-131-166.hsd1.pa.comcast.net
	(c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Wed, 21 Feb 2007 00:46:31 -0500
In-Reply-To: <7vwt2ct79x.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40280>

Quoting Junio C Hamano <junkio@cox.net>:

> I do not think we ever officially "supported" remotes with a dot
> in their names since $GIT_DIR/remotes/ or $GIT_DIR/branches
> days.

On the other hand, I've been tracking "wireless-2.6" for months without even
realizing that the name could be a problem.  It is only when I tried the new
"git-remote update" that I noticed that it tries to update "wireless-2" and
fails.

> I do not strongly oppose to allowing it now, but I suspect this
> is probably less impact:
>
> 	if (/^remote\.(\S+?)\.([^.\s]+)\s+(.*)$/) {
>         	...
> 	}
>
> With this, we disallow whitespaces in remote names, but we leave
> the door open for supporting variables other than fetch and url
> by accepting the third token that matches any sequence of
> non-dot, non-whitespace letters.

It would be great as long as we don't use names with more than one dot after the
remote name (e.g. remote.wireless-2.6.url.push), but if you think it's unlikely,
I agree that your code is better.

--
Regards,
Pavel Roskin
