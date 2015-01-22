From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/5] t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
Date: Wed, 21 Jan 2015 18:32:06 -0800
Message-ID: <1421893929-7447-3-git-send-email-sbeller@google.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 03:32:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE7Zd-00084O-1O
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 03:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbbAVCcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 21:32:24 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35631 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbbAVCcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 21:32:16 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so18976347igk.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eBIwsfV9kKhWiov7mmgzyaOJl8Nu/jofbpTqiM3XDvs=;
        b=As9Ata+mh6MS7jx446bB6C28ySTZjQPXZpylIBEBkByoTUfQHYUiuCEIQRSsCW3E35
         H2ubtQ4x2am0nSLKvzNFKH2Y+lhBbOM0XhDkwXH4hk6ORvyb50p7t3GXLe19BFhvR0Gr
         vjrw/pdjxicHLaZjfoDq4tdc576hFh7we0UdbC4ixnCevcBYmhg7hPLcCh4rj8qVb6YT
         /bQatCEQkKohyjBsafn8GA5bT/PGsqJoCDMJrK0WeNmn10tAiuzeGWmanKSzr6f3HWOV
         aVmrLOKXdRKYx22BiwExlINiLm0HOm+1mu+X+O/b5S4l7EQGstxCbZ1BXUcCINCPOmst
         41mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eBIwsfV9kKhWiov7mmgzyaOJl8Nu/jofbpTqiM3XDvs=;
        b=TU4k0i3YgLcc37wXzGyIevhOLpu+ObwiABNWmwUNcL+rq6Sz4iKeDYAzWA65LuEpg6
         XNjOPzF1jdFAO7ep+LcT7TofkiHiSPBYMidbigtY3brPej132wO902KG3TRxXp+D25RZ
         8AwiC1L7VEeIodPtlD+OsNyGPfz+XWZpYCbmMqJh+ztnky70fbk+7VyIY+0APfhhy337
         2Qx6UsJulcMu8U1pIyssM2BkMextlLZVO7pClntcsI4bhUpXh8ao8/r4/A706r9gSpxm
         +cEvnP0VZQwTnxDA5IVKU1Na5banSTixajNMDitPt/RKF6sWZwegkjhHemhekfsVYyBg
         3m9Q==
X-Gm-Message-State: ALoCoQmFvbHvq6H+9iqMIfYo0aAK/ZYOIfhdO1QsIGJLSiNzyuipsokg0YmQI89Ws4XHBiyraafF
X-Received: by 10.50.66.198 with SMTP id h6mr364558igt.22.1421893935275;
        Wed, 21 Jan 2015 18:32:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id n4sm1194372igr.3.2015.01.21.18.32.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 18:32:14 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421893929-7447-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262793>

During creation of the patch series our discussion we could have a
more descriptive name for the prerequisite for the test so it stays
unique when other limits of ulimit are introduced.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 796e9f7..06b8e0d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1463,10 +1463,10 @@ run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
-test_lazy_prereq ULIMIT 'run_with_limited_stack true'
+test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
 
 # we require ulimit, this excludes Windows
-test_expect_success ULIMIT '--contains works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
-- 
2.2.1.62.g3f15098
