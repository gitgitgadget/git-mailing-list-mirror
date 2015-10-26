From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/6] Miscellaneous platform-independent patches from Git for
 Windows
Date: Mon, 26 Oct 2015 14:14:50 +0100 (CET)
Message-ID: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqhc5-0000cn-O3
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbbJZNO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:14:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:57068 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbbJZNO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:14:56 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0M3j17-1ahymo35Np-00rHVb;
 Mon, 26 Oct 2015 14:14:51 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:TyxhUS3WcFEcJKoqYJm6XjKRbYaL8O4T9ZLlBQlyrzomtRTOWXC
 CNxh5zabEpUlkNLIpbqTKiHm8aTcjhg/8wrW5jw588FX+xqXpsGEz10PqcNajVQfGWt+bTw
 +94hYi/y28AbBJqEIjG6N0yLDdEDXSwzbfnnTqEdT6YUt8Ka9qs3Ky8Q42UISEeIHoCG3UT
 sy0/m+DGxubU9QItNPOyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZSGBezBvQp4=:/udiGLyjE4pOA8uFuytcNp
 3YuK8TxtGgGszfal6JTx7AF6r+35c8rXEaw+yNlqMl75iJDWZxMzQa768x0zSwCkHSfwEjelh
 WsckcooG22424JbR/zroT0SCteTDCmfYw+acIXtPOic+YuofSuGCkiYlpnt2ZRPtj8prqWq4D
 PRgmn56mrC1wxUu1AhUpBDv/rJ+iZzPLHly8FN+UNYXOm9miQHA1xpvBjeyqOQOtgT7qD6Oc+
 XxFhy9NDa/2MWuxuiiVRzt2xbzp6eIaNqW6/+GxzyTURE0iVZiWKcd7pZAWnGaepN6b2TTFR2
 o5FUBhFT9Xs29Jbka2RMdUjDiOkmje/+7QaPvytQPQMBiyFQzXX6ZvcVhVWuCvFyoqbczq7ED
 H7zPNeb5S7mvUysQngLRZgK3NFvYXmX6EBXOKwYPtVp8If9t7H+yIGuUhleDS2j3v+TDy8H9s
 gz8EMwXAJsjl7n9iKv/BuNkRIQU1IE4oxa1vWnOJG0zGixYLARS1X6wICi2tbByJx9SCSrsNT
 xmU6q0C/bzekO1fkF87PM7nCV4Ob4VL6P/VOnb9BbmNmWa4CWZJxM3fqwazchEU2YlGVfvTuZ
 rIxl+4aCzsrYCJWWCG08W+Kkl59s0odeQH0NTKFINqZUxqmiKgJ1wPsCsQDwBh0OK6/G4Tk7S
 cpq23iZkk3GRwjTB/17BUZCAtRYegGJpyZUuIlU4N4lAbif5nDtrVQnQvLLz/RIQlWTrlPGS8
 C4j4RuNBDO5ZWY3oxfKR2+pI8fDYrLBd3O3WvQA6c6jLgECfOEOn3Hwby02GE8mJuzJDUQ4N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280190>

While working on Git for Windows 2.x, a couple of fixes were necessary
that are not actually specific to Windows.

For example, when stuck behind a faulty Access Point that somehow worked
with an Android phone, but not with this developer's MacBook, it was
necessary to use a SOCKS proxy via the phone to be able to continue
developing Git for Windows.

This is the first patch series attempting to lift the patches from Git
for Windows' friendly fork into upstream Git.


Johannes Schindelin (4):
  Only use CURLOPT_LOGIN_OPTIONS if it is actually available
  Facilitate debugging Git executables in tests with gdb
  Squelch warning about an integer overflow
  Silence GCC's "cast of pointer to integer of a different size" warning

Pat Thoyts (1):
  remote-http(s): Support SOCKS proxies

Waldek Maleska (1):
  Correct fscanf formatting string for I64u values

 builtin/gc.c           |  2 +-
 compat/regex/regcomp.c |  6 ++++--
 git-compat-util.h      |  6 +++++-
 http.c                 | 11 +++++++++++
 imap-send.c            |  4 ++++
 pack-revindex.c        |  2 +-
 sha1_file.c            |  2 +-
 wrap-for-bin.sh        |  7 +++++++
 8 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.1.4
