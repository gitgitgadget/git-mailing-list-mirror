From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 07/14] weaken specification over cookies for authentication
Date: Wed, 11 Sep 2013 01:07:51 +0800
Message-ID: <1378832878-12811-8-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
 <1378832878-12811-7-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQo-0003Wj-QA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3IJRIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:36 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44819 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3IJRId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:33 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so7946389pdi.41
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OI7LQBciTONrvbvfjbaLE9XzGstcpXeMSU/8f2j2mGs=;
        b=Bou0XAqZdi7tKvQq8yL8L6yELu65sxvp3rEFexjUJQzZzjuKmrt+Uc2i92agG0n/MJ
         /QQSDhaAIU9qOl8Oy9QYSP6ANFn10zQdOSp4cqHvgaGVOeOgSSa/l8jCKi9PtrGZZe+3
         RBe46SGmETUg/WPiXLsH1eG9koT+Yt6hHhtupTM5I3efR5UntDxBq9j5UuB0UA/vO9TQ
         TFosky91nWAqD8T6WNMOyOQ/MWgNATCTPYEySndEkKi+YeqA+vuDu4beRyABgt6ThlSK
         GGBpR06K/GB3c89yPnknai1L5CP8rXzqnYMu2jRDIKDqq2Jc/4POAxDO94OgHSEyvmnc
         9qQQ==
X-Received: by 10.68.228.73 with SMTP id sg9mr11130469pbc.136.1378832913122;
        Tue, 10 Sep 2013 10:08:33 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-7-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234452>

From: "Shawn O. Pearce" <spearce@spearce.org>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
--
To Shawn: sign-off-by needed.

Based on the discussion in
  <20091009195035.GA15153@coredump.intra.peff.net>,
  <20091015165228.GO10505@spearce.org> (patch),
  <20091015173902.GA22262@sigill.intra.peff.net> (agreement)

  From: "Shawn O. Pearce" <spearce@spearce.org>
  Message-ID: <20091015165228.GO10505@spearce.org>

  I weakend the sections on cookies:

  + Authentication
  + --------------
  ....
  + Servers SHOULD NOT require HTTP cookies for the purposes of
  + authentication or access control.

  and that's all we say on the matter.  I took out the Servers MUST
  NOT line under session state.
---
 Documentation/technical/http-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 412b898..2382384 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -52,7 +52,7 @@ Clients SHOULD support Basic authentication as described by RFC 2616.
 Servers SHOULD support Basic authentication by relying upon the
 HTTP server placed in front of the Git server software.
 
-Servers MUST NOT require HTTP cookies for the purposes of
+Servers SHOULD NOT require HTTP cookies for the purposes of
 authentication or access control.
 
 Clients and servers MAY support other common forms of HTTP based
-- 
1.8.4.rc4.527.g303b16c
