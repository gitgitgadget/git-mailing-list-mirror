From: Alex Riesen <raa.lkml@gmail.com>
Subject: git-pack-redundant returns the most containing pack
Date: Thu, 17 Nov 2005 00:09:56 +0100
Message-ID: <20051116230956.GA21444@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 00:11:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWPv-00036X-3L
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbVKPXKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbVKPXKL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:10:11 -0500
Received: from devrace.com ([198.63.210.113]:30474 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030575AbVKPXKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 18:10:09 -0500
Received: from tigra.home (p54A0CE2A.dip.t-dialin.net [84.160.206.42])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAGN9wY1099010;
	Wed, 16 Nov 2005 17:10:00 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EcWPc-0000Wf-00; Thu, 17 Nov 2005 00:09:56 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EcWPc-0005cf-Mp; Thu, 17 Nov 2005 00:09:56 +0100
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12064>

...which very confusing: "git-repack -a -d" leaves the repository with
exactly the same packs as before, by creating a super-pack, and then
happily removing it, because pack-redundant returns the newly created
pack!

So, even if it is logically correct, it's hardly useful in practice.
