From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Wed, 9 May 2007 17:11:48 +0200
Message-ID: <20070509151148.GW4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site> <vpqk5vlamav.fsf@bauges.imag.fr> <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net> <20070509125225.GP4489@pasky.or.cz> <Pine.LNX.4.64.0705091513360.4167@racer.site> <20070509142426.GV4489@pasky.or.cz> <vpqps5ajb60.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 17:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlnpm-0007Hv-2o
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXEIPLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbXEIPLw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:11:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50105 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048AbXEIPLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:11:51 -0400
Received: (qmail 30743 invoked by uid 2001); 9 May 2007 17:11:48 +0200
Content-Disposition: inline
In-Reply-To: <vpqps5ajb60.fsf@bauges.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46723>

On Wed, May 09, 2007 at 04:59:03PM CEST, Matthieu Moy wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > -	echo "$log_message"
> > +	echo "$log_message" | fmt
> 
> I wouldn't do that for the first line of the message.
> 
> Someone typing
> 
> $ git commit -m "a very very very very very very very very very very very very long summary" \
>              -m "a longer description of the above summary"
> 
> Probably doesn't want his first line to be broken (otherwise,
> git-format-patch and other tools would be confused).
> 
> So, that would be more like
> 
> echo "$log_message" | (read first_line; echo "$first_line"; fmt)

Hmm, I don't really know if it's more evil to split an extra-long line
to two or keep it longer than the maximum sane width. Since I'm torn,
I'd prefer to go for the version that's simpler (also, avoids weird
results for those who for some reason chose not to follow the usual
convention, but that's a minor point).

I don't really care, but if noone else does either, I'd stay with the
current simple version. :)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
