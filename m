From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Improve git-bundle builtin
Date: Thu, 15 Dec 2011 22:15:26 +0530
Message-ID: <1323967528-10537-1-git-send-email-artagnon@gmail.com>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 17:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbERC-00017o-83
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 17:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558Ab1LOQph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 11:45:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42502 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1LOQpg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 11:45:36 -0500
Received: by iaeh11 with SMTP id h11so3006690iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 08:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bhcTjaOiuqDCo2AYckC/kXS9QnTVEPKB/n2mE7s7flc=;
        b=Di0ARl0DNxBTZ/3ZcpIby2cApDwqynxJc0FbZ/+0GWJsBqDgsr/2b0IqA2suW5x2g1
         Ybz61R1EVcg+7fWHBfhtv+qyd1008K1uz7HL/hi/qSZ7G6+j4+HaNmcWZ1P7J1vHBn+j
         /HCB/Vh9mRTKmLEP3RXoneeNK6aRfoXPvzhJ8=
Received: by 10.42.29.137 with SMTP id r9mr2878685icc.20.1323967535993;
        Thu, 15 Dec 2011 08:45:35 -0800 (PST)
Received: from localhost.localdomain ([122.174.88.206])
        by mx.google.com with ESMTPS id lu10sm11031370igc.0.2011.12.15.08.45.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 08:45:34 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187210>

Hi,

My OPT_SUBCOMMAND idea crashed and burned; I decided to salvage some
of the work that went into improving the git-bundle builtin and put it
into another series along with some additional tests.  I hope this
benefits people who use git-bundle to do incremental backups on their
servers or otherwise.

A couple of thoughts:

1. There's a SP between the OBJID and the ref name in list-heads as
opposed to the TAB used by other git commands such as ls-remote,
diff-tree.  Will fixing it break someone's parser somewhere?

2. Is it worth fixing the "--stdin" tests?  What is the usecase?  A
quick blame points to f62e0a39 (t5704 (bundle): add tests for bundle
--stdin, 2010-04-19): Jonathan, Joey?

Cheers.

-- Ram

Ramkumar Ramachandra (2):
  t5704 (bundle): rewrite for larger coverage
  bundle: rewrite builtin to use parse-options

 builtin/bundle.c  |   91 +++++++++++++++++++++++++++++---------------------
 t/t5704-bundle.sh |   95 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 122 insertions(+), 64 deletions(-)

-- 
1.7.4.1
