From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] Plug SVN exporter into remote helper
Date: Tue, 25 May 2010 19:00:17 +0200
Message-ID: <1274806818-10904-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 18:59:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGxTJ-0003n3-NW
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 18:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758989Ab0EYQ7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 12:59:10 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46472 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab0EYQ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 12:59:09 -0400
Received: by ewy8 with SMTP id 8so604062ewy.28
        for <git@vger.kernel.org>; Tue, 25 May 2010 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=c2KAQ6upDbvyi3lbMsQC7ictVkWuDdwLedt4w+s7/+Q=;
        b=lMZOq5zzfzBinevedDgIMvnv7YMfAzDAbs0U3ppjmUgmZAsDQuvo0gkuXitx1FuNSM
         oMd4bcwMBXBs3YQdDgzPdUpYGaKDNRzp37Hb2m0mOBKSAViCF0Se6y4EnS9dTZ/ZQ+tE
         XYygkKo/r9M8nuNYLL0Nrvv9XDdyqji5CIpAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fdvrX2OOrXzTjAFnF6foaXkhxkuEnInLnYbnDdK8fGwGMrHPZ0CVoOgZQLdLmn06bL
         96u8KodSuhmFDfEiXNzd3sw005oZlSryUxfqj+LxYDpNvDXuPJAei3pKUzZi6c4SPhKL
         KN7wUMIp4/Qg47WUOVuJZagEO1SruJXKiDcW4=
Received: by 10.213.3.66 with SMTP id 2mr613744ebm.32.1274806745205;
        Tue, 25 May 2010 09:59:05 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm2571778ewy.6.2010.05.25.09.59.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 09:59:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147715>

Hi,

This is a work-in-progress based on master, and is not intended for
inclusion anytime in the near future. The remote helper should now
have a valid import capability. To use it, you must:

0. Checkout the `git-merge` branch of my svn-dump-fast-export fork
   into a fresh vcs-svn/ subdirectory on git.git `master`, and then
   build it with the Makefile rule provided.
1. Call the remote with a valid file (relative path is alright) passed
   in as an argv[1].
2. Give it the command "import foo" following by two newlines where
   "foo" is any arbitrary string that isn't blank.

[1]: http://github.com/artagnon/svn-dump-fast-export

Ramkumar Ramachandra (1):
  Add remote SVN helper

 .gitignore   |    1 +
 Makefile     |   14 ++++-
 remote-svn.c |  191 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 1 deletions(-)
 create mode 100644 remote-svn.c
