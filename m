From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 0/3] Add --graft option to git replace
Date: Thu, 22 May 2014 23:33:03 +0200
Message-ID: <20140522211836.27162.80311.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 07:09:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnhjD-00087o-5A
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 07:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbaEWFJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 01:09:02 -0400
Received: from [194.158.98.15] ([194.158.98.15]:52607 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751546AbaEWFJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 01:09:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 4B84C37;
	Fri, 23 May 2014 07:08:39 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249971>

Here is a small patch series to implement:

	git replace [-f] --graft <commit> [<parent>...]

The changes since the RFC/PATCH are the following:

- in patch 1/3, parse_commit_buffer() is now used to
  make sure <commit> is not corrupt
- patch 2/3 add some tests
- patch 3/3 add some documentation

About the documentation, maybe we should add that --graft
can now be used instead of grafts in .git/info/grafts,
and maybe we could add an example that shows how it can
be done.

Christian Couder (3):
  replace: add --graft option
  replace: add test for --graft
  Documentation: replace: add --graft option

 Documentation/git-replace.txt |  8 +++++
 builtin/replace.c             | 84 ++++++++++++++++++++++++++++++++++++++++++-
 t/t6050-replace.sh            | 12 +++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

-- 
1.9.rc0.17.g651113e
