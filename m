From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 0/4] Add --graft option to git replace
Date: Fri, 06 Jun 2014 22:25:31 +0200
Message-ID: <20140606201741.3722.96819.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 08:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtAN6-0000bt-9X
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 08:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaFGGor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 02:44:47 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:51727 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbaFGGoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 02:44:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id CC5DB34;
	Sat,  7 Jun 2014 08:44:42 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251022>

Here is a small patch series to implement:

        git replace [-f] --graft <commit> [<parent>...]

This patch series goes on top of the patch series that
implements --edit.

The changes since v3, thanks to Junio, are:

- remove function read_sha1_commit() and its call as well as a
  call to parse_commit_buffer(), as lookup_commit_or_die()
  already reads the commit buffer and parses it (patch 1/4)

- source git-sh-setup and other small cosmetic changes in
  convert-grafts-to-replace-refs.sh (patch 4/4)

Christian Couder (4):
  replace: add --graft option
  replace: add test for --graft
  Documentation: replace: add --graft option
  contrib: add convert-grafts-to-replace-refs.sh

 Documentation/git-replace.txt             | 10 +++++
 builtin/replace.c                         | 62 ++++++++++++++++++++++++++++++-
 contrib/convert-grafts-to-replace-refs.sh | 28 ++++++++++++++
 t/t6050-replace.sh                        | 12 ++++++
 4 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100755 contrib/convert-grafts-to-replace-refs.sh

-- 
2.0.0.rc0.40.gd30ccc4
