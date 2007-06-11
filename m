From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Mon, 11 Jun 2007 15:45:41 -0700
Message-ID: <7vlkeqnm96.fsf@assigned-by-dhcp.pobox.com>
References: <20070611090451.26209.qmail@science.horizon.com>
	<46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxse0-0003Gn-Uv
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 00:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbXFKWpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 18:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbXFKWpp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 18:45:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37388 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbXFKWpo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 18:45:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070611224543.OJRU3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Jun 2007 18:45:43 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ANlh1X00R1kojtg0000000; Mon, 11 Jun 2007 18:45:42 -0400
In-Reply-To: <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 12 Jun 2007 09:54:50 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49894>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> It _will_ be a bit of an apple-to-oranges comparison, but you could
> use a few large-ish projects that have a published GIT gateway.
> ...
>   - cvs status vs git status

This _is_ apples and oranges.  git status is not about "the
current status of working tree" but about "what I would commit
if I were to say git-commit at this moment".  "cvs status" does
a lot more, I think.  Also I haven't met anybody who says "cvs
status" is useful; people seem to use "cvs -q update -n" often
when they want to know "what's different between me and
upstream"?

>   - cvs update vs git pull

While that is a valid comparison, I think CVS users use "cvs
update" (especially "cvs -q update -n" variant) far more
frequently for the purpose of seeing "what did I change so far"
than truly try to update from the upstream.  So a comparison
that has more real-life significance would be "cvs -q update -n"
vs "git diff --name-status HEAD".

There are a handful more.

 - "git pull -n" vs "cvs up" when your tree is clean and you are
   a dozen revs behind.

 - "cvs co -rother-branch" vs "git checkout other-branch".

 - "cvs diff -rold-version" vs "git diff old-version".

 - "git am a-dozen-of-mails" vs its cvs equivalent.

 - "git rebase a-dozen-of-commits" vs its cvs equivalent.

 - "git log path/to/directory/" vs its cvs equivalent
