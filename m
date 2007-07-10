From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC] series headers
Date: Tue, 10 Jul 2007 10:48:09 -0400
Message-ID: <20070710144808.GA27033@thunk.org>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org> <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net> <20070710132401.GJ2343@thunk.org> <Pine.LNX.4.64.0707101452250.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8H0t-0000sU-0v
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbXGJOsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbXGJOsR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:48:17 -0400
Received: from THUNK.ORG ([69.25.196.29]:56480 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbXGJOsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:48:17 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I8H8c-0004fq-Ct; Tue, 10 Jul 2007 10:56:26 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I8H0b-0002IU-5L; Tue, 10 Jul 2007 10:48:09 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707101452250.4047@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52082>

On Tue, Jul 10, 2007 at 02:56:48PM +0100, Johannes Schindelin wrote:
> And what is so wrong with
> 
> [insert before format-patch] $EDITOR my-cover-letter.txt
> 
> [replace $EDITOR 0000-cover-letter.txt] $EDITOR my-cover-letter.txt 
> 	0000-cover-letter.patch
> 
> and paste the changed text?

Nothing is *wrong* with it per-se, but if you have multiple things
that you are working on at the same-time, you might not want to keep
0000-cover-letter.patch in your working directory.  

The simplest place to put it is in .git/patches/<branch> while I'm
working with it using guilt (or the equivalent place in stgit), and if
you include it in the series file then it becomes easier to hack it so
that git-format-patches will create the cover letter for you.  (And
ideally, you would be able to use guilt to edit the cover letter using
"guilt header -e cover-letter" but that feature hasn't been added yet;
should be simple, though.)

Basically, the issue is of handling the cover letter as a first-class
object, as opposed to something whic his manually handled via
cut-and-paste.  A lot of the tools are actually there already if you
are using tools like guilt and stgit.  So it's basically making a
particular workflow a bit more optimized, that's all.  

There certainly is nothing *wrong* with manual maintenance of the
cover-letter file plus cut-and-paste when you want to update it.  Just
as there's nothing *wrong* with using git-write-tree instead of
git-commit.  Just a question of which is more convenient and less
error prone.  :-)

						- Ted
