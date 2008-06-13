From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Fri, 13 Jun 2008 19:26:34 +0200
Message-ID: <20080613172634.GB5671@steel.home>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net> <20080612060152.GA3798@steel.home> <20080612062309.GA31816@sigill.intra.peff.net> <20080612203245.GB8057@steel.home> <20080613060215.GB26768@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7D3k-0005HC-HB
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 19:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYFMR0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYFMR0i
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 13:26:38 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:47688 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYFMR0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 13:26:37 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r84gudV
Received: from tigra.home (Fa84e.f.strato-dslnet.de [195.4.168.78])
	by post.webmailer.de (fruni mo36) (RZmta 16.43)
	with ESMTP id x0131ek5DGOdHK ; Fri, 13 Jun 2008 19:26:35 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 135AD277BD;
	Fri, 13 Jun 2008 19:26:35 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E3DD756D28; Fri, 13 Jun 2008 19:26:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080613060215.GB26768@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84903>

Jeff King, Fri, Jun 13, 2008 08:02:15 +0200:
> On Thu, Jun 12, 2008 at 10:32:45PM +0200, Alex Riesen wrote:
> 
> > That was the problem. ActiveState Perl always replaces LF in the
> > output with CRLF, which caused mismatches with template files in some
> > tests (even the generated templates had LF line endings, cygwins tools
> > follow that convention). At first, I tried to get by putting
> > "binmode(STDOUT)" into every test, but this became boring with a time.
> > Besides, the lines get very long and ugly (and make conflict resolving
> > harder).
> 
> Does ActiveState respect the PERLIO environment variable? I haven't
> played with it much, but my understanding is that setting
> PERLIO=:unix:perlio should give you sane behavior (the default on
> Windows should be PERLIO=:unix:crlf).

I didn't know about it (and managed to miss it when I looked to
workaround the problem. I even looked into the manpage documenting
environment variables!)

Yes, it works. It has side effects (the scripts of some build
processes will be affected), but that's already something...
