From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/9] send-email: add sendmail aliases line continuation support
Date: Sun, 31 May 2015 18:29:22 -0400
Message-ID: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkU-0005cM-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522AbbEaWaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:21 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38682 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbEaWaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:19 -0400
Received: by igbjd9 with SMTP id jd9so48926046igb.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=gyM+vXLjFTuE7WOk0Axr7U8cjIyr5Eb0Li6n0udCC18=;
        b=nCHRBzW+da8NAXArFC72gjPIDSPEAF1RtDJ5tC7ia2DrvTDAmm2pXnyt0nUuGl9eB7
         3u5GKElV8z1k4eOyFkWC1eK0jNjhbW/rXPK5oFe8gCTVyI159Zk+JfI5TcbbMFSVLVnu
         WV49TQdh4Wj2QZG5wqTg6r12NxkIm/oovq/PA2rXz5qSKF+B/T9yEwbQneh2bSxdIEGN
         uwMXEPEYVFLT+JGuKmFU5yK/ZvMxocMMREt6ElCMpu8YmCTRvO6pAk1K/slvVZM7tdnd
         RRQCwAO75n8QsADZBMnqTpMa76B5FUFxPuop5nYnzwctQZtG8geBxAWImZl3KU15gK1g
         9p4w==
X-Received: by 10.50.79.166 with SMTP id k6mr9727777igx.25.1433111418976;
        Sun, 31 May 2015 15:30:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.17
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270356>

This series adds line continuation support for sendmail aliases.
It extends basic sendmail aliases functionality implemented by
ah/send-email-sendmail-alias (currently d1205b07 in 'pu')

Eric Sunshine (9):
  send-email: further document missing sendmail aliases functionality
  send-email: visually distinguish sendmail aliases parser warnings
  send-email: drop noise comments which merely repeat what code says
  send-email: fix style: cuddle 'elsif' and 'else' with closing brace
  send-email: refactor sendmail aliases parser
  send-email: simplify sendmail aliases comment and blank line
    recognizer
  send-email: implement sendmail aliases line continuation support
  t9001: refactor sendmail aliases test infrastructure
  t9001: add sendmail aliases line continuation tests

 Documentation/git-send-email.txt |  5 ++-
 git-send-email.perl              | 54 ++++++++++++++-------------
 t/t9001-send-email.sh            | 81 +++++++++++++++++++++++++++++++---------
 3 files changed, 94 insertions(+), 46 deletions(-)

-- 
2.4.2.538.g5f4350e
