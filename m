From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5 0/4] Stream fd to clean filter; GIT_MMAP_LIMIT, GIT_ALLOC_LIMIT with git_parse_ulong()
Date: Sun, 24 Aug 2014 18:07:42 +0200
Message-ID: <1408896466-23149-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 18:08:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLaLD-0003oS-Uc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 18:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbaHXQIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 12:08:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:49612 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbaHXQIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 12:08:21 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7OG81if016849;
	Sun, 24 Aug 2014 18:08:01 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7OG81sC016835;
	Sun, 24 Aug 2014 18:08:01 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
X-Miltered: at mailer.zib.de with ID 53FA0DE1.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FA0DE1.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FA0DE1.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255800>

Changes since v4: use git_parse_ulong() to parse env vars.

Steffen Prohaska (4):
  convert: Refactor would_convert_to_git() to single arg 'path'
  Change GIT_ALLOC_LIMIT check to use git_parse_ulong()
  Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
  convert: Stream from fd to required clean filter instead of mmap

 convert.c             | 60 +++++++++++++++++++++++++++++++++++++++++++++------
 convert.h             | 10 ++++++---
 sha1_file.c           | 50 +++++++++++++++++++++++++++++++++++++++---
 t/t0021-conversion.sh | 24 ++++++++++++++++-----
 t/t1050-large.sh      |  2 +-
 wrapper.c             | 16 ++++++++------
 6 files changed, 138 insertions(+), 24 deletions(-)

-- 
2.1.0.8.gd3b6067
