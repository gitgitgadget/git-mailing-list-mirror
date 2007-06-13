From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 19:30:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131929020.4059@racer.site>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de> <18032.3836.710438.73912@lisa.zopyra.com>
 <Pine.LNX.4.64.0706131916270.5241@castor.milkiway.cos>
 <18032.13176.649702.276044@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyXfB-0000wZ-JY
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304AbXFMSdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759169AbXFMSdr
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:33:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58347 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759031AbXFMSdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:33:47 -0400
Received: (qmail invoked by alias); 13 Jun 2007 18:33:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 13 Jun 2007 20:33:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19I1B8DBwBIeH3wfhtxAl+jOXPUaNdhD6I808BQwb
	eqiUiCMdEqgGNn
X-X-Sender: gene099@racer.site
In-Reply-To: <18032.13176.649702.276044@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50111>

Hi,

On Wed, 13 Jun 2007, Bill Lear wrote:

> Not completely: they don't want to commit, as this will then "pollute"
> the history in their working repository (which is just temporarily
> being used to play with a new feature, idea, bug fix, optimization,
> etc.).  This pollution with a handful of garbage would then have to be
> undone were they to say "ok, that's really not a good idea".  If a
> pull into a dirty tree were possible, that last step could be just a
> simple reset, or continuing to explore with the code, etc.

Notice that I am _not_ saying that CVS is bad. I am saying that their 
workflow is likely bad (and yes, they should change that workflow, since 
they now _can_).

Two things do they risk happily, which they should not do:

- they test their new feature against different references. For example, 
  it might well be that they tested cases A, B, and C before pull, and D, 
  E and F after that. It is really easy to get lost in what you have, and 
  what not. Now, guess what. Merges are known to break things sometimes. 
  Even the best merge algorithm. Now your developers say "we tested it, 
  and the merge broke it, it's not our fault". But it is.

- That new feature will have to be committed at some stage. Either your 
  devs commit at the end, which makes it a monster commit, which is bad. 
  Or they are _already_ using the suggested workflow "commit && pull", 
  which makes your whole complaint moot.

Ciao,
Dscho
