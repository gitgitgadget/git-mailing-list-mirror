From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/3] completion: refactor and zsh wrapper
Date: Sun, 14 Oct 2012 17:52:48 +0200
Message-ID: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 17:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQV1-0003dS-Da
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 17:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab2JNPw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 11:52:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54125 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2JNPw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 11:52:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1165990wib.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fU/QgJ6bWSxRXHSmjlu1eHj0nxkr3kP5FmCT2n1unL4=;
        b=0qPzYbDCwjWfjfComJRYo6DwIecXU0nDJeCL2BXcTENXOlXunSr5VrUxjtdtM+yrNu
         Nxo4uZrdUUThOGkmOh1LYoRLErcOl4anp80JIMo1mxR0MLfF4br7LDBWFQZonM5vlluC
         e1ehHG76RnFJzu+JUx3WJy6T2o7rZvJiH7r6D5BxfdzEn6Bqf8Wkj/KQRp2SGggvaOfr
         1uM0P2NOyOQvim1O5nyXGcnsUMqrPkUXyMSxDa6awFF5/QZd6jY4Tf6DuzLzdZTGUiSI
         3jcgaEKVgoz8bK0NMHa1qSUgcOBrtL0bn2+aPD0hHiabUs9e8lTlSug7yOPKBxbuYBhD
         Q09w==
Received: by 10.180.99.133 with SMTP id eq5mr17929540wib.21.1350229974755;
        Sun, 14 Oct 2012 08:52:54 -0700 (PDT)
Received: from localhost (ip-109-43-0-56.web.vodafone.de. [109.43.0.56])
        by mx.google.com with ESMTPS id m14sm9239704wie.8.2012.10.14.08.52.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 08:52:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207668>

Hi,

Here's a bit of reorganition. I'm introducing a new __gitcompadd helper that is
useful to wrapp all changes to COMPREPLY. 2nd and 3rd patches show how it's
useful.

The zsh wrapper is now very very simple, but I haven't received much feedback
yet. I hope it will get in at some point in time.

Felipe Contreras (3):
  completion: add new __gitcompadd helper
  tests: use __gitcompadd to simplify completion tests
  completion: add new zsh completion

 contrib/completion/git-completion.bash | 65 ++++++++++++++++++----------------
 contrib/completion/git-completion.zsh  | 48 +++++++++++++++++++++++++
 t/t9902-completion.sh                  | 29 +++++----------
 3 files changed, 91 insertions(+), 51 deletions(-)
 create mode 100644 contrib/completion/git-completion.zsh

-- 
1.7.12.1
