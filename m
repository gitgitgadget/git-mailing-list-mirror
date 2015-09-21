From: larsxschneider@gmail.com
Subject: [PATCH v4 0/2] git-p4: handle "Translation of file content failed"
Date: Mon, 21 Sep 2015 12:01:39 +0200
Message-ID: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 12:01:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdxuv-0004K3-9O
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 12:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbIUKBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 06:01:45 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38623 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbbIUKBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 06:01:44 -0400
Received: by wiclk2 with SMTP id lk2so103761926wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=V5enkPv6rCzacFqeO20Qm+LJfywQWADPhoq+OxDX11w=;
        b=lPdebb8QPxkulwGJaDYzvAUHdJU/G3pyXCw9p828XBMRGcQBxri0y+JJ2COEjDre6r
         DdjqnjcVKOuxqf0aAvPOotExPZJJFZwiLd5eyOPBxQK91TRH6vT36GuqfPCdY53ewUF4
         z/fRvOSGyT2s2Fh+V21QpWZFNfHNxq9QpwyQ0fNqtAOdqwDH9boM0f9uZJzrd4XTKe1h
         3pGivjXZ3PdDP7+wilTiyHfbC68Or6gB0ACmLsmnmdGb0RGyhXxwmZgW6GISKU8sSIkO
         6zrk0cQy5ABgNggpUR0VOZ53MXgCAU3ANLZKkFb/+aUDxgiugKWXCyR2Mh0/IoAyg7DI
         Is+Q==
X-Received: by 10.194.2.243 with SMTP id 19mr15096457wjx.140.1442829703306;
        Mon, 21 Sep 2015 03:01:43 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id kb9sm23192082wjb.49.2015.09.21.03.01.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 03:01:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278295>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v3:
* replace non portable "sed -i" call in test case (thanks Luke and Torsten!)
* use "test_expect_failure" in the first commit that adds the test case, flip it to "test_expect_success" in subsequent commit (thanks Eric and Luke!)
* rename test case from t9824... to t9825... to avoid clashes with "git-p4: add Git LFS backend for large file system" patch

Cheers,
Lars

Lars Schneider (2):
  git-p4: add test case for "Translation of file content failed" error
  git-p4: handle "Translation of file content failed"

 git-p4.py                                  | 27 +++++++++-------
 t/t9825-git-p4-handle-utf16-without-bom.sh | 50 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 11 deletions(-)
 create mode 100755 t/t9825-git-p4-handle-utf16-without-bom.sh

--
2.5.1
