From: Petr Baudis <pasky@suse.cz>
Subject: Re: CGit and repository list
Date: Sat, 13 Sep 2008 21:49:39 +0200
Message-ID: <20080913194938.GI10360@machine.or.cz>
References: <19449377.post@talk.nabble.com> <20080912145804.GF10544@machine.or.cz> <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com> <200809121812.40920.johan@herland.net> <20080912224817.GF10360@machine.or.cz> <8c5c35580809121620x2de1828cq498b3709f7b0bd1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Kristian H??gsberg <hoegsberg@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 21:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Keb8y-0005Qs-KW
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 21:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYIMTtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 15:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbYIMTtn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 15:49:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46106 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbYIMTtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 15:49:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0B9DC3939B3E; Sat, 13 Sep 2008 21:49:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8c5c35580809121620x2de1828cq498b3709f7b0bd1b@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95813>

On Sat, Sep 13, 2008 at 01:20:50AM +0200, Lars Hjemli wrote:
> I guess I could add support for something like
> 
>   scan-paths=/pub/git
> 
> in cgitrc (and optionally store the result of the scan as another
> cgitrc-file in the cache directory). Would that improve things for
> you?

Yes, certainly.

> > Unfortunately, the recommended RewriteRule is not working - it does not
> > play well together with query parameters cgit is using, so e.g. browsing
> > past commits does not work. What RewriteRule should I use instead?
> 
> On hjemli.net I used to specify "virtual-root=/git" in cgitrc combined
> with this rule in /etc/apache/httpd.conf
> 
>   RewriteRule ^/git/(.*)$   /cgit/cgit.cgi?url=$1  [L,QSA]

Ah, I see - sorry. I forgot the [L,QSA] part.

I wonder why

	http://repo.or.cz/c/libc.git/

has such a funny-looking summary page.

Let me know if you want me to update cgit there sometime. In the next
days I will add some means for switching between cgit and gitweb views.

P.S.: Johan - I discovered the cause of my problems - .strip() is
totally inappropriate string method to call here, it takes a _set_ of
characters.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
