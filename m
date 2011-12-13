From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 0/2 v2] run-command: Add eacces diagnostics
Date: Tue, 13 Dec 2011 16:08:35 +0100
Message-ID: <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 16:09:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTyv-0005j2-Td
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab1LMPJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 10:09:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56943 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1LMPJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 10:09:15 -0500
Received: by eekc4 with SMTP id c4so2162976eek.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 07:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uXj7lJsMIsmOuR2BnbB9MEtNnh3gAauTJD9h7Kp1vRg=;
        b=fWFI9tlybvgb7+gdM9rx18YTL3WYuFLi5wvxB+OwF5L1OTpKcPUhEEoChEweODAMtj
         Fm2YQbZiVxPuco34ll8mG487jdHXt2qYumKZq9G1J5D/R8jzx/CLoAcM7EPv/rO2KR3g
         KrwEY85p974ausEKYggwrH8AKRNSNHWeYYGRk=
Received: by 10.14.14.78 with SMTP id c54mr4352984eec.161.1323788952671;
        Tue, 13 Dec 2011 07:09:12 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm90027005eef.9.2011.12.13.07.09.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 07:09:12 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <op.v5e8mgbc0aolir@keputer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187026>

This replaces $gmane/186388

I had a lot of short stints incorporating the review remarks, so I might just
have missed something.

[PATCH 1/2] run-command: Add checks after execvp fails with EACCES
[PATCH 2/2] run-command: Add interpreter permissions check

run-command.c          |  130 ++++++++++++++++++++++++++++++++++++++++++++++++
t/t0061-run-command.sh |   38 ++++++++++++++-
2 files changed, 167 insertions(+), 1 deletions(-)
