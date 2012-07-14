From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] block-sha1: put macro arguments in parentheses
Date: Sat, 14 Jul 2012 16:57:49 -0500
Message-ID: <20120714215749.GE28502@burratino>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino>
 <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino>
 <50010B84.5030606@orcon.net.nz>
 <20120714075906.GD3693@burratino>
 <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
 <20120714205049.GA28502@burratino>
 <CA+55aFxHAPJi9cKVy6Mi7gunHT3PPLEQUwJBFQ4ftO2szc_dow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Cree <mcree@orcon.net.nz>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 23:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqALh-0006ks-4C
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 23:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2GNV54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 17:57:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40186 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab2GNV5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 17:57:54 -0400
Received: by obbuo13 with SMTP id uo13so6997220obb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c8knodpPwKBJPiWUbtDDsWNlZlNp7fGK/hWvm4+jsWg=;
        b=RDjRH5/Ote9zxcVXkLc4He1V2kVTnpML63wcZrh4ypPpEqw3wWRrdcUfLUVmrYEq1p
         mflfNOp016+7nXb8NcaC068XW8nfDRAblRKIl7DLX/dCtOeoWUp48S6sO5FQmJawQ8hz
         gYXH4TgmXyR90tdPqf5hacTDSoKc3dt+FgWaBwfyn/4UqG5V/PTd/Nt33IAEafTt5mzW
         2tQe/Farx6zh0u4K6484hSEVHYrUfx7hy34seVlF9YSKAowqB+HIz/uF5FVoQoVZbvnV
         QZIoUwkmN13o8rhw3trQvjjxLsl4xnE4VfhUKBfVBg0g+F9XDPni/7lYjkGKc2ufUGG+
         mKBg==
Received: by 10.50.36.227 with SMTP id t3mr2180954igj.13.1342303074013;
        Sat, 14 Jul 2012 14:57:54 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k6sm10253192igw.14.2012.07.14.14.57.53
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jul 2012 14:57:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFxHAPJi9cKVy6Mi7gunHT3PPLEQUwJBFQ4ftO2szc_dow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201460>

't' is currently always a numeric constant, but it can't hurt to
prepare for the day that it becomes useful for a caller to pass in a
more complex expression.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 block-sha1/sha1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 10fd94d1..6f885c43 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -100,8 +100,8 @@
  * Where do we get the source from? The first 16 iterations get it from
  * the input data, the next mix it from the 512-bit array.
  */
-#define SHA_SRC(t) get_be32((unsigned char *) block + t*4)
-#define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
+#define SHA_SRC(t) get_be32((unsigned char *) block + (t)*4)
+#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1);
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
 	unsigned int TEMP = input(t); setW(t, TEMP); \
-- 
1.7.10.4
