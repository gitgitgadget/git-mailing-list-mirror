From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 0/2] Helper function for ExamDiff and Winmerge mergetools
Date: Tue, 22 Mar 2016 17:43:12 -0700
Message-ID: <1458693794-9124-1-git-send-email-jacob.nisnevich@gmail.com>
References: <20160321033201.GA2004@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 23 01:45:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiWvT-0001qQ-GS
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 01:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcCWAp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 20:45:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35530 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcCWAp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 20:45:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id u190so91731pfb.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pC70WyAvW9thQk15vipE4xg6Olbm/dRQLfEfbm2Hcjk=;
        b=u2cfxB2qVc6gVH13Z0XAXgcuuEobUU3hxCH4VLFsP0Eb4AzTnx4tiEEaKfCKVU5W9T
         fiLHozoEb80cu0b0daoe5M+GKRm+c5+0gJ9fZ+CGzjlru3IfL5K8qvSCHRZoyo355YnP
         xnOFkpc59Bo+/uDYkThCRL5+nrEtEFs8gqRq0WINwPSvY4K9ILk+mVi7LxIrMCAQGNZb
         e2uCqmqTAdPlnHVSnC6QmgOi1hUVnZNrZ/WeaVZ9PfhvbWdmDDzsIOsiwnL8nC4znIdv
         ivY0ZVYjXi1oA51JE8OZ6K+IS0J/zrrNGRKOkUFfwIR/Ta1TFZChxfzzAOP2pvLAmQP6
         /HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pC70WyAvW9thQk15vipE4xg6Olbm/dRQLfEfbm2Hcjk=;
        b=ei1ee8hjNhDnUfjs6hushoQYe7YNmh0Hkp/KI8zL+6XlT1Si/DCiBHLza0G7y9ENCI
         B4rFiGpTbYP8J3vzvv7FJoVH9jMkMDRAZlfS9iO48RBQbNjL/xpT0LlY/YAM38KbVyqW
         jToFOO5o8KbnruQpvZCg4yyO/NSjrFWlqcJ59+B/PPa7rD4FBPMOQ4J1RJ8hCwWtvQEo
         rsgsepJGiEv2op54msxFXAWK9awhl1IOZ9iLS3nP8f7mTI/fVo40t72Zwtgxpt1ppXeT
         leog5MQoOZvPaZdRlBL4837Q2zWoJpaqzE9jQMG8ya+yKAejNLqVecNITXpcQnflAZ2p
         krGQ==
X-Gm-Message-State: AD7BkJKyfdGhslcngmC199xUd9U5lvsWzcH6mNSUpPEaIYlU9b8O31451+BX13VFuVn4zQ==
X-Received: by 10.98.69.84 with SMTP id s81mr60358pfa.125.1458693925847;
        Tue, 22 Mar 2016 17:45:25 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id l4sm35924725pfi.73.2016.03.22.17.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 17:45:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20160321033201.GA2004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289591>

I've been trying to implement a helper function for both Winmerge and ExamDiff
as you requested, but for some reason including another shell script with . or
source seems to fail on Windows in this case. I've attached the patches for the
two commits I've made so far. Is there anything I'm doing wrong or is it an
issue with Windows?

Jacob Nisnevich (2):
  mergetools: created new mergetool file for ExamDiff
  created helper function for both winmerge and examdiff mergetools

 ...s-created-new-mergetool-file-for-ExamDiff.patch | 58 ++++++++++++++++++++++
 mergetools/examdiff                                | 20 ++++++++
 mergetools/mergetools_helpers                      | 30 +++++++++++
 mergetools/winmerge                                | 23 ++-------
 4 files changed, 111 insertions(+), 20 deletions(-)
 create mode 100644 0001-mergetools-created-new-mergetool-file-for-ExamDiff.patch
 create mode 100644 mergetools/examdiff
 create mode 100644 mergetools/mergetools_helpers

-- 
1.9.1
