From: Daniel Bingham <daniel@dbingham.com>
Subject: [PATCH] git-p4: Fetch the proper revision of utf16 files
Date: Fri,  3 Apr 2015 14:13:46 -0700
Message-ID: <1428095627-8772-1-git-send-email-git@dbingham.com>
Cc: luke@diamond.org, pw@padd.com, Daniel Bingham <git@dbingham.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 23:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye8vf-0000AJ-3o
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbbDCVO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:14:58 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:35118 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbDCVO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:14:58 -0400
Received: by qcbii10 with SMTP id ii10so73793703qcb.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 14:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XIy1dn/rzYiz5nFTT29+ucaitUOgPbOwpCy7g8S7LjM=;
        b=UC0eoRxzpwLpIdnERteQLT0JNzsAwxvOXtWiwtKxIb89+Ua/eMkPzJTHbPMM8YyT+x
         t6JJ7WdqwH6k+UblpETjzDZM2HXdt+yfyUL1sQtXP0N6/vyEAS/oWwm6BX+3OdRk1oth
         gSOrjVn18Pu64+bkAcc7hdnAaapzakTfXp4hlJs6moNJjq+6QLzLnB1gavb879SCrWdi
         SvUA/jJcjkN2Pqu/UobMuWSEnbQGDKHj0orY5kPPx6eGFXbOfYsCcATG+S1F6Rp0GNcp
         2AJOlVGh7S8nYTeFS3MgP2AHKp7i0tkgvLGHSEaRk2gTXHJKEkZvuKx/nmwltpyQpGvr
         uIfQ==
X-Gm-Message-State: ALoCoQkZ9Ei/LYBuf0fvtfSkwOuLyWhL4qbjU2zzue8Kw7vKzvcjgb6adzng41n0vzRI+wH/79eD
X-Received: by 10.229.122.70 with SMTP id k6mr4987497qcr.27.1428095697229;
        Fri, 03 Apr 2015 14:14:57 -0700 (PDT)
Received: from dbingham-rmbp.ca.com (c-73-181-209-250.hsd1.wa.comcast.net. [73.181.209.250])
        by mx.google.com with ESMTPSA id z93sm6438038qgd.45.2015.04.03.14.14.55
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2015 14:14:56 -0700 (PDT)
X-Google-Original-From: Daniel Bingham <git@dbingham.com>
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266727>

I discovered what appears to be a bug with the handling of utf16 type files 
when cloning from P4.  It appears that it always fetches the content of the 
latest version rather than getting the revision specified in the changelist 
being processed.  This patch is an attempt to resolve that by formatting
the print command using the revision number as is done in streamP4Files().

Daniel Bingham (1):
  git-p4: Fetch the proper revision of utf16 files

 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.3.5
