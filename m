From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 5/5] http-backend: more explict LocationMatch
Date: Sun, 25 Oct 2009 14:05:35 -0400
Message-ID: <1256493935-8680-6-git-send-email-lodatom@gmail.com>
References: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
 <1256493935-8680-2-git-send-email-lodatom@gmail.com>
 <1256493935-8680-3-git-send-email-lodatom@gmail.com>
 <1256493935-8680-4-git-send-email-lodatom@gmail.com>
 <1256493935-8680-5-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27Ss-00075h-4i
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbZJYSE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZJYSE4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:04:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:41144 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZJYSEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:04:53 -0400
Received: by qyk4 with SMTP id 4so7380307qyk.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3aah+8/o6d1wbbue60++1dzBdUxOSymS3U5PLBUWZ2A=;
        b=naNeHUrYEFQcylJMOuDfT3Wz1acqrZxx1/s+aNXyClybPuLDu0RX5ZGqhDTv/lr4KH
         GU63ZzgYl7Qo6aboeExP6mJB3BIQBp+nwYfTjfDa/UVHqwqMFaJL3Bm6iOYnvGnAdE7n
         UwrtW+bOxAJOAgiBVqZjrJCjdPH+WuBmk+XEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eSeyq5MUcbtwJ6zAaeOl/z5jBxUiLz3/thymWk+mTDQDOLk1S+7odf4cJvAdRsqL9n
         uA3OYWeJ3v4yR8SwFtkIbk1WrwbyO5Jarbn5a9c7B8BR5y/ITVuLv/rzL33zyGYxaX+g
         Qb+ymKwM57yURLa0K4z9lpW9Pa6r+3tkXTMlc=
Received: by 10.224.71.203 with SMTP id i11mr6756625qaj.338.1256493897673;
        Sun, 25 Oct 2009 11:04:57 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 7sm13930120qwf.46.2009.10.25.11.04.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:04:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256493935-8680-5-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131233>

In the git-http-backend examples, only match git-receive-pack within
/git/.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-http-backend.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 2989c9f..f17251a 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -69,7 +69,7 @@ To enable anonymous read access but authenticated write access,
 require authorization with a LocationMatch directive:
 +
 ----------------------------------------------------------------
-<LocationMatch ".*/git-receive-pack$">
+<LocationMatch "^/git/.*/git-receive-pack$">
 	AuthType Basic
 	AuthName "Git Access"
 	Require group committers
-- 
1.6.5.1
