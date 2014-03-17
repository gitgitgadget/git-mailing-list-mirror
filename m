From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH v4 0/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 17:52:23 -0400
Message-ID: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 22:52:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfSW-0004Dt-LH
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbaCQVwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:52:32 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:45971 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaCQVwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:52:32 -0400
Received: by mail-qa0-f47.google.com with SMTP id w5so6061128qac.34
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uZ7o9f9ttP/w+IFklg++lrGFtfpOctSIpQxGLZOPbEQ=;
        b=r6JaLV1Yxs5mUPBTOJRMwTtVmjfaEp3ENj7eGrKvZ6qh/5ew2N+bNTsqBIOasmXzS8
         k5D2cz3RCuYp7GAh8u+Rde3qbA2+6AA43IoOjIBKCg0hOPUu3nobjuTTNzilywceDpl9
         ALNWa7UDsvykvXav6O95O6kQUDHX2/jifEUEAOFWJIrmnwrLWXTHB9SWHOvnvJUL1kQK
         xZXC+HhlgllqssCgY8aS0mMXzvJNViTCHgXjrpRvWV0CJzHXcERp0XXt6QxEfQaygQU7
         Os+CbPB+N/EyrbTEiXSAni6MsSRP3FDIMQqQyO/7IcSFu6wu2hAJ0F1D8Y2mqP7pj/06
         SwCg==
X-Received: by 10.229.176.72 with SMTP id bd8mr31462733qcb.12.1395093151448;
        Mon, 17 Mar 2014 14:52:31 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id 21sm18928351qgh.23.2014.03.17.14.52.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 14:52:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244292>

Hi again, all.

I've gone through the patch again to filter for the use of magic numbers so
that I can leave those hunks alone. Junio says, and Michael agrees, that:

> The original hunks show that the code knows and relies on magic numbers 7
> and 8 very clearly and there are rooms for improvement.  The result after
> the conversion, however, still have the same magic numbers, but one less
> of them each.  Doesn't it make it harder to later spot the patterns to
> come up with a better abstraction that does not rely on the magic number?

I cut this one down very sharply; Michael says:

> It would be much better for you to submit only a handful of changes (or
> even only one!) that is perfect, rather than throwing a bunch at the wall
> and asking the reviewer to pick between the good and the bad.

Thanks for the guidance, everyone.

This work is microproject #14 for GSoC.

Quint Guvernator (1):
  general style: replaces memcmp() with starts_with()

 builtin/apply.c        |  6 +++---
 builtin/for-each-ref.c |  2 +-
 builtin/mktag.c        |  4 ++--
 builtin/patch-id.c     | 10 +++++-----
 connect.c              |  4 ++--
 imap-send.c            |  6 +++---
 remote.c               |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

-- 
1.9.0
