From: Jerzy Kozera <jerzy.kozera@gmail.com>
Subject: [PATCH] git-p4: Fix 'p4 opened' in git-p4 for names with spaces
Date: Tue, 14 Dec 2010 20:56:04 +0000
Message-ID: <1292360165-26771-1-git-send-email-jerzy.kozera@gmail.com>
Cc: Jerzy Kozera <jerzy.kozera@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 21:56:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSbuy-0006f7-JS
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 21:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760007Ab0LNU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 15:56:11 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44480 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759636Ab0LNU4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 15:56:09 -0500
Received: by wyb28 with SMTP id 28so870437wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GZWqDRbfGs282WJUPT55Qgf78goPfEzLyYnhVX+gDPw=;
        b=w8ZmodbO590AC8J1MTsogBgwWQZaQFIhknd+XPgePGLdiq0P6oZtbfaKH5rFy1lE3k
         FRemSG5YHXR5U9wHJWe07huu6dB2TZ04sXzfDqJtdvAgSVciJhX587w69LhReN8qpTq8
         dUtG6mmgrEUimGSIV0ra65seTAzfgxWnadCi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CjaE+FgwSZmBDeiPTlwhLZ6FKiWy8Yfw5lFUBHFhnuv7JCmFh23ppDaXrh9XBOBcKo
         +Un48DXdEPXtLZnZl139c5+7nkq8ULT0b+nxmLPmS57lbFiDcn/XDE3xBskSk0iMgh1J
         K8iwZFbBSmjvSt4pEp7NaidRb0eTd41Y9zatM=
Received: by 10.216.171.68 with SMTP id q46mr5159781wel.98.1292360168505;
        Tue, 14 Dec 2010 12:56:08 -0800 (PST)
Received: from localhost.localdomain (188-223-231-164.zone14.bethere.co.uk [188.223.231.164])
        by mx.google.com with ESMTPS id b30sm376246wen.1.2010.12.14.12.56.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 12:56:07 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163689>

There is problem with git-p4 when trying to submit changes to file containing spaces in name - submit fails with "Command failed: p4 opened [name with spaces here]"

It's caused by not quoting name for p4 opened, and the patch attached fixes it.

Jerzy Kozera (1):
  Fix 'p4 opened' in git-p4 for names with spaces

 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
