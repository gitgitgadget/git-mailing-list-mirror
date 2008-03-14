From: Len Brown <lenb@kernel.org>
Subject: Segmentation fault      git read-tree
Date: Thu, 13 Mar 2008 23:59:06 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200803132359.06745.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 05:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja15b-0007XS-Hd
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbYCND7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 23:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbYCND7U
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 23:59:20 -0400
Received: from hera.kernel.org ([140.211.167.34]:43752 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320AbYCND7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 23:59:19 -0400
Received: from t61 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m2E3xBqH002212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 14 Mar 2008 03:59:13 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/6225/Thu Mar 13 14:52:37 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77165>

i pushed the branches necessary to reproduce this right
before it happened, so you should be able to pull them
and try it yourself.

thanks,
-Len

[lenb@t61 acpi (test)]$ git push lenb
lenb@master.kernel.org's password:
Counting objects: 723, done.
Compressing objects: 100% (237/237), done.
Writing objects: 100% (492/492), 82.22 KiB, done.
Total 492 (delta 389), reused 337 (delta 249)
To master.kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
   93d7446..dba92d3  linus -> linus
   93d7446..dba92d3  release -> release
   93d7446..c68a500  suspend -> suspend
   93d7446..5dceb6d  test -> test
[lenb@t61 acpi (test)]$ git merge test suspend
Already up-to-date with 5dceb6d3377c3cbd06f7b3282fec0e201273c302
Trying simple merge with c68a5009ab9938af22af668e0e2d646d2482c866
/home/lenb/bin/git-merge-octopus: line 52: 24287 Segmentation fault      git read-tree -u -m --aggressive $common $MRT $SHA1
Merge with strategy octopus failed.
[lenb@t61 acpi (test)]$ git merge test suspend
fatal: unable to create '.git/index.lock': File exists
Already up-to-date with 5dceb6d3377c3cbd06f7b3282fec0e201273c302
Trying simple merge with c68a5009ab9938af22af668e0e2d646d2482c866
fatal: unable to create '.git/index.lock': File exists
Merge with strategy octopus failed.
[lenb@t61 acpi (test)]$ git --version
git version 1.5.4.4.537.gb75aa
[lenb@t61 acpi (test)]$
