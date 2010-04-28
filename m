From: Matthias Lehmann <mat@matlehmann.de>
Subject: git-apply fails on creating a new file, with both -p and --directory specified
Date: Wed, 28 Apr 2010 14:29:26 +0200
Message-ID: <201004281429.26579.mat@matlehmann.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 14:35:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O76UH-0007IC-Ub
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 14:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab0D1Mf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 08:35:28 -0400
Received: from delta422.server4you.de ([85.25.135.164]:39655 "EHLO
	mail.bluedigit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab0D1Mf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 08:35:28 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2010 08:35:27 EDT
Received: from tpmat.localnet (g224234124.adsl.alicedsl.de [92.224.234.124])
	(Authenticated sender: mail@matlehmann.de)
	by mail.bluedigit.de (Postfix) with ESMTPSA id C5A631762EF
	for <git@vger.kernel.org>; Wed, 28 Apr 2010 14:29:34 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-21-generic; KDE/4.4.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145992>

Hi all,

the subject of this mail may read familiar to some - there was a discussion in 
November last year (see 
http://kerneltrap.org/mailarchive/git/2009/11/23/16899/) concerning this 
problem.

Today I had this same issue with git 1.7.0.4. Reading the above mentioned 
discussion and seaching the net did not help me in finding a solution to the 
problem. 

I have to apply patches from one repository to another repository, which have 
a different layout (I am working on splitting one big repository into several 
smaller ones, while development still continues on the big repository).

So I did

big-repo$ git format-patche -o /tmp/foo 
small-repo$ git apply -p2 --directory=some/path --check /tmp/foo/*

and get

fatal: git diff header lacks filename information when removing 2 leading 
pathname components (line 37)

the patch looks like this:

35| diff --git a/xyz/bar.jpg b/xyz/bar.jpg
36| new file mode 100644
37| index 
0000000000000000000000000000000000000000..3dcce2e1f68586ed2089d86b1bf4e7e41c818d97
38| GIT binary patch
39| literal 8791



Since this problem was discussed before - is there a solution?
This is something like a showstopper for me right now, so I am very thankful 
for any hints.

Best regards,

Mat
