From: Mike Hommey <mh@glandium.org>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 22:55:28 +0100
Organization: glandium.org
Message-ID: <20071113215528.GA30695@glandium.org>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3mH-0001m2-KR
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450AbXKMV5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759425AbXKMV5n
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:57:43 -0500
Received: from vawad.err.no ([85.19.200.177]:46324 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344AbXKMV5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:57:42 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Is3kg-0005xS-8Y; Tue, 13 Nov 2007 22:57:00 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Is3jF-0000BL-1h; Tue, 13 Nov 2007 22:55:29 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64890>

On Tue, Nov 13, 2007 at 12:56:19PM -0800, Linus Torvalds wrote:
> 
> Ok, I've made a bugzilla entry for this for the Fedora people, but I 
> thought I'd mention something I noticed yesterday but only tracked down 
> today: it seems like the beagle file indexing code is able to screw up git 
> in subtle ways.
> 
> I do not know exactly what happens, but the symptoms are random (and 
> quite hard-to-trigger) dirty index contents where git believes that some 
> set of files are not clean in the index.
> 
> I *suspect* that beagle is playing games with the file access times, 
> causing the ctime on disk to not match the ce_ctime in the index file. But 
> that's just a guess.
(...)

IIRC, beagle stores a bunch of useful information for itself in extended
attributes on indexed files. It is likely that it's that that is
tampering with the file stats.

Mike
