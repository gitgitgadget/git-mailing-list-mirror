From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] credential-cache--daemon.c: Don't leave stale socket
 on --exit
Date: Thu, 27 Oct 2011 18:29:46 +0100
Message-ID: <4EA9950A.9020208@ramsay1.demon.co.uk>
References: <4EA2FC63.9060602@ramsay1.demon.co.uk> <20111022191711.GC1785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTnj-00072s-OE
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab1J0Rbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:31:33 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48076 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524Ab1J0Rbc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 13:31:32 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RJTne-0005gw-ot; Thu, 27 Oct 2011 17:31:31 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20111022191711.GC1785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184303>

Jeff King wrote:
> On Sat, Oct 22, 2011 at 06:24:51PM +0100, Ramsay Jones wrote:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>  credential-cache--daemon.c |   23 ++++++++++++-----------
>>  1 files changed, 12 insertions(+), 11 deletions(-)
> 
> Looks sane, and I'll probably squash it in. Alternatively, we could also
> set a signal/exit handler to clean up our socket when we die. That would
> also cover the error exit cases.

I considered this, *very* briefly, but decided it wasn't worth the effort
or complexity.

> In either case, I think we need to handle stale sockets better. They
> will happen eventually due to power loss or kill -9, anyway.

Indeed, hence patch #2. ;-)

I suspect that, given the current code, the *vast* majority of stale sockets
would be (somewhat gratuitously) created by the --exit action - hence this
patch. :-P

ATB,
Ramsay Jones
