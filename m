From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/5] teach replace objects to sha1_object_info_extended()
Date: Sat, 30 Nov 2013 14:51:18 +0100
Message-ID: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 14:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmkxx-0004XU-Rs
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 14:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab3K3NwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 08:52:09 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:55417 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab3K3NwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 08:52:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id CDBF1E5;
	Sat, 30 Nov 2013 14:52:04 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238560>

Here is a patch series to improve the way sha1_object_info_extended()
behaves when it is passed a replaced object.

This patch series was inspired by a sub thread in this discussion:

http://thread.gmane.org/gmane.comp.version-control.git/238118

Patches 1/5 and 2/5 are cleanups.
Patch 4/5 adds a test that fails.
Patch 5/5 adds a call to lookup_replace_object_extended() in
sha1_object_info_extended() and makes the previous test pass.

Christian Couder (5):
  replace_object: don't check read_replace_refs twice
  introduce lookup_replace_object_extended() to pass flags
  Add an "unsigned flags" parameter to sha1_object_info_extended()
  t6050: show that git cat-file --batch fails with replace objects
  sha1_file: perform object replacement in sha1_object_info_extended()

 builtin/cat-file.c |  2 +-
 cache.h            |  8 +++++++-
 replace_object.c   |  3 ---
 sha1_file.c        | 20 ++++++++++----------
 streaming.c        |  2 +-
 t/t6050-replace.sh |  5 +++++
 6 files changed, 24 insertions(+), 16 deletions(-)

-- 
1.8.4.1.561.g12affca
