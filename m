From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/6] archive: refactor and cleanup
Date: Mon, 14 Jul 2008 21:21:50 +0200
Message-ID: <487BA74E.5070208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITqE-0000zW-Rs
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbYGNTfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 15:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbYGNTfN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:35:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:45935 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbYGNTfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:35:09 -0400
Received: from [10.0.1.200] (p57B7FF09.dip.t-dialin.net [87.183.255.9])
	by india601.server4you.de (Postfix) with ESMTPSA id A01E82F8070;
	Mon, 14 Jul 2008 21:24:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88454>

This series is a collection of cleanups for git archive that I finally =
need
to get out, reviewed and (hopefully!) integrated.  It should make addin=
g
more format backends easier.

Patch 2 adds a context parameter to read_tree_recursive(), thus affecti=
ng
all its callers.  The rest of the patches change *archive*.[ch], only.

Ren=E9



 archive-tar.c             |  115 ++++++++++++-------------------------=
--
 archive-zip.c             |  102 +++++------------------------------
 archive.c                 |  132 ++++++++++++++++++++++++++++++++-----=
-------
 archive.h                 |   15 ++----
 builtin-archive.c         |   75 ++++++++++++--------------
 builtin-checkout.c        |    4 +-
 builtin-log.c             |    4 +-
 builtin-ls-tree.c         |    4 +-
 builtin-merge-recursive.c |    4 +-
 builtin-upload-archive.c  |   11 ++--
 tree.c                    |   12 ++--
 tree.h                    |    4 +-
 12 files changed, 208 insertions(+), 274 deletions(-)
