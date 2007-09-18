From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 11:54:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181153530.28586@racer.site>
References: <20070917112136.GA30201@glandium.org>
 <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr> <46EF7BF7.3070107@op5.se>
 <Pine.LNX.4.64.0709181109130.28586@racer.site> <CEE6032F-39FB-42D8-A57A-671E4E0875C7@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:55:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXajR-0004Hj-Ro
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbXIRKzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbXIRKzA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:55:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:57893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753513AbXIRKy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:54:59 -0400
Received: (qmail invoked by alias); 18 Sep 2007 10:54:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 18 Sep 2007 12:54:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18coFVcyQEcCLO2G44Q0DairO0WH2DiHB7cWfbDAY
	RkZmsDcdAldjp3
X-X-Sender: gene099@racer.site
In-Reply-To: <CEE6032F-39FB-42D8-A57A-671E4E0875C7@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58575>

Hi,

On Tue, 18 Sep 2007, Benoit SIGOURE wrote:

> On Sep 18, 2007, at 12:13 PM, Johannes Schindelin wrote:
> 
> > On Tue, 18 Sep 2007, Andreas Ericsson wrote:
> > 
> > > const char *find_commit_subject_end(const char *commit_msg)
> > > {
> > > 	const char *dot, *paragraph_end;
> > > 		paragraph_end = strstr(commit_msg, "\n\n");
> > > 	dot = strchr(commit_msg, '.');
> > > 		return min_non_null(dot, paragraph_end); }
> > > 
> > > would probably get it right very nearly always.
> > 
> > Counterexample (not even mentioning the missing handling of NULL):
> > 
> > http://brick.kernel.dk/git/?p=qemu.git;a=commit;h=eb66d86e295cd5a8f13221589806e15db62a62fa
> > 
> > And no, the responsible developer showed a strong unwillingness to adapt
> > to better tools and workflows.
> > 
> 
> OK, look, I think this is the typical case where there is no single solution
> to fit all use cases.
> To handle this specific case, you could say "OK let's stop at punctuation
> symbols then".  But what if my commit message is "Add namespace::member
> whatever."
> 
> If there is a single line followed by a blank line: it's a git-style commit
> message, do what was done before.

That's the current behaviour already.  And has been for a long time.

> Otherwise, we need some heuristic to find the relevant part of the commit
> message (if there is such a relevant part in the first place!).

Or do we?

I was opposed to this change, since I think that there is really no way to 
fit all exisiting (!) repositories.

And since oneline was always only meant as a hint, it might just as well 
have stayed at "just one line, the first one".

Maybe you guys find a better method, such as providing a regular 
expression in the config or something, but let's not do another change 
that does not work for all cases.

Ciao,
Dscho
