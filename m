From: Henrik Austad <henrik@austad.us>
Subject: git checkout does not warn about tags without corresponding commits
Date: Fri, 2 Jan 2009 13:25:57 +0100
Message-ID: <200901021325.58049.henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 13:27:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIj7f-0004ps-GX
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 13:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbZABM0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 07:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbZABM0I
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 07:26:08 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:34498 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbZABM0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 07:26:07 -0500
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <henrik@austad.us>)
	id 1LIj6K-0002eW-0B
	for git@vger.kernel.org; Fri, 02 Jan 2009 13:26:04 +0100
Received: from ti121210a080-9171.bb.online.no ([85.164.99.227] helo=[192.168.1.1])
	by asterix.frsk.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <henrik@austad.us>)
	id 1LIj6J-00015f-Nk
	for git@vger.kernel.org; Fri, 02 Jan 2009 13:26:03 +0100
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104376>

Hi!

I recently tried to do a checkout of (what I thought was the first) inux 
kernel in the linux git repo.


git checkout -b 2.6.11 v2.6.11

This tag exists in the linux-tree (direct clone from Linus' tree), along with 
v2.6.11-tree

However, when I inspect the log, I see that I am still stuck in master. So, I 
did a git tag -v v2.6.11 and got the following:

object c39ae07f393806ccf406ef966e9a15afc43cc36a
type tree
tag v2.6.11-tree

This is the 2.6.11 tree object.

NOTE! There's no commit for this, since it happened before I started with git.
Eventually we'll import some sort of history, and that should tie this tree
object up to a real commit. In the meantime, this acts as an anchor point for
doing diffs etc under git.
gpg: Signature made Thu 05 May 2005 01:50:54 AM CEST using DSA key ID 76E21CBB
gpg: Good signature from "Linus Torvalds (tag signing key) 
<torvalds@osdl.org>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: FF6D 4EAC 37AC C1B9 53AE  C7E8 1776 2C46 76E2 1CBB


I can see that there's no commit for this, but, when there's a tag. I thought 
that a tag was just a commit-sha1 with a name attached, along with some tag 
info and a signature. Can you really create a tag without a commit?

Shouldn't git checkout fail in some way, letting me know that the checkout did 
not check out what I thought it did? (I got aware of the bug when I found 
CFS-related code in something I thought was 2.6.11.. :-)


-- 
 -> henrik
