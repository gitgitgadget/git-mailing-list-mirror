From: David Miller <davem@davemloft.net>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 22:53:32 -0800 (PST)
Message-ID: <20090228.225332.152995144.davem@davemloft.net>
References: <20090301034632.GA318@coredump.intra.peff.net>
	<20090228.215752.122159841.davem@davemloft.net>
	<7vvdqtagpp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 01 07:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldfaw-0001dr-MD
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 07:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZCAGxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 01:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbZCAGxw
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 01:53:52 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49857
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752497AbZCAGxv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 01:53:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 278D635C00A;
	Sat, 28 Feb 2009 22:53:33 -0800 (PST)
In-Reply-To: <7vvdqtagpp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111821>

From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 28 Feb 2009 22:40:34 -0800

> David Miller <davem@davemloft.net> writes:
> 
> > Indeed I have some serious corruption in my pack file.
> 
> Just a sanity check; did you run verify-pack on each packfile to validate
> that suspicion?

No, sorry, I didn't validate it in that way.

I just ran verify-pack on all of the *.idx files and it produced
no output.

But I do know for a fact that the corrupt tree object c9ee57c is in a
pack and not sitting there explicitly under .git/objects/c9/

> These may only indicate that your .git/index is corrupt but the object
> database may still be good.
> 
> We fixed an incorrect "missing object" diagnosis when your repository
> borrows objects from another repository via the alternates mechanism
> (check if .git/objects/info/alternates refers to another repository)
> fairly recently.  "Missing objects" could be false alarms.

Yes I do use alternates heavily.
