From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 0/4] fix compilation with OpenSSL 1.1.0-pre4
Date: Sat,  9 Apr 2016 01:22:12 +0900
Message-ID: <cover.1460130092.git.k@rhe.jp>
Cc: Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 18:22:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZBC-0000dJ-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 18:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454AbcDHQWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 12:22:37 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:42463 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbcDHQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 12:22:33 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 4B17161C9F;
	Fri,  8 Apr 2016 16:22:30 +0000 (UTC)
X-Mailer: git-send-email 2.8.1.104.g0d1aca6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291042>

OpenSSL 1.1.0 is not released yet, but the first beta 1.1.0-pre4 was
released on Mar 16[1]. According to the OpenSSL's web site[2], only bug
fixes will be applied after beta release, and 1.1.0 final will be in a
month or two.

Thanks,

[1] https://mta.openssl.org/pipermail/openssl-announce/2016-March/000067.html
[2] https://www.openssl.org/policies/releasestrat.html

Kazuki Yamaguchi (4):
  imap-send: use HMAC() function provided by OpenSSL
  imap-send: check NULL return of SSL_CTX_new()
  imap-send: avoid deprecated TLSv1_method()
  configure: remove checking for HMAC_CTX_cleanup

 Makefile                     |  6 ------
 compat/apple-common-crypto.h | 16 +++++++++++-----
 configure.ac                 |  4 ----
 git-compat-util.h            |  3 ---
 imap-send.c                  | 20 ++++++++++----------
 5 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.8.1.104.g0d1aca6
