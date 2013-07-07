From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Documentation: finding $(prefix)/etc/gitconfig when
 prefix = /usr
Date: Mon, 8 Jul 2013 00:32:06 +0200 (CEST)
Message-ID: <1436467098.1055670.1373236326672.JavaMail.root@dewire.com>
References: <20130707222152.GV9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Shawn Pearce <sop@google.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jul 08 00:32:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxV9-00031P-R0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab3GGWcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:32:12 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:56157 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab3GGWcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:32:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id C7F6482C0D;
	Mon,  8 Jul 2013 00:32:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kz+nXuUqtTsd; Mon,  8 Jul 2013 00:32:06 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id AC40A82BD8;
	Mon,  8 Jul 2013 00:32:06 +0200 (CEST)
In-Reply-To: <20130707222152.GV9161@serenity.lan>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229811>



----- Ursprungligt meddelande -----
> On Mon, Jul 08, 2013 at 12:00:02AM +0200, Robin Rosenberg wrote:
> > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> > ---
> >  Documentation/git-config.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/git-config.txt
> > b/Documentation/git-config.txt
> > index 9ae2508..3198d52 100644
> > --- a/Documentation/git-config.txt
> > +++ b/Documentation/git-config.txt
> > @@ -107,7 +107,8 @@ See also <<FILES>>.
> >  
> >  --system::
> >  	For writing options: write to system-wide $(prefix)/etc/gitconfig
> > -	rather than the repository .git/config.
> > +	rather than the repository .git/config. However, $(prefix) is
> > /usr
> > +	then /etc/gitconfig is used.
> 
> That's a build time condition, not something that's decided at
> runtime
> so I'm not sure that this logic belongs in the user facing
> documentation.  The technically correct change would be to use
> "$(sysconfdir)/gitconfig" but I think that will just confuse users
> more.
> 
> Since we have a build step for the documentation, I wonder if it's
> possible to replace these with the correct directory at build time.

Might work for documentation. I'd like a run-time variant for my
particular problem, but the one I found now, e.g. git rev-parse --show-prefix"
does not work in the general case. I want to tell JGit where the system
wide configuration file is, even before we have a git repository.

-- robin
