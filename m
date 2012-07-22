From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] block-sha1: put expanded macro parameters in parentheses
Date: Sun, 22 Jul 2012 18:40:54 -0500
Message-ID: <20120722234054.GB2012@burratino>
References: <20120722233547.GA1978@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 23 01:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St5lp-0004Af-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 01:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab2GVXlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 19:41:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48972 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2GVXk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 19:40:59 -0400
Received: by obbuo13 with SMTP id uo13so8600440obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7VJxfq1PGRZuk79c2SjULcmXawQWVcLqNUOE2MJV4Mw=;
        b=xZvuu3Ll86CJvPNL15+HooUkBgJz4q8BqrwlqkBllKC++Wvk56DjjjngO7oGBRwfA7
         do9jmF33fJm1yqilKbqb+pIMWGILVCUnhjlSpUpDC00il9qhuPmUnnBFpePkiyGSAVaZ
         8XIUu89WmL6IIvbZvnaBKqYIWEgXiQAPRF0yDUmAQxjgN5Akm/QIbyTZodO2gHlRkRWB
         FVGQ6SDK4N34JfqdIjHZl9LU3J/1WrH3/tewulyx5CRq9ewtekwc1cu5aa9wOQJkASqs
         xLsLW1w54IhGfdhzUPZRe/db9aA4T64+dCFshJniMe2bqVmOdrtrh5mYtE8fzQSWso+5
         DTPQ==
Received: by 10.50.190.234 with SMTP id gt10mr9057128igc.20.1343000459288;
        Sun, 22 Jul 2012 16:40:59 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ua2sm10450998igb.7.2012.07.22.16.40.58
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 16:40:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120722233547.GA1978@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201875>

't' is currently always a numeric constant, but it can't hurt to
prepare for the day that it becomes useful for a caller to pass in a
more complex expression.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Clarified subject line.  No other change.

Thanks for reading.

 block-sha1/sha1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 10fd94d1..6f885c43 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -100,8 +100,8 @@
  * Where do we get the source from? The first 16 iterations get it from
  * the input data, the next mix it from the 512-bit array.
  */
-#define SHA_SRC(t) get_be32((unsigned char *) block + t*4)
-#define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
+#define SHA_SRC(t) get_be32((unsigned char *) block + (t)*4)
+#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1);
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
 	unsigned int TEMP = input(t); setW(t, TEMP); \
-- 
1.7.10.4
