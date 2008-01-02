From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Remove duplication in t9119-git-svn-info.sh
Date: Tue, 1 Jan 2008 19:43:17 -0800
Message-ID: <20080102034317.GB11711@untitled>
References: <7vodc65whw.fsf@gitster.siamese.dyndns.org> <1199143999-6859-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 04:43:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9uWF-00080Y-14
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 04:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbYABDnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 22:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbYABDnT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 22:43:19 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55182 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbYABDnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 22:43:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5BBC02DC034;
	Tue,  1 Jan 2008 19:43:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1199143999-6859-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69452>

Junio C Hamano <gitster@pobox.com> wrote:
> "David D. Kilzer" <ddkilzer@kilzer.net> writes:
> 
> > @@ -350,8 +355,8 @@ test_expect_success 'info unknown-symlink-directory' "
> >  	cd svnwc &&
> >  		ln -s unknown-directory unknown-symlink-directory &&
> >  	cd .. &&
> > -	ptouch gitwc/unknown-symlink-directory \
> > -	       svnwc/unknown-symlink-directory &&
> > +	ptouch svnwc/unknown-symlink-directory \
> > +	       gitwc/unknown-symlink-directory &&
> 
> Hmph.  Am I the only one who finds this repetition somewhat
> disturbing?

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Simplify arguments to ptouch bash function.

Not reading Junio's mind, I think he meant that you were swapping the
"gitwc/" and "svnwc/" args everywhere in your changeset.

Nevertheless, does your change make things work with older
versions of SVN?  I'm running 1.4.x everywhere these days, but
I seem to recall the version of SVN on kernel.org was giving
Junio trouble with the tests.

-- 
Eric Wong
