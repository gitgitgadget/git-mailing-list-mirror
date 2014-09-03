From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 0/3] Teach revert/cherry-pick the --no-verify option
Date: Wed,  3 Sep 2014 16:03:51 +0200
Message-ID: <1409753034-9459-1-git-send-email-johan@herland.net>
Cc: =?UTF-8?q?Lars=20Gullik=20Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 16:14:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPBKW-0006DA-FU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 16:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbaICOOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 10:14:31 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:49331 "EHLO
	alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbaICOOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 10:14:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AikFAJwfB1StJV2T/2dsb2JhbABZgw1TV8hKh1CBDBZ3hQOKE71oARePTR2ENgWGFY9LnBuDYzsvgk8BAQE
X-IronPort-AV: E=Sophos;i="5.04,457,1406592000"; 
   d="scan'208";a="74567085"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-7.cisco.com with ESMTP; 03 Sep 2014 14:04:03 +0000
Received: from jherland.rd.tandberg.com ([10.47.39.59])
	by rcdn-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id s83E41HA005685;
	Wed, 3 Sep 2014 14:04:01 GMT
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256394>

A colleague of mine noticed that cherry-pick does not accept the
--no-verify option to skip running the pre-commit/commit-msg hooks.

Here's a first attempt at adding --no-verify to the revert/cherry-pick.

Have fun! :)

...Johan

Johan Herland (3):
  t7503/4: Add failing testcases for revert/cherry-pick --no-verify
  revert/cherry-pick: Add --no-verify option, and pass it on to commit
  revert/cherry-pick --no-verify: Update documentation

 Documentation/git-cherry-pick.txt |  4 ++++
 Documentation/git-revert.txt      |  4 ++++
 Documentation/githooks.txt        | 20 ++++++++++----------
 builtin/revert.c                  |  1 +
 sequencer.c                       |  7 +++++++
 sequencer.h                       |  1 +
 t/t7503-pre-commit-hook.sh        | 24 ++++++++++++++++++++++++
 t/t7504-commit-msg-hook.sh        | 24 ++++++++++++++++++++++++
 8 files changed, 75 insertions(+), 10 deletions(-)

-- 
2.0.0.rc4.501.gdaf83ca
