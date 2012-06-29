From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 21:59:18 +0200
Message-ID: <20120629195918.GB9403@camk.edu.pl>
References: <20120629124122.GG1258@camk.edu.pl>
 <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
 <20120629174358.GB3804@sigill.intra.peff.net>
 <20120629181701.GB6533@camk.edu.pl>
 <20120629182944.GA20346@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 21:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkhLu-0005pH-KB
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 21:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab2F2T7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 15:59:33 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:50897 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab2F2T7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 15:59:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 057DC5F004D;
	Fri, 29 Jun 2012 22:00:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U8adlhZt7lYv; Fri, 29 Jun 2012 22:00:26 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 4FE905F004A;
	Fri, 29 Jun 2012 22:00:26 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 0EF7346739; Fri, 29 Jun 2012 21:59:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120629182944.GA20346@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200826>

On Fri, Jun 29, 2012 at 02:29:44PM -0400, Jeff King wrote:
> On Fri, Jun 29, 2012 at 08:17:01PM +0200, Kacper Kornet wrote:

> > >  as strbuf_addstr_without_crud was
> > > only added recently (but it is a refactoring of older code which should
> > > have the same behavior).

> > It depends what you call recently. It was refactored in July 2005
> > (commit: 6aa33f4035d5). But it looks like the previous code (before
> > refactoring) removed only comma, dot and semicolon from the end of the
> > author name.

> I meant the name strbuf_addstr_without_crud did not exist until I added
> it in c96f0c8, about a month ago. But yes, the functionality of the code
> has been there since the very early days.

> I'm tempting by the patch below, which would remove only the
> syntactically significant meta-characters ("\n", "<", and ">"), as well
> as trimming any stray whitespace at the edges. The problem is that we
> don't really have a clue how many people were relying on this trimming
> to clean up their names or emails, so there may be regressions for other
> people.

So maybe the option to enable/disable the old behaviour should be added.

-- 
  Kacper
