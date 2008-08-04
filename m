From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Mon, 4 Aug 2008 02:03:09 -0700
Message-ID: <20080804090309.GD5435@hand.yhbt.net>
References: <1217684549.8296.10.camel@heerbeest> <20080802172742.GT32184@machine.or.cz> <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org> <1217701021.8296.35.camel@heerbeest> <20080804020931.GA4109@untitled> <1217836189.7649.7.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Aug 04 11:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPvzJ-0006QX-Ha
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 11:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYHDJDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 05:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbYHDJDL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 05:03:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50758 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbYHDJDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 05:03:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 9E6862DC01B;
	Mon,  4 Aug 2008 02:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1217836189.7649.7.camel@heerbeest>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91332>

Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> On zo, 2008-08-03 at 19:09 -0700, Eric Wong wrote:
> 
> > Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> > > I could imagine that leaving git-svn alone and adding a hook to git-log
> > > would be more useful, though.
> > 
> > NACK on modifying git-svn to support more changelog formats.
> > 
> > A better idea would be to write a generic script that takes "git log",
> > "git svn log" or even plain "svn log" output and filters it
> > independently.
> 
> > This filter should be reusable for both plain svn and git-svn:
> 
> >     The possibilities are endless :)
> 
> Yes, but we'll most probably drop SVN rsn, possibly after a short period
> of supporting both; and not stripping the cruft in the conversion means
> we carry this with us until eternity.  Besides, who is going to
> distribute the script, inform users about its availability?
> 
> What we have now suffices for our ooo-build conversion.  If you do not
> find it useful, more power/less code to you.  Let others search the
> archives and/or patch git-svn themselves, if indeed there are any.

In the one-shot case, a git filter-branch script would probably be ideal
and reusable for other projects.

Anyways, I strongly believe changelog modification/reformatting should
be done in a more generic way that can benefit users of other tools
(archimport/cvsimport etc...), too.

-- 
Eric Wong
