From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 12:17:17 +0100
Organization: At home
Message-ID: <fhrrbt$lvk$1@ger.gmane.org>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <11954023881802-git-send-email-prohaska@zib.de> <119540238994-git-send-email-prohaska@zib.de> <7vwssfqb0w.fsf@gitster.siamese.dyndns.org> <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de> <7vejempudf.fsf@gitster.siamese.dyndns.org> <53F12F4D-73C5-446E-9A97-9D2D4CA9DF9F@zib.de> <7vk5oeocnr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 12:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4dS-0002Cu-76
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbXKSLRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 06:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbXKSLRc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 06:17:32 -0500
Received: from main.gmane.org ([80.91.229.2]:43526 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbXKSLRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 06:17:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu4d6-00065X-RP
	for git@vger.kernel.org; Mon, 19 Nov 2007 11:17:29 +0000
Received: from abwr246.neoplus.adsl.tpnet.pl ([83.8.241.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 11:17:28 +0000
Received: from jnareb by abwr246.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 11:17:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwr246.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65428>

Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
>> What's left is a new switch "--current".  Less code, easy
>> to explain.
> 
> But won't that force the "current" people always type that from
> the command line, as your previous point was that your earlier
> patch to say "remote.$there.push = HEAD" does not work that way?
> If that configuration works as expected, then I'd 100% agree
> that we would not need push.defaultRefs.  Either you do not have
> "push" at all if your preference is --matching, or you do have
> "push = HEAD" if your preference is --current.  But if it
> doesn't (which was what I gathered from your earlier response),
> having a configuration would help them, wouldn't it?

Brief recap, to check if I understand things correctly:

1. If you use "matching" more often, then it should be enough to provide
   remote.<remotename>.push with refspec or wildcard refspec. "git push"
   would push matching. If one wants to push only current branch, one
   would use "git push --current" or "git push <remotename> HEAD".

   Question: what to do if there is no remote.<remotename>.push? Assume
   1-1 matching?

2. If you use "current" more often, then it should be anough (after
   correcting git; although it was written that it is quite a bit of work)
   to provide "remote.<remotename>.push = HEAD", or 
   "push.defaultRefs = current" if one wants to set this up for all
   remotes, or perhaps "remote.*.push = HEAD". "git push" would push
   current. If one wants to push matching, one would use "git push
   --matching"... although for matching one needs remote configured...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
