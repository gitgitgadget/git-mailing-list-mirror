From: larsxschneider@gmail.com
Subject: [PATCH v3 0/3] Add Travis CI support
Date: Sun, 11 Oct 2015 10:54:59 -0700
Message-ID: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Cc: johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 19:55:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlKq6-00069m-KJ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 19:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbbJKRzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 13:55:07 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32771 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbJKRzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 13:55:06 -0400
Received: by pacex6 with SMTP id ex6so4803147pac.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=olKSHmX0udPS6+sUJHyCZifeqpSlpj4lZZsLSjzbZf0=;
        b=Zw5U5/ZdJMbti5DyEfSdon/I7Snx4mrJjLMif3VYqlZzQpc6UQCAT5c6tdKi+uqTTV
         eILssRpJv/zXbfGimfi51WabhsquSFhHCXQSzPjo3kfG7dfdSIw9fU5j5RjkDmkMrXD3
         P+tg5PG43FDeAlTAKP5x6I/mRUh1AMmcdDSefB9bFOtFr2vrs4yHiC0axp9bVWg03vc5
         53bw2zLxzbPyMjRT7sOHwCOD1o61scQ9MwV9SE3hXn4390hl0GwsuS1bX1Il4IxWLt6K
         5vO8D6hwx/IXTi/Br2VMRk7X0C4E/rI5W+nQzESClCQHptD01M7eswvC7dKh7nFc/t7J
         lJmg==
X-Received: by 10.68.201.33 with SMTP id jx1mr28870057pbc.75.1444586105436;
        Sun, 11 Oct 2015 10:55:05 -0700 (PDT)
Received: from slxBook3.hsd1.ca.comcast.net (c-69-181-162-247.hsd1.ca.comcast.net. [69.181.162.247])
        by smtp.gmail.com with ESMTPSA id de4sm13746279pbb.60.2015.10.11.10.55.04
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Oct 2015 10:55:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279348>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v2:
* fix commit message to express what systems the Travis CI's infrastructure
  "currently" uses (thanks Dscho)
* use `case` instead `if` syntax for OS detection (thanks Dscho)
* remove unnessary DARWIN flag (thanks Junio)
* use flag `case_insensitive_fs` to disable t9819-git-p4-case-folding based on
  the currently used filesytem (thanks Junio)
* replace `stats` call in t9815-git-p4-submit-fail with `ls` to improve
  portability (thanks Junio, Torsten, and Pete)
* use Travis lifecycle properly to make output foldable in Travis (see
  little triangle on the left of the output on the Travis website)
* set git test option "--quite" and run make with option "--quite" to reduce
  log output noise

Thanks,
Lars

Lars Schneider (3):
  Add Travis CI support
  git-p4: Improve test case portability for t9815 git-p4-submit-fail
  git-p4: Skip t9819 test case on case insensitive file systems

 .travis.yml                    | 46 ++++++++++++++++++++++++++++++++++++++++++
 t/t9815-git-p4-submit-fail.sh  |  7 ++-----
 t/t9819-git-p4-case-folding.sh |  6 ++++++
 3 files changed, 54 insertions(+), 5 deletions(-)
 create mode 100644 .travis.yml

--
2.5.1
