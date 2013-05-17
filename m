From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/3] Colored prompt for ZSH
Date: Fri, 17 May 2013 14:25:45 +0530
Message-ID: <1368780948-28917-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 10:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGQb-0000PU-7Y
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 10:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3EQIyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 04:54:11 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52994 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab3EQIyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 04:54:09 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so1848904pbb.36
        for <git@vger.kernel.org>; Fri, 17 May 2013 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8ycD6Zh4fQSYkApEAcRcu0fe7jzeNRm+EyNly/ph0Ig=;
        b=pIQKqJXF4aQCmUFGQw1GYgnJNz0K3ewecRCJnPCR8jUsdmKUqcV1khg3A/w1ggkwfP
         +2FTms+zFPDaEug4wNED09HwyMlPleX8qHrieitqcRNNwfyZFxR5QT5G4IJSp/n2O07a
         ZIUSoMKPOdfKX98JDeiCIA3/3eSnQ0OVEnHG5y90DbcgYerdcRiNczistwExKPd2Qm6G
         SQ1gYOEQOkWMGUKWooJgdPiTh3vgbmceMaII7RymXPWUFwnLfphiu7hQziySlA/jWztC
         LriFOkkVFaRdENUl3EKmbcGGiYyfY4a5cwUhcOP/5DdkigZ8p/fq2mYVhfEh74oWJIaa
         hOEA==
X-Received: by 10.66.232.165 with SMTP id tp5mr48116460pac.135.1368780849283;
        Fri, 17 May 2013 01:54:09 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id do4sm10438933pbc.8.2013.05.17.01.54.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 01:54:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2.432.g070c57d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224659>

One minor change, in accordance with Junio's review.  In part 1, I
use:

local z="${GIT_PS1_STATESEPARATOR-" "}"

Instead of the convoluted:

local z=" "
if [ -n "${GIT_PS1_STATESEPARATOR+set}" ]; then
	z="${GIT_PS1_STATESEPARATOR}"
fi

Everything else is the same.  I've rebased it on top of the latest
`master`.

Ramkumar Ramachandra (3):
  prompt: introduce GIT_PS1_STATESEPARATOR
  prompt: factor out gitstring coloring logic
  prompt: colorize ZSH prompt

 contrib/completion/git-prompt.sh | 124 +++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 39 deletions(-)

-- 
1.8.1.2.432.g070c57d
