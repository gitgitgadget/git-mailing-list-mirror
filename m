From: Florian Weimer <fw@deneb.enyo.de>
Subject: Editing patch sequences
Date: Sun, 09 Mar 2008 10:30:16 +0100
Message-ID: <877igcw8gn.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 10:31:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYHsC-000462-Ii
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 10:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYCIJaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 05:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYCIJaU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 05:30:20 -0400
Received: from mail.enyo.de ([212.9.189.167]:58646 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbYCIJaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 05:30:19 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1JYHrF-0002Qe-97
	for git@vger.kernel.org; Sun, 09 Mar 2008 10:30:17 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1JYHrE-0006Mb-SF
	for git@vger.kernel.org; Sun, 09 Mar 2008 10:30:16 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76641>

I've got a patch sequence (a list of file names of patches to apply to
some directory tree, not necessarily in quilt format), and I need to
reorder those patches (for instance, I've got a different version of the
directory tree, but don't want the patch at the beginning of the patch
sequence, but add the end).  If automatic reordering fails, I'd really
like to get some sort of three-way conflict.  After the editing process,
I want to get back another patch sequence, with as few as possible
differences to the original sequence (e.g., embedded file time stamps
should be kept the same, file headers should be preserved, and the order
of files in the patch should remain unchanged).

Has this already been implemented? "git rebase --interactive" comes
close, I think.  But minimizing the changes to individual patches seems
a bit of work.

It's not necessary that this integrates well with other GIT operations,
all this can happen on some throw-away branch or set of branches.
