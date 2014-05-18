From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 23/33] The log.decorate setting should not influence guilt rebase.
Date: Sun, 18 May 2014 23:59:59 +0200
Message-ID: <1400450409-30998-24-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9IG-0005KK-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbaERWKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:10:52 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:48422 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaERWKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:10:52 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so3399775lab.26
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bGZ216pKC3s1i9gVKKxXD7BufyF0e3hfa2Xe1vxkqTA=;
        b=V13EkQpn/Xo9/CC5MCrfwm66HARvBYs+TavtU+L1sgyy92pLMUpGCswfXGS3jPefTr
         zXq34ne+h2s2UeyEoMsYPx8t13B3h/ficac8lR/10nkmjIR5ykYQIflwemnE9wqGs6DW
         dcsrvcCcOYQ4IXubixXBLLEd1tbFn21zrdJGpu3h6LWmSI/YrwiknHWny/cmlL2kppVV
         FD24MBoQl7g94kMVSHCBxMhibIWT1Exk9OodwrzNMEKascYX9efgGuvBQA6Rr5cj8BIM
         vp+ukos1UydC8jxxF47KbBIjsUh4iwAlvuqOTi2r8t92YyGtZXy4irUbIzYMQrTgGwlU
         Ycxw==
X-Gm-Message-State: ALoCoQkQzEGxX2vTLiQeTxYCOKSIPi+7YAjK2J41FVwdaij44+xacyP+XMMngHpk4n+/5zoJjmyN
X-Received: by 10.112.29.79 with SMTP id i15mr22343699lbh.26.1400451050996;
        Sun, 18 May 2014 15:10:50 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.10.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:10:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249538>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-rebase | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-rebase b/guilt-rebase
index fd28e48..a1714a0 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -66,7 +66,7 @@ pop_all_patches
 git merge --no-commit $upstream > /dev/null 2> /dev/null
 
 disp ""
-log=`git log -1 --pretty=oneline`
+log=`git log -1 --no-decorate --pretty=oneline`
 disp "HEAD is now at `echo $log | cut -c 1-7`... `echo "$log" | cut -c 41-`"
 
 #
-- 
1.8.3.1
