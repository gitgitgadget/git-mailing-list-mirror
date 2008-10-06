From: Ed Avis <eda@waniasset.com>
Subject: Re: Build bug report: 'make check' needs sparse, but =?utf-8?b?Y29uZmlndXJlCWRvZXNuJ3Q=?= check it
Date: Mon, 6 Oct 2008 11:28:25 +0000 (UTC)
Message-ID: <loom.20081006T112601-258@post.gmane.org>
References: <loom.20081004T131652-828@post.gmane.org> <20081005003446.GN21650@dpotapov.dyndns.org> <loom.20081005T094301-345@post.gmane.org> <20081006065847.GA27516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 13:29:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmoHg-00027u-NE
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 13:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYJFL2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYJFL2k
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 07:28:40 -0400
Received: from main.gmane.org ([80.91.229.2]:52914 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbYJFL2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 07:28:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KmoGR-0002eU-T3
	for git@vger.kernel.org; Mon, 06 Oct 2008 11:28:35 +0000
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 11:28:35 +0000
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 11:28:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.30 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97577>

Shawn O. Pearce <spearce <at> spearce.org> writes:

>Nah.  We're not going to rename the target to "make sparse".

Fair enough.  Can I suggest a one line patch to avoid any misunderstanding in 
the future?

diff --git a/Makefile b/Makefile
index 3c0664a..c98b921 100644
--- a/Makefile
+++ b/Makefile
@@ -1354,6 +1354,7 @@ check-sha1:: test-sha1$X
        ./test-sha1.sh

 check: common-cmds.h
+       @echo "'make check' runs the 'sparse' tool on all source files; say 
'make test' to run the test suite."
        for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done

 remove-dashes:
