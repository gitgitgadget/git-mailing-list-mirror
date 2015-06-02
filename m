From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] gitk: Alter the ordering for the "Tags and heads" view
Date: Tue,  2 Jun 2015 07:11:09 -0400
Message-ID: <1433243470-93392-1-git-send-email-rappazzo@gmail.com>
Cc: paulus@samba.org, Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 13:11:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzk6O-00079l-F6
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbbFBLLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 07:11:19 -0400
Received: from mail-vn0-f47.google.com ([209.85.216.47]:42122 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbbFBLLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:11:18 -0400
Received: by vnbg129 with SMTP id g129so19853647vnb.9
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nR4OXZv09lwyJf6Y4jWP/KzRW3egw7zQatovODDIOIM=;
        b=vFDLK1urbV8tshy2Xt42z/ZwzK7glomJgeMTthzct6eejUPlDpFvN3+lYKCRC/TZr4
         bt64dMSQJSwl/An2Jfdvnf2uB1uwRVhS/GAM5Uq7L32XmSZhSZMpXJ/ev9N+ljeb0kTu
         BZ0fPEgpJ+iQuLrM5CsoNTnfuE2TzfZw67vZdZC7Bv+52ibVQk8wycxqVn3jrig02FTV
         a+YxcX1HhLIBPdGYhrrSmbDPysTw5jOvA9aNvMtBm1yQhN4P/LCsg301h3TsyQzFOFRC
         EiaLDO88/16Y6rHCFhzeMCN43owzZCChowqlB2S2OR8hW4HDhFUEV4oPPj8bVRQt1nBJ
         R50w==
X-Received: by 10.52.114.163 with SMTP id jh3mr36089056vdb.93.1433243477472;
        Tue, 02 Jun 2015 04:11:17 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id hq1sm26403056vdb.24.2015.06.02.04.11.15
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 04:11:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270521>

In a codebase with a large number of remote branches, the "Tags and heads"
view can split the local refs around the name "remotes".  I wanted to make 
this view more useful as a quick view of the refs that are important to me
at the moment (I would say the branches that I am actively looking at).

Therefore, I have made this change to the ordering of the view.  It should
show up in the following order:

    local refs
    remote refs which are tracked (upstream) by local refs
    remote refs
    tags
    other refs

Each of these lists is independently sorted before being put into the main
ref list.  Also note that the upstream refs are _not_ duplicated in the 
remote refs list.

Michael Rappazzo (1):
  gitk: Alter the ordering for the "Tags and heads" view

 gitk-git/gitk | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

-- 
2.4.2
