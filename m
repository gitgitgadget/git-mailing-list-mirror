From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Sequencer fixups mini-series
Date: Sat,  8 Oct 2011 23:06:41 +0530
Message-ID: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCapp-0004l3-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1JHRg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:36:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab1JHRg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 13:36:58 -0400
Received: by gyg10 with SMTP id 10so4416168gyg.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aIj9CTpYmIkyMkXn7pYL/G8MtavKhlEmKbCsAXaQY34=;
        b=dia8pmL8O3Divnt1rfhN8zi3ahuHkes6LqfPetY3oH22uwFP9XwdlzXt8ssRa6sqmo
         J2c5ldu0T+NQWh3TnN6+31qA1axmdBTulApLtn8wuylDAb4KIObnpRA0/LhNpsPQ0qnp
         n5dkdUAoK0klmwr1lObjozT7rLLZdozVHHyIM=
Received: by 10.68.29.199 with SMTP id m7mr23116335pbh.112.1318095417038;
        Sat, 08 Oct 2011 10:36:57 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.157])
        by mx.google.com with ESMTPS id h5sm45151528pbq.11.2011.10.08.10.36.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 10:36:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183157>

Hi,

Now that the original sequencer series has hit 'master' (cd4093b6), we
can now build on it!  Unfortunately, as outlined in $gmane/179613,
there are several UI design difficulties that we need to surmount.  As
a prelude, I've decided to prepare this mini-series for fixing up a
few minor issues before attacking the problem; please see
$gmane/179304 for relevant discussions.

The differences are:
1. I've dropped the last two parts in the previous iteration.
2. Part 2 is new.  Thanks to Jonathan for the suggestion.
3. Minor fixups and commit message improvements in response to
reviews.

p.s- I'm travelling this week, and won't be able to respond to
reviews until the 16th.

Thanks.

-- Ram

Jonathan Nieder (1):
  revert: Simplify passing command-line arguments around

Ramkumar Ramachandra (5):
  revert: Free memory after get_message call
  revert: Simplify getting commit subject
  revert: Fix buffer overflow in insn sheet parser
  revert: Make commit descriptions in insn sheet optional
  revert: Allow mixed pick and revert instructions

 builtin/revert.c                |  209 ++++++++++++++++++++-------------------
 sequencer.h                     |    8 ++
 t/t3510-cherry-pick-sequence.sh |   86 ++++++++++++++++
 3 files changed, 200 insertions(+), 103 deletions(-)

-- 
1.7.4.1
