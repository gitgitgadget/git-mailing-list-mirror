From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb.cgi
Date: Wed, 19 Oct 2005 03:33:21 +0200
Message-ID: <20051019013321.GA10331@vrfy.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org> <43552FC2.3000000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 03:38:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2tr-0000yF-6T
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJSBdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVJSBdf
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:33:35 -0400
Received: from soundwarez.org ([217.160.171.123]:25495 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932440AbVJSBdY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 21:33:24 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 539296359B; Wed, 19 Oct 2005 03:33:21 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43552FC2.3000000@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10258>

On Tue, Oct 18, 2005 at 10:24:18AM -0700, H. Peter Anvin wrote:
> Kay Sievers wrote:
> >
> >>Most of the hits we get are either the 
> >>gitweb front page or the gitweb rss feeds, and it's eating I/O bandwidth 
> >>like crazy.
> >
> >I tested some stuff on these boxes and 30 stat() calls alone take app. 2 
> >seconds
> >on these boxes cause of I/O load ... :)
> >
> 
> Welcome to my hell :)

Yeah, I get an idea now :)

> I set up mod_cache (which I didn't know about, silly me) and so far it 
> seems to work and has produced a tremendous decrease in load and 
> improvement in response time.

Great! Hope that will work.

> I do, have, however, a request.  There 
> are some gitweb pages which are more likely to change than others; in 
> particular, some gitweb pages will *never* change (because they directly 
> reflect immutable git data.)

Yes, makes sense.

> If gitweb could produce Last-Modified and Expires headers where 
> appropriate, it should improve caching performance.

I've added the Expires: header to the commit and commitdiff pages with
one whole day ahead. Let's see if that will help...

Kay
