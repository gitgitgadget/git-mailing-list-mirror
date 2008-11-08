From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: pull --preserve-merges
Date: Sat, 8 Nov 2008 11:57:10 -0600
Organization: Exigence
Message-ID: <20081108115710.7f501aa9.stephen@exigencecorp.com>
References: <20081107160138.aa96405c.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0811081607300.30769@pacific.mpi-cbg.de>
	<200811081807.53199.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 18:58:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kys4v-00019g-Dj
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbYKHR5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 12:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYKHR5O
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 12:57:14 -0500
Received: from smtp182.sat.emailsrvr.com ([66.216.121.182]:57650 "EHLO
	smtp182.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYKHR5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 12:57:13 -0500
Received: from relay8.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 297A411B0BF0;
	Sat,  8 Nov 2008 12:57:12 -0500 (EST)
Received: by relay8.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id A1FB511B0BEC;
	Sat,  8 Nov 2008 12:57:11 -0500 (EST)
In-Reply-To: <200811081807.53199.fg@one2team.net>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100414>


Replying to both Johannes and Francis...

> > > Awhile ago I brought up wanting to have a "rebase with preserve merges"
> > > option for `git pull`
> >
> > That might be something you want, but you cannot call it
> >
> > 	git pull --preserve-merges
> >
> > since everybody used to "pull = fetch && merge" would go "Huh? A merge
> > _does_ preserve merges".

Ah, right, sorry, Johannes, I know it only makes sense in the context if
--rebase is also being in use, I was just being too brief.

> > If at all, you could call it "--rebase=preserve-merges".

I'd be fine with that, I had not thought of it.

> Why not --rebase --keep-merges? Personnally, I think it makes things clearer 
> since in general options are either standalone or have a value.

I originally had --rebase --preserve-merges in mind because it matches
the existing -p/--preserve-merges flag that git rebase has that I'd
like git pull to just pass along.

If they were separate flags, passing just --preserve-merges without
--rebase should likely report an error. Probably the same thing if
someone sets `branch.name.preservemerges` but `branch.name.rebase` is
not set.

Unless instead of separate config parameters, `branch.name.rebase` uses
Johannes's suggestion and has separate values...true or false or
preserve-merges. That would probably better parallelize with the
--rebase=preserve-merges style command line argument.

Between one flag/config parameter or two flags/config parameters, I
could go either way and would be willing to patch together either one
to get it in.

Thanks,
Stephen
