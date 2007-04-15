From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Expose subprojects as special files to "git diff" machinery
Date: Sun, 15 Apr 2007 21:01:19 +0200
Message-ID: <20070415190119.GA21786@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:00:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd9xi-0008Cg-KE
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbXDOTAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbXDOTAb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:00:31 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:51599 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXDOTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:00:30 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 635E1800AC3;
	Sun, 15 Apr 2007 21:00:29 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 28392580D2; Sun, 15 Apr 2007 21:01:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44503>

>  
> +static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
> +{
> +	int len;
> +	char *data = xmalloc(100);
> +	len = snprintf(data, 100,
> +		"Subproject commit %s\n", sha1_to_hex(s->sha1));

In userland I would use a local variable for an array of the size of 100.
I would normally only allocate when we are say 5x bigger.

I wonder if there is a specific reason why you decided upon xmalloc here?
I see no problem in using xmalloc but wonder if there is something I
should start to do differently??

	Sam
