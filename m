From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 0/5] color enhancements, particularly for grep
Date: Fri, 26 Feb 2010 23:57:45 -0500
Message-ID: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlEhS-0007hl-CG
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967848Ab0B0EyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 23:54:14 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51848 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967830Ab0B0EyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 23:54:13 -0500
Received: by qyk9 with SMTP id 9so475291qyk.5
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 20:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OCnjCA2nS7O965EwInjlkfuYiqjmyC/DJD0JyFnOQqo=;
        b=H+y0uCrVCHqCBSFCX4DLSWilBGk3UO+0sgNxlgRQ2XdeW/XNPyboRRuL5Q9NzfAtS+
         o1QSYbXAt3rb5ogCfbou0Qa9wFTQl2Gfa2zsXinuY967dXlfZtgQcTf/+EQZBwAJlKr/
         cx6D7vYKukYvtiqrZFhIhCuOOB/GHcG606sUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HJAi3b9WB4z37/O29l28KHqfKld2B+IWQnZSoO7h/YYL1MKLrM1eFl2er6uKV/m9OR
         9LMo/muxmUTcSIm7PdXIGX5DZZkqGMdZ4e2ZnEbeySmspsazf7kUdNDyODQCi+BeT7yc
         RkukG5QTKcBZ7mS7zD2b5y6qhJILkMuEGr9vE=
Received: by 10.229.250.73 with SMTP id mn9mr661254qcb.52.1267246452045;
        Fri, 26 Feb 2010 20:54:12 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm622133qyk.12.2010.02.26.20.54.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 20:54:11 -0800 (PST)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141186>

The main purpose of this patch series is to add color to git grep a la
GNU grep.  The only change to the default is to colorize the separator
between filename, line number, and match (':', '-', or '=') and between
hunks ('--').  This improves readability immensely without being
distracting.  However, the filename, line number, function line (-p),
and non-matching text can also be colored, if desired.

The first three patches are each independent of any other patch, but
they seem like a good idea.

Mark Lodato (5):
  Allow explicit ANSI codes for colors
  Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*
  Remove reference to GREP_COLORS from documentation
  grep: Colorize filename, line number, and separator
  grep: Colorize selected, context, and function lines

 Documentation/config.txt |   32 +++++++++++++++++++---
 builtin-grep.c           |   42 +++++++++++++++++++++-------
 color.c                  |   16 +++++++++++
 color.h                  |   11 +++++++
 graph.c                  |   12 ++++----
 grep.c                   |   66 ++++++++++++++++++++++++++++++---------------
 grep.h                   |    6 ++++
 t/t4026-color.sh         |   18 ++++++++++++
 8 files changed, 159 insertions(+), 44 deletions(-)
