From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] read-cache: fix indentation in read_index_from
Date: Mon, 31 Aug 2015 11:43:29 -0700
Message-ID: <1441046609-24181-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 31 20:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWU3V-0004mb-DL
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbbHaSnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:43:42 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33975 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbHaSnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:43:41 -0400
Received: by pabzx8 with SMTP id zx8so147655451pab.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AurPdmqm6yDPLEc+FzlsOhAwo8HsdkgwXQd9dFwChsw=;
        b=dhF69JztFtkDhDBX//rOLJSD/wONA+y0ioZ0oetbdYy3RzyYJm1CzbdNL9ntt/Abk9
         iCLKtVz0MmgobEocceMmWISz5mFyRCyDxFXjeZ6mo8qg80LrXI0JiRCrFq/E/kLn/zcz
         HQzHPoJPGfblunbHw0m8TEIpSFs1uPrrgxSh+h9ShxoQmJWcze6EPlVw5J2ho43/eGs9
         zUsp8CkoK3Xdc2Cin1UFDfUUdq0WeD0v/J1/dlkxhKCkkfQCxfF+3akA9KpCFfjAY99b
         PH9H+u6UpznxAmxMK4nGpd/qfjT2MDVyXse61BcbMXoPZJjg80l4BkLcPcuVF/BtgTm9
         JgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AurPdmqm6yDPLEc+FzlsOhAwo8HsdkgwXQd9dFwChsw=;
        b=WtbvZA34Gf9B6kb5e+l8EJi6erPV71UAZKXIyEnrrNzKRmAXaEJQZ49HCmq2ZLCXnn
         hkm7hqpcKGHE1++Z9ORfHISG4q4b/rI9MjsZdJHERl4S4lXf6qX2TFgcTOsKwdOCr2RW
         H8zY7hd1uqY8PicDkAfi7mtIj7EliWUV6S/PaD81F0ud6JA3/E865N0J10e5B4bdUZU3
         Fpgmwne3WSrZeysa/WaKUpMZEHJMVGuEfuiQ2EROxFu79l/mXRViNvHIS6nU+g+OEBmR
         rESaPDEMizt9fBHNI95XIa4T+pPXJtUKVn85VmwW28AeoxQN7ZRgP2oNQ2ePSRDOf0eQ
         3zsw==
X-Gm-Message-State: ALoCoQnD3U8utJA1VVKotSywWDTahGNHkOaqAOlOmzAczPYgOxUw6AoVK2Vq/XL+uAYM1FYXAC7o
X-Received: by 10.68.219.194 with SMTP id pq2mr39678462pbc.20.1441046620854;
        Mon, 31 Aug 2015 11:43:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:25db:53e9:3895:b743])
        by smtp.gmail.com with ESMTPSA id ha11sm387882pbd.65.2015.08.31.11.43.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 11:43:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.geed6e44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276906>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 89dbc08..a3df665 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1653,7 +1653,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		die("broken index, expect %s in %s, got %s",
 		    sha1_to_hex(split_index->base_sha1),
 		    git_path("sharedindex.%s",
-				     sha1_to_hex(split_index->base_sha1)),
+			     sha1_to_hex(split_index->base_sha1)),
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	check_ce_order(istate);
-- 
2.5.0.264.geed6e44.dirty
