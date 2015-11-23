From: larsxschneider@gmail.com
Subject: [PATCH v7 0/2] Add Travis CI support
Date: Mon, 23 Nov 2015 09:25:06 +0100
Message-ID: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 09:25:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0mR8-0004rY-M3
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 09:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbbKWIZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 03:25:15 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33462 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbbKWIZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 03:25:12 -0500
Received: by wmec201 with SMTP id c201so148490672wme.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kMPW//n+5kCljCdP/fjVt+g6qgKt0yeatHt4uDO48UA=;
        b=y1jfiV+SnNIX1Kh2sBH1wLt72RR82Nsn8pJHM0XD63oHANw8QkELEjhol9tIQQA6Ic
         eSeA6jxj028RIrE1QxEx5n4P5xJ4RW2jNlJKrBd0B7fcZFwmu+6O9vHIxuxOGguAp29g
         dfwHthVy5acZLZl3U25wK4ikm7yPpOdf3BpYC4SXSM0z1reo/0fLDEJQUk/TgZnzqsEa
         htlTnBLaffBajmF2kEDzS1QtY5XdXUYcP+LpKf00JfuNdojqqbxB4C1t6w6hqxt1S5N5
         T/OSkQwnmi5j7TWdQwVqptWjEtnYBlPDhw6X1lkykFpWzr71dLqUuNaqv4SvhLXe9g+N
         S/yw==
X-Received: by 10.28.142.205 with SMTP id q196mr15937481wmd.42.1448267110836;
        Mon, 23 Nov 2015 00:25:10 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB6DC4.dip0.t-ipconnect.de. [93.219.109.196])
        by smtp.gmail.com with ESMTPSA id a63sm8659788wmc.5.2015.11.23.00.25.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Nov 2015 00:25:09 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281575>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v6 (thanks Peff for the review):
* removed sub topics "de-flaking test_must_fail" and "p4 test improvements"
  as suggested by Peff
* fixed Perforce spelling
* disabled t9810 and t9816 in .travis.yml as they are instable
* removed commented flags in .travis.yml
* removed GETTEXT_* flags in .travis.yml
* removed NO_* build configration in .travis.yml
* removed autoconf usage
* fixed OS X 10.9 build and later with NO_GETTEXT flag
* added cflags "-Wall -Werror" to detect all kinds of warnings (see [1])
* updated Git-LFS and P4D to the latest version

Cheers,
Lars

[1] http://thread.gmane.org/gmane.comp.version-control.git/281140


Lars Schneider (2):
  config.mak.uname: Darwin: define NO_GETTEXT for OS X 10.9 and later
  Add Travis CI support

 .travis.yml      | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 config.mak.uname |  5 ++++
 2 files changed, 95 insertions(+)
 create mode 100644 .travis.yml

--
2.5.1
