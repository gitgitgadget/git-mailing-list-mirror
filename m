From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..."
 page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 14:02:30 +0100
Message-ID: <20100125130230.GE9553@machine.or.cz>
References: <cover.1264198194.git.jnareb@gmail.com>
 <f4660e9c7ffdb4a62da0c56703de002c9df3b598.1264198194.git.jnareb@gmail.com>
 <20100124222417.GC9553@machine.or.cz>
 <201001251246.40237.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 14:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZOaT-0003pb-2q
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab0AYNCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306Ab0AYNCd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:02:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52230 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab0AYNCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:02:33 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id E8C7486208B; Mon, 25 Jan 2010 14:02:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201001251246.40237.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137959>

On Mon, Jan 25, 2010 at 12:46:39PM +0100, Jakub Narebski wrote:
> On Sun, 24 Jan 2010, Petr Baudis wrote:
> >   I have stupid question, common to both the original patch and this
> > RFC.
> > 
> > > [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
> > > regenerating cache (WIP)
> > 
> >   Just why is a "Generating..." page appropriate?
> > 
> >   I have to admit I hate it; can you please at least make it
> > configurable? Why is it needed at all? It [...] confuses
> > non-interactive HTTP clients [...]
> 
> First, if I understand the code correctly HTTP clients which do not 
> honor metaredirect (http-equiv refresh) would get page which looks
> the following
> 
>   <html>
>   Generating...
>   </html>
>   <html>
>   Gitweb page
>   </html>

To be clear, I conjectured it confuses non-interactive HTTP clients from
one of the TODOs in your patch series - I'm not sure about it myself. :)

> Second, gitweb can always check User-Agent header, and serve 
> "Generating..." page only to web browsers:
> 
>   unless (defined $cgi->user_agent() &&
>           $cgi->user_agent() =~ /\b(Mozilla|Opera)\b/i) {
>   	return;
>   }
> 
> or something like that.

I'm not too happy with this. What about Safari? Opera? ELinks? There's a
lot of web browsers.

Most of the issues can be worked around, but I'm not sure why to go
through all the trouble. I just personally don't see the value in having
the placeholder in there at all, to me it is distracting UI even if all
the technicalities are put aside.

But if it will be possible to turn this off eventually, it's all your
call whether to bother implementing it. :-)

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
