From: Alexander Rinass <alex@fournova.com>
Subject: [PATCH v2] diff: run arguments through precompose_argv
Date: Fri, 13 May 2016 22:41:01 +0200
Message-ID: <1463172062-4175-1-git-send-email-alex@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Rinass <alex@fournova.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 22:41:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Jtp-0001Gz-2d
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcEMUlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:41:20 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37384 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEMUlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:41:19 -0400
Received: by mail-wm0-f44.google.com with SMTP id a17so47866627wme.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7KSt2AQ378zQK+7BcFv/nN+1qDbj6m/PnyknC+JX/lw=;
        b=sh+ap5HAICTH326sg3ue28YgowJFLNgN1gTBoTUvUxDuOC48yehc8VvegxL5r5CLNY
         B/yUW+Y+vZ8Z5ppyMDUazH7EYOuD+cxcf0VpKz35do+WluJ4iJJ4LtzSJypyAvbu8iDg
         PWSTGycb4wpdEqoXWS/zr2Lrk0SDPFQTfQcnazkTk8XBaiQq47EyqgUHTyVKD5w0i5V1
         iHPLI8MTZdl9ZO+U5lkeeeuwSa26CwLtOplXWQdfAaoRz6JD0SydOOCCM0oC1JEgydiK
         mVAaJDPgPd1EEqjNTXmGI1m1M6o76Gzam+KFTMY9WpTgXA1sMF7IDmBRju3AGw5IP4BA
         YYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7KSt2AQ378zQK+7BcFv/nN+1qDbj6m/PnyknC+JX/lw=;
        b=Br21vmyPMAuOgANv+o3Ch9/Q7WO7hmuCulf6W0XCuxy0S4T32xHilG6VLZmQNbiFym
         mCLJDaHz2S54HMNobo+fsvgZyFhUkHpK7nW1NrvGB+2wenmG9siMKsXVWeTsf8e0hdl9
         tLjSmhEPYel/BQaPMlPDJp7aBjfUWII3lTh8GDh+umUlfipCyidvzeFJGdcoYhivte+l
         GX4yhV8R28/OhdDirAneY2BVtqjLdzJCnnren91WuYaYPPZp4XsjNIZFPFVvLHi34cip
         mP/97hLXRMtjcvseT7l+MZhHr4wKsiW+QSKN/kOOrcfE2hMJiCmnobG3WXKaUC/UGapC
         HXMA==
X-Gm-Message-State: AOPr4FXPYLQ4moeWaLr+UODSoduJtUC0VMYpbqSAUPL1ZilYQFegvPtO6BAYEJnT1h2Haw==
X-Received: by 10.194.231.196 with SMTP id ti4mr19045076wjc.41.1463172077918;
        Fri, 13 May 2016 13:41:17 -0700 (PDT)
Received: from Alexanders-MacBook-Pro.fritz.box (aftr-109-90-232-30.unity-media.net. [109.90.232.30])
        by smtp.gmail.com with ESMTPSA id b15sm4950304wmd.1.2016.05.13.13.41.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 13:41:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294576>

I have used Junios proposal/changes for the commit message as I 
liked it and it is probably more in line with the usual commit
messages of the git project. I hope this is ok.

Let me know if you need me to do any more changes or what the
next steps are if the patch is ok.

Alexander

Alexander Rinass (1):
  diff: run arguments through precompose_argv

 builtin/diff-files.c         |  1 +
 builtin/diff-index.c         |  1 +
 builtin/diff-tree.c          |  2 ++
 builtin/diff.c               |  1 +
 t/t3910-mac-os-precompose.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+)

-- 
2.8.2
