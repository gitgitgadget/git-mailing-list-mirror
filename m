From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Fri, 21 Oct 2005 15:59:06 +1300
Message-ID: <4358597A.6000306@catalyst.net.nz>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz> <200510202137.22311.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 21 05:01:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESn85-00065O-V3
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 04:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVJUC7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 22:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVJUC7B
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 22:59:01 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:11953 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964845AbVJUC7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 22:59:00 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ESn7S-0007QX-4h; Fri, 21 Oct 2005 15:58:58 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200510202137.22311.dtor_core@ameritech.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10409>

Dmitry Torokhov wrote:
> On Thursday 20 October 2005 19:51, Petr Baudis wrote:
> 
>>(ii) You say:
>>
>>        - Very fast stupid merge
>>            ... and very smart, slow merges when stupid won't do
> 
> He might be referring to manual merge which is indeed as smart as it gets :)

Almost. No, truly, I'm very impressed with git-merge.sh, which first 
does the simple git-read-tree -m, and it can then try several merger 
scripts to resolve the index. The "smartest" merge resolver we have 
follows renames, but we could have language-specific and 
project-specific resolvers, for instance.

If you combine the coolness of git-merge.sh with the fact that cg-merge 
right now is buggy[*]... I'm starting to rely on doing cg-fetch and 
running git-merge.sh by hand.

* I just merged your latest fixes, knowing that they'd conflict on 
cg-fetch, but the merge didn't say a thing a bout cg-fetch, and only 
complained like this:

    MERGE ERROR: : Not handling case  ->  ->

But there were no conflicts at all in the tree! It seems to be that it's 
dropping the upstream changes it doesn't like.

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
