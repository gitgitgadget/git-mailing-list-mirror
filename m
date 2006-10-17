From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:21:59 +1000
Message-ID: <20061017082159.GB5215@sourcefrog.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <20061017052019.GB21210@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 17 10:22:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZkDy-0003QI-1x
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 10:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423156AbWJQIWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 04:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423157AbWJQIWz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 04:22:55 -0400
Received: from ozlabs.org ([203.10.76.45]:48862 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1423156AbWJQIWv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 04:22:51 -0400
Received: from hope.sourcefrog.net (ppp112-44.static.internode.on.net [150.101.112.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37B0167C4F;
	Tue, 17 Oct 2006 18:22:50 +1000 (EST)
Received: by hope.sourcefrog.net (Postfix, from userid 1000)
	id 85E665C414; Tue, 17 Oct 2006 18:21:59 +1000 (EST)
To: Shawn Pearce <spearce@spearce.org>
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <20061017052019.GB21210@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29034>

On 17 Oct 2006, Shawn Pearce <spearce@spearce.org> wrote:
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> > Jakub Narebski wrote:
> > > One cannot have universally valid revision numbers (even
> > > only per branch) in distributed development. Subversion can do that only
> > > because it is centralized SCM. Global numbering and distributed nature
> > > doesn't mix... hence contents based sha1 as commit identifiers.
> > 
> > Sure.  Our UI approach is that unique identifiers can usefully be
> > abstracted away with a combination of URL + number, in the vast majority
> > of cases.
> 
> But this only works when the URL is public.  In Git I can just lookup
> the unique SHA1 for a revision in my private repository and toss it
> into an email with a quick copy and paste.  

Yes, but then people need to know how to get it out of your private
repository.  For stuff that goes into well-known repositories I suppose
it just propagates.

> With Bazaar it sounds like I'd have to do that relative to some known
> public repository, which just sounds like more work to me.

You can also name a revision using its UUID, in which case things will
work similarly to git.  We tend to often say "in r1234 of dev".

> But I don't want to see this otherwise interesting thread devolve into
> a "we do X better!" match so I'm not going to say anything further here.

Sure.

> > > I wonder if any SCM other than git has easy way to "rebase" a branch,
> > > i.e. cut branch at branching point, and transplant it to the tip
> > > of other branch. For example you work on 'xx/topic' topic branch,
> > > and want to have changes in those branch but applied to current work,
> > > not to the version some time ago when you have started working on
> > > said feature.
> > 
> > If I understand correctly, in Bazaar, you'd just merge the current work
> > into 'xx/topic'.
> 
> Git has two approaches:
> 
>  - merge: The two independent lines of development are merged
>    together under a new single graph node.  This is a merge commit
>    and has two parent pointers, one for each independent line of
>    development which was combined into one.  Up to 16 independent
>    lines can be merged at once, though 12 is the record.
> 
>  - rebase: The commits from one line of development are replayed
>    onto a totally different line of development.  This is often
>    used to reapply your changes onto the upstream branch after the
>    upstream has changed but before you send your changes upstream.
>    It can often generate more readable commit history.
> 
> I believe what you are talking about in Bazaar is the former (merge)
> while what Jakub was talking about was the latter (rebase).

For the 'rebase' operation in Bazaar you can use 'bzr graft':

  http://spacepants.org/src/bzrgraft/

-- 
Martin
