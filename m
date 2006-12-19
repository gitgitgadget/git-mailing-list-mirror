X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 10:13:19 +0100
Message-ID: <20061219091319.GC30448@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org> <20061219083242.GF2511@spearce.org> <20061219084017.GB30448@fiberbit.xs4all.nl> <20061219084908.GG2511@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Date: Tue, 19 Dec 2006 09:13:57 +0000 (UTC)
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219084908.GG2511@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34805>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwb2i-0001sY-9c for gcvg-git@gmane.org; Tue, 19 Dec
 2006 10:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932707AbWLSJNi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 04:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWLSJNi
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 04:13:38 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:60957 "EHLO
 fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932707AbWLSJNg (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 04:13:36 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
 (envelope-from <marco.roeland@xs4all.nl>) id 1Gwb2F-0008An-CP; Tue, 19 Dec
 2006 10:13:19 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tuesday December 19th 2006 at 03:49 Shawn Pearce wrote:

> [pread patch to speed up git-index-pack on Mac OS X]
> 
> More testing on Linux is probably needed, but if using pread()
> on Linux is breakeven or slightly faster (as suggested by Johannes'
> LilyPond test) this 60x performance improvement on initial clone
> of largish projects on Mac OS X would be nice to have.

I see a decrease in total time (so an improvement in performance)
going from 37.3 to 35.2 seconds with the pread patch on Linux x86-64.
Note that both my testing on Linux and Mac OS X was done on dual core
processors (Athlon 3800+ XP on Linux and Intel Core 2 Duo 2.16GHz on an
iMac). Git is only single threaded and thus uses only core, but the
system can use the other core.

The minor page faults also decreased from 734866 to 370690. Nice.

> Not that I personally frequently clone large projects on Mac OS X.
> But new users to Git might.  :-)

And perhaps the Cygwin version might benefit too.
-- 
