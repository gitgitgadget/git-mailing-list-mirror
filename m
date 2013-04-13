From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Introduce pull.autostash
Date: Sun, 14 Apr 2013 02:45:26 +0530
Message-ID: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 13 23:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR7nf-00017H-CB
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 23:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab3DMVPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 17:15:51 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47321 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMVPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 17:15:50 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so1907661pdi.7
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=LaTa/JsTP177/FknViBRxJ2B/eakgBMmMl/Q3kyhrqE=;
        b=j8IRcO88SyxXhyIwibeM+F9Y+NwpGOAKrTZZWgTgNdalagWTzeMu1ZNzzutwLxn8qr
         ZyhmcQx1nM6b3975ImNwWEFVrfgY7t1xDXMx2KyV5DUXty+lD+prypbq3Q/r2/DUUMLb
         0bVeFbqAj/LXhlDa0YHozCoYSH569q3EQ5Qku771ZA7ClkE8hc8uKhUBqnzPC/YQaCYN
         aKBaYLe7Ja7Rwm9PEL2IHruHH9OtoIRXagsmYFgiQwR2ntpJE4y9wJ8Qq74bRZYrvjzX
         YvKqL6UbleNLqgAR+mkZ1l6rURDe5p00W2CYMu988uLLFujnbi4rUOncCabLwKUYmqbh
         aG0g==
X-Received: by 10.68.250.164 with SMTP id zd4mr21640802pbc.133.1365887749765;
        Sat, 13 Apr 2013 14:15:49 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.24])
        by mx.google.com with ESMTPS id fb7sm15112193pab.16.2013.04.13.14.15.47
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 14:15:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.392.g6943ea6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221069>

I've been using this patch for some time now, and have to say that
'git pull' is much more useable now.  The feature is turned off by
default so that it doesn't break any existing tests.

[1/3] and [2/3] are simple "while we're there" patches, that are
unchanged from the last round.

[3/3] is actually fine in this round.  I'm embarassed that I sent out
the previous round in such a hurry: there were a lot of things wrong
with it, as Junio's review pointed out.

Ramkumar Ramachandra (3):
  pull: prefer invoking "git <command>" over "git-<command>"
  t5521 (pull-options): use test_commit() where appropriate
  pull: introduce --[no-]autostash and pull.autostash

 Documentation/config.txt   |  5 ++++
 Documentation/git-pull.txt |  7 +++++
 git-pull.sh                | 37 ++++++++++++++++++++++---
 t/t5521-pull-options.sh    | 67 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 110 insertions(+), 6 deletions(-)

-- 
1.8.2.1.392.g6943ea6
