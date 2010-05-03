From: Matthias Lehmann <mat@matlehmann.de>
Subject: patches between different repositories
Date: Mon, 03 May 2010 19:47:30 +0200
Message-ID: <hrn27j$e3b$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 19:47:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8zkJ-00071o-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 19:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab0ECRrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 13:47:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:44406 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166Ab0ECRrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 13:47:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8zk6-0006wG-FB
	for git@vger.kernel.org; Mon, 03 May 2010 19:47:42 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:47:42 +0200
Received: from mat by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:47:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: KNode/4.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146244>

Hi all,

I have to apply patches from one repository to another repository, which 
have a different layout (I am working on splitting one big repository into 
several smaller ones, while development still continues on the big 
repository).

So I did

big-repo$ git format-patche -o /tmp/foo @{some-date} -- subdir
small-repo$ git apply -p2 --directory=some/path --check /tmp/foo/*

and get

fatal: git diff header lacks filename information when removing 2 leading 
pathname components (line 37)

the patch looks like this:

35| diff --git a/xyz/bar.jpg b/xyz/bar.jpg
36| new file mode 100644
37| index 0000000000000000000000000000000000000000.. 
3dcce2e1f68586ed2089d86b1bf4e7e41c818d97
38| GIT binary patch
39| literal 8791

It seems, like the -p options to git-apply can't handle new files.

Am I doing something wrong here? Or is there another way to merge changes 
within different repositories with differnt layouts?

Any help would be greatly appreciated.

Best regards,

Matthias
