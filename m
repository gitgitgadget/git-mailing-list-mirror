From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Newbie grief
Date: Thu, 3 May 2012 15:33:53 -0400
Message-ID: <20120503193353.GI18002@thunk.org>
References: <86mx5rmx32.fsf@red.stonehenge.com>
 <4FA055D0.7040102@palm.com>
 <86aa1rmvhb.fsf@red.stonehenge.com>
 <4FA05E9F.9090709@palm.com>
 <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
 <947c3d6ae263495985543764a57c3fbb-mfwitten@gmail.com>
 <63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no>
 <e7c7047452954a4b80f5fd436103cb11-mfwitten@gmail.com>
 <f66919ac273fd1c90839e5556f126960@ulrik.uio.no>
 <4FA2CDCC.6020303@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	Michael Witten <mfwitten@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Thu May 03 21:34:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1n2-00012p-MF
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431Ab2ECTeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:34:06 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:35394 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758358Ab2ECTeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:34:05 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1SQ1mm-0006tr-4N; Thu, 03 May 2012 19:33:56 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SQ1mj-0007RZ-Lw; Thu, 03 May 2012 15:33:53 -0400
Content-Disposition: inline
In-Reply-To: <4FA2CDCC.6020303@palm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196949>

On Thu, May 03, 2012 at 11:26:20AM -0700, Rich Pixley wrote:
> 
> In other systems, the branches are tracked identically.  You see
> master, I see master.  The only differences we see are any changes
> I've created that haven't yet been pushed to you or vice verse.  But
> since git can't handle collisions in the repository the way other
> systems do, it's forced to use the geographic branch scheme for
> non-bare repositories.  Bare repositories don't have the collision
> between repository branch and working directory copy in git, so with
> bare repositories, git can use the identical branch scheme,
> (although it still refuses colliding pushes).

I'm still not sure I understand your development workflow.  It seems
like you are trying to publish multiple branches across to multiple
repositories on different machines, so they are visible to different
developers?  What are all of these branches used for, and why are you
doing things this way?  (I'm not implying that the reason you have for
doing this way is silly or stupid, just that I don't understand it and
I don't understand why you feel you need to do things this way.)

> What I don't understand is why git chose this less functional
> architecture over the previously existing practice that doesn't have
> these limitations, although "because that's what BitKeeper did"
> might be the sad answer.

It's mainly because many git users, including many kernel developers
have a set of development workflows which is well suited for how git
is set up to work.  So git was very much shaped by the development
workflows of the early git users --- and it goes the other way, too
--- new git features will sometimes cause our development practices
and workflow to evolve.

So I may have a number of different branches that I'm working on, but
in general they stay local to my repository until they are ready to be
merged to mainline.  If patches need to be reviewed, they either get
sent via e-mail to the appropriate mailing list, and the review
happens via e-mail, or internally at $WORK, we use Gerrit and we push
the change to gerrit where the patches are kept and trackked inside
Gerrit, alongside the comments as the patch goes through the review
process.  (I suspect you are pushing patches out to the repository for
review as the patches are getting developed and refined, but I don't
know that for sure, since you haven't talked about why you want the
particular SCM features that you've been asking for.)

Once a patch is fully baked, it goes into a maintainer's repository
where it gets pulled into a higher-level maintainer's repository.  So
in practice a developer's repository has very few branches that he or
she needs to export to the outside world, at least as I and other
Linux kernel developers typically tend to use git.

It's obvious you want to use your DSCM in a different way, and it's
not that any particular workflow is right or wrong.  But obviously,
some tools are a better match for certain workflows as compared to
other workflows.

Regards,

					- Ted
