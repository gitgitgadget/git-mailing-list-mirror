From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 03:13:16 -0400
Message-ID: <20070726071316.GE18114@spearce.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com> <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com> <7vps2fc196.fsf@assigned-by-dhcp.cox.net> <20070726031838.GO32566@spearce.org> <7v6447bxc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707260614500.14781@racer.site> <46A8378A.6050201@xs4all.nl> <Pine.LNX.4.64.0707260737170.14781@racer.site> <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Jul 26 09:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxXf-00057s-UR
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762681AbXGZHNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757250AbXGZHNY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:13:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42874 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762669AbXGZHNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:13:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDxXB-0000GP-EI; Thu, 26 Jul 2007 03:13:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 80A4120FBAE; Thu, 26 Jul 2007 03:13:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53797>

Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> 2007/7/25, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >Did you succeed in adding perl?
> 
> >It is not that important, because I plan
> >to make git-gui the main user interface with this installer.  But Junio
> >keeps adding Perl scripts (ATM add -i and remote) that I have to convert
> >later...
> 
> I don't see what this is good for.

What git-gui is good for?  Its a GUI.  For people who perfer to use
mice and push buttons over keys and a command prompt.  A large number
of people in this world (many of them on Windows) like these things.
Me, I'm more command line than I am GUI, yet I develop git-gui.
So I find myself using it a lot, just so I can eat my own dogfood.

Or do you mean Dscho's other point about rewriting tools into C?

> I would suggest to making a clear
> decision of what are recommended languages, and move everything else
> to contrib/ .. Currently, C and bash seem the most reasonable choice,
> but you could decide for perl, but then the consequence should be that
> the bash scripts are translated into perl. Having both bash and perl
> serves no purpose, and will lead to duplication of library code to
> interact with the git binary.

Sure, but there's some stuff that shell is good at, and other stuff
that Perl is good at.  Forcing everything into one mold while we
prototype new features is really limiting.

But both are slower on fork challenged systems than using native C.
Look at git-fetch for example; my ~400+ branch repository is taking
upwards of 5 minutes to run a no-argument, no-changes git-fetch in.
All sh and fork overhead.

-- 
Shawn.
