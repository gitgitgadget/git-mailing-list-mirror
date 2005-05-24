From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 16:10:33 -0400
Message-ID: <42938A39.6020008@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240911050.2307@ppc970.osdl.org> <42938893
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:09:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafiA-00072h-7O
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVEXUKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVEXUKn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:10:43 -0400
Received: from iris.cobite.com ([208.222.83.2]:64386 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S261998AbVEXUKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 16:10:34 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id F3AA69888E; Tue, 24 May 2005 16:10:27 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12846-04; Tue, 24 May 2005 16:10:27 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id C5016988A0; Tue, 24 May 2005 16:10:27 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 918E598833; Tue, 24 May 2005 16:10:27 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: David Mansfield <david@cobite.com>
In-Reply-To: <42938893.9010608@cobite.com>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Mansfield wrote:
> Linus Torvalds wrote:
> 
>>On Tue, 24 May 2005, Linus Torvalds wrote:
>>
>>
>>>Fixing the branch handling shows that cvsps does some really strange
>>>things with the newly added "Ancestor grpah". Here's one example:
>>
>>
>>Ahh, looking at cvsps source, I think I see what's going on. 
>>
>>It's deciding the "previous branch" by looking at what the previous branch 
>>for the first individual file in the PatchSet was, which fails because in 
>>this case, PatchSet 372 was changing "syslinux.doc", and Patchset 374 was 
>>changing "syslinux.c", and thus the previous version of the individual 
>>_files_ were both in the HEAD branch.
>>
>>So it does look like I should just ignore the "Ancestor branch" 
>>information if the new branch already existed.
>>
> 
> 
> I've attached what I just committed.  The previous 'show ancestor' patch 
> needs to be reversed and this applied.  It works for me on a half-dozen 
> repos including syslinux.
> 

Oops.  I forgot to metion I made the tracking of branch ancestry an 
option because it potentially increases the cpu time a fair margin 
(though here it seemed trivial).  You need to pass '-A' as an additional 
argument.

David
