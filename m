From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/3] builtin-branch: use strbuf
Date: Mon, 17 Nov 2008 21:48:34 +0100
Message-ID: <cover.1226954771.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2B1e-00021v-BO
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 21:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYKQUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 15:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYKQUrf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 15:47:35 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52933 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbYKQUrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 15:47:33 -0500
Received: from vmobile.example.net (dsl5401C78D.pool.t-online.hu [84.1.199.141])
	by yugo.frugalware.org (Postfix) with ESMTPA id A7F77446CCF;
	Mon, 17 Nov 2008 21:47:31 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id F2FF019D92D; Mon, 17 Nov 2008 21:48:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101242>

These 3 patches do what's in the subject: use the strbuf API instead of
snprintf() / sprintf().

The current risk of writing unallocated memory is low, I think, but
still, the return value of these functions were not checked at several
places.

Miklos Vajna (3):
  builtin-branch: use strbuf in delete_branches()
  builtin-branch: use strbuf in fill_tracking_info()
  builtin-branch: use strbuf in rename_branch()

 builtin-branch.c |   65 +++++++++++++++++++++++++++--------------------------
 1 files changed, 33 insertions(+), 32 deletions(-)
