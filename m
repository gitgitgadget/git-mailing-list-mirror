From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid problem with xpg4 grep in Solaris that broke t9400
Date: Thu, 19 Apr 2012 13:06:53 -0700
Message-ID: <xmqqlilrv63m.fsf@junio.mtv.corp.google.com>
References: <1334002409-5708-1-git-send-email-bwalton@artsci.utoronto.ca>
	<1334445524-sup-1455@pinkfloyd.chass.utoronto.ca>
	<xmqqfwbzslt2.fsf@junio.mtv.corp.google.com>
	<1334857109-sup-7979@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Apr 19 22:07:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKxdB-0007NR-QW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 22:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab2DSUG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 16:06:58 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:40839 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327Ab2DSUG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 16:06:56 -0400
Received: by wgbdt11 with SMTP id dt11so479194wgb.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 13:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Khlui/O/8/cu6nRgQMoFDVb1hLsZ7KAL5TYSPBKF1hY=;
        b=gdI5mFLQN+95a/ptfIgnL127DE56dBK3au+lyDWS5hMUi/R8tx3U1p3iQI2off52CY
         1tMP0vx12xbc2iHezOr8n5FX9popVopQsfy4GKxIRIbe95qtDLbTyHS+ivG8Ckcux5I+
         K76pUGhJ5z7mAcO8AaKtIskWmZy757DZdeXQenD0s7AqLZl3LVUHdJWYU6cJFG/UZ3KM
         UzOX03BmiLneCyjnUMXKcfugy8eMLIWxGXDY1l/77aitFWCvEsMJftNwsoRtlbW2QlDo
         amByKUg+pe/LGN/dQl092a0awxpudazkSyWUu9ig8dNI/eYpgd9jatN9LFCaODLdPmWH
         XNWw==
Received: by 10.213.14.146 with SMTP id g18mr335818eba.0.1334866015697;
        Thu, 19 Apr 2012 13:06:55 -0700 (PDT)
Received: by 10.213.14.146 with SMTP id g18mr335809eba.0.1334866015572;
        Thu, 19 Apr 2012 13:06:55 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z52si3065774eeb.1.2012.04.19.13.06.55
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 13:06:55 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 5FF7820004E;
	Thu, 19 Apr 2012 13:06:55 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 72EB9E1209; Thu, 19 Apr 2012 13:06:54 -0700 (PDT)
In-Reply-To: <1334857109-sup-7979@pinkfloyd.chass.utoronto.ca> (Ben Walton's
	message of "Thu, 19 Apr 2012 13:39:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmC8T/3/enanl8ROanRE5bQyETJES9jN+LMGk1QYHD6BYlJtHHC+rKpDgConOuZup/+rO+KEAsYpQSbM+TNqyFfQou97BgXV3iZ8XxG2AXdnNYsR9f2+UpyOx5Avfn8Nqh2HKgfxjpkMvfg5gvphnvDRiNZGkhvFkaIHejuj7YobdCEzUk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195966>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> This does work and if there is some significance to the space or tab
> then it's a better patch.

Ok, I'll queue this:

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9400: fix gnuism in grep

Using "\+" in "grep" and expecting that it means one or more
is a GNUism.  Spell it in a dumb and portable way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9400-git-cvsserver-server.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9199550..173bf3d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -500,8 +500,8 @@ test_expect_success 'cvs status (no subdirs in header)' '
 cd "$WORKDIR"
 test_expect_success 'cvs co -c (shows module database)' '
     GIT_CONFIG="$git_config" cvs co -c > out &&
-    grep "^master[	 ]\+master$" < out &&
-    ! grep -v "^master[	 ]\+master$" < out
+    grep "^master[	 ][ 	]*master$" <out &&
+    ! grep -v "^master[	 ][ 	]*master$" <out
 '
 
 #------------
-- 
1.7.10.282.g21208e
