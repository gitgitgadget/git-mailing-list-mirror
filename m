X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 09:40:17 +0100
Message-ID: <20061219084017.GB30448@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org> <20061219083242.GF2511@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Date: Tue, 19 Dec 2006 08:40:35 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219083242.GF2511@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34801>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwaWW-0004lQ-8D for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932674AbWLSIk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWLSIk3
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:40:29 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:44059 "EHLO
 fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932674AbWLSIk2 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 03:40:28 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
 (envelope-from <marco.roeland@xs4all.nl>) id 1GwaWH-000864-C4; Tue, 19 Dec
 2006 09:40:17 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tuesday December 19th 2006 at 03:32 Shawn Pearce wrote:

> > Anyway, try the pread() version first, see if that fixes the OS X problem.
> 
> It does.  Without pread() (aka stock 'next') it takes me over an
> hour to index a pack of linux-2.6.  With pread() its 1m6s to run
> index-pack on the same pack file.  The indexes are (of course)
> identically produced.

I see the same here. From an (estimated) time of 37 minutes down to 52
seconds with the pread() patch. Running the profiler (shark) on the old
version showed that 85% of the time was spent in the Mac OS X mmap()
system call.
-- 
