From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 11:16:14 +0100
Message-ID: <20071127101614.GB26072@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org> <Pine.LNX.4.64.0711230050270.27959@racer.site> <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com> <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org> <20071125170019.GB25800@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0711261647400.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 11:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwxUs-0001us-3n
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 11:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbXK0KQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 05:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbXK0KQe
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 05:16:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1197 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbXK0KQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 05:16:34 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IwxUE-0006tU-00; Tue, 27 Nov 2007 10:16:14 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711261647400.27959@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66180>

On 2007-11-26 16:48:14 +0000, Johannes Schindelin wrote:

> On Sun, 25 Nov 2007, Karl Hasselstr=F6m wrote:
>
> > On 2007-11-23 15:59:58 -0500, Shawn O. Pearce wrote:
> >
> > > I have been considering creating a "git-gui daemon" process that
> > > links to libgit.a and can be driven bidirectionally through its
> > > stdin/stdout. Based on git-fast-export, sorta. But I haven't
> > > even started it...
> > >
> > > But the idea is sort of what Han-Wen wants. Why should I fork
> > > rev-parse to get a ref value? Or update-ref to change one?
> >
> > Obviously, something like this would be very valuable for StGit as
> > well.
>
> Could you be a little more specific _what_ you want to do, and _how_
> this could be done with fast-export | fast-import?

Currently, a single StGit command can result in quite a few
invocations of git-cat-file, for example, each of which forks off a
new process. If it could start just one daemon such as Shawn proposed,
and feed it simple questions and commands about blobs, trees, commits,
and refs, that would probably be quite a lot faster.

=46rom what I understand, this is not something that would fit a
fast-export | fast-import pipeline. Which is why I didn't take the
time to elaborate on (or indeed find out) exactly which commands StGit
would like such a daemon to support.

By the way: one command one _would_ likely want in the daemon is "list
modified files". Being long-lived (not when driven by StGit, perhaps,
but definitely when driven by git-gui or qgit), the daemon would be
able to use inotify for that.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
