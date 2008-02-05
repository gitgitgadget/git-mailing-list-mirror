From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 05 Feb 2008 18:24:50 -0500
Message-ID: <1202253890.26144.8.camel@gaara.boston.redhat.com>
References: <ve53xwob.fsf@blue.sea.net>
	 <alpine.LSU.1.00.0802051524580.8543@racer.site> <prvbxfhl.fsf@blue.sea.net>
	 <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
	 <alpine.LSU.1.00.0802052236220.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 00:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMXBM-0006ac-H7
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763075AbYBEXZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757113AbYBEXZy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:25:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761938AbYBEXZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:25:53 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m15NOuhB024568;
	Tue, 5 Feb 2008 18:24:56 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m15NOuto015237;
	Tue, 5 Feb 2008 18:24:56 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m15NOuLh004026;
	Tue, 5 Feb 2008 18:24:56 -0500
In-Reply-To: <alpine.LSU.1.00.0802052236220.8543@racer.site>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72721>

On Tue, 2008-02-05 at 22:41 +0000, Johannes Schindelin wrote:
> Hi,
> 
> [Jari, keep me Cc'ed.  I missed your mail, because you didn't.]
> 
> On Tue, 5 Feb 2008, Linus Torvalds wrote:
> 
> > It all makes perfect sense. Or rather, it made sense way back when. I 
> > agree that it's just totally insane these days, and ".dotest/" should be 
> > renamed to something like ".git/split/" or something.
> 
> But please, please, please not without a proper plan to keep people 
> informed!  I.e. a switch-over plan with deprecation and all.  (IOW what I 
> _already_ wrote to Jari.)
> 
> On at least one machine (not the current one, because I was too lazy), I 
> have a git alias to call when the patch does not apply, to call another 
> program in turn which made it easier for me to integrate a non-applying 
> patch into the current working directory.

Aha, that's the script we're talking about :)

> And guess what: this script accesses .dotest/.  Yes, I know, it was 
> _prone_ to move.
> 
> But I am lucky, I read the git list regularly, I know what truck is going 
> to hit me if I do not change that alias.

I think there's a correlation here: anybody who's meddling with git
implementation details (yes, I'm talking about .dotest here) is probably
also subscribed to this list :)  Seriously though, in git there is often
no clear line between implementation details and supported features, so
it's way to easy to claim everything is set in stone and that the world
will break if we change it.  Especially if you've written a script that
happens to reach a little to far into the git guts.

Kristian
