From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 09:24:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFIH-0003X9-3Q
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbXCPQ2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbXCPQ2i
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:28:38 -0400
Received: from x35.xmailserver.org ([64.71.152.41]:49163 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbXCPQ2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:28:37 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S21C885> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 16 Mar 2007 12:28:19 -0400
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42375>

On Fri, 16 Mar 2007, Linus Torvalds wrote:

> On Thu, 15 Mar 2007, Davide Libenzi wrote:
> >
> > Hacked up test case below ...
> 
> This one seems to do benchmarking with 8MB buffers if I read it right 
> (didn't try).

Yes, I just wanted to have the biggest time spent in inflate(). That why I 
use a big buffer.


> The normal size for the performance-critical git objects are in the couple 
> of *hundred* bytes. Not kilobytes, and not megabytes.
> 
> The most performance-critical objects for uncompression are commits and 
> trees. At least for the kernel, the average size of a tree object is 678
> bytes. And that's ignoring the fact that most of them are then deltified, 
> so about 80% of them are likely just a ~60-byte delta.

Definitely. The nature of the data matters.
Did you try to make a zlib with my patch and oprofile git on real data 
with that?



- Davide
