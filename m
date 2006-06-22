From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking CVS
Date: Thu, 22 Jun 2006 10:05:10 -0700
Message-ID: <7vveqtp1dl.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
	<20060622135831.GB21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 19:06:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtScb-0007u3-F8
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 19:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWFVRFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 13:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWFVRFU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 13:05:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14251 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932557AbWFVRFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 13:05:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622170512.NYQH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 13:05:12 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622135831.GB21864@pasky.or.cz> (Petr Baudis's message of
	"Thu, 22 Jun 2006 15:58:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22347>

Petr Baudis <pasky@suse.cz> writes:

> If you want to be safe even with filenames containing newlines, you need
> to go at the Git level:
>
> 	git-ls-files -z --others | \
> 		xargs -0 git-update-index --add --

If you want to avoid "xargs -0", you can replace it with
"git-update-index -z --stdin" I think.

> Perhaps we might make a special command which would sync the index set
> with the working copy set...

I think that makes sense.  Something like what "git-commit -a"
does before making a commit.
