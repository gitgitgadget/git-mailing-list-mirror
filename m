From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 02:22:03 -0400
Message-ID: <1152512523.3504.28.camel@dv>
References: <20060708183402.GA17644@spearce.org>
	 <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
	 <20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de>
	 <20060710052255.GA15173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 08:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzp9r-0007Hq-AU
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 08:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWGJGWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 02:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWGJGWM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 02:22:12 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:54174 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161135AbWGJGWL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 02:22:11 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fzp9m-0004v3-Do
	for git@vger.kernel.org; Mon, 10 Jul 2006 02:22:10 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fzp9f-0000YE-An; Mon, 10 Jul 2006 02:22:03 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060710052255.GA15173@spearce.org>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23594>

Hi, Shawn!

On Mon, 2006-07-10 at 01:22 -0400, Shawn Pearce wrote:
>   $ cc -V                                                        
>   cc: Forte Developer 7 C 5.4 2002/03/09
>   usage: cc [ options] files.  Use 'cc -flags' for details
> 
> and from `man cc`:
> 
>   -xc99  enables C99 features:
[skip]
>           o  Flexible Array Members

This must be enabled already because it's used in git (see FLEX_ARRAY).

> So neither of the constructs my patch removes are supported in this
> (old) compiler, although a newer one might accept them with -xc99.
> Yes, I tried building a pristine git-1.4.1 with -xc99.  It barfed,
> as one would expect given the description above.

This means that the Sun compiler has almost all c99 features used by git
with just a little exception (initializers).  I think it's fair that we
fix this incompatibility.  It's very very minor compared to what "gcc
-std=c89 -pedantic" would have required.

-- 
Regards,
Pavel Roskin
