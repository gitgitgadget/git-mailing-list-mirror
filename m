From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/3] Improve robustness of putty detection
Date: Sun, 26 Apr 2015 20:30:09 +0000
Message-ID: <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 22:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmTCB-000729-Gw
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 22:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbbDZUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 16:30:21 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48874 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754AbbDZUaV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 16:30:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D9BCD2808D;
	Sun, 26 Apr 2015 20:30:19 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267836>

This series improves detection of plink (the putty utility).

While I was adding tests, I noticed that we had a broken test due to the
use of single quotes within a test, which resulted in the test always
being skipped.  Therefore, nobody noticed that the test was actually
broken.

brian m. carlson (3):
  connect: simplify SSH connection code path
  t5601: fix quotation error leading to skipped tests
  connect: improve check for plink to reduce false positives

 connect.c        | 56 ++++++++++++++++++++++++++++++++++----------------------
 t/t5601-clone.sh | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 23 deletions(-)

-- 
2.3.5
