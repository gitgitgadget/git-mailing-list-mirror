From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Fri, 12 Jul 2013 16:58:44 -0400
Message-ID: <20130712205843.GJ4604@pug.qqx.org>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
 <20130712095923.GA4695@sigill.intra.peff.net>
 <F5272E14-188E-4199-9523-D2ED66574D91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxkQT-0001eO-BQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965446Ab3GLU6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:58:45 -0400
Received: from pug.qqx.org ([50.116.43.67]:33112 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965443Ab3GLU6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:58:45 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 382C11D3E3; Fri, 12 Jul 2013 16:58:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <F5272E14-188E-4199-9523-D2ED66574D91@gmail.com>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230255>

At 06:07 -0700 12 Jul 2013, "Kyle J. McKay" <mackyle@gmail.com> wrote:
>I don't think it's necessary to split the URL apart though.  Whatever 
>URL the user gave to git on the command line (at some point even if 
>it's now stored as a remote setting in config) complete with URL-
>encoding, user names, port names, etc. is the same url, possibly 
>shortened, that needs to be used for the http.<url>.option setting.

This seems to be assuming that the configuration is done after the URL 
is entered and that URLs are always entered manually.  I don't think 
either of those assumptions is valid.  A user may want to specify http 
settings for all repositories on a specified host and so add settings 
for that host to ~/.gitconfig expecting those settings to be used later.  
A URL in a slightly different format may later be copy+pasted without 
the user realizing that it won't use that config due to one of the 
versions being in a non-canonical form.

>I think that's simple and very easy to explain and avoids user 
>confusion and surprise while still allowing a default to be set for a 
>site but easily overridden for a portion of that site without needing 
>to worry about the order config files are processed or the order of the 
>[http "<url>"] sections within them.

I agree that the method is easy to explain, but I think a user may very 
well be surprised and confused in a scenario like I described above.  
And having the order not matter (in some cases) for these configuration 
items deviates from how other configuration values are handled.
