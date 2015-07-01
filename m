From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 5/7] pack-protocol.txt: Be more precise about pusher-key relationship
Date: Wed,  1 Jul 2015 11:08:17 -0700
Message-ID: <1435774099-21260-6-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMRc-0004oz-LF
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbbGASJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:06 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33594 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbbGASIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:52 -0400
Received: by igcur8 with SMTP id ur8so98380487igc.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOlLhOzG6UjEniLPXvmse9yL1tmDZ+4JSRcRdnXYnx4=;
        b=NjkIqr9ZIpEj+1nLs+wnHf35rTKjpAp+P5+ctWZUX9xdydreViK3wDmBLZkwTY3LYR
         GwZpDWm0Gkj8EgJmoYwVLAX+hoLLoiPFUbwsFAE0zLvRfZclGA/jLAMTVTvufKCi5SB8
         n6KciUPDJEqKu21KiS1yo6yiGvUbAfv8ZDAEdf8qayGRBpc7WF/q2N6NHnlp2a77eeLE
         MaAAJHSrS4AhQVGRmuitsZsyGSrTLqPUqLKCEtAUG6PAYdQVNivneMpVOH3Htbmy5NYO
         hsKqlEfdpzb2/dynSLT4/aMjocWcCDX8L0fOEqawMSbHrZv2irfrbay0z3Yu8Lo/bdvo
         akQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oOlLhOzG6UjEniLPXvmse9yL1tmDZ+4JSRcRdnXYnx4=;
        b=R0tafkIjw7Fxz99zmcwVEoFpXJWnQTE5FpOHrgZ0IrWVSvT9PuE6gvRQp0rZUFTH4y
         ZxdPddf2q6zmKXI9CBFpfOFueKGNTbnrZnkPuUIfkpl4jYFoO7vgyz9n3EnmTQ0mpGHz
         W/qQSkYVwoXBlqyw+15RzKsnOz4/nIJD5nTbgUo+/Q2gW7ndJjnCf7YKD6jRnB1W14Dz
         fZFvReQ2vqaq695o9/bg5o5dncUXVY0EttVo3jldUZKRfnXLg4KFsCe1UEbfkxv6NIMz
         O1QDX0wukqC4KmIVNc/SggeNxA27NZTqkeBXbfR7y6bqMObUzjL0ewsfK9yXGovkCU54
         oWSA==
X-Gm-Message-State: ALoCoQmgwMTvqwEizWrs2ghOn98ZP7DmfjioI5CZbw6lWbK8NU9WuQj1tshusp+S0eN7CxALfs/O
X-Received: by 10.43.58.143 with SMTP id wk15mr5997009icb.81.1435774131383;
        Wed, 01 Jul 2015 11:08:51 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273168>

The use of "must" (albeit not in all caps) suggests that this is
actually a requirement of the protocol. As no implementation exists
that actually does this verification, this is misleading at best.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/technical/pack-protocol.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index de3c72c..f37dcf1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -564,7 +564,8 @@ Currently, the following header fields are defined:
 The GPG signature lines are a detached signature for the contents
 recorded in the push certificate before the signature block begins.
 The detached signature is used to certify that the commands were
-given by the pusher, who must be the signer.
+given by the pusher, which verifier code SHOULD enforce is a valid User
+ID associated with the signer.
 
 Report Status
 -------------
-- 
2.4.3.573.g4eafbef
