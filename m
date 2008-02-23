From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 02:37:00 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjKh-0007gQ-7n
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbYBWBhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYBWBhE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:37:04 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:51855 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYBWBhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:37:03 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 1185218030649; Sat, 23 Feb 2008 02:37:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 046A31C0624D5;
	Sat, 23 Feb 2008 02:37:01 +0100 (CET)
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74779>


On Feb 22 2008 18:37, Chase Venters wrote:
>
>I've been making myself more familiar with git lately and I'm curious what 
>habits others have adopted. (I know there are a few documents in circulation 
>that deal with using git to work on the kernel but I don't think this has 
>been specifically covered).
>
>My question is: If you're working on multiple things at once,

Impossible; Humans only have one core with only seven registers --
according to CodingStyle chapter 6 paragraph 4.

>do you tend to clone the entire repository repeatedly into a series
>of separate working directories

Too time consuming on consumer drives with projects the size of Linux.

>and do your work there, then pull
>that work (possibly comprising a series of "temporary" commits) back
>into a separate local master respository with --squash, either into
>"master" or into a branch containing the new feature?

No, just commit the current unfinished work to a new branch and deal
with it later (cherry-pick, rebase, reset --soft, commit --amend -i,
you name it). Or if all else fails, use git-stash.

You do not have to push these temporary branches at all, so it is
much nicer than svn. (Once all the work is done and cleanly in
master, you can kill off all branches without having a record
of their previous existence.)

>Or perhaps you create a temporary topical branch for each thing you
>are working on, and commit arbitrary changes then checkout another
>branch when you need to change gears, finally --squashing the
>intermediate commits when a particular piece of work is done?

if I don't collect arbitrary changes, I don't need squashing
(see reset --soft/amend above)
