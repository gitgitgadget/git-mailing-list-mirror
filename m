From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/7] Generalized sequencer foundations
Date: Sun, 14 Aug 2011 14:03:02 +0530
Message-ID: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWB4-0000BZ-3f
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab1HNIgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:36:07 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63576 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab1HNIgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:36:05 -0400
Received: by pzk37 with SMTP id 37so1545680pzk.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+WVNsKwYGd2h21hpKJ2H5qcEoSluFdIN1Yr/scnqhU4=;
        b=UsLWbF5v4EDz6ijkqu2fhdZndmGAUGUUxVjz7HFooocREIQTUZsXhsOJUBZDmwjJAm
         9LX9lNkSkRiVV13QXJLkTPfvlEpx3oPePOSF2M9wTI+9/fbYx31EBtZQeB7d2UX/+mYo
         Y+VNzQDBcyY5JN4QjQiMes8OJhG2XfpAtAxec=
Received: by 10.142.179.6 with SMTP id b6mr1105951wff.188.1313310964772;
        Sun, 14 Aug 2011 01:36:04 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 14sm2642752wfl.5.2011.08.14.01.35.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:36:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179304>

Hi,

This is the second iternation prepared mainly in response to
Jonathan's reviews.  It's ready for inclusion (or very nearly so) now.
I'll start working on more features as soon as I'm confident that this
series doesn't need to be rewritten.

Thanks.

-- Ram

Ramkumar Ramachandra (7):
  revert: Free memory after get_message call
  revert: Fix buffer overflow in insn sheet parser
  revert: Make commit descriptions in insn sheet optional
  revert: Allow mixed pick and revert instructions
  revert: Make the argument parser responsible for setup_revisions
  sequencer: Expose API to cherry-picking machinery
  sequencer: Remove sequencer state after final commit

 builtin/commit.c                   |    8 +
 builtin/revert.c                   |  858 +-----------------------------------
 sequencer.c                        |  806 +++++++++++++++++++++++++++++++++-
 sequencer.h                        |   36 ++
 t/t3032-merge-recursive-options.sh |    2 +
 t/t3510-cherry-pick-sequence.sh    |   87 ++++-
 6 files changed, 956 insertions(+), 841 deletions(-)

-- 
1.7.6.351.gb35ac.dirty
