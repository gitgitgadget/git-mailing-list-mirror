From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 00/10] Sequencer Foundations
Date: Wed, 25 May 2011 14:16:55 +0000
Message-ID: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEtf-0003Gk-QM
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab1EYORK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:10 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794Ab1EYORJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:09 -0400
Received: by qyk7 with SMTP id 7so2121342qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=ZbiIXaN2YkF/tC70NrKqey6Nv0QNnDqkypQC2gwkFa0=;
        b=jfC0WZ+rhsA0cL8PH7+tEvWxUXCAHiTx430gTahWE5mmDrjZg4Npl5TPyX7+0VARZd
         7Pw2qlBQlfa54W9B61POihTIwOQz+XZz9L8m2/NMg3tedAE7prUBWLtOsmY5cGhxQfK4
         +okunYoQOuKzYJ8JY8nDy3dISJu3dn21QCWtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OZH/+CYYScFDCoVPpmFzNbGkXJKRJedAZtVYxVwepMdeU7ogWtbqRAe4vohY4H8W5/
         e7wj4VFcFCpeZdeIUvYRVrGhJ13B8mwMyLits/b8ZBs5KkttGWmbFFnQlfGNl1k0lXzQ
         OY0Wel7Xq+UwyYo6WTfT65Is2i3U9LFA3Jt9Y=
Received: by 10.224.216.68 with SMTP id hh4mr3751390qab.193.1306333028667;
        Wed, 25 May 2011 07:17:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174393>

Hi,

Error handling is a very complex topic, and trying to build it up with
the Sequencer series had disasterous consequences, as seen in the
previous iteration of the series.  In this iteration, I've nearly
re-written everything from scratch, and tried to get the basics right,
without introducing anything new.  Time is short, and I'll have to
work very hard if I want to target "master",

I hope there are no major issues with this iteration.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (10):
  advice: Introduce error_resolve_conflict
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Rename no_replay to record_origin
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Catch incompatible command-line options early
  revert: Introduce HEAD, TODO files to persist state, plan
  revert: Implement parsing --continue, --abort and --skip
  revert: Implement --abort processing

 advice.c         |   17 ++-
 advice.h         |    1 +
 builtin/revert.c |  484 +++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 361 insertions(+), 141 deletions(-)

-- 
1.7.5.GIT
