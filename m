From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/5] Add a --cover-letter option to format-patch
Date: Wed, 20 Feb 2008 11:57:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802201143180.19024@iabervon.org>
References: <cover.1203392527.git.barkalow@iabervon.org> <alpine.LNX.1.00.0802182254310.5816@iabervon.org> <7vfxvodz1i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 17:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRsGU-0007Sm-W2
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 17:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758199AbYBTQ5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 11:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760035AbYBTQ5J
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 11:57:09 -0500
Received: from iabervon.org ([66.92.72.58]:55586 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbYBTQ5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 11:57:05 -0500
Received: (qmail 26391 invoked by uid 1000); 20 Feb 2008 16:57:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 16:57:02 -0000
In-Reply-To: <7vfxvodz1i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74523>

On Tue, 19 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > +	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
> > ...
> > diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
> > new file mode 100644
> > index 0000000..311e207
> > --- /dev/null
> > +++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
> > @@ -0,0 +1,101 @@
> > +$ git format-patch --stdout --cover-letter -n initial..master^
> > +From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
> > +From: C O Mitter <committer@example.com>
> > +Date: Mon, 26 Jun 2006 00:05:00 +0000
> > +Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
> > +
> > +
> > +*** BLURB HERE ***
> > +
> > +A U Thor (2):
> > +      Second
> > +      Third
> 
> I still disagree with your earlier point on the extra blank line
> here.
> 
> When we give commit log template, we do leave an extra blank line
> before we start the template material "# Please enter ...", to
> ease typing, but it is different.  The template material does
> not have to be removed by the end-user, so giving a blank line
> upfront and starting the editor at that line is a usability
> improvement, compared to the case where there is none.
> 
> But this "*** BLURB HERE ***" needs to be removed when the user
> edits the cover-letter, and I really do not see any reason to
> have an extra blank line in front of it.
> 
> Incidentally, I strongly suspect that if you do not have that
> extra blank line, we would not even need to have the [PATCH 4/5]
> (which is a slight regression) in the series.
> 
> So how about this squashed in, with [PATCH 4/5] skipped?

Sure. I still like the extra line, but it's not that big a deal. (And I 
still think it's odd that the code removes extra blank lines from that 
spot but not elsewhere, but likewise not a big deal)

	-Daniel
*This .sig left intentionally blank*
