From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --color-words: Make the word characters configurable
Date: Sun, 4 May 2008 10:18:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041010000.30431@racer>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com> <1209736766-8029-1-git-send-email-pkufranky@gmail.com> <alpine.DEB.1.00.0805031501290.30431@racer> <20080503144337.GA7987@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun May 04 11:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsaNG-0000q7-C6
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbYEDJS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbYEDJS0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:18:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:34238 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753607AbYEDJSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:18:25 -0400
Received: (qmail invoked by alias); 04 May 2008 09:18:23 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp045) with SMTP; 04 May 2008 11:18:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Lyoo9CvrL/lpp8wV9nycWEcyvC910A1wC91xZtJ
	ojhv/jYzxlHmPp
X-X-Sender: gene099@racer
In-Reply-To: <20080503144337.GA7987@mithlond.arda.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81152>

Hi,

On Sat, 3 May 2008, Teemu Likonen wrote:

> Johannes Schindelin wrote (2008-05-03 15:03 +0100):
> 
> > Now, you can specify which characters are to be interpreted as word
> > characters with "--color-words=A-Za-z", or by setting the config
> > variable diff.wordCharacters.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> > 	I would have preferred an approach like this.
> 
> Unfortunately this does not work at all with other than Ascii 
> characters. It makes --color-words completely unusable for anything 
> other than Ascii text. Sorry.

Sorry, but the original way was also only meant for ASCII.  The fact that 
isspace() happens to work with UTF-8 does _not_ mean that it was any more 
useful with non-ASCII: think UTF-16.

So no, I do not buy into your ASCII argument at all.

> Ping Yin's version has also the problem that UTF-8 multibyte characters
> U+0080..U+10FFFF don't work in diff.nonwordchars. Fortunately the most
> important word delimiters are in U+0000..U+007F (=Ascii) area so Ping's
> version is perfectly usable with Unicode text.
>
> (Even the old --color-words behaviour with only SPACE as non-word char 
> was perfectly usable with Unicode text.)

See above.

> I, too, would like to see Ping's patch series merged in.

I have no problems with the intention.  But I have problems with the 
design.  It is no less ASCII-bound than what I proposed, it wants you to 
specify what does _not_ make a word character (making every newbie, and 
me, too, going "Huh?").

And I also commented on the artificial limitations by design: I think it 
is a big mistake to limit the user's options when it would be easy not to, 
just because the designer could not think of useful applications.

Ciao,
Dscho
