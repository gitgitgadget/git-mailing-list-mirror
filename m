From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 0/2] git-merge-file: do not add LF at EOF while applying unrelated change
Date: Sun, 29 Jun 2014 01:04:44 +0300
Message-ID: <1403993086-15625-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 00:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X10ry-0002kz-Nd
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 00:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbaF1WNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 18:13:06 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:38291
	"EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaF1WNG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 18:13:06 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jun 2014 18:13:06 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-07.prod.phx3.secureserver.net with 
	id Ky521o00K3gsSd601y57cx; Sat, 28 Jun 2014 15:05:12 -0700
X-Mailer: git-send-email 2.0.0.526.g5318336
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252620>

I realized the case when the newline adding can be needed.

The version 2 have this case (union-merge of changes at EOF without LF)
fixed, with adding corresponding tests.

Max Kirillov (2):
  t6023-merge-file.sh: fix and mark as broken invalid tests
  git-merge-file: do not add LF at EOF while applying unrelated change

 t/t6023-merge-file.sh | 91 +++++++++++++++++++++++++++++++++++++++++++++++++--
 xdiff/xmerge.c        |  4 +--
 2 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.0.0.526.g5318336
