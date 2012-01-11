From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/2] The move to sequencer.c
Date: Wed, 11 Jan 2012 23:45:55 +0530
Message-ID: <1326305757-27525-1-git-send-email-artagnon@gmail.com>
References: <20120111164758.GD1891@burratino>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 19:17:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl2jt-0000u9-KP
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 19:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835Ab2AKSRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 13:17:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57610 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933665Ab2AKSRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 13:17:22 -0500
Received: by iabz25 with SMTP id z25so1432844iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AMu/atL9fN0LHL4e0rOlmFKYxOAIqv/I2WFQ2hFSl+Q=;
        b=cI+rLqtvd91yTM7hGK7GGqsMFaM1Xlnss5xCNE3DQBiHxuxJg3L9D6NcUtbck5IyLk
         svH32H9NNnTFs+g2UpkWWSJtfs0NbsNnKgeyWHUkz5KSkwpshsibptaiqC28xbXyn5c9
         07Tp+jhHp1n/20JP1853RspaqkAL265+EYtQw=
Received: by 10.50.214.102 with SMTP id nz6mr43384igc.8.1326305842245;
        Wed, 11 Jan 2012 10:17:22 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id i2sm10109238igq.6.2012.01.11.10.17.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 10:17:21 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <20120111164758.GD1891@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188379>

Hi,

I figured I'd just post a minimal series performing the move:

1. I can write up scratch code and toy with various ideas I have on
   the generalization.  It'll help with my thought process.

2. I can stop thinking about how to begin every commit message with a
   note about anticipating this move.  This'll be a big relief!

Thanks.

Ramkumar Ramachandra (2):
  revert: prepare to move replay_action to header
  sequencer: factor code out of revert builtin

 builtin/revert.c |  952 +-----------------------------------------------------
 sequencer.c      |  918 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h      |   37 +++
 3 files changed, 961 insertions(+), 946 deletions(-)

-- 
1.7.8.2
