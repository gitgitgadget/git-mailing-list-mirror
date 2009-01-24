From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] Makefile: Use libc strlcpy on OSX
Date: Sat, 24 Jan 2009 16:41:30 +0100
Message-ID: <7f978c810901240741k201f954dx1c0470186094ae24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 16:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQkfk-0003qa-JF
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 16:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZAXPld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 10:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZAXPlc
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 10:41:32 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:10810 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbZAXPlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 10:41:32 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3309360muf.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=irXIco3zbWDVsuKF0YTECGHSwzku0Noem1LnbQquJ20=;
        b=rbINy1ANDMLhkPSJlbDoUZuw7+7GAIi3nMuY9o6/GwzJyW6DMva5a2Av4DpH/aD5dI
         bfMMVpxEqZtTvpsMspi5X00KSBU7pn+9T1FlCEab2iZrwJb0q9jt1IIBMA5gVMf539EA
         OFHlGwucgb+HswUMYkWNAM9qfMvcS9w3+QrS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bfFj2TrIEXZe/r3gqwRNXMP4B13C8fPhlrN7KL2mtkK18MFdFRgHn2cd0zsqw+8m3h
         jDWS/XHtmDW54R+q++qCIsZsFSr5x6L1y7m80yrJLkUaWWwxDbBdJp+qHrymZNzD0OfE
         03kwDJmWI+afvobfiwv68beS+mlN6bawiQLBA=
Received: by 10.103.182.3 with SMTP id j3mr1454741mup.107.1232811690287; Sat, 
	24 Jan 2009 07:41:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106971>

OSX supports strlcpy(3) since 10.2 so we don't need
to use our own.

Signed-off-by: Benjamin Kramer <benny.kra@gmail.com>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b4d9cb4..4c9aab5 100644
--- a/Makefile
+++ b/Makefile
@@ -643,7 +643,6 @@ ifeq ($(uname_S),Darwin)
 	ifneq ($(shell expr "$(uname_R)" : '9\.'),2)
 		OLD_ICONV = UnfortunatelyYes
 	endif
-	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
-- 
1.6.1.285.g3454
