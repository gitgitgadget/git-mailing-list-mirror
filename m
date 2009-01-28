From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Heads up: rebase -i -p will be made sane again
Date: Tue, 27 Jan 2009 23:21:36 -0600
Organization: Exigence
Message-ID: <20090127232136.c54369d6.stephen@exigencecorp.com>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
	<20090127085418.e113ad5a.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0901280225240.3586@pacific.mpi-cbg.de>
	<20090127213950.3596ecf9.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0901280458590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 06:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2tN-0005i8-7Y
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 06:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbZA1FVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 00:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbZA1FVo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 00:21:44 -0500
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:45975 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbZA1FVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 00:21:44 -0500
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 6C140DB468;
	Wed, 28 Jan 2009 00:21:42 -0500 (EST)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 37543DB44A;
	Wed, 28 Jan 2009 00:21:42 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901280458590.3586@pacific.mpi-cbg.de>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107479>


> > > So I adapted my code to find the "dropped" merges in 
> > > git-rebase--interactive, too, for now, but I guess the proper fix is 
> > > something like this:
> > 
> > So, if C, as a merge commit, doesn't get a patch id anymore (right?),
> > does that mean that C is included with A and D in the cherry-picking
> > on top of UPSTREAM (because with no patch id it cannot be recognized
> > as a duplicate)?
> 
> Yep, it gets into the list.  But not with a "pick" command, as a merge it 
> will get a "merge" command.
> 
> > So then C' is an empty-commit? This would be fine, I think, or can you 
> > detect that C is a noop somehow without patch ids?
> 
> Actually, there are three possible outcomes:
> 
> - it tries to merge an ancestor of HEAD or HEAD itself -> noop
> 
> - it tries to merge which results in a fast-forward -> fine
> 
> - it tries to merge and a proper merge is necessary -> may conflict

Ah, cool, that makes sense.

Thanks,
Stephen
