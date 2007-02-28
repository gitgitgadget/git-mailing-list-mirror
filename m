From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 10:52:31 -0600
Message-ID: <17893.45903.748382.298137@lisa.zopyra.com>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	<20070228035713.GC5597@spearce.org>
	<20070228044719.GA6068@spearce.org>
	<17893.40847.313519.283218@lisa.zopyra.com>
	<17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
	<17893.43522.511785.121778@lisa.zopyra.com>
	<Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
	<17893.44936.525606.74693@lisa.zopyra.com>
	<Pine.LNX.4.64.0702280843030.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMS2u-0008Lf-LQ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbXB1Qws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXB1Qws
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:52:48 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60667 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbXB1Qwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:52:47 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SGqdi27825;
	Wed, 28 Feb 2007 10:52:39 -0600
In-Reply-To: <Pine.LNX.4.64.0702280843030.12485@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40965>

On Wednesday, February 28, 2007 at 08:47:44 (-0800) Linus Torvalds writes:
>
>
>On Wed, 28 Feb 2007, Bill Lear wrote:
>
>> On Wednesday, February 28, 2007 at 08:34:18 (-0800) Linus Torvalds writes:
>> >> [...]
>> >> Resolving 2210 deltas.
>> >> fatal: cannot pread pack file: Success [obj[0].offset=39393; obj[1].offset=39602; n=305; obj->size=0; rdy=0; len=207]
>> >> fatal: index-pack died with error code 128
>> >
>> >What's "n"? Is that the return value from pread? Or was that "rdy"?
>> 
>> Yes, n is the value from pread.
>
>Ok, that's just ODD. 
>
>Getting 305 bytes back when you asked for 207 is a bad bad bad thing. It's 
>also really really odd and unexpected. 

You may have missed my admission that I screwed up the print: n is 0, obj->size
was 305.

>What filesystem? And could you strace this and actually see the pread() 
>system call?

How can I tell which filesystem?  It's Linux all around, as far as I
know.  Here is what mount tells me about this filesystem:

storage:/storage/disk1 on /austin type nfs (rw,addr=192.168.2.192)

>(use "strace -f -o tracefile" to follow all forks and to put the end 
>result in a trace file)

Will do ...


Bill
