From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 04:03:02 -0500
Organization: Exigence
Message-ID: <20080923040302.c4d0d33b.stephen@exigencecorp.com>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
	<20080922231927.ef18f420.stephen@exigencecorp.com>
	<48D88813.9060400@viscovery.net>
	<20080923024653.a3bb8666.stephen@exigencecorp.com>
	<48D8A6EA.4020805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki3oj-0007eW-Pk
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 11:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYIWJDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 05:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbYIWJDK
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 05:03:10 -0400
Received: from smtp112.sat.emailsrvr.com ([66.216.121.112]:48604 "EHLO
	smtp112.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbYIWJDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 05:03:09 -0400
Received: from relay1.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id A791A24CB72;
	Tue, 23 Sep 2008 05:03:07 -0400 (EDT)
Received: by relay1.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 2A47D24CAEB;
	Tue, 23 Sep 2008 05:03:07 -0400 (EDT)
In-Reply-To: <48D8A6EA.4020805@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96540>


> >  ---A--B--C--D           <-- origin/stable
> >      \       |
> >       E--F   |           <-- origin/topica
> >           \  |
> >              g--h        <-- topica
> > 
> > All the upper case commits have been published to origin. Other
> > devs, etc., know about them, their hashes are in the bug tracking
> > system.
> > 
> > I'm bringing topica up to date, but with a merge because I have
> > published history already on topica, so I merge stable and get a
> > new merge commit: g. And maybe make another change: h.
> > 
> 
> Why do you merge stable at this point?

Good question--I appreciate the sanity check.

I merged stable because we had a new release of the software. E.g.
A=1.0, B=1.1, C=1.2, and finally D=1.3.

So, topica is a new feature, "Add widgets/whatever", but it's not ready
for stable (production) yet, so, yes, I think it is a topic branch.

However, D=1.4 is now out the door, I've had two commits E and F on
topica that I had already committed and pushed out for code review, our
email list, and our bug tracker, and now, post-1.4, qa wants to see
topica up and running to see if it's good enough to go into the next
release.

If our deployment guy pushes out F, qa is going to (and did) complain
that they're not seeing the latest features from 1.4 in topica.

As you said, integration testing.

Okay, so I merge g, however, I really want to push it back out so that
the deployment guy can push it to qa (he would rather not resolve my
conflicts by making his own local g). And even if I did the deployment
myself, locally against g, I would prefer to share g in case another
dev working on the same topic gets feedback about funkiness from qa and
would like to see the code as it is in qa. E.g.: g.

I can appreciate that if I was doing integration testing all by myself,
with only automated tests, I could throw g away. However, even then, I
would prefer to push g out and let our integration server run the tests
for me.

Does this sound reasonable?

Thanks,
Stephen
