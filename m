From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2 0/3] grep color enhancements
Date: Sun,  7 Mar 2010 11:52:44 -0500
Message-ID: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 17:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoJjG-0005kc-Gc
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 17:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab0CGQxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 11:53:12 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:43192 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab0CGQxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 11:53:10 -0500
Received: by qw-out-2122.google.com with SMTP id 5so896439qwd.37
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 08:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=79aOiIa7CKsCrnpcYCvzozyFapyBVDGgND6kmDDXFKY=;
        b=pwITs/Gw2dkkOZhXslYipYnwd9cDZ10qM0hOwaq9Lvn/FCoVqFuYmYByqs1gewSqhS
         WoXpdXIRcO0tF1tjTXOL3Gff6zz8vDwJoCZ2bf8UGaWRvtrmu8kFns4583T4QHwL56Oa
         XyOeWHxQQP1tyLx2r1r6e0uxBSeLWYKrZUQEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G/s6l+oBy2ellZvb6tcdeu4eobVwpy8xpLQ4u1jZln6D/vhs+JEirpsLIeqJLbWfSB
         jObEzhL+3vZYp7pJF4W/Y6DnVlJM8qITHVmhA+ZHeZy8JdkUabVqTdtqCyZDTvIqCoTV
         TjgeTNW5UyOiQD4HhdAp7lv3PpQhlJ5xTVSvo=
Received: by 10.224.96.86 with SMTP id g22mr1820491qan.267.1267980789062;
        Sun, 07 Mar 2010 08:53:09 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm2767266qyk.4.2010.03.07.08.53.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 08:53:08 -0800 (PST)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141719>

This is a re-spin of the second half of Gmane 141186,  "color
enhancements, particularly for grep", which is currently in pu as
'ml/color-grep'.  The following changes were made, all to the second
patch:

* Fix the parsing of color.grep.  The old code caused a segfault if this
  option was set, and it also disallowed setting this option without
  a value.

* Color the filename in --name-only output.  I still don't like this,
  but I understand that makes the coloring more consistent.  As Junio
  said, if there's no strong argument one way or the other, it's
  probably best to follow GNU's lead.

* Style changes: Remove the cast to int for "rm_eo - rm_so", put else
  on same line as curly brace, and remove an unnecessary variable
  assignment.

* Asciidoc fixes: Use ";;" instead of ":::" for nested lists, and
  un-indent the last sentence for color.grep.<slot>.

Mark Lodato (3):
  Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*
  grep: Colorize filename, line number, and separator
  grep: Colorize selected, context, and function lines

 Documentation/config.txt |   26 ++++++++++++++++--
 builtin-grep.c           |   38 +++++++++++++++++++++-----
 color.h                  |   11 +++++++
 graph.c                  |   12 ++++----
 grep.c                   |   66 ++++++++++++++++++++++++++++++----------------
 grep.h                   |    6 ++++
 6 files changed, 119 insertions(+), 40 deletions(-)
