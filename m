From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Introduce commit notes
Date: Sun, 15 Jul 2007 16:36:50 -0700
Message-ID: <7vlkdhck8d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160022560.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADe8-0003bN-4P
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbXGOXg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756185AbXGOXg4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:36:56 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33487 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbXGOXgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:36:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715233650.RAED1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 19:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Pzcq1X0091kojtg0000000; Sun, 15 Jul 2007 19:36:51 -0400
In-Reply-To: <Pine.LNX.4.64.0707160022560.14781@racer.site> (Johannes
	Schindelin's message of "Mon, 16 Jul 2007 00:23:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52608>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The notes ref is a branch which contains trees much like the
> loose object trees in .git/objects/.  In other words, to get
> at the commit notes for a given SHA-1, take the first two
> hex characters as directory name, and the remaining 38 hex
> characters as base name, and look that up in the notes ref.
> ...
> However, a remedy is near: in a later commit, a .git/notes-index
> will be introduced, a cached mapping from commits to commit notes,
> to be written when the tree name of the notes ref changes.  In
> case that notes-index cannot be written, the current (possibly
> slow) code will come into effect again.

I wonder if it is worth using the fan-out tree structure for the
underlying "note" trees, as the notes-index would be the primary
way to access them.

Not that I've looked at the code too deeply with an intention of
possibly including it early.  I was hoping to see fixes to d/f
code in merge-recursive from either you or Alex instead ;-)
