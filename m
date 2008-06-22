From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: core.autocrlf and merge conflict output
Date: Sun, 22 Jun 2008 18:08:59 -0400
Message-ID: <g3miho$se5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 00:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAXmH-0004Dk-2K
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 00:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923AbYFVWKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 18:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756183AbYFVWKI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 18:10:08 -0400
Received: from main.gmane.org ([80.91.229.2]:37607 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919AbYFVWKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 18:10:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KAXl5-0005Lx-0z
	for git@vger.kernel.org; Sun, 22 Jun 2008 22:10:03 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 22:10:03 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 22:10:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041206 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Enigmail-Version: 0.95.6
OpenPGP: id=869C48DA;
	url=http://www.thewritingpot.com/gpgpubkey.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85807>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Apparently, the conflict information Git writes to the working copy
during merge doesn't respect core.autocrlf, magically converting files
to LF and causing problems when you try to commit the files, when
core.safecrlf is on.

I'm in the process of making a patch, but I'm having difficulty getting
builtin-merge-file.c and convert.c to play together. Part of the problem
is the lack of documentation in convert.c, which I'd also like to fix
(but in a different patch).

So, here's an appeal to the Git gods:

* Should I even bother trying to document this? While good docs are
always a definite plus, poor documentation can hurt code.

* Would crlf_to_worktree (apparently an internal function) or
convert_to_working_tree be more appropriate for this task?

* Where can I get a sensible value for *path in convert.c from
builtin-merge-file.c?

Thanks!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIXs17qTO+fYacSNoRAuAEAJ9LekfdUzU8WjbYxdhDOLaUfN67HACgg6gR
3kpT/5CbV3X7bbfkwJFDpAI=
=lega
-----END PGP SIGNATURE-----
