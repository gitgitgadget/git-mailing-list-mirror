From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Thu, 1 Feb 2007 17:52:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011749100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <7vireuaj9d.fsf@assigned-by-dhcp.cox.net>
 <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net>
 <45B928AD.50508@zytor.com> <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BBCD27.5050408@zytor.com> <Pine.LNX.4.63.0702011501250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C2124C.5070308@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 17:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCfBb-0004Jh-Az
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 17:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbXBAQwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 11:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbXBAQwt
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 11:52:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:45743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161188AbXBAQws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 11:52:48 -0500
Received: (qmail invoked by alias); 01 Feb 2007 16:52:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 01 Feb 2007 17:52:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C2124C.5070308@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38372>

Hi,

On Thu, 1 Feb 2007, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > I just had another idea: why not generate the content of the "cover page" in
> > a cron job, every minute or so, and save it into a static index.html? This
> > should take quite a load from the server, since not even Perl has to be
> > started to serve that page.
> > 
> 
> Ehm... because it often takes longer than that to generate the page?

Sorry, I should have been clearer. Plan:

1. echo "Generating" > /htdocs/git/index.html
2. edit crontab to do this every minute:
2.1 gitweb is called directly_, to generate /htdocs/git/index.html.new
2.2 /htdocs/git/index.html.new is _moved_ into /htdocs/git/index.html, 
    overwriting the existing one.

Yes, there could be two instances of this task concurrently. No, it does 
not matter.

> We can pre-generate the page before the first hit, but that's not a 
> replacement for update-time caching.

It was only meant as a quick fix for the horrible workload.

Just a thought, feel free to ignore me,
Dscho
