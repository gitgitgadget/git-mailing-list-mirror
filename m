From: larsxschneider@gmail.com
Subject: [PATCH v2 0/2] git-p4: handle "Translation of file content failed"
Date: Mon, 14 Sep 2015 18:55:26 +0200
Message-ID: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 18:55:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbX2X-00073B-9P
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 18:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbbINQzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 12:55:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35175 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbINQzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 12:55:32 -0400
Received: by wicge5 with SMTP id ge5so151213105wic.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rlhGmceK866QZjEK3h6JanVRGI/VnW8YeEiJYGHau0w=;
        b=DXi4uksUxP3z/Y7E36ActpvwiNbWFfR1Bn1Zqy5+DMIJuyGzdq88gCTTrFVSJDxM+c
         RkInbonYEaB7sbP7moPjzeAJGAq2lZqEhOLFs+8HHMUI3ozOCRnQFQ23t9OCeD1kNUyf
         2fJAC4rtf1QvAHrb2+m53YQcEIi2aUO1i4lzz6SC9jbB0hGvT23ZPh/vqXM+vEqqOC/u
         jT/TRoRWwiqSWdMeWntJM6z4xYkcUGk3ejfIs5TGCB5frAx30IdGYg37Ull85FdbDHDB
         BfIy4vWgiPyXzuCbVtaZvvyyS6zawafFHWN12TEm8xyDDeEF7woV4+7Kssgv8kexrzmH
         jRDA==
X-Received: by 10.180.108.136 with SMTP id hk8mr27127615wib.47.1442249730827;
        Mon, 14 Sep 2015 09:55:30 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lh11sm15264784wic.18.2015.09.14.09.55.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 09:55:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277837>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v1:
* add a test case
* use Popen "communication" function instead of "wait"

Thanks to Junio for feedback!

Known issue: My fix works only if git-p4 is executed in verbose mode.
In normal mode no exceptions are thrown and git-p4 just exits.

Lars Schneider (2):
  git-p4: add test case for "Translation of file content failed" error
  git-p4: handle "Translation of file content failed"

 git-p4.py                                  | 27 ++++++++++-------
 t/t9824-git-p4-handle-utf16-without-bom.sh | 47 ++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 11 deletions(-)
 create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh

--
2.5.1
