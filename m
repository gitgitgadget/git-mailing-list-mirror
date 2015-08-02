From: larsxschneider@gmail.com
Subject: [PATCH] git-p4: fix faulty paths for case insensitive systems
Date: Sun,  2 Aug 2015 17:15:16 +0200
Message-ID: <1438528517-5028-1-git-send-email-larsxschneider@gmail.com>
Cc: pw@padd.com, torarvid@gmail.com, ksaitoh560@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 17:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLuz7-00046G-8n
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 17:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbbHBPP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 11:15:28 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34625 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbbHBPP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 11:15:28 -0400
Received: by wibud3 with SMTP id ud3so107912920wib.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=f2OafEV78xUDf5a4kNhHtiSlqKqBHychga7Jjvq/eu4=;
        b=KvFMOKXByx81Dm90pGbsdZ8gH14FuaLVdIfLLlNKZbAmfzt/rQE/xGNZUcsXNq4R/4
         YgnAVi2vO+O3Nru+ggHyqWlAS0msSU6rPE+dE+y4nNMpRut4bWZJxFrO8ipUwEt2bEHI
         o23efhlxNhRJaxogwbiCJs0HpU9wk0dcSPNd6ZMdn+jYoI2g6L99gSPlaM7H7niTdvPW
         nZJUHsNW67M3U6oHGwEM+5UY0UGGXcivMzYwIN2tVu5p2rVZWHjgCH4T0DX3JkHuiRH0
         dGDt65DhsJXzD/vYk9Kh39dJ9FwpyUGd/uYrKLM9qneH2NnIejn8e0jqDATwk5sfzBzo
         nwFg==
X-Received: by 10.194.186.171 with SMTP id fl11mr25383043wjc.100.1438528526758;
        Sun, 02 Aug 2015 08:15:26 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id dz4sm8617349wib.17.2015.08.02.08.15.24
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2015 08:15:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275139>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

I want to propose this patch as it helped us to migrate a big source code base
successfully from P4 to Git. I am sorry that I don't provide a test case, yet.
I would like to get advise on the patch and on the best strategy to provide a
test. Do you only run git-p4 integration tests in "t/t98??-git-p4-*.sh"? If yes,
which version of "start_p4d" should I use?

Thanks,
Lars

Lars Schneider (1):
  git-p4: fix faulty paths for case insensitive systems

 git-p4.py | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 4 deletions(-)

--
1.9.5 (Apple Git-50.3)
