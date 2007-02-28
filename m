From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 11:10:55 -0600
Message-ID: <17893.47007.136145.112498@lisa.zopyra.com>
References: <20070228044719.GA6068@spearce.org>
	<17893.40847.313519.283218@lisa.zopyra.com>
	<17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
	<17893.43522.511785.121778@lisa.zopyra.com>
	<17893.44181.129918.669187@lisa.zopyra.com>
	<20070228163256.GD5479@spearce.org>
	<118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
	<20070228164922.GB5924@spearce.org>
	<17893.46083.869042.467318@lisa.zopyra.com>
	<20070228170641.GC5924@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSKf-0007Hg-8u
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbXB1RK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933194AbXB1RK7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:10:59 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60778 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933193AbXB1RK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:10:58 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SHAtm30438;
	Wed, 28 Feb 2007 11:10:55 -0600
In-Reply-To: <20070228170641.GC5924@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40969>

On Wednesday, February 28, 2007 at 12:06:41 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> % strace -f -o tracefile git clone --bare ~/devel/project
>> [...]
>> fatal: cannot pread pack file: Success from=39395, packfile size=0
>> [...]
>> % grep pread tracefile
>> 28635 pread(3,  <unfinished ...>
>> 28635 <... pread resumed> "", 207, 39395) = 0
>> 28635 write(2, "cannot pread pack file: Success "..., 59) = 59
>
>Well, that answers that.  The packfile is 0 bytes long.  Why?
>We downloaded the data and are trying to resolve deltas... but
>when we go back into the packfile we thought we had, we find it is
>nothing but an empty file.  NFS strikes again!
>
>Have you been able to clone onto this drive before?  Maybe with a
>different version of Git (1.4.x series, before this pread change
>in index-pack)?  Clearly this operation should be working, but
>its not, and I'm certainly at a loss for why the file would just
>magically truncate itself.

Yes: 1.4.x worked fine.  This was actually my attempt to re-do the 1.4
clone I had laying around, as I wanted my backup done with 1.5.  I
still have the 1.4 cloned repo, just moved it out of the way...


Bill
