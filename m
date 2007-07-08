From: bdowning@lavos.net (Brian Downing)
Subject: [RFC] Dynamic window size on repack?
Date: Sun, 8 Jul 2007 16:16:06 -0500
Message-ID: <20070708211606.GF4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 23:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7e78-0000L4-Bk
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbXGHVQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757197AbXGHVQQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:16:16 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:12716 "EHLO
	asav07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849AbXGHVQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:16:15 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav07.insightbb.com with ESMTP; 08 Jul 2007 17:16:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAHTwkEZKhvbzR2dsb2JhbACBTIVdiAIBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id AE2CC309F31; Sun,  8 Jul 2007 16:16:06 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51921>

I have a CVS repository which is mostly sane, but has an approximately
20MB RTF file that has two hundred revisions or so.  (Thank you, Windows
help.)

Now, since this is old history, I want to make it as small as possible.
The only problem is that when I use high --window values for repack,
it goes along swimmingly until it gets to this file, at which point
memory usage quickly rises to the point where I'm well into my swap file.

I think what I'd like is an extra option to repack to limit window
memory usage.  This would dynamically scale the window size down if it
can't fit within the limit, then scale it back up once you're off of the
nasty file.  This would let me repack my repository with --window=100
and have it actually finish someday on the machines I have access to.
The big file may not be as efficiently packed as possible, but I can
live with that.

My question is, is this sane?  Does the repack algorithm depend on having
a fixed window size to work?  I'd rather not look into implementing this
if it's silly on the face of it.

Thanks,
-bcd
