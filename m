From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 15:45:54 -0700
Message-ID: <20120727224554.GA30385@dcvr.yhbt.net>
References: <7vhast3hpb.fsf@alter.siamese.dyndns.org>
 <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
 <20120727220753.GA7378@dcvr.yhbt.net>
 <20120727221924.GA8700@dcvr.yhbt.net>
 <7vboj0zv7t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutIG-0000au-Jv
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab2G0Wp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:45:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33731 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab2G0Wpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:45:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83931F5B5;
	Fri, 27 Jul 2012 22:45:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vboj0zv7t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202388>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > The redundant dependencies are biting us :<  I agree there presence in
> > the top-level Makefile needs to be reviewed.
> 
> Do you feel confident enough that we can leave that question hanging
> around and still merge this before 1.7.12 safely?

Yes.

> I do not think it is a regression at the Makefile level per-se---we
> didn't have right dependencies to keep perl.mak up to date, which
> was the root cause of what we observed.
> 
> But the lack of dependencies did not matter before this series
> because the list of *.pm files never changed, so in that sense the
> series is what introduced the build regression, and I do not have a
> solid feeling that we squashed it.

Right, I agree the original dependencies are not good and it's not
a recent regression in the Makefile level.

I do feel our patch deals with the problem for now.  I've been going
between commits in Michael's 3rd series and haven't noticed new issues
when running the tests.
