From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v4] git-p4: warn if git authorship won't be retained
Date: Wed, 11 May 2011 01:26:00 +0100
Message-ID: <1305073561-24910-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 02:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJxFm-000681-18
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 02:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab1EKA0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 20:26:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41995 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1EKA0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 20:26:07 -0400
Received: by wya21 with SMTP id 21so2959wya.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 17:26:06 -0700 (PDT)
Received: by 10.216.229.3 with SMTP id g3mr4590571weq.91.1305073566104;
        Tue, 10 May 2011 17:26:06 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id z9sm4707863wbx.34.2011.05.10.17.26.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2011 17:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173386>

Updated version of git-p4 authorship warning suggested by Junio,
incorporating fixes for problems in v2 pointed out by Peter Wyckoff.

In the previous version of this patch I forgot to add an && in the
test harness.

Pete suggested doing "grep -q" however it turns out that this
doesn't work - git-p4 explodes when it tries to do stdout.flush() at
line 1588 in importChanges(). I can only imagine that grep -q does
something very subtle to stdin.

Luke Diamand (1):
  git-p4: warn if git authorship won't be retained

 contrib/fast-import/git-p4     |   33 +++++++++++++++++++++++++++-
 contrib/fast-import/git-p4.txt |    7 ++++++
 t/t9800-git-p4.sh              |   46 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)
