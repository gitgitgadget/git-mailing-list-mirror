From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Mon, 15 Jan 2007 19:03:53 -0800
Message-ID: <18039.1168916633@lotus.CS.Berkeley.EDU>
References: <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 04:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ecB-0004tb-Eb
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 04:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXAPDD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 22:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAPDD5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 22:03:57 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45220 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXAPDD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 22:03:56 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G33rSH018051;
	Mon, 15 Jan 2007 19:03:53 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G33rZE018048;
	Mon, 15 Jan 2007 19:03:53 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36915>

And Junio C Hamano writes:
> We have done this already so it might be too late to raise this
> question, but does everybody have printf?

It's in the Single Unix Spec as the alternative to non-portable
echo uses:
  http://opengroup.org/onlinepubs/007908799/xcu/echo.html#tag_001_014_525
And no one has complained so far...

> > -			name=$(echo -n "$f" | tr -c "A-Za-z0-9" ".")
> > +			name=$(printf "$f" | tr -c "A-Za-z0-9" ".")

> This should almost be safe as no sane person would have a remote
> whose name is 'foo%s'...

Forgot about that, thanks.  It should be printf "%s" "$f".

Jason
