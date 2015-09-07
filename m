From: larsxschneider@gmail.com
Subject: [PATCH v1 0/2] git-p4: handle "Translation of file content failed"
Date: Mon,  7 Sep 2015 14:42:01 +0200
Message-ID: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvkY-0002lH-6n
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbbIGMmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:42:13 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34196 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbIGMmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:42:12 -0400
Received: by wicfx3 with SMTP id fx3so87446334wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qR4+mk5CulVKPMb8D3aFNSXSTXT0w0vvGpx/nTPYg/8=;
        b=dYWzm9qfsNnu6i6rPM/2zIFh9+ShTW2L2PAXYcMrOCDC+5owfExJOCVX39wv+Xqcg9
         tm4TV3IaLIDgZMe9xFHkqDAKwzh1R6auxlvASoJ/PGDi3ZJAbeUu5bl4FWNgDovIxLDq
         368Qvc2BF+PyOI7sf/XlkAIbEQFG/OxIOwidqKuo+btvTbCEjYtTHsKultFUWbAi5olm
         PEOUpHU1FV7wfIDGCCfU97myU3E+V7/Q0kaX05rYFYYc7JNWv1Ue5caIBrIHyZJ1umv6
         BqkXUT1b4bQA/LOB8oxyTmPkdOucXJEHc9PPqkIf8A36mjLesmZCJmd1wTTTfPtBCVsd
         Ua2Q==
X-Received: by 10.180.105.138 with SMTP id gm10mr10072269wib.37.1441629731331;
        Mon, 07 Sep 2015 05:42:11 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ul1sm19891852wjc.30.2015.09.07.05.42.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:42:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277457>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

this patch fixes the P4 "Translation of file content failed" error. Unfortuantly
I was not able to generate a P4 test repository to reproduce the error with a
test case.

An Internet search shows that this error happens in the wild:
https://stackoverflow.com/questions/5156909/translation-of-file-content-failed-error-in-perforce
https://stackoverflow.com/questions/887006/perforce-translation-of-file-content-failed-error

Thanks,
Lars

Lars Schneider (2):
  git-p4: print stderr if P4 read_pipe operation fails
  git-p4: handle "Translation of file content failed"

 git-p4.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--
2.5.1
