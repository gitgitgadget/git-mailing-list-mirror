From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 20:10:04 +0300
Message-ID: <20080123171004.GS14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org> <4797095F.9020602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHj7e-00054y-Ft
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbYAWRKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYAWRKN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:10:13 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:62853 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbYAWRKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 12:10:12 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id 55803A2A6DB;
	Wed, 23 Jan 2008 20:10:08 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-241.pppoe.mtu-net.ru [85.141.188.241])
	by smtp05.mtu.ru (Postfix) with ESMTP id 7302EA2A3A2;
	Wed, 23 Jan 2008 20:10:05 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHj6y-0008Ht-Q6; Wed, 23 Jan 2008 20:10:04 +0300
Content-Disposition: inline
In-Reply-To: <4797095F.9020602@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71556>

On Wed, Jan 23, 2008 at 10:31:11AM +0100, Andreas Ericsson wrote:
> ---
> FNV Hash
> 
> I need to fill this in. Search the web for FNV hash. It's faster than my 
> hash on Intel (because Intel has fast multiplication), but slower on most 
> other platforms. Preliminary tests suggested it has decent distributions. 
> ---

I believe that under words "my hash", Bob Jenkins meant lookup2, which
was significant slower.

> 
> My tests ran on Intel.

Please, could you specify your CPU model.

> I also noticed I had a few hashes commented out when
> doing the test, one of them being Paul Hsie's. For some reason, Jenkin's and
> Hsie's didn't perform well for me last time I used the comparison thing (I
> did a more thorough job back then, with tests running for several minutes
> per hash and table-size, so I commented out the poor candidates).

I expected that Paul Hsieh's hash may not do well on some architecture,
though it seems it did even worse than I expected.

> 
> I still believe that for this very simple case, the lookup3.c case is not
> very practical, as the code is that much more complicated, which was my
> main point with posting the comparison.

I would not describe lookup3 as impractical. It is widely used and well
tested. Perhaps, for some Intel CPUs, the difference in speed is not so
big, and FNV hash is much smaller and simpler, so FNV is a reasonable
choice, but the hash is twice slower on my AMD processor and I suspect
it may be even worse on other CPUs, where integer multiplication is slow.
Besides, it may turn out that hashing filename may be not only case where
a fast hash is needed.

Dmitry
