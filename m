From: Bill Lear <rael@zopyra.com>
Subject: Meaning of "fatal: protocol error: bad line length character"?
Date: Sat, 20 Jan 2007 06:04:57 -0600
Message-ID: <17842.1385.366750.915767@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 20 13:05:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8EyI-0001cz-8H
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 13:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbXATMFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 07:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbXATMFJ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 07:05:09 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61276 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965237AbXATMFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 07:05:08 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0KC56U23407;
	Sat, 20 Jan 2007 06:05:06 -0600
To: git@vger.kernel.org
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37269>

[Many thanks to Junio for explaining in generous detail how to think
properly about branches in git's distributed model.]

We are making progress in our conversion to git, but one of our
developers, on pushing into our company repo, has encountered this
error:

% git push
updating 'refs/heads/master'
  from 6b421066e842203e383e1dc466c1cdef10de56b1
  to   2a8e554ae0c99d44988690c9fce693b3f5f128fa
Generating pack...
Done counting 61 objects.
Result has 32 objects.
Deltifying 32 objects.
 100% (32/32) done
Writing 32 objects.
 100% (32/32) done
Total 32, written 32 (delta 18), reused 0 (delta 0)
Unpacking 32 objects
fatal: protocol error: bad line length character

The notion of fatality led him to think, quite plausibly, that
something very bad had happened with his push.  However, we can find
no evidence that anything bad really did happen.

I did read through the code, and pkt-line.c seems to be the origin of
this, and it does seem to short-circuit the read of the packet if this
error is encountered.  Of course, I have no idea what this really
means...

Could someone please explain what this error means, and how to deal
with it?

Thank you.


Bill
