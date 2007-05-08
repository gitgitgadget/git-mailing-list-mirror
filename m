From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git rebase chokes on directory -> symlink -> directory
Date: Mon, 07 May 2007 18:08:12 -0700
Message-ID: <463FCD7C.4020009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 08 03:08:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEBt-00080R-2w
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966665AbXEHBIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967555AbXEHBIU
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:08:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39805 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966665AbXEHBIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:08:19 -0400
Received: from tazenda.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l4818CjY032518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 18:08:16 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3217/Mon May  7 11:01:19 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.8 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no
	version=3.1.8
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46501>

The following tree:

http://git.kernel.org/?p=linux/kernel/git/hpa/linux-2.6-newsetup.git;a=summary

... has one commit which changes arch/x86_64/boot from a directory to a
symlink, and another one which changes it back.  Apparently as a result,
git rebase dies horribly; on the first change it requires manual fixup,
but it crashes on the second, with or without -m.

The specific task attempted is to rebase the main branch of that tree
onto the current Linus tree, a989705c4cf6e6c1a339c95f9daf658b4ba88ca8.

	-hpa
