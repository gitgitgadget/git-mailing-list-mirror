From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/2] The move to sequencer.c
Date: Wed, 11 Jan 2012 12:40:37 -0600
Message-ID: <20120111184036.GC3005@burratino>
References: <20120111164758.GD1891@burratino>
 <1326305757-27525-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 19:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl31Z-00013V-P0
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 19:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933111Ab2AKSfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 13:35:44 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37375 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab2AKSfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 13:35:44 -0500
Received: by ghbg21 with SMTP id g21so483111ghb.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 10:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m4REck/jlDfXwH5IcqlGWNsoIK4xsvolWflYzayuJz4=;
        b=wJuUbTQmfJ4YwJZ8bUZO3WCW6eBHfA+Dfqs9i5glqiEyZtyc4AA9rn6SgkR6db1Y3E
         wM308AhFQnCMEDz3rVv/fVfy+i5Rba65AjT2o9L2lsB0th0uaMvY8ZnMWyq0bM7gTyqp
         BCwAKBDqL6PtMQoFQTjR3Us0Slsq5Zl5Wnlpc=
Received: by 10.236.146.4 with SMTP id q4mr33142795yhj.105.1326306943704;
        Wed, 11 Jan 2012 10:35:43 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c28sm6027804ana.16.2012.01.11.10.35.41
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 10:35:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326305757-27525-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188382>

Ramkumar Ramachandra wrote:

> Ramkumar Ramachandra (2):
>   revert: prepare to move replay_action to header
>   sequencer: factor code out of revert builtin

Ah.  "git diff HEAD^:builtin/revert.c HEAD:sequencer.c" gives a sane
diff, and the remaining stuff in builtin/revert.c feels pleasant.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Here's a patchlet for squashing into patch 2/2.
---
 builtin/revert.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4116f2d3..e6840f23 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -30,8 +30,6 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-#define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
-
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
-- 
