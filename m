From: Eli Barzilay <eli@barzilay.org>
Subject: Remote operations synchronization, and hooks
Date: Tue, 02 Mar 2010 00:09:46 -0500
Message-ID: <m3r5o3ux5x.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 06:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmKMy-00038I-HT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 06:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab0CBFJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 00:09:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:53582 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab0CBFJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 00:09:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NmKMn-00035K-V5
	for git@vger.kernel.org; Tue, 02 Mar 2010 06:09:57 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 06:09:57 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 06:09:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:hbhcP5sKVadQtX8EkTclhb5iJBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141375>

Is there any kind of synchronization with remote operations?  That is,
can there be any race conditions if multiple clients connect?  I'm
assuming that such operations are safe, but I couldn't find a place
with a concrete description.

More specifically, I'm wondering about writing hooks (specifically, a
`post-receive' hook), and it would make things convenient if I knew
that it was called synchronously.

And a related question: is there somewhere a summary of how the hooks
are called for each operation?  The githooks man page specifies some
of the relationships but a list with how each operation perform its
work would be much more convenient to read through.  For example, if a
remote update had a list of operations with "grab lock" in the
beginning and a "release lock" after running the `post-receive' hook,
then I wouldn't have the above question.  Also, it's unclear how
`post-update' is related to `post-receive' -- there's one comment in
the man entry for the former that makes it sound like it is supersedes
by the latter, but there's nothing explicit about it.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
