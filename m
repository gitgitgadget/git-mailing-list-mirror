From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 12:15:30 -0400
Message-ID: <42935322.6070902@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:18:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dac5F-0000Y2-6G
	for gcvg-git@gmane.org; Tue, 24 May 2005 18:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVEXQSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVEXQSG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 12:18:06 -0400
Received: from iris.cobite.com ([208.222.83.2]:12268 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S262123AbVEXQPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 12:15:45 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id DF4F5985CB; Tue, 24 May 2005 12:15:31 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06079-06; Tue, 24 May 2005 12:15:31 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id A7F299884A; Tue, 24 May 2005 12:15:31 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id A7340985CB; Tue, 24 May 2005 12:15:24 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 23 May 2005, Linus Torvalds wrote:
> 
>>I've gotten side-tracked with purely git issues, and since I don't 
>>actually have any CVS archives, the cvs->git translation will be on the 
>>back-burner for a while, but your "Ancestor branch" patch seems to at 
>>least solve the problem that cvsps didn't show all the information that 
>>was there.
> 
> 
> Naff.
> 
> I just checked in a "cvs2git.c" file in the "tools" project (which has my 
> patch application stuff).
> 
> It's still buggy, and it's hacky as hell, but you can basically do 
> something like this:
> 
> 	cvsps | cvs2git > script
> 
> with the normal setup for "cvsps", and "cvs2git" needs one additional
> stage, namely it wants to know the RCSDIR where to find the RCS files
> (that should be basically "$CVSROOT/module").
> 
> That _script_ then creates a git archive. Very hacky. So after you've 
> successfully created the conversion script, check it to see that it looks 
> sane, and then do
> 
> 	sh script
> 
> and the end result is a git'ified version of your CVS repo (and a 
> corrupted working directory, btw, so look out. It _shouldn't_ corrupt 
> your old CVS repo, though, so it should be ok).

I'll take a look.  One problem is that many folks use non-local cvs... 
not sure if that will be an issue.  I'll look to cleaning this up if 
necessary.

> 
> It has the logic for branches, but it doesn't work, and I'm fed up enough
> with CVS and RCS for the moment that I'm not going to work on it any more
> tonight. I don't know what stupid bug I have (I've had about a million of
> them on this silly program), but it's at a point where I think others
> might find it interesting, and it's probably/hopefully some really
> embarrassing typo or something and easily fixed.
> 

I actually found an issue with the 30-second ancestor branch patch I 
sent and I'm doing that one properly now.  Once that's done I can look 
at the branch capture logic in cvs2git and see if anything pops out.


> It converted Peter's "syslinux" repository in a couple of minutes, 
> resulting in 1038 commits (it _should_ have resulted in 1046 commits, 
> that's the branch thing afaik) and most of it looks sane:

Really cool.  What's 8 commits between friends?

David
