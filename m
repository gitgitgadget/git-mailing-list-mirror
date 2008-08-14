From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 0/3] count-objects size and strbuf human-readable
Date: Thu, 14 Aug 2008 18:18:25 -0400
Message-ID: <1218752308-3173-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlAN-00017M-Mv
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYHNWSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbYHNWSd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:18:33 -0400
Received: from boohaunt.net ([209.40.206.144]:40227 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbYHNWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:18:29 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 85D4F1878CC7; Thu, 14 Aug 2008 18:18:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92418>

This patch series does three things.  First, it allows count-objects
to report pack size along side loose object size in verbose output.

Second, it adds a function to strbuf to assist in formatting values
using metric orders of magnitude in both SI and binary units, thus
providing a more human-readable display format.

Third, it allows count-objects to utilize that faculty through an
additional command line argument which shows sizes in verbose
output as human readable values.

Marcus Griep (3):
  count-objects: Add total pack size to verbose output
  strbuf: Add method to convert byte-size to human readable form
  count-objects: add human-readable size option

 .gitignore                          |    1 +
 Documentation/git-count-objects.txt |   13 ++++--
 Makefile                            |    2 +-
 builtin-count-objects.c             |   31 +++++++++++-
 strbuf.c                            |   88 +++++++++++++++++++++++++++++++++++
 strbuf.h                            |    9 ++++
 t/t0031-human-readable.sh           |    9 ++++
 test-human-read.c                   |   64 +++++++++++++++++++++++++
 8 files changed, 209 insertions(+), 8 deletions(-)
 create mode 100755 t/t0031-human-readable.sh
 create mode 100644 test-human-read.c
