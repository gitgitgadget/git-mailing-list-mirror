From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: To graft or not to graft... (Re: Recovering from repository corruption)
Date: Thu, 12 Jun 2008 01:21:26 +0200
Message-ID: <20080611232126.GA9054@cuci.nl>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <m3abhtp42o.fsf@localhost.localdomain> <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com> <200806102159.02875.jnareb@gmail.com> <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com> <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org> <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com> <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Ze6-000567-UR
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbYFKXV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbYFKXV2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:21:28 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38124 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbYFKXV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:21:27 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A82F5545E; Thu, 12 Jun 2008 01:21:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84683>

Linus Torvalds wrote:
>more corruption by hiding things (ie if you clone a repo with a grafts 
>file, the result will now have neither the grafts file _nor_ the state 
>that was hidden by it, so the result is guaranteed to be corrupt).

This is kind of confusing.
As I understood it from the few shreds of documentation that actually
mention the grafts file, the grafts file is *not* being cloned.
Therefore, my assumption was that cloning a repository that has a grafts
file gives an identical result to cloning the same repository *without*
the grafts file present.

As I understand it now, the cloning process actually peeks at the grafts
file while cloning, and then doesn't copy it.  This results in a rather
confusingly corrupt clone.

I suggest two things:
a. That during the cloning process, the grafts file is completely
   disregarded in any case at first.
b. Preferably the grafts file is copied as well (after cloning).  I
   never really understood why the file is not being copied in the first
   place (anyone care to explain that?).
-- 
Sincerely,
           Stephen R. van den Berg.

Differentiation is an integral part of calculus.
