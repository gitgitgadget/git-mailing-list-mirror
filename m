From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [offtopic?] xdelta patch format wrapper
Date: Wed, 13 Feb 2008 16:46:56 +1300
Message-ID: <47B26830.6090501@catalyst.net.nz>
References: <47B24D8A.5090703@catalyst.net.nz> <7vy79py1it.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jmacd@cs.berkeley.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 04:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP8ay-0003md-Jy
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 04:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYBMDrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 22:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYBMDrE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 22:47:04 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:33871 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYBMDrC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 22:47:02 -0500
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.94])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JP8aH-0006eC-AF; Wed, 13 Feb 2008 16:46:57 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vy79py1it.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73741>

Junio C Hamano wrote:
> I am lost as to your objective because you seem to be keeping a
> whole LOT more than I would have imagined for a specialized
> purpose file format.

My source files are 2 zipfiles that I know contain 1 xml file, and then
may contain any arbitrary files. As a specialised file format is a
pretty general case ;-) Because of compression, xdeltas of the zipfiles
aren't good. So what I want to do is to diff the 2 unzipped directories
- nothing git-specific, I could use diff -urN.

Git diff *is* better in that it handles binary files, but we pay a
sizable cost in being reversible.

So I am thinking of doing is writing a wrapper that does the equivalent
of the "urN" flags to diff, but uses xdelta as the diffing algorithm.

As my case is rather general I suspect I'm better off biting the bullet
and writing something generally useful - it doesn't take that much more
effort and if it ends up being popular, I'll have some help with its
maintenance ;-)

In other words, I'm trolling for peer review to make sure the tool is
sane, and will be useful to others ;-)

> If you want to reuse that much of git

I don't think I'll use *any* git code at all for the time being. If it
was trivial to produce a statically compiled git-diff.exe and
git-apply-patch.exe that work without funny dependencies on any windows
box then I would. Don't think any of the windows ports of git are there
(even though they are excellent!).

cheers,



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
