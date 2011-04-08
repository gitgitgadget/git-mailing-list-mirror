From: "Neal Kreitzinger" <neal@rsss.com>
Subject: convert crlf to eol on vendor branch overlay
Date: Thu, 7 Apr 2011 21:40:29 -0500
Message-ID: <inlsit$scv$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 04:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q81cv-0000hZ-2x
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 04:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab1DHCkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 22:40:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:55100 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327Ab1DHCkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 22:40:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q81cn-0000ds-2Q
	for git@vger.kernel.org; Fri, 08 Apr 2011 04:40:41 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 04:40:41 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 04:40:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171099>

My vendor gave me a tarball with all CRLF eol's.  I'm using the 
vendor-branch overlay method (git ls-files -z | xargs -0 rm -f && tar -xvzf 
tarfile.tar.gz).  How do I convert the eol's to LF?

I tried this:

vi .git/attributes
SRC/*/* text  (convert these to LF eol on commit)

$ git config core.eol lf (convert "text" attr files to LF eol on checkout)

$ git add . -A
$ git commit -m'convert eol'  (should convert CRLF to LF)
$ git checkout otherbranch  (change worktree)
$ git checkout vendorbranch (checkout worktree from commit to get LF 
version)
$ git reset HEAD^  (remove commit but keep worktree LF version)
$ git diff (still CRLF)
$ git status (still show everything as modified due to CRLF)

v/r,
neal 
