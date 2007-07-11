From: Paul Mackerras <paulus@samba.org>
Subject: --ignore-invalid flag to git log et al.?
Date: Wed, 11 Jul 2007 17:29:50 +1000
Message-ID: <18068.34542.502048.222112@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 09:30:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8We8-0000wn-6c
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 09:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbXGKH35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 03:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbXGKH35
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 03:29:57 -0400
Received: from ozlabs.org ([203.10.76.45]:54724 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbXGKH35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 03:29:57 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0AA71DDE2C; Wed, 11 Jul 2007 17:29:56 +1000 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52136>

Junio,

What would you think about a --ignore-invalid flag for things like git
rev-list and git log, to tell it to ignore any refs on the command
line that are not valid objects?

Currently there is a buglet in gitk where if a user puts some sort of
ref on the command line, and then makes the ref invalid (e.g. by
deleting the ref if it is a head or tag, or doing a git prune if it is
a sha1 ID with no head/tag pointing to it), and then does "Update" in
gitk, it will get an error because of the now-invalid ref.  (Yes, this
is a bit of a corner case, but I have had a user point out this
behaviour to me.)  With a --ignore-invalid flag, gitk could use this
when doing "Update" to avoid the error.

An alternative would be to have some way to validate refs.  I don't
know how to do that efficiently.  I think I would not want to have to
do a fork/exec for every ref that I wanted to check.

Thoughts?

Paul.
