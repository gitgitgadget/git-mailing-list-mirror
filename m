From: Ivan Ukhov <ivan.ukhov@gmail.com>
Subject: [PATCH v2] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 20:33:21 +0200
Message-ID: <1C828CFA-F4EA-44D6-98F7-3F5F32D74621@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2093\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 29 20:37:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcI4x-0000rI-BN
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 20:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbbC2Sd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 14:33:26 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34107 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbbC2Sd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 14:33:26 -0400
Received: by lboc7 with SMTP id c7so36663343lbo.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=XmygHIGbk4DnBrzLaPxnwyoVB+66+5IS5YHibty7nzA=;
        b=k2bXx5V4/gN1W42tTT0uPZFXaFq+iqroBoMthKqX5ReOmB0opuKNLs9HPzb5Tra9IB
         aWS89AdgBsQps0kXrgdKYE6rF67RP4tNeSbL/MO8BEkaucwRySDIm9ykCHQ9hi5WGUer
         69CO8EvkCF1N70ohbTviN4pZtCmKRXoITyIZDAnKX6q6p5oVTLXhVAJDxIGbzaOQzN5a
         VVXBd1S7L5AaBBFECuM09EHZ2EW/RndlFJfdYDZlbHiAdCk1l43zVbbjTONHNa9Y/dSo
         laFPlAp63osKk+pz07X+iYG+E2Vv6o4SRqNWvTuSl+JbCUcREjpulIWgSigESsP/0n9s
         8zmg==
X-Received: by 10.152.36.133 with SMTP id q5mr19338515laj.35.1427654004165;
        Sun, 29 Mar 2015 11:33:24 -0700 (PDT)
Received: from c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se (c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se. [85.228.198.21])
        by mx.google.com with ESMTPSA id le10sm1606682lac.7.2015.03.29.11.33.23
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Mar 2015 11:33:23 -0700 (PDT)
X-Mailer: Apple Mail (2.2093)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266445>

OPTION_BIT and OPTION_SET_INT do not store pointers in defval.

Signed-off-by: Ivan Ukhov <ivan.ukhov@gmail.com>
---
 parse-options.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 7940bc7..c71e9da 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -95,8 +95,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
- *   OPTION_{BIT,SET_INT} store the {mask,integer,pointer} to put in
- *   the value when met.
+ *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
  *   CALLBACKS can use it like they want.
  */
 struct option {
--
2.3.4
