From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/2] cherry-pick: fix memory leaks
Date: Fri,  7 Jun 2013 17:29:26 -0500
Message-ID: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:31:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5Br-0006LY-F0
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab3FGWbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:31:19 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47700 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab3FGWbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:31:18 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so7226082obc.6
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uPWq6M/Ezi+lySx7Midz6gyKKehN7v/C0C0a/MO9LOw=;
        b=bMfXJsDqh18BsuIHIHOrBlb/5C5qGyEfkMuKpVItlMebqft9CZhnYmwq5u6YkfNqkR
         gnWzQDzWg0I7yNA0UiQa4AKW4fjA8BZWcxg3q6VQcZS2nQ4T58L67TsQa7EiLiw4zOv+
         BUXkJDhsjOKtufstvmiq0OgmqIEdCjKzG/aRZPTdyZlH1gVRJ2zKKB6x269OCY335Ldk
         YIxAL5v5IWVxIvyS+0Lg0b5qHkOxI53TsMrtoqCsq66XeCgsJb7GGDoxsf66bcAMKf4a
         J9EYR+f7RomxKbevmqZJ/yfY71WKMFRWdjPBD/8H0m1UEIv/SRre4r991kER9hV/m197
         SfGQ==
X-Received: by 10.60.117.41 with SMTP id kb9mr585763oeb.33.1370644278238;
        Fri, 07 Jun 2013 15:31:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm993768obx.9.2013.06.07.15.31.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:31:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226756>

Felipe Contreras (2):
  unpack-trees: plug a memory leak
  read-cache: plug a few leaks

 read-cache.c   | 4 ++++
 unpack-trees.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.8.3.698.g079b096
