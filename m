From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] format-patch: use cwd as default output directory
Date: Fri, 22 Sep 2006 13:12:01 +0200
Message-ID: <20060922111201.GA10124@moooo.ath.cx>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 13:12:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQixT-0000un-61
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 13:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWIVLMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 07:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWIVLMS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 07:12:18 -0400
Received: from moooo.ath.cx ([85.116.203.178]:30626 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932296AbWIVLMG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 07:12:06 -0400
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27526>

---
Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> git format-patch in subdir generates files in topdir instead of
> current dir as documented in its man page
Here is a patch for this.
---
 builtin-log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index fbc58bb..130b53a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -270,6 +270,8 @@ int cmd_format_patch(int argc, const cha
 
 	rev.extra_headers = extra_headers;
 
+	output_directory = prefix;
+
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
-- 
1.4.2.1.ge767
