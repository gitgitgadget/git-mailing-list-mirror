From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 11 Mar 2008 20:22:18 +0100
Message-ID: <20080311192218.GA7040@efreet.light.src>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <478D1442.2090301@gmx.ch> <c0f2d4110801151230g5843df66t62fb659375a1680e@mail.gmail.com> <alpine.LNX.1.00.0801152109580.13593@iabervon.org> <320075ff0803111038x36bc40bbkf4b9eec6dd9284fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZA4Y-0006fI-TR
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 20:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbYCKTWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 15:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYCKTWl
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 15:22:41 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:57215 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbYCKTWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 15:22:40 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A6AAA57542;
	Tue, 11 Mar 2008 20:22:38 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id EWUv2OO5YSoQ; Tue, 11 Mar 2008 20:22:29 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 155A257444;
	Tue, 11 Mar 2008 20:22:27 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JZA3H-0001u7-6X; Tue, 11 Mar 2008 20:22:19 +0100
Content-Disposition: inline
In-Reply-To: <320075ff0803111038x36bc40bbkf4b9eec6dd9284fd@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76895>

On Tue, Mar 11, 2008 at 17:38:22 +0000, Nigel Magnay wrote:
> Did there ever become a way of generating svn format diffs from git?

There was a talk about it, but I am not sure anything was actually written.
Would be quite easy to add the Index: and equals line with a few lines of
perl.

> A project is having a hard time applying my format-patch --no-prefix
> diffs, but I don't have a tortoiseSVN machine to figure out why..

You quoted quite precise explanation below.

> On Wed, Jan 16, 2008 at 2:20 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Tue, 15 Jan 2008, Chris Ortman wrote:
> >
> >
> > > You are correct about Tortoise in that it is too strict.
> >  > I looked through their code and they have written their own patch
> >  > program which keys off these Index: lines
> >  > http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/src/TortoiseMerge/Patch.cpp
> >  >
> >  > I think it could go either way as to if git-svn creates a different
> >  > format patch or tsvn accepts multiple formats, but I anticipated
> >  > git-svn would be easier to extend so I started here.
> >
> >  I think it would be worthwhile for tsvn to be less picky in some ways. It
> >  should at least be able to accept GNU diff, since sometimes people send
> >  maintainers patches prepared by hand (diff -u file.c.orig file.c), and
> >  there are comments in there that suggest that they're trying to support
> >  non-svn-generated diffs, although they seem to think that such diffs look
> >  like:
> >
> >  Index: filename
> >  ============
> >  @@ -xxx,xxx +xxx,xxx @@
> >  ...
> >
> >  which isn't anything I've ever seen. You're much more likely to get:
> >
> >  ...junk...
> >  --- junk
> >  +++ filename    junk
> >  @@ -xxx,xxx +xxx,xxx @@
> >
> >  And that should be easy enough to parse as an alternative format in tsvn.
> >  (I'd send them a patch to do it, but they wouldn't be able to apply it...)
> >
> >
> >         -Daniel
> >  *This .sig left intentionally blank*
> >  -
> >
> >
> > To unsubscribe from this list: send the line "unsubscribe git" in
> >  the body of a message to majordomo@vger.kernel.org
> >  More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
