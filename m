From: Edmundo Carmona <eantoranz@gmail.com>
Subject: [PATCH 0/2] checkout: added two options to control progress output
Date: Sat, 24 Oct 2015 08:59:28 -0600
Message-ID: <1445698768-22614-1-git-send-email-eantoranz@gmail.com>
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 16:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq0IK-0006BF-JX
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbbJXO7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 10:59:40 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34840 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbJXO7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 10:59:39 -0400
Received: by ykaz22 with SMTP id z22so147730765yka.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BXPMUoXb1C98CfDr9zCJI6eNii5/OVfLKkVe9EDwR04=;
        b=SwrOLJGExmo7ZjEgsXCmJSI+3DGJDS1swKts0XWcbculkUgm+0ocP6rwc2YvpU2UA5
         ewqr2SCbdiu7NpejiiEyPc7fygMc+zb8bpz8QmI2KGP04s7kN6xsJMJqYCkYMzJ0mqlL
         DJOZ0UQCPsJarFOpGLQYl7pFw9hT6XAVw3pRTNurxal5LAxoJMmLaK7qNfp43CK+s52F
         dY6tgVbVMn/L387uu2tfsTzXbnPFriwA1Aebx6wi52AU9SXWJAEvwNAOcH1TlNkkJU6K
         LecCrGkZN82kaaWicqEUl+5jUHiYG4DvbgHf17qAMSU8/GMUoTLPJu7nbpfR29HBdbK+
         MuZg==
X-Received: by 10.129.49.144 with SMTP id x138mr11927523ywx.171.1445698779217;
        Sat, 24 Oct 2015 07:59:39 -0700 (PDT)
Received: from linuxerio.cabletica.com (ip14-190-15-186.ct.co.cr. [186.15.190.14])
        by smtp.gmail.com with ESMTPSA id y185sm16074780ywc.44.2015.10.24.07.59.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 07:59:38 -0700 (PDT)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280123>

From: Edmundo Carmona Antoranz <eantoranz@gmail.com>

checkout will refuse to print progress information if it's not connected
to a TTY. These patches will add two options:

--progress-no-tty: enable printing progress info even if not using a TTY
--progress-lf: print progress information using LFs instead of CRs

If none of these options is used, default behavior would be used to avoid
breaking current use cases

Edmundo Carmona Antoranz (2):
  checkout: progress on non-tty. progress with lf
  checkout: adjust documentation to the two new options

 Documentation/git-checkout.txt | 10 ++++++++++
 builtin/checkout.c             | 12 ++++++++++--
 progress.c                     |  8 +++++++-
 progress.h                     |  1 +
 unpack-trees.c                 |  3 +++
 unpack-trees.h                 |  2 ++
 6 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.6.1
