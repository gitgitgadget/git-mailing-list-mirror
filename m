From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Mon, 18 Feb 2008 12:15:55 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181203080.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171335520.5816@iabervon.org> <7v4pc7udux.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:16:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR9bh-0004s1-Ca
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYBRRQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbYBRRQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:16:09 -0500
Received: from iabervon.org ([66.92.72.58]:34208 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbYBRRQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:16:07 -0500
Received: (qmail 22283 invoked by uid 1000); 18 Feb 2008 17:15:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 17:15:55 -0000
In-Reply-To: <7v4pc7udux.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74315>

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > +	argv[0] = "shortlog";
> > +	argv[1] = head_sha1;
> > +	argv[2] = "--not";
> > +	argv[3] = origin_sha1;
> > +	argv[4] = NULL;
> > +	fflush(stdout);
> > +	run_command_v_opt(argv, RUN_GIT_CMD);
> 
> Please make it a habit to always append "--" disambiguator for
> such command lines generated internally.  In this case you are
> not usinging short and common name like "master" or "HEAD" but
> 40-letter-long hex string, so it is much less likely to get hit
> by the "ambiguous rev vs file" rule, but even then it is still
> possible that a work tree happens to have a file with the same
> name.

Sure.

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
> > +
> 
> This probably falls within the "personal taste" category, but
> I'd rather not to see two extra blank lines between Subject: and
> BLURB HERE.

The file is ugly with the double blank line, but I like it for what I 
think is the normal case, where you import the series into your mail 
reader, edit the cover letter there (where it appears as a message with 
some space devoted to the blurb by virtue of starting with now one blank 
line), and then send. In that context, I think it's nicer.

	-Daniel
*This .sig left intentionally blank*
