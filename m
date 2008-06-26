From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Wed, 25 Jun 2008 22:53:36 -0500
Message-ID: <g3v3s1$bok$1@ger.gmane.org>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <20080621214241.GA3839@dualtron.vpn.rwth-aachen.de> <20080622072420.GA5161@dualtron.vpn.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 06:06:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBiko-0007f5-AT
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 06:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbYFZEFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 00:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbYFZEFH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 00:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:33259 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbYFZEFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 00:05:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KBijG-0005XD-M8
	for git@vger.kernel.org; Thu, 26 Jun 2008 04:05:02 +0000
Received: from adsl-76-197-196-93.dsl.chcgil.sbcglobal.net ([76.197.196.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 04:05:02 +0000
Received: from dpmcgee by adsl-76-197-196-93.dsl.chcgil.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 04:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-76-197-196-93.dsl.chcgil.sbcglobal.net
User-Agent: Thunderbird 2.0.0.14 (X11/20080522)
In-Reply-To: <20080622072420.GA5161@dualtron.vpn.rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86391>

On 06/22/2008 05:01 AM, Junio C Hamano wrote:
>> Having said all that, I have to say I am regretting to have accepted that
>> patch to enable pager on status, not because it bothers me personally (it
>> doesn't primarily because I practically never run git-status because I
>> consider the command useless and living almost always in Emacs helps), but
>> because in principle changing anything that existing users are used to is
>> bad.

I'm a bit late on the uptake here, but I wanted to throw my two cents in- this was one of the biggest usability flubs I've seen with git in a long time. I suspect (actually, I *know*) there were many users like I that used git-status all the time in the console to get a handle on what their work tree was looking like. That became impossible with 1.5.6 out of the box, and I have to spend an hour reading mailing list posts trying to restore the former non-broken behavior.

Why did this patch get pulled in with so little discussion? Didn't someone think that there must be a reason git-status didn't use a pager before?

On 06/22/2008 02:24 AM, Johannes Gilger wrote:
> On 21/06/08 23:42, Johannes Gilger wrote:
>> Wow, I just noticed it myself. Why was that changed? I don't know about 
>> your status lines, but I for one find it really annoying. Anything 
>> that's in a pager isn't visible in my console afterwards. What's next? 
>> git branch in a pager too?
> 
> Seems like I got ahead of myself there. After setting the core.pager to 
> less -FRSX everything works fine ;)

This is a terrible thing to force users to have to do. Not only that, but the interaction between GIT_PAGER, core.pager, and everything else just makes this change even more hard to swallow.

I probably came across as flame/troll here, but I felt I needed to speak up for those of us that never knew this change was coming. I would go so far as to say this should be reverted for a maint release.

-Dan
