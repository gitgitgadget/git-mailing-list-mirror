From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH/RFC 0/2] Search for parent commit in new branch import
Date: Fri, 19 Aug 2011 01:09:48 +0100
Message-ID: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 02:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCfR-0006tY-Nb
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 02:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab1HSAK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 20:10:26 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49122 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1HSAKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 20:10:25 -0400
Received: by wwe5 with SMTP id 5so4561603wwe.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4JySBVb8DAKryWQbDrV7G079rDwF9iFXT9CqYghXAHE=;
        b=KOYPbh3ui9nTaCz1vq/JEy5smafgIctL1rj9JsH2YVUfD/tjXd72DLIguuzj07r5/Q
         mFU15xV3RMBIb/kkKYkFlUdhZWTGSsHzHLBlLdrDJ4z+kd+/5WcsrxEewoxaVG0SYXKi
         yfESH8rcjGY9ZKo0VDaZ4dp4E8dRbrFo7lGMA=
Received: by 10.227.3.3 with SMTP id 3mr1114449wbl.60.1313712624140;
        Thu, 18 Aug 2011 17:10:24 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2152633wbb.49.2011.08.18.17.10.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 17:10:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179663>

This is mostly a RFC/RFH (Request For Help;) regarding the code I used on this
patch. I think that this is not a clean solution, but it shows the algorithm I
want to implement. The worst points are:

1. Relies on a sleep() to avoid a race condition. I'm using 0.1s, but it still
   fails sometimes, so it needs to be bigger.
2. Requires the --force option of fast-import.

Test case is included.

Thanks in advance to everyone who contributes.

Vitor Antunes (2):
  git-p4: Search for parent commit on branch creation
  git-p4: Add complex test case for branch import

 contrib/fast-import/git-p4 |   22 +++++++++++-
 t/t9800-git-p4.sh          |   77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 2 deletions(-)

-- 
1.7.5.4
