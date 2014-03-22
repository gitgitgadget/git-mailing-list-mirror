From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 00/10] pickaxe: honor -i when used with -S and --pickaxe-regex; cleanups
Date: Sat, 22 Mar 2014 18:15:50 +0100
Message-ID: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXR-00025U-5V
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbaCVRQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:31 -0400
Received: from mout.web.de ([212.227.15.3]:56148 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbaCVRQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:29 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M9XP5-1WFcta2spD-00CwMc; Sat, 22 Mar 2014 18:16:09
 +0100
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K0:Wqby4W4Yzdtn9Z7eXxDIYWWYZdyB7oUfKQO7JgfORmnSockYWp6
 v+CxDodCsN07S8eN6JkCcDiwFWexil5VGflfTyiCeGoPPULC0ghA8o5aa6krwbIp2bqGzhF
 kIYGPXGMAbeQwklVDMOwATW8ixRCJFVLoZDKeVNB8K5pGwW9n0vuvzrqM0luN9GRYpqCE2s
 uJNqVkLY/PKQtrPEFBEhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244779>

This series allows the options -i/--regexp-ignore-case, --pickaxe-regex,
and -S to be used together and work as expected to perform a pickaxe
search using case-insensitive regular expression matching.  Its first
half refactors the test script and extends test coverage a bit while
we're at it.  The actual change is in the sixth patch.  It enables the
two following cleanups.  The last two patches are independent simple
cleanups.

  t4209: set up expectations up front
  t4209: factor out helper function test_log()
  t4209: factor out helper function test_log_icase()
  t4209: use helper functions to test --grep
  t4209: use helper functions to test --author
  pickaxe: honor -i when used with -S and --pickaxe-regex
  pickaxe: merge diffcore_pickaxe_grep() and diffcore_pickaxe_count()
    into diffcore_pickaxe()
  pickaxe: move pickaxe() after pickaxe_match()
  pickaxe: call strlen only when necessary in diffcore_pickaxe_count()
  pickaxe: simplify kwset loop in contains()

 diffcore-pickaxe.c     | 142 +++++++++++++++++--------------------------
 t/t4209-log-pickaxe.sh | 159 +++++++++++++++++--------------------------------
 2 files changed, 110 insertions(+), 191 deletions(-)

-- 
1.9.1
