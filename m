From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v2] Replace tmpname with pack_tmp_name in warning. The developer mistook tmpname for pack_tmp_name.
Date: Sun,  2 Mar 2014 10:43:39 +0800
Message-ID: <1393728219-3142-1-git-send-email-sunheehnus@gmail.com>
Cc: gister@pobox.com, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwPO-0006XF-9O
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbaCBCpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 21:45:00 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36824 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbaCBCo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:44:59 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so2343618pdi.33
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yAUTbXR0ezK72KqyaReoLWOsT/9Ea3QzzUqf6LkjDzE=;
        b=RAsYGjd7m6+BrtGWJtA6nP+WVSOMKxwiPlqm4uo0t3Nz/c/KLSExBxAimLcfIesNGR
         Z1xI5kvVHO28/4T06IdmuGGuIFd6wkEBh4LVuSMSEEWvqb0bgDMfMsualOjpn3xudgx5
         0t3FdnLDloWNDK1OTwNf1D1YIQ8yyyV6Ilfbi20c+OJvL0YlqWngpUYfAQ2qrwqZR+kl
         DwzVud9goJrqeZWw84mH7wnmCoijaku30niQER0HONYQ9ceMxHQgMvwA8EaYXnxVGNy8
         cTTkv/AVsRjGDuTARsybkVopGnUAA5ci8GKjt6pVRf3UcCzcEZ/YWwGTlEgpWNfmLL9Q
         mdFg==
X-Received: by 10.68.194.65 with SMTP id hu1mr70318pbc.158.1393728299547;
        Sat, 01 Mar 2014 18:44:59 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id sx8sm50785033pab.5.2014.03.01.18.44.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Mar 2014 18:44:58 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243119>

Signed-off-by: Sun He <sunheehnus@gmail.com>
---

 As tmpname is used without initialization, it should be a mistake.

 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..4922ce5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -823,7 +823,7 @@ static void write_pack_file(void)
 				utb.modtime = --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
 					warning("failed utime() on %s: %s",
-						tmpname, strerror(errno));
+						pack_tmp_name, strerror(errno));
 			}
 
 			/* Enough space for "-<sha-1>.pack"? */
-- 
1.9.0.138.g2de3478.dirty
