From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] Fix compilation on newer NetBSD systems
Date: Mon, 15 May 2006 14:41:16 +0200
Message-ID: <20060515124115.G78828137@leonov.stosberg.net>
References: <20060511173531.G18d4553c@leonov.stosberg.net> <7vu07rx3a9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 14:41:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfcO8-00088V-EN
	for gcvg-git@gmane.org; Mon, 15 May 2006 14:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWEOMlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWEOMlY
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 08:41:24 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:31156 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751394AbWEOMlY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 08:41:24 -0400
Received: from leonov.stosberg.net (p213.54.84.32.tisdip.tiscali.de [213.54.84.32])
	by ncs.stosberg.net (Postfix) with ESMTP id 4E062590C002;
	Mon, 15 May 2006 14:41:12 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 43924FE76C; Mon, 15 May 2006 14:41:16 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu07rx3a9.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20048>

Junio C Hamano wrote:

> Dennis Stosberg <dennis@stosberg.net> writes:
> 
> > +	ifeq ($(shell test `uname -r | sed -e 's/^\([0-9]\).*/\1/'` -lt 2 && echo y),y)
> > +		NEEDS_LIBICONV = YesPlease
> > +	endif
> 
> This looks rather ugly.  I do not know if NetBSD has 0.xx
> versions, but perhaps something like this?
> 
> 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)

Admittedly, that looks a lot nicer.  And it works correctly with
NetBSD's "expr", too.

Regards,
Dennis
