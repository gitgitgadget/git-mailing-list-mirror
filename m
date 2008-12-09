From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 10:39:50 -0600
Organization: Exigence
Message-ID: <20081209103950.46c0cc00.stephen@exigencecorp.com>
References: <1228815240.18611.48.camel@starfruit.local>
	<8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
	<1228817565.18611.54.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 17:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA5e4-0004yT-KG
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 17:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbYLIQjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 11:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbYLIQjz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 11:39:55 -0500
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:53150 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYLIQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 11:39:54 -0500
Received: from relay20.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay20.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 35FEE1B9FBB;
	Tue,  9 Dec 2008 11:39:54 -0500 (EST)
Received: by relay20.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id E93641BA021;
	Tue,  9 Dec 2008 11:39:53 -0500 (EST)
In-Reply-To: <1228817565.18611.54.camel@starfruit.local>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102639>


> > $ git config branch.stable.mergeoptions "--no-ff"
> 
> I recall stumbling across this a while ago looking at the git-config(1)
> man page, but this isn't /quite/ what we need.
> 
> I'm talking about forcing for *every* pull, it's a safe assumption to
> make that we want a merge commit every time somebody fast-forwards a
> branch. 
> 
> The only way I could think to make use of branch.<name>.mergeoptions
> would be to automagically set it up in a "pre-merge" hook, but alas
> post-merge exists but not pre-merge.

I had done something like this with a post-checkout hook. After checking
out any branch, the hook sets various branch.<name>.options.

Also, I wrote a hook to enforce "only no-ff commits can move stable" and
other fun stuff. It's out on github, in a semi-documented/unannounced
project with the email/trac/etc. hooks we put in place:

http://github.com/stephenh/gc/tree/master/server/update-stable

- Stephen
