From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] fetch: fix '.' fetching
Date: Thu, 16 May 2013 02:31:11 -0500
Message-ID: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 09:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcsgC-0007jE-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab3EPHco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:32:44 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35659 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab3EPHcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:32:43 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so3373987oag.31
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=54OjxikiWCHQ8XTZizG1JHRIe18abMUK4P6pR1w/plM=;
        b=UPTQuRbkt6u/B/Ao/grLDunPD4WvdD9gcGTsKPz3Q5RT6smqQAzPu2+1Ys/oY1LE0c
         /tQ5ltWrNC6nkU2vuBaWZZyKi6EP7IzZsC+I2cTUYdQodGcl3eVvrH+VimWVubP2+F7V
         Zl7AeoJJinffEWog0WtY2AY5R5bE/QxGdOx/97/MXDgUJnr2liCjQQiEuS5jFxLV4iWu
         6nTwRO/Q+R4TwW//mLDOw3JZRBLoCiPP7PdyVeBDoZsGxdh8InJ/Cafw+L5wHq7sAQy6
         oXjQGP/iGPcSjm4RFrr5YgSgmmTkvVlpDoCf+yYv3chmiN1hYbDca31l0Wweg7j5n35y
         GYuw==
X-Received: by 10.182.226.136 with SMTP id rs8mr19770792obc.50.1368689563206;
        Thu, 16 May 2013 00:32:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm6816393obb.5.2013.05.16.00.32.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 00:32:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224485>

Hi,

It's quite annoying that 'git fetch' tries to fetch '.' when the upstream
branch is a local one. This patch series fixes that, and while on it, it also
fixes 'git push'.

Felipe Contreras (3):
  fetch: add --allow-local option
  fetch: switch allow-local off by default
  remote: disable allow-local for pushes

 builtin/fetch.c         |  6 +++++-
 git-pull.sh             |  2 +-
 remote.c                | 17 ++++++++++++++---
 remote.h                |  1 +
 t/t5513-fetch-track.sh  | 14 ++++++++++++++
 t/t5528-push-default.sh |  7 +++++++
 6 files changed, 42 insertions(+), 5 deletions(-)

-- 
1.8.3.rc1.579.g184e698
