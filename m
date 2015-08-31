From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 22:43:52 +0200
Message-ID: <1441053833-63790-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 22:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVvx-0004Ti-EZ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbbHaUn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:43:59 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36639 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbHaUn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:43:58 -0400
Received: by wibz8 with SMTP id z8so11982444wib.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RkBgInk4aW8w9dcn/PrZ9cPg3gMiCuDh0CAvqj42yPY=;
        b=U2E06/e0Ap3VOv/mGQe5j2umKjJSpa0+fVqSRUsuxxOnfLvu53Mm5hofs/2FoeOmEt
         kcl3Hvox1QuVvXONSooK62bagJRomKklRlOLAn6Aa2wi+/CHkKSadAFLy6ZdLJ+E8QK5
         Hs2lqqQ4NGwu4bFmhBHqWRriHLc2yRFLIhDKtg5VSQj2XmTVwx/h/fyUDQBv7AE/CLAc
         eTG6iwlhckx06fwpSyisXM2BTVU098apwTqN0JT+S0MJIK1Vmeo01VuuH6nqCR1QwbMh
         j6N9gp4rNQfLWHHavuX0PxzeSMeSz1cGlz44Ly1W/sb7Ao103ZfcEyDqo7LcUYn/Vq8f
         CQow==
X-Received: by 10.180.81.4 with SMTP id v4mr389971wix.71.1441053837238;
        Mon, 31 Aug 2015 13:43:57 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id cj1sm441615wib.14.2015.08.31.13.43.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 13:43:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276936>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v1:
* switch example conversions from cp1252 to iso8859-1 (thanks Torsten!)
* fix git-p4.txt line length and double dashes (thanks Junio!)
* remove bare UTF-8 sequence (thanks Junio!)

As with v1, I ensured the unit test runs on OS X and Linux.

I noticed one weird point, though. "git ls-files" outputs the UTF-8 characters escaped on Linux and on OS X. Is there a problem with my setup or this a Git bug?

Thanks,
Lars

Lars Schneider (1):
  git-p4: add "--path-encoding" option

 Documentation/git-p4.txt        |  5 +++++
 git-p4.py                       |  6 ++++++
 t/t9821-git-p4-path-encoding.sh | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 t/t9821-git-p4-path-encoding.sh

--
2.5.1.1.g9071995.dirty
