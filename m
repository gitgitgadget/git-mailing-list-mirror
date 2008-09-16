From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-branch manpage question
Date: Tue, 16 Sep 2008 18:25:50 +0200
Message-ID: <48CFDE0E.4020806@drmicha.warpmail.net>
References: <957350.34177.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 18:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfdOT-00012B-6G
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 18:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbYIPQZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 12:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbYIPQZz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 12:25:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60946 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483AbYIPQZy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 12:25:54 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2634C163196;
	Tue, 16 Sep 2008 12:25:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 16 Sep 2008 12:25:54 -0400
X-Sasl-enc: qtXk6Lg52eir5Dgf1H9JArVH4fw9bCl1DcPtaucakF8l 1221582353
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3DABF28453;
	Tue, 16 Sep 2008 12:25:53 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <957350.34177.qm@web27803.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96014>

Mark Struberg venit, vidit, dixit 16.09.2008 16:46:
> Hi!
> 
> I think i found an inconsistency in the documentation of the
> git-branch command:
> 
> *snip* --track:: .... Set the branch.autosetupmerge configuration
> variable to `false` if you want 'git-checkout' and 'git-branch' to
> always behave as if '--no-track' were given... *snip*
> 
> and
> 
> *snip* --no-track:: Ignore the branch.autosetupmerge configuration
> variable.
> 
> *snip*
> 
> So, the description of branch.autosetupmerge is referencing
> --no-track and vice versa, thus the effective documentation is
> essentially missing as far as I understand.

Well, what's missing is the explanation that "--no-track" is the
opposite of "--track".  Do we really need to stress that?

The explanation of "--track" is in the "....", you left it out in your
quote.

Maybe the formulation is a bit suboptimal because it's squeezed more or
less forcibly into the option list concept. At "--track" there is a
description of what is meant by a tracking branch configuration. Now,
the logical flow is:

If --track is given, set up tracking.
If --no-track is given, don't set up tracking.
If none is given, check branch.autosetupmerge:
If it is false, don't set up tracking.
If it is always, set up tracking.
If it is unset (or true), check what kind of start point we branch off from:
If it is a remote, set up tracking.
If it is not a remote, don't set up tracking.

Admittedly, the description at --track is a bit contrived. But if you
read the DESCRIPTION section before the options things should become
clear. Maybe git-branch(1) should reference git-config(1).

Cheers,
Michael
