From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 0/2] imap-send: fixes for CRAM-MD5 authentication
Date: Fri, 8 Apr 2016 23:02:18 +0900
Message-ID: <20160408140218.GA13469@chikuwa.rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 16:02:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoWzb-0005og-Nn
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 16:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556AbcDHOCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 10:02:23 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:35276 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755378AbcDHOCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 10:02:22 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 504D161B42;
	Fri,  8 Apr 2016 14:02:19 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291033>

[1/2]
Check for LOGINDISABLED capability only when using LOGIN command, as it
is unrelated to authentication with CRAM-MD5.

[2/2]
Remove extra + 1, which is probably mistakenly added. Without this patch
I can't open my IMAP server (Dovecot 2.2).

Thanks,

Kazuki Yamaguchi (2):
  imap-send: check for NOLOGIN capability only when using LOGIN command
  imap-send: fix CRAM-MD5 response calculation

 imap-send.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.8.1.104.g07d5700.dirty
