From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 0/4] http cleanups
Date: Tue,  3 May 2011 23:47:25 +0800
Message-ID: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 17:48:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHHpQ-0003ZP-5R
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 17:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab1ECPrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 11:47:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61216 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1ECPrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 11:47:47 -0400
Received: by pwi15 with SMTP id 15so105338pwi.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=1biLgd3Ef+4iJMQB5rJuqATgKp1iN3uvYACEIQR7hYA=;
        b=n7uFj81GnwIf0nGDfG6vyyUsPHoE51AdeVawlYUwKmH1Tc06+XePCfIxrIhLRxKxZz
         7BUewk7lsXg+E9TOsNQ5HxNNINOe83TUZmNq2p1qKKITn4r9hBUIFtuahV585HzAo5XA
         gEhTRGUvGvTgRxPabSnCPCdd5ZI6A/D8j7YVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mohQUyM6rD68r3BFm7B5xyF3dL8m8w6HJJ426oumKZlBZ34g4/JUOriq+Fpmcfbap0
         0P+IJt/VmHapdqA40s4SmeaOEhh1RfgZ/E08QHMNEFxhtyZW8s1Nt2Q3lSAvMn+3W9h0
         tu62T/1xeuBlhxTRrco88m7cTHRGh+Z+TLOJM=
Received: by 10.68.15.134 with SMTP id x6mr10455625pbc.308.1304437666427;
        Tue, 03 May 2011 08:47:46 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id p7sm117856pbp.1.2011.05.03.08.47.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 08:47:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172667>

This is a re-roll of dm/http-cleanup. I've also included a test for
chunked http pushes that has been sitting on my side for some time.

Note to Junio: these patches should apply safely on
sp/maint-clear-postfields. Actually, the first patch depends on it.

[1/4] t5541-http-push: add test for chunked
[2/4] http: make curl callbacks match contracts from curl header
[3/4] http-push: use const for strings in signatures
[4/4] http-push: refactor curl_easy_setup madness

 http-push.c          |  152 +++++++++++++++++---------------------------------
 http-walker.c        |    4 +-
 http.c               |   12 ++--
 http.h               |    6 +-
 remote-curl.c        |    2 +-
 t/t5541-http-push.sh |   28 +++++++++-
 6 files changed, 90 insertions(+), 114 deletions(-)

-- 
1.7.3.3.585.g74f6e
