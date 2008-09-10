From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Wed, 10 Sep 2008 20:03:18 +0900
Message-ID: <20080910200318.6117@nanako3.lavabit.com>
References: <7vljy13sq0.fsf@gitster.siamese.dyndns.org> <20080910062529.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 13:05:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdNVY-0000Nl-Nd
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 13:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbYIJLDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 07:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbYIJLDc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 07:03:32 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49400 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbYIJLDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 07:03:31 -0400
Received: from g.earth.lavabit.com (g.earth.lavabit.com [192.168.111.16])
	by karen.lavabit.com (Postfix) with ESMTP id 75423C8926;
	Wed, 10 Sep 2008 06:03:21 -0500 (CDT)
Received: from 1180.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id PZ8B6EHNZ9XP; Wed, 10 Sep 2008 06:03:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=USEe1QylgtqqbxUoEHPyqqx7Pqya2GZ1HxjKPoix3I4YftuSLeYCzjTXIBd5L6TAgnHclx8GOPvL0YEuFA8YMkhmkNKWx7/WGYhqbutXJuf3TZnNt8dMvQO7Yz0rFwqrrt4b97Cd1y4g+3H5mldUs6TQkOL96dmgtl1geKVStSY=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95511>

Quoting Junio C Hamano <gitster@pobox.com>:

>  * We always install "server side programs" in $(bindir).
>
> I think git-cvsserver is the last one we missed from the set of server
> side programs (git-cvsserver, git-daemon, git-receive-pack,
> git-upload-archive, git-upload-pack).

-- %< --
Subject: [PATCH] Install git-cvsserver in $(bindir)

It is one of the server side programs and needs to be found on usual $PATH.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index f4c31c8..92a109f 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,7 +1368,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
-- 
1.6.0.1


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
