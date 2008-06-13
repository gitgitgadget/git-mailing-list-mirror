From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 08:54:27 -0500
Message-ID: <48527C13.2000800@freescale.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K79km-0001eH-Ls
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 15:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbYFMNys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 09:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755814AbYFMNys
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 09:54:48 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:54752 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbYFMNyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 09:54:47 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m5DDsSYO014664;
	Fri, 13 Jun 2008 06:54:29 -0700 (MST)
Received: from [10.214.73.115] (mvp-10-214-73-115.am.freescale.net [10.214.73.115])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5DDsQ3J002425;
	Fri, 13 Jun 2008 08:54:26 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48521EDA.5040802@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84876>

Andreas Ericsson wrote:

> I think these are the options we're faced with:
> 1. Never expire stashes (don't shoot the user)
> 2. Don't treat stashes specially (shoot the user)
> 3. Don't purge stashes when auto-gc-ing (let the users shoot themselves)
> 4. Make the behaviour configurable (let the users shoot themselves)
> 5. Double the expiration time on stashes and warn for them when they should
>   normally have expired (during gc, that is) (shoot the user, but warn 
> first).
> 
> I'm all for #4 and will cook up a patch for that next week when I'm on
> vacation unless #1 gets applied before that.
> 

There are additional choices too, I think, with config-driven
variations as well.

At git-gc time, notice a reflog entry for a stash that
is about to expire and either convert it to a branch or
interactively offer to convert it or delete it.

Provide a command that converts stash entries to branches.
Maybe even take over refs/stash/ name-space or so?

All with various config options to do that quietly, interactively,
always, never, etc.

jdl
