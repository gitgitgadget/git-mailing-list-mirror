From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/10] Re-roll rr/revert-cherry-pick v3
Date: Wed, 14 Dec 2011 22:24:27 +0530
Message-ID: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras6W-0004LV-Ds
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab1LNQyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:54:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1LNQyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:54:46 -0500
Received: by vbbfc26 with SMTP id fc26so774122vbb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2UWkepyMP7RGA50VQcwXggdzVgmgU6mtLX+J+MGB1XM=;
        b=gHobYAMpRENpaGfnqFUDYiIxG6UjAJnR7nXLY1Xhoije5cHstdcE5zONVoB9n13Z9O
         zgOqEnmRE09MqZEPHyFg3V2vQZtqsb19JRG5dnC2o6oAlc+NBcPi5qu4T27BiXm05BqY
         SkPF4zVxjTfpiHb2bDUOXR7V1SwSPAHrfATsg=
Received: by 10.52.28.211 with SMTP id d19mr5386099vdh.48.1323881685996;
        Wed, 14 Dec 2011 08:54:45 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.54.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:54:45 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187144>

Hi,

There are 10 parts in this iteration.  The main changes are:

- "t3502, t3510: clarify cherry-pick -m failure" and "revert: move
replay_action, replay_subcommand to header" are new.  They've been
made separate parts for clarity.

- Since jn/maint-sequencer-fixes contains "revert: pass around
rev-list args in already-parsed form", I've dropped it from this
series.  Except for the tests, I've checked that it doesn't conflict
with the topic.

- Rebased on new `master`.

- Other changes are fairly minor, and mainly arise as responses to
  Jonathan's reviews.

Thanks.

-- Ram

Ramkumar Ramachandra (10):
  revert: free msg in format_todo()
  revert: make commit subjects in insn sheet optional
  revert: tolerate extra spaces, tabs in insn sheet
  revert: simplify getting commit subject in format_todo()
  t3510 (cherry-pick-sequencer): use exit status
  t3502, t3510: clarify cherry-pick -m failure
  t3510 (cherry-pick-sequencer): remove malformed sheet 2
  revert: move replay_action, replay_subcommand to header
  revert: allow mixed pick and revert instructions
  revert: report fine-grained error messages from insn parser

 builtin/revert.c                |  194 ++++++++++++++++++++-------------------
 sequencer.h                     |   18 ++++
 t/t3502-cherry-pick-merge.sh    |    2 +-
 t/t3510-cherry-pick-sequence.sh |  142 +++++++++++++++++++++++------
 4 files changed, 231 insertions(+), 125 deletions(-)

-- 
1.7.4.1
