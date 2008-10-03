From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Numeric Revision Names?
Date: Fri, 3 Oct 2008 12:42:24 -0500
Organization: Exigence
Message-ID: <20081003124224.843a5a21.stephen@exigencecorp.com>
References: <19796862.post@talk.nabble.com>
	<m3d4ihr7as.fsf@localhost.localdomain>
	<20081003115557.08d80c2f.stephen@exigencecorp.com>
	<200810031913.55594.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	marceloribeiro <marcelo@sonnay.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 03 19:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klogl-0007ke-4s
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 19:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYJCRm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 13:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbYJCRm2
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 13:42:28 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:57653 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbYJCRm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 13:42:28 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id B093A9B2AB0;
	Fri,  3 Oct 2008 13:42:27 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 1DDEB9B27A9;
	Fri,  3 Oct 2008 13:42:27 -0400 (EDT)
In-Reply-To: <200810031913.55594.trast@student.ethz.ch>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97441>


> You might as well use the commit (not author!) timestamp for that
> purpose (assuming your clocks are all synced).

True. Revision numbers are typically shorter though. E.g. we're on
~19,000 now, which is less digits than 20081003122101.

> They do not convey history membership, only history non-membership,
> for the same obvious reason that commit timestamps do.

I know--see my explicit disclaimer about false negatives in my previous
post.

I'll nit pick, revision numbers if put together with branch name, can
actually occassionally convey history membership (subject to false
negatives).

For example, our bug fix hook will say "hashX committed on topica as
r100" and so if qa is looking at a build that was built while on topica
at r105 (so labeled) "topica-r105") then it is very likely hashX is on
the box.

Okay, not with branch renames, but for all intents and purposes. Of
course, as you point out, topicb-r106 says nothing about the
availability of hashX, but that is a less common question for our qa
team than the first two. And they ask the question often enough during
the day that addressing the major 2 of the 3 cases helps cut down "hey
dev--I've got this hash..." calls.

Do not confuse my willingness to hack commit numbers into our git repo
(and my willingness to share our hack with the original poster) with
full fledged support of the concept. Hashes are superior, but, when
they work, revision numbers are nice too. I did not see a reason we
could not have both, especially if it made people more comfortable with
git.

(I also face/faced a situation where "monotonic revision numbers" were
essentially a check box item on a required list of SCM features, so
despite whatever I/the-git-team/etc. thought about their technical
inferiority, it was a criteria that could have ruled git out for us.
Hence my mentioning an FAQ entry for others faced with my same
political situation.)

- Stephen
