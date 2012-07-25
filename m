From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 0/5] difftool: Use symlinks in dir-diff mode
Date: Tue, 24 Jul 2012 19:59:28 -0700
Message-ID: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Strp3-0001za-He
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab2GYC7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:59:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37671 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab2GYC7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:59:31 -0400
Received: by pbbrp8 with SMTP id rp8so634306pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/xqZxEs54bKLDzc6FLlVa6bBwL/QdP+UUsbkpPFCtVI=;
        b=d4Vi4YLFLnNkmDJRiMd89k4d+mbuThBlX9zrOkZc7ZTCAM4DVfmjxvvBEXu3TTOSnI
         WkUFkH+IW3FZptGsNcBCezRTQ9FYelBg+wr9mk5XkvHu7i/aqh3tpDVFCPp9253QrYT+
         njNefd1fmX/vlOKozjHWPDbUPkqnohjjceGFzrYR0ATHkBsCtakqCW3VolkETjQTzUTh
         WdgERG1vWgpFox3QkqNp/d4xHpLt1yL8v8mYEqdHsn9YtQ4f7oj9XcpSvnV/KKBhARif
         AbHcjz2eya+0QkBovwGVPpf2PWtKpjtgKv0GuDaJ14Ls7qnPXraOx8MRWafXoliwTb/2
         H+9A==
Received: by 10.68.190.102 with SMTP id gp6mr49805189pbc.5.1343185171279;
        Tue, 24 Jul 2012 19:59:31 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kh1sm13382996pbc.23.2012.07.24.19.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 19:59:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202094>

Teach difftool to use symlinks when diffing against the worktree.

David Aguilar (5):
  difftool: print_tool_help() globals
  difftool: Eliminate global variables
  difftool: Move option values into a hash
  difftool: Call the temp directory "git-difftool"
  difftool: Use symlinks when diffing against the worktree

 Documentation/git-difftool.txt |   8 ++
 git-difftool.perl              | 180 ++++++++++++++++++++++++++---------------
 2 files changed, 124 insertions(+), 64 deletions(-)

-- 
1.7.12.rc0.15.g8157c39
