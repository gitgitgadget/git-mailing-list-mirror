From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 20:45:01 -0400
Message-ID: <4270320D.5090708@dwheeler.com>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org> <426FD3EE.5000404@zytor.com> <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org> <426FF8C4.8080809@zytor.com> <Pine.LNX.4.58.0504271352110.18901@ppc970.osdl.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:37:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQx1q-0000cj-Qw
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVD1Amm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVD1Amm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:42:42 -0400
Received: from aibo.runbox.com ([193.71.199.94]:8079 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262128AbVD1Amk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:42:40 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DQx6x-0002gg-A0; Thu, 28 Apr 2005 02:42:35 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DQx6w-0000WD-Os; Thu, 28 Apr 2005 02:42:35 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271352110.18901@ppc970.osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 27 Apr 2005, H. Peter Anvin wrote:
> 
>>I know that.  However, is that going to be true for all versions of the 
>>repository format over all time?  If so, the repository format is brittle.
> 
> I agree, it's brittle by design, exactly because I think it's very 
> important not to allow any variations.

In the short term, not allowing any variations is probably a
good thing, it'll winnow out mistakes.  Creating a format that
COULD change in the future is, however, a very good way of avoiding
getting boxed into a corner if it turns out a mistake has been made.

> HOWEVER, that's where "convert-cache" comes in. Any one particular format 
> may be brittle, but if we accept that, and just say "we can upgrade by 
> converting the cache", then we should be ok. IOW, we can change from one 
> brittle format with 160-bit SHA1 names to _another_ brittle format with 
> 256-bit SHA1 (or other) names.

There's a disadvantage to that, unfortunately: invalidating signatures.
Yes, you can get people to re-sign their stuff... assuming you can
find them & convince them to do it (ha!).  More than likely,
you'll lose signatures that way.  Probably not your TOP priority,
but there are advantages to being able to go back & years later
SHOW that someone really did sign something.

In the long run, I'd really like to see (at least) signed commits,
and that those signatures would "stick around" cleanly into the future.
"Breaks" can be handled other ways, but it is DEFINITELY a pain,
and an avoidable one.

--- David A. Wheeler
