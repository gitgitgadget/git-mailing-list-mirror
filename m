From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1] git-p4: test harness directory handling tidyup
Date: Thu, 12 May 2011 06:14:58 +0100
Message-ID: <1305177299-27130-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKOFQ-00023H-Km
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 07:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab1ELFPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 01:15:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33098 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab1ELFPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 01:15:35 -0400
Received: by wwa36 with SMTP id 36so1346387wwa.1
        for <git@vger.kernel.org>; Wed, 11 May 2011 22:15:33 -0700 (PDT)
Received: by 10.227.201.148 with SMTP id fa20mr1911704wbb.39.1305177304180;
        Wed, 11 May 2011 22:15:04 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id bd8sm505740wbb.14.2011.05.11.22.15.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 22:15:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173442>

Junio pointed out that the git-p4 test harness (t9800-git-p4.sh) has
tests that 'cd' into a directory, do stuff, and then cd back out. If
the tests fail partway through then the process is left in the wrong
directory for the next test.

This patch changes it to use the "(cd dir && do_test)" pattern instead.

Luke Diamand (1):
  git-p4: test harness directory changing tidyup

 t/t9800-git-p4.sh |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)
