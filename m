From: Dave Jones <davej@codemonkey.org.uk>
Subject: git-clone --quiet broken?
Date: Sat, 5 Jul 2008 17:16:16 -0400
Message-ID: <20080705211616.GA3874@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 23:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFF2H-0004qk-Up
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 23:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYGEVKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 17:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbYGEVKK
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 17:10:10 -0400
Received: from testure.choralone.org ([194.9.77.134]:35167 "EHLO
	testure.choralone.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbYGEVKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 17:10:09 -0400
Received: from davej by testure.choralone.org with local (Exim 4.69)
	(envelope-from <davej@codemonkey.org.uk>)
	id 1KFF7A-0001IS-LA
	for git@vger.kernel.org; Sat, 05 Jul 2008 22:16:16 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87467>

The server I run various git snapshots on recently got upgraded to git 1.5.6,
and I started getting a lot more mail from cron than usual.
It seems that passing -q to git-clone at some point changed from 'silent'
to 'slightly less noisy'. Only the difference is so slight that it may
as well be nil..

Here's a normal clone..

Initialize git/.git
Initialized empty Git repository in /home/davej/git-trees/git/.git/
remote: Counting objects: 76925, done.
remote: Compressing objects: 100% (25373/25373), done.
remote: Total 76925 (delta 55699), reused 70336 (delta 50160)
Receiving objects: 100% (76925/76925), 17.09 MiB | 1111 KiB/s, done.
Resolving deltas: 100% (55699/55699), done.

And here's the 'quiet' clone..

Initialize git/.git
remote: Counting objects: 76925, done.
remote: Compressing objects: 100% (25373/25373), done.
remote: Total 76925 (delta 55699), reused 70336 (delta 50160)
Receiving objects: 100% (76925/76925), 17.09 MiB | 1128 KiB/s, done.
Resolving deltas: 100% (55699/55699), done.

Spot the difference :)

It looks even worse in mail from cron, where you get one line of text
for every % that git progresses through.

I could run the clone with 2>/dev/null, but I'd really like to get
mail when something breaks instead of it being totally silent.

I'm assuming this was an unintentional side-effect of some other recent change?

	Dave

-- 
http://www.codemonkey.org.uk
