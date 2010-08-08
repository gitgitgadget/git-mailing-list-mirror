From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Makefile: add missing dependencies on url.h
Date: Sun, 8 Aug 2010 16:25:11 -0500
Message-ID: <20100808212510.GA6962@burratino>
References: <20100808211910.GA7210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 23:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiDOD-000288-JG
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 23:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0HHV0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 17:26:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62194 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab0HHV0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 17:26:36 -0400
Received: by gyg10 with SMTP id 10so3245205gyg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0btb5rtbSSmN0bKPe1kJ/K6C+H+pJACpJlpyE4ck60I=;
        b=vrMEYEsnOS7OQupPRqi0Y7OfmtWFauMYKCtUl/A4AEcHiNFvmrLeQIEnkv9+5ClNiY
         pag1qKy5iIlRx/49SeULXfjl3WGkxA9T4ibrJ27fXyHDDS/+KE6AKEZ1DKMCRgpmNTvT
         xSfBoQyqlXxDOQkBmbCSapPrXEqVsoUTPs/ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lwz3l280nB4BM8PmoT4QCITPkLkJm7TTankZi72BfqMa8hw2Xikxd01sHmXxKUxvBf
         GYbizNfryV1vzZpq20MSSvkfdDi9SGdvKBJbPIQnRUszqaGtBLrgAChMwhq5wXqZpaL2
         BqYzDVMybOfYpme+icwFWClXVZj8E5IKM5XAA=
Received: by 10.100.128.16 with SMTP id a16mr16896940and.34.1281302795354;
        Sun, 08 Aug 2010 14:26:35 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id u14sm7068668ann.0.2010.08.08.14.26.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 14:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100808211910.GA7210@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152931>

v1.7.2-rc0~56^2 and its parent (decode file:// and ssh://
URLs, 2010-05-23) introduced a new url library.  Update the
Makefile with the relevant dependencies.

Detected with "make CHECK_HEADER_DEPENDENCIES=1".

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f33648d..9a233b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1854,6 +1854,7 @@ builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 builtin/pack-objects.o: thread-utils.h
+connect.o transport.o http-backend.o: url.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o remote-curl.o: http.h
 
-- 
1.7.2.1.544.ga752d.dirty
