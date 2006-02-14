From: Greg KH <greg@kroah.com>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 22:34:20 -0800
Message-ID: <20060214063420.GA11851@kroah.com>
References: <20060214055425.GA32261@kroah.com> <20060214055648.GA592@kroah.com> <7vveviv5d1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tlY-0004DJ-8N
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWBNGeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWBNGeS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:34:18 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:37060
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030496AbWBNGeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:34:17 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F8tlS-000225-QF; Mon, 13 Feb 2006 22:34:18 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveviv5d1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16120>

On Mon, Feb 13, 2006 at 10:09:30PM -0800, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Hm, in looking at it closer, it's probably the last two lines of the
> > file, the signature that git format-patch adds to the message:
> > 	-- 
> > 	1.2.0
> 
> If that is the case, it's unfortunate that diffstat is broken
> and is not properly counting lines to tell which lines are part
> of the patch and which lines are not.
> 
> Have you tried "git apply --stat" instead?

How would that work after I've allready applied the patches to a branch?

> > Any way to suppress these?
> 
> Sorry, there is no option to disable that, but the stuff is
> GPLv2 so you can do whatever ;-).

Bah, make me go create a patch :)

> The string "-- \n" is an established convention to mark the
> beginning of the signature (or whatever inmaterial stuff that
> follow the message contents), so changing the marker is
> pointless -- if we want the option it should be to delete those
> two lines altogether.

Oh I understand what it is and it does follow the proper convention.
Maybe we just need an extra line of padding in there before the
signature or something... I'll go play with it.

> I personally find it useful to see the trend of version of tools
> people use on the public mailing list, and that was the primary
> reason it is there.

Why not just add a "X-Git-Version: 1.2.0" flag to the message instead?

thanks,

greg k-h
