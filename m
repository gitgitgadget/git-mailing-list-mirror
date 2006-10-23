From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] Use column indexes in git-cvsserver where necessary.
Date: Mon, 23 Oct 2006 19:02:01 +1300
Message-ID: <453C5AD9.4030008@catalyst.net.nz>
References: <20061023050934.GA25018@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: martyn@catalyst.net.nz, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 08:02:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbst5-0008NT-6y
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 08:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWJWGCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 02:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWJWGCL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 02:02:11 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:42408 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751547AbWJWGCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 02:02:09 -0400
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.5])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gbsss-0008BN-P7; Mon, 23 Oct 2006 19:02:02 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061023050934.GA25018@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29819>

Shawn Pearce wrote:
> Tonight I found a git-cvsserver instance spending a lot of time in
> disk IO while trying to process operations against a Git repository
> with >30,000 objects contained in it.
> 
> Blowing away my SQLLite database and rebuilding all tables with
> indexes on the attributes that git-cvsserver frequently runs queries
> against seems to have resolved the issue quite nicely.
> 
> Since the indexes shouldn't hurt performance on small repositories
> and always helps on larger repositories we should just always create
> them when creating the revision storage tables.
 >
 > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Ack.

I am thinking we need a lightweight schema versioning mechanism to 
decide whether the DB schema needs changes such as this. Too much work 
for this though. ;-)

We have a simple one in Moodle I could port when the time comes.

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
