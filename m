From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Grafting mis-aligned trees.
Date: Tue, 18 Nov 2008 10:24:00 +0100
Message-ID: <492289B0.4010903@drmicha.warpmail.net>
References: <200811171645.12869.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 10:25:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Mpm-0003G6-Ju
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 10:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYKRJYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 04:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbYKRJYG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 04:24:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51292 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869AbYKRJYE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 04:24:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 606481B779A;
	Tue, 18 Nov 2008 04:24:03 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 18 Nov 2008 04:24:03 -0500
X-Sasl-enc: 6kg2LXDrCArgSs8Dt1Imtj1qYDYWAI9nzvNBFQ+AWPWx 1227000243
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BEAA612FA6;
	Tue, 18 Nov 2008 04:24:02 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <200811171645.12869.bss03@volumehost.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101265>

Boyd Stephen Smith Jr. venit, vidit, dixit 17.11.2008 23:45:
> I haven't gotten a response from my subscription email, so please CC me on any replies.
> 
> So, I've been managaing the source I had from a client project in git and 
> have a non-linear history.  Currently, two tips (production and testing) 
> but there are many feature branches that were git-merge'd in, not rebased.
> 
> Now, I've gotten the full tree.  Turns out all the source code I was 
> working on was in a subdirectory "project/web".  I'd like to "graft" the 
> *changes* I made onto the full tree.
> 
> I figured this might be a job for git-filter-branch.  Certainly, that did 
> the job of moving all my changes into the subdirectory.  But, now I want to 
> do something that's a combination or git-rebase and git-filter-branch.  I 
> want to replay the *patches/deltas* (like rebase) on top of the full tree I 
> have, but *maintain the non-liear history* (like filter-branch).
> 
> Can anyone think of a recipe for me?
> 
> Trees look something like this right now.
> 
> <some history> -> FT
> 
> TI -> <non-linear history> -> A -> <non-linear history> -> C
>    \                            \                           \
>     -> PI ------------------------> B ------------------------> D
> 
> I'd like to have it look something like:
> 
> <some history> -> FT -> <non-linear history> -> A' -> <non-linear history> -> C'
>                     \                            \                           \
>                      -> PI' ----------------------> B' -----------------------> D'
> 
> A', B', C', and D' are different commits, but the diff (and history) between 
> FT and A' is the same as the diff (and history) between TI and A.
> 
> Again, please CC me on any replies.

[CCing is customary here anyways.]

So, your base directory for TI and FT is different, right? I.e.: In the
TI repo, your project sits at the root, whereas in the FT repo it sits
in project/web? Has FT advanced since you took the initial subdir
snapshot for TI?

Michael
