From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
Date: Fri, 05 Jan 2007 13:25:58 -0800
Message-ID: <1168032358.2505.10.camel@localhost.localdomain>
References: <459C0232.3090804@linuxtv.org>
	 <20070103202555.GA25768@localhost>  <459EC16F.1070809@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Krufky <mkrufky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 05 22:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2wap-00005O-2X
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbXAEV1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 16:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXAEV1M
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:27:12 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:42457 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbXAEV1K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 16:27:10 -0500
Received: from [10.0.6.67] (yardgnome.c2micro.com [69.104.58.50])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.7) with ESMTP id l05LQY46020427
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 5 Jan 2007 13:26:34 -0800
To: Michael Krufky <mkrufky@linuxtv.org>
In-Reply-To: <459EC16F.1070809@linuxtv.org>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36024>

On Fri, 2007-01-05 at 16:21 -0500, Michael Krufky wrote:
> Robert Fitzsimons wrote:
> > My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
> > found by Michael Krufky which caused the passed in hash value to be
> > ignored, so shortlog would only show the HEAD revision.
> > 
> > Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
> > ---
> > 
> > Thanks for finding this Michael.  It' just a small bug introducted by a
> > recent change I made.  Including John 'Warthog9' so hopefully he can add
> > this to the version of gitweb which is hosted on kernel.org.
> > 
> > Robert
> 
> Robert,
> 
> Thank you for fixing this bug so quickly.  I've noticed that the gitweb
> templates on kernel.org have changed at least once since you wrote this email to
> me... (I can tell, based on the fact that the git:// link has moved from the
> project column to a link labeled, "git" all the way to the right.)
> 
> Unfortunately, however, the bug that I had originally reported has not yet been
> fixed on the kernel.org www server.  Either the patch in question hasn't yet
> been applied to that installation, or it HAS in fact been applied, but doesn't
> fix the problem as intended.

Simple answer - it's sitting in my tree waiting for me to have enough
time to get back to gitweb.  There are several things in flight and I'm
not prepared to push them out in their current state.

So yes the problem is fixed, but it will probably be sometime this
weekend before it gets pushed out to the kernel.org servers.

> 
> Do you know which of the above is true?
> 
> Thanks again,
> 
> Mike Krufky
> 
> >  gitweb/gitweb.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index d845e91..2e94c2c 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -4423,7 +4423,7 @@ sub git_shortlog {
> >  	}
> >  	my $refs = git_get_references();
> >  
> > -	my @commitlist = parse_commits($head, 101, (100 * $page));
> > +	my @commitlist = parse_commits($hash, 101, (100 * $page));
> >  
> >  	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
> >  	my $next_link = '';
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
