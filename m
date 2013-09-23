From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 00/15] Make Gnome Credential helper more Gnome-y and support ancient distros
Date: Sun, 22 Sep 2013 22:07:56 -0700
Message-ID: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOF-0001pI-VO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab3IWFIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:08:52 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62686 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab3IWFIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:08:51 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so2740719pdj.39
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jwqd8pyXCab9dFoCvJQAgn2Y1U4nsC9ssKxA4Hvg9Dc=;
        b=aIWjlNe5RXd4l/btaxUXM356Yxe4OCu/uSJM8Ldi260wmPNWRdLNAxJHnJsRssYgxb
         27EaD1n1uG6ITPpql25wAkT+mquYTovqyKK2Kd270qdg7+QVj7Hl0/IOPRIj0rVvEeRy
         w61j+WnIwop3smrjBnmekJb6vc0OqJLFauw0WqEJahhs4r4CNxOoq3dKTVL1n1tvdGje
         Ac2bg91P/CS5oSyQgSgRpTn/tlefTfQLKAK8PcQstJq6eKydvReHjP9VsxpAj1DPfNa9
         14NC1vVZaUxB2Iyam3D74k44eOtltwQ+SpDpl79q0PAe9K091f0354YjQ88C+BTFiFKD
         jFYA==
X-Received: by 10.68.179.98 with SMTP id df2mr21906589pbc.38.1379912931161;
        Sun, 22 Sep 2013 22:08:51 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:08:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235185>

A few cleanups, followed by improved usage of the glib library (no need
to reinvent the wheel when glib provides the necessary functionality), and
then the addition of support for RHEL 4.x and 5.x.

Brandon Casey (15):
  contrib/git-credential-gnome-keyring.c: remove unnecessary
    pre-declarations
  contrib/git-credential-gnome-keyring.c: remove unused die() function
  contrib/git-credential-gnome-keyring.c: add static where applicable
  contrib/git-credential-gnome-keyring.c: exit non-zero when called
    incorrectly
  contrib/git-credential-gnome-keyring.c: set Gnome application name
  contrib/git-credential-gnome-keyring.c: strlen() returns size_t, not
    ssize_t
  contrib/git-credential-gnome-keyring.c: ensure buffer is non-empty
    before accessing
  contrib/git-credential-gnome-keyring.c: use gnome helpers in
    keyring_object()
  contrib/git-credential-gnome-keyring.c: use secure memory functions
    for passwds
  contrib/git-credential-gnome-keyring.c: use secure memory for reading
    passwords
  contrib/git-credential-gnome-keyring.c: use glib memory allocation
    functions
  contrib/git-credential-gnome-keyring.c: use glib messaging functions
  contrib/git-credential-gnome-keyring.c: report failure to store
    password
  contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
  contrib/git-credential-gnome-keyring.c: support really ancient
    gnome-keyring

 contrib/credential/gnome-keyring/Makefile          |   4 +-
 .../gnome-keyring/git-credential-gnome-keyring.c   | 280 ++++++++++++---------
 2 files changed, 158 insertions(+), 126 deletions(-)

-- 
1.8.4.489.g545bc72
