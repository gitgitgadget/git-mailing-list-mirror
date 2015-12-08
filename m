From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: Add option to ignore empty commits
Date: Tue,  8 Dec 2015 10:36:21 +0100
Message-ID: <1449567382-63713-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 10:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6EhF-0003Gp-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 10:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbbLHJg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 04:36:28 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32836 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbbLHJg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 04:36:26 -0500
Received: by wmec201 with SMTP id c201so203837229wme.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 01:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GOAj5OF0z3bDttEI9Y8ImiXS1g24kXW82DDkTW6+ZQI=;
        b=Ah2Nx8DA95uFKQhb8n/aruaRfU6+TLsnLXR+24UC3GNTgua2o/m48wtFu4u6ze6HEd
         qzS0fFLUQA3s77PgbBL4QU4TfJffDH7UnRYutnfHzfBhONvLztG6s8HD3NcaRrFZ6tKT
         +UeDSWXUi8TKEY/X8z1eEEORKabBF+ai3Brg84/7qPjRC9e7CexFFnyLG+t8n15g/y7Q
         pzOy/dxti02abZeY6XwDCW5CkTNKWvH8V6Cb1yhJXbYIVlsWZtombJBAdB/jEkNuiq1f
         sOcUFN5S9yvjN/uS5iNb3rnhO65zQLC3GIlL+hGyr6xjfq+bnfPvV0x/BSZa3rboN8cZ
         +7NQ==
X-Received: by 10.194.63.142 with SMTP id g14mr2082351wjs.161.1449567384956;
        Tue, 08 Dec 2015 01:36:24 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB6FA0.dip0.t-ipconnect.de. [93.219.111.160])
        by smtp.gmail.com with ESMTPSA id l7sm2133062wjx.14.2015.12.08.01.36.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 01:36:23 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282151>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v1:
* change the default behavior and replace "ignore empty commits" option
  with "keep empty commits" (thanks Junio/Luke)
  --> I kept the original topic name in the subject letter to ease finding
      v1, ok?
* add 'an' to fix grammar in commit message (thanks Luke)
* remove quotes around 'true' in docs to avoid confusion (thanks Luke)
* add deletion test (thanks Junio/Luke)
* use print statement to avoid ugly \n (thanks Luke)
* use positional argument specifiers in Python format string syntax to
  support Python 2.6 (thanks Pete Harlan)

Thanks,
Lars

Lars Schneider (1):
  git-p4: Add option to keep empty commits

 Documentation/git-p4.txt             |   4 ++
 git-p4.py                            |  44 +++++++-----
 t/t9826-git-p4-keep-empty-commits.sh | 134 +++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 17 deletions(-)
 create mode 100755 t/t9826-git-p4-keep-empty-commits.sh

--
2.5.1
