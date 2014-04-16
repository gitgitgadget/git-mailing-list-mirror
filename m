From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 5/6] contrib/credential/wincred/git-credential-wincred.c: reduce scope of variables
Date: Wed, 16 Apr 2014 02:33:30 -0700
Message-ID: <1397640811-17719-5-git-send-email-gitter.spiros@gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:34:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMEB-0005Gq-P2
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbaDPJds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:33:48 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:32806 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbaDPJdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:33:46 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so10599723pbc.24
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+yWORb4dM2Yp+XJyBUC668DT+ItuEvMZ7OXSxb2snlo=;
        b=EdrwhFeAE9JVGYhodFbbMuY02NFFdIpFzUhMSqZ1PfxuEPc5LsfZC/x3vVKJWhlj64
         7BB39NZzzVyKYgGq3ie8gGB+u4u7BspvsrOUMfgGCkSBHg5d8Z5m34423Yxv8uMO2O7j
         r5wJ/nsSXpAXBTc4lBPQLbIylfryGW3/gqyUiJWdquct53T1/fhjx4B9pSVCZYcV5lk4
         W06+lxYqCpWFu+4kyLMbds9gnRnP4TOfnyIaNGMJw1vO4mMxXDO4Aq4p2rFP3WB4v0iT
         /vJ3PUHfmfvQ3VcWgZigpeow/+phfT5g0NA91rXNeoTDBzPU8sTMAMdVKTqhR3CkulXW
         wQXg==
X-Received: by 10.68.110.129 with SMTP id ia1mr7375226pbb.158.1397640826271;
        Wed, 16 Apr 2014 02:33:46 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id de5sm45687493pbc.66.2014.04.16.02.33.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 02:33:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246320>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/credential/wincred/git-credential-wincred.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index a1d38f0..edff71c 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -258,11 +258,13 @@ static void read_credential(void)
 
 int main(int argc, char *argv[])
 {
-	const char *usage =
-	    "usage: git credential-wincred <get|store|erase>\n";
 
 	if (!argv[1])
+           {
+	        const char *usage =
+	          "usage: git credential-wincred <get|store|erase>\n";
 		die(usage);
+           }
 
 	/* git use binary pipes to avoid CRLF-issues */
 	_setmode(_fileno(stdin), _O_BINARY);
-- 
1.7.10.4
