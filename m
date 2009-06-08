From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/3] Miscellanous cleanups around start_command/run_command callers
Date: Mon,  8 Jun 2009 22:34:28 +0200
Message-ID: <cover.1244492658.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlYc-0005e6-1x
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 22:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZFHUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 16:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZFHUex
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 16:34:53 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62619 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbZFHUew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 16:34:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 514BFCDF8D;
	Mon,  8 Jun 2009 22:34:52 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0CA311D0C2;
	Mon,  8 Jun 2009 22:34:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121101>

This is just to flush a queue of unrelated changes before they pile up.
I found these while I reviewed start_command and run_command call sites.

Johannes Sixt (3):
  Simplify some instances of run_command() by using
    run_command_v_opt().
  diff.c: plug a memory leak in an error path
  Simplify some 'fprintf(stderr); return -1;' by using 'return error()'

 builtin-help.c         |   16 ++++++----------
 builtin-receive-pack.c |   10 +++-------
 diff.c                 |    1 +
 ll-merge.c             |   11 ++---------
 merge-index.c          |   42 +++++++++++++-----------------------------
 5 files changed, 25 insertions(+), 55 deletions(-)
