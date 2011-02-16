From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v3 0/2] mergetool: don't skip modify/remove conflicts
Date: Wed, 16 Feb 2011 05:47:43 -0500
Message-ID: <1297853265-18993-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <7vbp2dnjkt.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppevq-0001ch-IG
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809Ab1BPKsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:48:22 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55332 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab1BPKsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:48:21 -0500
Received: by qyk12 with SMTP id 12so1266466qyk.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ZotXj4pNIgd23Tu+lKSxnkH1pCRCGko2AWSHt0UQpIs=;
        b=h0EdiO7o3krc+8q9vNHfXXpJ2pe0r6fV3vXuZ1lEnBiftjnPnAwD2ukbaNfxXIP/lk
         uoJw4DT164D0OjW7dVyF1DZUxkPPo5btgzs2k/v0y1JpleygyITHxtnEm7RvYKS87IRj
         V1zG4P2tkcBEpGloGZoHJxTvPLfOTUpmXd4d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bD8UP579OyqW0bVpuUwc+HVY/aNKn6FHJbLKlTV0Jq82U8IitFqWSY5sDkqmuLJ1E9
         oXT/CmHj/duPjuvTBUTSfoWsRSGbcHgKCB/WJeJyBA4IlV/qAu8vccnNCecDgZZTvQmN
         iiMuSOem/tPDhmbeUnN5hxwAWs1BlRng1NK9E=
Received: by 10.224.67.72 with SMTP id q8mr510005qai.222.1297853300377;
        Wed, 16 Feb 2011 02:48:20 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id c8sm1339vcc.33.2011.02.16.02.48.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:48:18 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <7vbp2dnjkt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166954>

Third round. Reorganized the patches a bit as suggested by Junio. The
first patch now contains all the changes to rerere and the second one
only makes mergetool call 'rerere remaining'.

The only tiny change to the end result is the removal of a blank line.

The series applies on top of master.


Junio C Hamano (1):
  rerere "remaining"

Martin von Zweigbergk (1):
  mergetool: don't skip modify/remove conflicts

 builtin/rerere.c     |   17 +++++++++--
 git-mergetool.sh     |    2 +-
 rerere.c             |   79 +++++++++++++++++++++++++++++++++++++++++++------
 rerere.h             |    8 +++++
 t/t7610-mergetool.sh |   40 +++++++++++++++++++++----
 5 files changed, 126 insertions(+), 20 deletions(-)

-- 
1.7.4.rc2.33.g8a14f
