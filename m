From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Wed, 1 Oct 2008 00:14:53 +0200
Message-ID: <20080930221453.GA13659@strlen.de>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp> <20080929150127.GB18340@spearce.org> <20080930095641.GA9001@strlen.de> <20080930190449.GG21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 00:16:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KknVq-00038D-7r
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 00:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbYI3WPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 18:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbYI3WPA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 18:15:00 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:51345 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752957AbYI3WO7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 18:14:59 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1KknUb-0003Zg-Mx; Wed, 01 Oct 2008 00:14:53 +0200
Content-Disposition: inline
In-Reply-To: <20080930190449.GG21310@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97164>

Hi Shawn,

On Tue, Sep 30, 2008 at 12:04:49PM -0700, Shawn O. Pearce wrote:
> Uwe Kleine-KKKnig <ukleinek@strlen.de> wrote:
> > On Mon, Sep 29, 2008 at 08:01:27AM -0700, Shawn O. Pearce wrote:
> > > --tags::
> > > 	If a lightweight tag exactly matches, output it.  If no
> > > 	annotated tag is found in the ancestry but a lightweight
> > > 	tag is found, output the lightweight tag.
> >
> > IMHO --tags should behave as Erez expected (because it's what I
> > expected, too).  As --tags currently behaves it's only usable in very
> > rare cases (most of the time it only makes a difference on repos without
> > any annotated tag).
> > 
> > When do you pass --tags?  Only if a lightweight tag is OK for an answer.
> > And then I would prefer a "near" lightweight tag to a "farer" annotated
> > one.
> 
> I don't disagree.  I've been tempted to write a patch to change the
> behavior of git-describe so that --tags and --all control what names
> are inserted into the candidate list, but don't control the ordering
> of their selection.
> 
> I think this is all that is needed to make the behavior do what you
> and Erez expected.  But its a pretty big change in the results if
> you are passing in --all or --tags today.
But it matches the documentation, and the expectations of Erez, me and
(at least initially) Pierre.

My POV is still:  If you pass --all or --tags you have to be able to
handle if a lw tag is used in the answer.

> -static int all;	/* Default to annotated tags only */
> -static int tags;	/* But allow any tags if --tags is specified */
> +static int all;	/* Any valid ref can be used */
> +static int tags;	/* Either lightweight or annotated tags */
Mmmh, IMHO the comment for tags is misleading, its either annotated only
or both.

Best regards and thanks,
Uwe
