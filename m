From: larsxschneider@gmail.com
Subject: [PATCH v3 0/3] add test to demonstrate that shallow recursive clones fail
Date: Mon, 21 Dec 2015 00:19:52 +0100
Message-ID: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Cc: sbeller@google.com, peff@peff.net, Jens.Lehmann@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 00:20:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAnHL-0004OI-EX
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 00:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbbLTXUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 18:20:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35455 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbLTXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 18:19:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id p187so11055954wmp.2
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 15:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=73mLkMLioFx4y4mfaL8PY6WOXdKQHxiySLSmbJbASog=;
        b=hm1JDcB8CP9tlL7BQwTfHhLDFqPovF9nPlq/YlnMKegeBYfvKp8uERQmiZ5AghVd4F
         ySMiAZZP5EjRCtLR4bfvqKnDM/kYHCxFthzYeivmIg0wKrQk5yytgg3nM8szTH9MY+q9
         ZwfUJdorjgFJrdvLjb/IA7KNL0LSozj6Y2bzwIhaJOQcSzbAgex/Oeune62tSPwWdEc9
         M9Z4bhEHnlta3soZvIT3T+yHheajXBbK2yGlPO63tO1u1khCv4+USMTrV6K8eZhCuz2I
         o5dC14ceiOD1C344ts5LptWwYsN5Q7oCABvOo18nH3nnoJo8yzKZUL/5VDorgPCJIq3f
         8alA==
X-Received: by 10.194.82.229 with SMTP id l5mr19033977wjy.140.1450653598603;
        Sun, 20 Dec 2015 15:19:58 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id da10sm25396623wjb.22.2015.12.20.15.19.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 15:19:57 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282779>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v2:
* remove workaround tests as suggested by Peff [1]
* fix chain breakage introduced in 275cd18
* add hints to the user if a submodule checkout fails while using the
  depth argument [2]

Thanks,
Lars

[1] http://article.gmane.org/gmane.comp.version-control.git/281237
[2] http://article.gmane.org/gmane.comp.version-control.git/281420

Lars Schneider (3):
  submodule: add test to demonstrate that shallow recursive clones fail
  submodule: fix &&-chain breakage
  submodule: extend die message on failed checkout with depth argument

 git-submodule.sh               |  4 ++++
 t/t7406-submodule-update.sh    | 35 +++++++++++++++++++++++++---
 t/t7412-submodule-recursive.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100755 t/t7412-submodule-recursive.sh

--
2.5.1
