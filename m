From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v6] format-patch --signature-file <file>
Date: Tue, 20 May 2014 18:02:49 -0700
Message-ID: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 03:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmuw6-0006EK-6n
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 03:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaEUBDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 21:03:10 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34203 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaEUBDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 21:03:09 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so833217pdj.12
        for <git@vger.kernel.org>; Tue, 20 May 2014 18:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OZfVICPDh94lxvXgrjNRa2NEUko7daMRePImTgC26K8=;
        b=AcmrX4aSVklCWFhWPuDahlwY/g0wIDJMDFUJbfG3TuI19VQ2/JcDmJxc/AH8QHzPh+
         j1iscnT4F8XIZP/vqUPLpXUk4iVUHV+F6dGrZD2/EljQzWyp5902dlohx6Olff5k5cjM
         1H+3hwL0J2/r1Rj1h3XeBqscjLqMTGv0THBgoZjgIMleTQ7hrA+p1y4r4IDTocrjBadn
         WmDYOUWtQxuDz5AdcWS+lxIXjue1bRuJgrDZQ5dzG9PfIAf9DI2gXfhDg8w4j0GjJ1AN
         wr4AsGWWCTPrFlkVBI1uDiewHy3x6iIUpLMwcTO+u+5S+jEFVyx8Caj/GC7FRPYKuA6k
         bg1g==
X-Received: by 10.68.204.162 with SMTP id kz2mr54451372pbc.13.1400634188720;
        Tue, 20 May 2014 18:03:08 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ck10sm97086302pac.0.2014.05.20.18.03.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 18:03:07 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 20 May 2014 18:03:04 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.g20b0be9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249771>

v6 of patch to add format-patch --signature-file <file> option.

This revision includes more suggestions from Jeff King and Junio C Hamano:

  - Adding #define DEFAULT_SIGNATURE was a good idea but it could be
    used in a way that nullifies the pointer comparison used to see if
    the default has changed.  So this was removed.

  - The test cases depend on there being two blank lines after a
    signature from a file.  This is an odd problem because if --signature
    or the default is used only one blank line is produced.
    This problem can be addressed in another patch.

Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
