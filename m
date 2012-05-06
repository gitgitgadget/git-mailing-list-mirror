From: Roy Liu <roy@eschatonlabs.com>
Subject: A small change to the gitweb documentation
Date: Sun, 6 May 2012 19:59:10 -0400
Message-ID: <CAOZa66yEnrC1bMVVLCzGJgqqWryg1Kt0AnP54YftASudG5zt7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:59:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRBMh-0000kk-MO
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 01:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab2EFX7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 19:59:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40930 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232Ab2EFX7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 19:59:11 -0400
Received: by pbbrp8 with SMTP id rp8so5977185pbb.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eschatonlabs.com; s=google;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=2b/DUHYg3QLk4Vpu9zJTH3+MdfUyBjjdQIdc9f2Ebj8=;
        b=QnqSWYT0Yt9tT2rTtbDzJ40Y2Zj6smTiNqA7RXtim/Po1pQk1QeyDIivUMgmV0PZT0
         6Wqquxlo9Yzhd3sjCW2fvAA3HEdwarNIUvPWMpDnXccd5GWMVibO6uBe//q1lagPg6cH
         +e7r8sRTMwnS+tNMZWjshRmFdY4Ia/n3HdQt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=2b/DUHYg3QLk4Vpu9zJTH3+MdfUyBjjdQIdc9f2Ebj8=;
        b=hWGUIbp5vYbM6RyZKHIQiD35WhLAz+lmIOuPFfT0Bk8JBgvW98xXLlPFyWR2CFhhxm
         cH3AQ0sQ0k6fLRpArGEmb/0Fwjfd/XMLYvNAArre4iiJUAqXOgcMY4LpSdJUuzI4WPKv
         CogUWv88NpQc1s5vfqWrE/5Drk8UbEoLfUwfb3tyzfD4ERvow1STw5pdXywuOHmAdy+f
         YNIXNEAncvs3xaPsFFgq9CgAgwEZtJTKxZpF3M31hhPICcn+8IYqxJ7vFUMJo3aEY8Fy
         DK1yxbefSQzXptkhOAshDxUTAlf7Dj8xNwo5cpRNiEQ4A7Jmtm/psJ3M6rgtI/r6Nhk+
         o9uQ==
Received: by 10.68.203.66 with SMTP id ko2mr40473992pbc.84.1336348750379; Sun,
 06 May 2012 16:59:10 -0700 (PDT)
Received: by 10.68.191.233 with HTTP; Sun, 6 May 2012 16:59:10 -0700 (PDT)
X-Originating-IP: [166.249.100.5]
X-Gm-Message-State: ALoCoQndj/fg7YPB6Sijj9APoXI7RIH9g4VCB6lUpj71sin+7JBW6eMs8Nfmd2Vy/1X7bc1KxWcT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197224>

Hi,

When reading the Apache server mod_rewrite documentation, I noticed
that it had this to say about the "PT" (passthrough) option:

The PT flag implies the L flag: rewriting will be stopped in order to
pass the request to the next phase of processing.

Current, the gitweb documentation has a mod_rewrite example that uses
the option "[L,PT]".  Since the "L" is probably redundant, I propose
the following patch:

Regards,
Roy

diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 168e8bf..eb16bbd 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -633,7 +633,7 @@ complementary static files (stylesheet, favicon,
JavaScript):
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RewriteEngine On
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RewriteCond %{REQUEST_FILENAME} !-f
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RewriteCond %{REQUEST_FILENAME} !-d
- =C2=A0 =C2=A0 =C2=A0 RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+ =C2=A0 =C2=A0 =C2=A0 RewriteRule ^.* /gitweb.cgi/$0 [PT]
=C2=A0 =C2=A0 </Directory>
=C2=A0</VirtualHost>
=C2=A0-----------------------------------------------------------------=
-----------
@@ -664,7 +664,7 @@ named *without* a .git extension (e.g.
'/pub/git/project' instead of
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RewriteEngine On
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RewriteCond %{REQUEST_FILENAME} !-f
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RewriteCond %{REQUEST_FILENAME} !-d
- =C2=A0 =C2=A0 =C2=A0 RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+ =C2=A0 =C2=A0 =C2=A0 RewriteRule ^.* /gitweb.cgi/$0 [PT]
=C2=A0 =C2=A0 </Directory>
=C2=A0</VirtualHost>
=C2=A0-----------------------------------------------------------------=
-----------
