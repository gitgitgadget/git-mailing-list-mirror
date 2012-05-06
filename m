From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/4] allow recovery from command name typos
Date: Sun,  6 May 2012 14:55:26 +0800
Message-ID: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQvO8-0004bP-Is
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 08:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab2EFGzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 02:55:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39937 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2EFGzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 02:55:42 -0400
Received: by dalf4 with SMTP id f4so2666026dal.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gbsNEqduj+j5aaLImXtdWW5KDSOzNcAGiBgV5Hytyks=;
        b=zGZPZFWwcJqPRtSjHc5/NXPSpj0BNi+NHBmaxpq0XytNE6sHcRjOPmFua+4JkDn2Md
         zRl91jD44B2n2cllkajcYaZ8gjgzZHvQbL2BeEUNPERFlwTdZaSlGX+WZsLy3zxLCkMD
         FqPdqykVe/VU7915hKXke88okjNaC9ial4nBk1JYA0j2HCHZSS4wxhTo56HuP2IIxvPG
         w8ttmpjnq+MXu4KnD0j085wjb5D6loIfSw2b2eK7UWwMTZb15Bt62zJ2Be4v/p1Bi37S
         HZ4ZgfiSK4yRanJb1JR8+zkzLojdZWNpSfRMCqzV44iLgRn4t792hy9XRbQOCLH7K59g
         sZmg==
Received: by 10.68.236.233 with SMTP id ux9mr12324831pbc.143.1336287341580;
        Sat, 05 May 2012 23:55:41 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm32.beta238.maxonline.com.sg. [116.86.238.32])
        by mx.google.com with ESMTPS id wn3sm14086094pbc.74.2012.05.05.23.55.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 23:55:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.611.g8a79d96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197151>

Patch 4 has the meat of this series.

While running valgrind to check that I didn't leak any memory, a couple
of leaks were spotted. Patches 1-3 address them.

Tay Ray Chuan (4):
  help.c::uniq: plug a leak
  help.c::exclude_cmds: plug a leak
  help.c: plug a leak when help.autocorrect is set
  allow recovery from command name typos

 help.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 12 deletions(-)

-- 
1.7.10.1.611.g8a79d96
