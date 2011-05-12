From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v5] git-p4: warn if git authorship won't be retained
Date: Thu, 12 May 2011 06:05:55 +0100
Message-ID: <1305176756-27046-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKO6N-0006oU-Gq
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 07:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1ELFGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 01:06:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50533 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab1ELFGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 01:06:11 -0400
Received: by wya21 with SMTP id 21so878044wya.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 22:06:09 -0700 (PDT)
Received: by 10.216.143.74 with SMTP id k52mr1252816wej.8.1305176769804;
        Wed, 11 May 2011 22:06:09 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id d54sm408283wej.10.2011.05.11.22.06.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 22:06:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173439>

Updated version of git-p4 authorship warning suggested by Junio,
incorporating fixes for problems in v2 pointed out by Peter Wyckoff.

Compared to v4, adds better cd'ing for the authorship warning test
as suggested by Junio. There's a second patch to come that fixes all the
cd'ing in the git-p4 test script. Without this, if a test bails out,
subsequent tests will be in the wrong directory.

I didn't put the "-q" into the grep commands as it makes python
explode; instead they now redirect to /dev/null. I guess this is a
bug that needs to be investigated at some point...

Luke Diamand (1):
  git-p4: warn if git authorship won't be retained

 contrib/fast-import/git-p4     |   33 ++++++++++++++++++++++++++-
 contrib/fast-import/git-p4.txt |    7 ++++++
 t/t9800-git-p4.sh              |   47 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 2 deletions(-)
