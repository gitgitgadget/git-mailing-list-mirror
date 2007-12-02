From: Junio C Hamano <gitster@pobox.com>
Subject: v1.5.4 plans
Date: Sun, 02 Dec 2007 14:04:26 -0800
Message-ID: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 23:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iywvh-0004qy-PP
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXLBWEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXLBWEa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:04:30 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52868 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXLBWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 17:04:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1B9472EF;
	Sun,  2 Dec 2007 17:04:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9793A9C347;
	Sun,  2 Dec 2007 17:04:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66825>

Please do not take this as the final decision made by the Emperor, whose
subjects now must follow.  This is a sanity-check to see if everybody is
on the same page.

I am not the Emperor anyway ;-)

Deprecation and Removal
-----------------------

 * We have already removed svnimport without giving a deprecation notice
   in the release notes of the previous feature release, which was bad.
   Maybe the users will forgive us.  Maybe not.

 * As discussed on the list, v1.5.4 will ship with the dashed form of
   commands (e.g. "git-commit") on users' PATH by default.  However we
   will move them outside the normal PATH (exact location needs to be
   decided by checking FHS first, something like /usr/libexec/git-core)
   in v1.5.5 so the release notes to v1.5.4 will declare deprecation
   (see the top of Documentation/RelNotes-1.5.4.txt).  We might want to
   keep copies of dashed form Porcelains in /usr/bin but that discussion
   is towards v1.5.5 (post v1.5.4, not now).

 * We also will give deprecation warning for the following features and
   commands in the release notes to v1.5.4, and remove them in v1.5.5:

   - lost-found (use fsck --lost-found);
   - post-update hook (use post-receive hook);
   - peek-remote (use ls-remote)


Topics not in 'master' yet but should be in v1.5.4
--------------------------------------------------

I think the following should go in, along with what we already have in
'master':

 * git-commit in C (Kristian and others)
 * git-add --patch (Wincent)
 * git-prune --expire (Dscho)
 * git-add --interactive coloring (Dan Zwell)
 * whitespace error classes in diff and patch, using gitattributes (Bruce and me)
 * cvsserver runs post-receive (Michael Witten)
 * git-rebase -i gives chance to rerere (Dscho)
 * git-rebase gives more appropriate help text (Wincent)
 * make refspec matching logic in git-push and git-fetch saner (Steffen Prohaska)
 * work-tree related minor fixes (Nguyen and Dscho)
 * allow update hook to munge commit (Steven Grimm)

I'd like to explicitly exclude topics about the following, although I
think there might be worthwhile ones among them to think about in the
longer term:

 * removing dashed form from the filesystem
 * teaching diff family about fileglob pathspecs
 * making it possible to omit leading paths from diff family output when
   run from a subdirectory
