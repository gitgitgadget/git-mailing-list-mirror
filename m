From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/2] push: honor advice.* configuration
Date: Sun,  2 Dec 2012 21:27:49 -0600
Message-ID: <1354505271-25657-1-git-send-email-chris@rorvick.com>
References: <7vmwxwka6f.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 04:29:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfMig-0003Ri-O8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 04:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab2LCD3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 22:29:04 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:37158 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab2LCD3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 22:29:03 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1849795iay.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 19:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LZ6oFDUrW9cMRBkJSZ++C6ErdnCv4jD0SxVuZTVBbdU=;
        b=XwuXLDansVvsb4euO1M8f2GSBM29rEBahDAdCt7/ot7HwiKJmFjVphKiPdFTIYjYt3
         6kIn05g/5e74+khALSk/o50bLKQlTkPa5qnJbKIoSYTfnmEIr+1u/147Fju8uXxDeGxA
         81TTwNclxJhqv93gH0bztggS5EMbzKN52PmFg+yquK0TBV2nTb0uV31HULE6mTIwXSkb
         /Pxy2PZ+dVIfpe25U2++GVNBGInSeekRPfAhGe4HCXTWx3s9FIYbt1VhK7dbQDnODg6y
         wN62/tJNM7z/m11aOZ6xie6N9l5vJiEnkwqvprVUe6Oa08M4rzg9Li+A+MDNArWzYBNG
         WKUg==
Received: by 10.50.85.170 with SMTP id i10mr5154159igz.14.1354505342216;
        Sun, 02 Dec 2012 19:29:02 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id fa6sm6610808igb.2.2012.12.02.19.28.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 19:29:01 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.541.g73be2da
In-Reply-To: <7vmwxwka6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211023>

Added a new config option to turn off the already-exists advice.  We
also want to observe the 'pushNonFastForward' setting, but the name of
this config is too narrow after this addition.  Renamed to have broader
scope while retaining the old name as an alias for backward-
compatibility.

Chris Rorvick (2):
  push: rename config variable for more general use
  push: allow already-exists advice to be disabled

 Documentation/config.txt | 10 +++++++---
 advice.c                 |  9 +++++++--
 advice.h                 |  3 ++-
 builtin/push.c           |  8 +++++---
 4 files changed, 21 insertions(+), 9 deletions(-)

-- 
1.8.0.1.541.g73be2da
