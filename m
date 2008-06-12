From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 19:20:09 +0200
Message-ID: <20080612172009.GD6848@leksak.fem-net>
References: <20080612002258.GC7200@leksak.fem-net> <200806121610.43674.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 19:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6qU3-00072M-Mt
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 19:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYFLRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 13:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757426AbYFLRUP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 13:20:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:59452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757323AbYFLRUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 13:20:14 -0400
Received: (qmail invoked by alias); 12 Jun 2008 17:20:12 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp013) with SMTP; 12 Jun 2008 19:20:12 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/TxGshGyrT3GYO0BbDoauxj7JxwYY9EkQ1bB1Tip
	YPN59xcXaItIBx
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K6qT3-0000BS-E1; Thu, 12 Jun 2008 19:20:09 +0200
Content-Disposition: inline
In-Reply-To: <200806121610.43674.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84768>

Hi,

On Thu, Jun 12, 2008 at 04:10:42PM +0200,
Jakub Narebski <jnareb@gmail.com> wrote to git@vger.kernel.org:
> > SYNOPSIS
> > --------
> > [verse]
> > 'git-sequencer' [--batch] [--onto=<base>] [--verbose] [<file>]
> > 'git-sequencer' --continue | --skip | --abort | --edit | --status
> 
> I'm not sure if --edit should be mentioned in line with "processing"
> commands: --continue, --skip, --abort and related --status.

Hm I've put it in this line, because it's also an option that is rather
than a command and that takes no other options, as --continue, --skip,
--abort, --status are.

For more information, everybody can scroll down and read the
description.

> > OPTIONS
> > -------
> > <file>::
> > 	Filename of the TODO file.  If omitted, standard input is used.
> > 	See 'TODO FILE FORMAT' below.
> 
> Omitted for standard input, --stdin for standard imput, or special
> filename of '-' for standard input?

In the current spec it is omitted.
In the last one, it was '-'.
My mentors and me discussed also the --stdin/--file approach but put
that down.

> > --onto=<base>::
> > 	Checkout given commit or branch before sequencing.
> > 	If you provide a branch, sequencer will make the provided
> > 	changes on the branch, i.e. the branch will be changed.
> 
> I'm not sure if repeating rebase design is best idea.  But this
> ferature is certainly necessary...

Ok, you say that it's necessary.
I thought this, too, up to Junio's mail I just replied to.

Now I think I can get along without that and let the sequencer user
tools prepare and finish that.
This *could* mean duplicated code, but currently the only tool
that would use this feature is rebase-i.

> > -v::
> > --verbose::
> > 	Be more verbose. [XXX: to be defined more accurately, i.e. print diffstat]
> 
> I think it would be nice to have --quiet mode (which perhaps --batch
> would imply, or perhaps not), which would make git-sequencer to not
> report progress report (i.e. which actions are being done).

Currently I have no idea what should be outputted and what not.
I think I won't care about that for the prototypem but for the builtin
sequencer.

But I add -q/--quiet to the spec, but --batch does not imply it ;)

> > git-sequencer will usually be called by another git porcelain, like
> > linkgit:git-am[1] or linkgit:git-rebase[1].
> 
> Or git-cherry-pick, or git-revert.

Well, I don't know about the others, but for me this is currently not
clear ;-)
The prototype uses git-cherry-pick and I think the first versions of my
builtin will also use it.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
