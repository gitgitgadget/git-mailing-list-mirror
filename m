X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 08:52:56 +0100
Message-ID: <20061219075256.GA30448@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org> <20061219072607.GD2511@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Date: Tue, 19 Dec 2006 08:39:32 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 2766 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 03:39:15 EST
Content-Disposition: inline
In-Reply-To: <20061219072607.GD2511@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34800>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwaVM-0004bX-2h for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932668AbWLSIjR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWLSIjQ
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:39:16 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:44053 "EHLO
 fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932668AbWLSIjQ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 03:39:16 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
 (envelope-from <marco.roeland@xs4all.nl>) id 1GwZmS-0007zk-IJ; Tue, 19 Dec
 2006 08:52:56 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tuesday December 19th 2006 at 02:26 Shawn Pearce wrote:

> [git-index-pack limping along on Mac OS X]
> 
> ActivityMonitor is showing that I'm spending 94% CPU in the kernel,
> which is just insane.  Clearly Mac OS X's kernel cannot gracefully
> handle what git-index-pack is currently doing.

A bit off topic but it might help people diagnose and test different
strategies.

The equivalent of "oprofile" on Mac OS X is a tool called "shark" from
Apple itself. It's very nice actually.

It's in the CHUD (Computer Hardware Understanding
Developer Tools) package. More information at
http://developer.apple.com/tools/performance and it is free as in beer.
;-)

Also the OpenSSL version on Mac OS X is rather old and compiled as
32-bit application. OpenSSL is one of the few userspace packages that
_really_ benefits tremendously from being compiled as 64-bit. It might
explain a bit of the enormous performance difference in this case. But
only profiling (perhaps with the help of "shark") will tell of course...

The kernel git repository isn't very handy on the Mac HFS+ filesystem,
due to it being case-insensitive, but I suppose it won't influence
git-index-pack.
-- 
