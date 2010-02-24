From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 0/5] repo-local env vars handling
Date: Thu, 25 Feb 2010 00:34:13 +0100
Message-ID: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 00:34:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQkR-0002nx-Hm
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758551Ab0BXXe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:34:26 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61827 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420Ab0BXXeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:34:25 -0500
Received: by wwf26 with SMTP id 26so1593994wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/ai1NWL8APhUn+FLqPp/5lRajJc0ZMr26mMR+W8nLGE=;
        b=pmz3ZVB1C6ZzSEtI/mSBhSMXRyRYwxjXRepErXexQIfQMZ0E5OfPHceY0bx2rN6rpX
         LyvdSnkK52xPYB8pCZEE6cOJtxe7QEZo/InO4Utu77dNYRnC6Ld/kf+/mqyGQXIr5HjY
         vXwq8eZdGv7EjnLFNFw7PWWJJuVLEXkx9zSQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DkAEhVDFMNVTlsrs6pEDz4FU4/S4QxlQcTL1V14swO8kR6mQBEqTOZmsChuz71yuW0
         8Ayp+j+rpHARSSUeFpfjf9t918eRzIuzgzENCf1/5VrdQA7YVhRkITght/11ZIQqoPrk
         tWblmOc/KnW2FZS/KdbcArVwdtEF2RFWUb5Vk=
Received: by 10.216.165.148 with SMTP id e20mr283576wel.29.1267054464335;
        Wed, 24 Feb 2010 15:34:24 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id g9sm23873747gvc.18.2010.02.24.15.34.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 15:34:23 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g5b851b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141003>

Changes from the previous iteration:

* the first two patches were squashed together
* local_repo_env_size is now a #define to the number of non-NULL entries in 
  the list of repo-local env vars. The last patch is consequently adjusted.

Giuseppe Bilotta (5):
  Refactor list of of repo-local env vars
  rev-parse: --local-env-vars option
  shell setup: clear_local_git_env() function
  submodules: ensure clean environment when operating in a submodule
  is_submodule_modified(): clear environment properly

 Documentation/git-rev-parse.txt |    6 ++++++
 builtin-rev-parse.c             |    8 ++++++++
 cache.h                         |    8 ++++++++
 connect.c                       |   14 ++------------
 environment.c                   |   15 +++++++++++++++
 git-sh-setup.sh                 |    7 +++++++
 git-submodule.sh                |   20 ++++++++++----------
 submodule.c                     |   21 +++++++++++----------
 8 files changed, 67 insertions(+), 32 deletions(-)
