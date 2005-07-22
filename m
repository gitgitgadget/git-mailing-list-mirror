From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/9] applymbox updates and assorted trivial patches.
Date: Fri, 22 Jul 2005 16:03:58 -0700
Message-ID: <7voe8uigtd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:04:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6Yz-00019q-0r
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVGVXEC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVGVXEC
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:04:02 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25060 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262212AbVGVXEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 19:04:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722230357.BDLG8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 19:03:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(Resend after you said you prefer people resending).

I was experimenting with applypatch and applymbox to see how it
feels like being Linus ;-) and also I saw some trivially correct
patches on the list floating unmerged during KS/OLS.

Since I rebase my repostitory to fix up the history often, I
needed a reliable way to preserve authorship information when I
export the patches via format-patch and slurp them via applymbox.

I am sending the following changes to applymbox and format-patch
first:

  [PATCH] tools/applymbox: allow manual fixing and continuing after a failure.
  [PATCH] git-format-patch-script and mailinfo updates.
  [PATCH] format-patch: --mbox and --check.

I wrote the first one to recover from a situation where an
earlier patch failed to apply but I still had many other e-mails
in the mailbox.

The second one allows format-patch to give ability to optionally
add From: and Date: lines as the first two lines after the patch
title line.  The mailinfo program has been enhanced to grok
Date: in the top part of the message body just like From: in the
message body can override the sender of the e-mail.

The third one is an extra.  It lets me export patches in a
format resembling UNIX mbox, so I can concatenate the output
together and reprocess them through applymbox.

After they are accepted, I will forward these trivially correct
patches I saw on the list, using the enhanced format-patch; they
are expected to be processed with the new applymbox as a
practice; by doing this I am also ACKing these patches:

  [PATCH] debian/ fixes
  [PATCH] Fix a typo in git-unpack-objects documentation.
  [PATCH] Cleanup: git-verify-tag-script
  [PATCH] Install git-verify-tag-script
  [PATCH] Support more http features: https no cert, .netrc -> auth
  [PATCH] Document "curl" requirements.
