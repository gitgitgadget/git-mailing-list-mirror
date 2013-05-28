From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] cherry-pick: improvments
Date: Tue, 28 May 2013 07:59:04 -0500
Message-ID: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJWI-0005UP-SD
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933955Ab3E1NAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:00:50 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33992 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933906Ab3E1NAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:00:49 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so981303obb.39
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lUVVy+gdfqEqCui3y/rGZyDmBbCDqvRexkGiCa/vJTY=;
        b=WWdOVZH59VatnaqLw23ThHHbtHDAdsplSnnoOAcpAhCbX78kJ1cq65wUDMz+heesAZ
         LsthfoUk089bKocWYlcc7b2FKNX4EPAg3aHFPADACxelHWAia70W81ieWrYN3KzRfezk
         KNiS4/L0fGboDzdWj+XdZrWbvMA8mR4vqCTChRkzdEdqp+Oje/xv8kqx1Azz6PzcD8BN
         Q28/x4nXX2aEZPD9UPMDNd8adA2SMu8tXY4L83dRtUT9zv+Eml5Yzgp1shGnyfe3afek
         4hn3UOadN8ruM+C+FeIyAGhEmmobWcUTHgKMJN/IhxSbkve2zQmkplXwJBCbY3Zq5whP
         eMuQ==
X-Received: by 10.182.80.65 with SMTP id p1mr3607736obx.42.1369746049254;
        Tue, 28 May 2013 06:00:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm34552844obl.1.2013.05.28.06.00.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:00:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225640>

Hi,

Here's a bunch of changes to make cherry-pick (and revert) more useful.

Felipe Contreras (3):
  cherry-pick: add support to copy notes
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option

 Documentation/git-cherry-pick.txt |   7 +-
 Documentation/git-revert.txt      |   7 +-
 Documentation/sequencer.txt       |   3 +
 builtin/revert.c                  |   9 +++
 sequencer.c                       | 162 +++++++++++++++++++++++++++++++++++++-
 sequencer.h                       |   6 +-
 t/t3500-cherry.sh                 |  32 ++++++++
 t/t3510-cherry-pick-sequence.sh   |  12 +++
 8 files changed, 232 insertions(+), 6 deletions(-)

-- 
1.8.3.rc3.312.g47657de
