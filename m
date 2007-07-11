From: David Kastrup <dak@gnu.org>
Subject: Getting version output for a file.
Date: Wed, 11 Jul 2007 13:39:31 +0200
Message-ID: <86abu3dv9o.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 13:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8aY2-0006wn-6F
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 13:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763516AbXGKLjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 07:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763413AbXGKLjy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 07:39:54 -0400
Received: from main.gmane.org ([80.91.229.2]:44867 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762977AbXGKLjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 07:39:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8aXk-0008BW-0H
	for git@vger.kernel.org; Wed, 11 Jul 2007 13:39:40 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 13:39:39 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 13:39:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:WmaDYN77iDqKJvxsii3K6trOXVM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52152>


Hi,

the Emacs support for git is incomplete, making it bomb out, for
example, when doing
C-u C-x v =

In order to have it work better, I need to fill in the following
functions:

(vc-git-previous-version FILE REV)
Return the version number immediately preceding REV for FILE,
or nil if there is no previous version.

(vc-git-next-version FILE REV)
Return the version number immediately following REV for FILE,
or nil if there is no previous version.

REV will tend to be a symbolic reference like "master" or possibly
"master{2}" (I am fuzzy about the details, but at least repeated
invocations of vc-git-previous-version should work with the previous
output).  The corresponding next and previous versions should be
changes that actually changed the file in question.

There is likely going to be some magic shell invocation of
git-rev-list, git-symbolic-ref and/or similar things to achieve this
task.  I don't have enough of a clue to fill in the necessary details,
but I'd be able to convert them into Elisp.

Anybody with good suggestions?  It would be beneficial if this would
not require the newest git version in order to work.  If that means
that the output needs to be somewhat more massaged, that's ok.

Thanks,

-- 
David Kastrup
