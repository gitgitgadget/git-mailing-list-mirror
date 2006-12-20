X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: Change in git-svn dcommit semantics?
Date: Wed, 20 Dec 2006 06:57:32 -0500
Message-ID: <20061220115731.GA29786@coredump.intra.peff.net>
References: <m2mz5jegka.fsf@ziti.local> <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com> <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de> <C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com> <7v3b7bnz6q.fsf@assigned-by-dhcp.cox.net> <emb77h$cf2$1@sea.gmane.org> <360A3F7A-0849-4BCE-8550-1F05BB9821C5@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 11:57:40 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <360A3F7A-0849-4BCE-8550-1F05BB9821C5@silverinsanity.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34919>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx04n-0008AQ-VO for gcvg-git@gmane.org; Wed, 20 Dec
 2006 12:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754447AbWLTL5f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 06:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWLTL5f
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 06:57:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:53106
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1754447AbWLTL5e (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 06:57:34 -0500
Received: (qmail 825 invoked from network); 20 Dec 2006 06:57:33 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 20 Dec 2006 06:57:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec
 2006 06:57:32 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

On Wed, Dec 20, 2006 at 06:47:45AM -0500, Brian Gernhardt wrote:

> >>The --full-diff option helps because it shows the diff for other
> >>files (that do not have different number of substring COLLISION
> >>in the pre and postimage) in the same commit as well.
> >
> >Yet another undocumented option. Sigh...
> 
> I'd send in a patch to fix that (little gnome work is what I do in  
> Wikipedia, and seems to be what I do here), but the option seems to  
> be in setup_revision.c:setup_revisions, which is used in several  
> places.  Is there a central place to put that in the documentation?   
> Should there be?

Please read the rest of the thread for some explanation from Junio on
how this option works.

I think it makes sense to group the porcelain-ish options together for
git-log/git-whatchanged (and potentially git-show). Really, they can
take any of the diff-options or any of the rev-list options.  The
rev-list options are not currently grouped for inclusion in another man
page. The diff options are available in diff-options.txt, but are not
included by the log manpages.  They probably should be.

