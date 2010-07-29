From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] svn-fe fixes
Date: Thu, 29 Jul 2010 11:06:17 +0530
Message-ID: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 07:38:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeLp7-0006eP-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 07:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab0G2FiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 01:38:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61688 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab0G2FiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 01:38:07 -0400
Received: by iwn7 with SMTP id 7so232148iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WwMAeMSNZPpsVqzsthH94/JhYUUzK4rNxW0nyYPP/Es=;
        b=gpOC51l4W6ZFmyxNNCECLsbzFJXiPB7je79/BYjdUyG76harulYpPD2To1Xa+MafQ2
         buUxSpuprdYmP0eG4Shnd4MMdmULUnNGh0YWEGc2hwcAmamc6L7AnPGh/kbpkLoZNABE
         SPyBBrRxs+NW/kTYTyaPCQvEVXjZI+eVmQU5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pYRdwecdl6epKdfyeRHMRibsMksMyNafu/7iAJWnAYoHH+TV1vVzzEmyHCewCBRxF8
         /OoaIR37fc1YB85IrxZXui1c3sPlNzN9sqBhvql6ccxrCC/IigaXN+M+fZz5Du8twVc3
         yEXFQfzvzmN42eYOEsTtb4MmN0eT1AS4P57CA=
Received: by 10.231.173.9 with SMTP id n9mr6776805ibz.146.1280381886326;
        Wed, 28 Jul 2010 22:38:06 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id h8sm442940ibk.3.2010.07.28.22.38.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 22:38:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152159>

Hi,

My first patch removes a few function calls that Jonathan forgot to
remove while turning off persistence- those functions aren't generated
by the obj_pool.h merged into `pu` (Commit fd94590214). My second
patch fixes the IncludePath in the Makefile so that svn-fe.h is able
to find the specified header. My third patch is just a trivial
patch to add /svn-fe to the .gitignore.

I'm sorry I didn't catch this earlier- I only just noticed that the
version merged into `pu` wasn't exactly the version I was basing my
work on, so I grafted out the commits and rebased to find these
problems. In the meantime, I'd request everyone to try out svn-fe in
`pu`- I'm soon going to send in more patches that are based on what's
already merged.

Thanks.

-- Ram

Ramkumar Ramachandra (3):
  vcs-svn: Remove stray calls to removed functions
  contrib/svn-fe: Fix IncludePath
  contrib/svn-fe: Add the svn-fe target to .gitignore

 contrib/svn-fe/.gitignore |    1 +
 contrib/svn-fe/Makefile   |    2 +-
 contrib/svn-fe/svn-fe.c   |    2 +-
 vcs-svn/repo_tree.c       |    3 ---
 vcs-svn/string_pool.c     |    1 -
 5 files changed, 3 insertions(+), 6 deletions(-)
