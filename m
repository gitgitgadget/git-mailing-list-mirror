From: Mike Hommey <mh@glandium.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 13:10:43 +0100
Organization: glandium.org
Message-ID: <20080207121042.GA10210@glandium.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207110601.GA8488@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 13:11:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN5b9-0001PC-GB
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbYBGMKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbYBGMKr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:10:47 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:42332 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbYBGMKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:10:46 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 31B661C00149
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 13:10:44 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-42-109.w82-124.abo.wanadoo.fr [82.124.6.109])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id EB7C51C000A5;
	Thu,  7 Feb 2008 13:10:43 +0100 (CET)
X-ME-UUID: 20080207121043964.EB7C51C000A5@mwinf1907.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JN5aV-0002g9-IA; Thu, 07 Feb 2008 13:10:43 +0100
Content-Disposition: inline
In-Reply-To: <20080207110601.GA8488@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72924>

On Thu, Feb 07, 2008 at 06:06:02AM -0500, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 07, 2008 at 10:15:02AM +0000, Anand Kumria wrote:
> 
> > > OK, I was finally able to reproduce your bug. It seems that it _only_
> > > happens when using curl built against gnutls. I built against the
> > > libcurl4-openssl-dev in Debian unstable, and the problem goes away.
> > 
> > Thanks for figuring out how to reproduce it ... how did you btw?
> 
> I saw the gnutls error message in your output and took a guess that it
> was related. I was able to reproduce against the first https repository
> that I tried (I don't think it has anything to do with the repository).
> 
> I wish we could more certainly blame it on something besides git,
> though. I can't reproduce it using just 'curl', so it's possible that
> there is a problem with the way git is calling libcurl.
> 
> > It appears that git 1.5.3.8 on Debian links to libcurl3-gnutls whereas, 
> > at least for me, git 1.5.4 on Debian links to libcurl4-gnutls 
> > (or libcurl4-openssl).
> > 
> > I agree with you, it is a bit problematic when the library (curl) relies
> > on another library (gnutls) and the bottom one is having a problem.
> 
> It would be nice if we could generate a minimal test case that
> demonstrates the problem, but I can't seem to reproduce it with a
> smaller program. If we could, then we could probably get advice from
> curl and/or gnutls people.

Did you try to run with the GIT_SSL_NO_VERIFY environment variable set ?

Mike
