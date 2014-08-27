From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Document LF appearing in shallow command during send-pack/receive-pack
Date: Wed, 27 Aug 2014 13:46:56 -0700
Message-ID: <1409172416-10750-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:47:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMk7T-0003eb-6p
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 22:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbaH0Uq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 16:46:59 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59060 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964892AbaH0Uq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 16:46:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so1283083pab.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pra5TSnkv/h7VD/vd5GO7KDLHRYuUko6IqKfWhVaSBE=;
        b=UZxSCPKWUktTGzcD3PZ53Ylh5VKintkrFhtMLCZ3zlQmTQyuib/WaXYdUoakoYVz63
         ScS/Lxn0bPDhWaekPqsXVyABwixi8fyqUXgMNJWFuf4h3bhaFqwZHRqX53vhQbcWahcm
         /nbNVPD0N4LR/zUZ1x0KIncDsQPJeMPDsQF9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pra5TSnkv/h7VD/vd5GO7KDLHRYuUko6IqKfWhVaSBE=;
        b=Efo38C088xRSua5FG8Xgpnl5qPRykfEPfyZiCCi/FFyeWZFqVYNeAja/TOgkWZc2nC
         HZrk/lo9wYOsGx4HQlCnv7BH1u6NALHgnrfcg3H2y1GyaMOH1eE/w1kARf8Ou6HY53gZ
         xMjn8pY62QJHtlmPR1nJgpzE3kLA1XfjSC69NjF7qZN3dKLzI9UxYGzfYFHPwVHWcSIx
         RY/+KKlt883DQXtmPUn/ygtOj5fjvUK4ml9GxypQ/U4RriG8VnvbPX4K1nMA0HMMKvAX
         G2Eka3O02xBEEvuQDxi7trzYVTrscahhy9Bf9iaLgVNmWzWkce/Uw2NIufNGeGuyFmxP
         emGg==
X-Gm-Message-State: ALoCoQmAXkiHwpJe5yP+bdz71Melywv08lw7HjRU4OJHCG28jwT84dVvst2nW8tUUUALTij30YPY
X-Received: by 10.68.175.161 with SMTP id cb1mr48778327pbc.91.1409172418144;
        Wed, 27 Aug 2014 13:46:58 -0700 (PDT)
Received: from sop-linux.mtv.corp.google.com (sop-linux.mtv.corp.google.com [172.27.69.14])
        by mx.google.com with ESMTPSA id hc11sm1295098pbd.70.2014.08.27.13.46.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 13:46:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256040>

The implementation sends an LF, but the protocol documentation was
missing this detail.

Signed-off-by: Shawn Pearce <spearce@spearce.org>
---
 Documentation/technical/pack-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 18dea8d..569c48a 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -467,7 +467,7 @@ references.
 ----
   update-request    =  *shallow command-list [pack-file]
 
-  shallow           =  PKT-LINE("shallow" SP obj-id)
+  shallow           =  PKT-LINE("shallow" SP obj-id LF)
 
   command-list      =  PKT-LINE(command NUL capability-list LF)
 		       *PKT-LINE(command LF)
-- 
2.1.0.rc2.206.gedb03e5
