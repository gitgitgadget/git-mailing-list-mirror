From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/4] submodule trailing slash improvements
Date: Thu, 12 Sep 2013 20:24:57 +0100
Message-ID: <cover.1379013786.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 21:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCWJ-0001Sc-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab3ILTZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:25:35 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42530 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3ILTZe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:25:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 66CE060651B;
	Thu, 12 Sep 2013 20:25:34 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WdPYMLSGy5Dw; Thu, 12 Sep 2013 20:25:33 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 76C2E606516;
	Thu, 12 Sep 2013 20:25:33 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 687CE161E575;
	Thu, 12 Sep 2013 20:25:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzGBy4BGMzWs; Thu, 12 Sep 2013 20:25:31 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4C0B3161E57B;
	Thu, 12 Sep 2013 20:25:20 +0100 (BST)
X-Mailer: git-send-email 1.8.4.277.gfbd6843.dirty
In-Reply-To: <cover.1378840318.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234676>

Changes since v1:

* Improvements to existing pathspec code to use is_dir_sep instead of
  comparing against '/' and handle multiple trailing slashes
* Remove calls to read_cache() made redundant by a new call in
  builtin/reset.c::parse_args()

John Keeping (4):
  pathspec: use is_dir_sep() to check for trailing slashes
  pathspec: strip multiple trailing slashes from submodules
  rm: re-use parse_pathspec's trailing-slash removal
  reset: handle submodule with trailing slash

 builtin/reset.c            |  8 ++++++--
 builtin/rm.c               | 20 ++++----------------
 pathspec.c                 | 30 +++++++++++++++++++-----------
 t/t7400-submodule-basic.sh |  6 ++++--
 4 files changed, 33 insertions(+), 31 deletions(-)

-- 
1.8.4.277.gfbd6843.dirty
