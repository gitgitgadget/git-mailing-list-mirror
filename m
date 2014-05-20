From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v5] format-patch --signature-file <file>
Date: Tue, 20 May 2014 01:00:05 -0700
Message-ID: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 20 10:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmeyG-0006ZX-0d
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 10:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaETIAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 04:00:20 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36172 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbaETIAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 04:00:20 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so400405igq.13
        for <git@vger.kernel.org>; Tue, 20 May 2014 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EoAii/4wPLUib5+MNd2iXB6mERGD9qqVQJ4Pu+JqlLg=;
        b=qUuaLjrFh2+mGSX2twn+kR6jQdH3oCFairGNiQR5lZLEFr7y4ppRCpKwaXiPsEhdxC
         UhlXTf3E1DyxR3p4eW4oIwY5QmBzTWQIbN1W1zd/T5JlHCbOAT0lpB/JAJMw9Cm2FuSa
         Q3W8iEiTy4/aWrKQ+TKv8E4noivduFHLyH9KN8EdIkQNCm5ShHntVNzDjDiRlGnryPpz
         HECrp77V7ire1dgK2bueNDYYGHq2OlhGJSsXVaHuXS6OtS33wVfAv9Vl7Z+8T5rc2QXH
         hWtnOoKW0nHy5bHuPQNAHDMyKfaJN61TNM+j7DMWhXV7t5Dt5Ls9D1xw/vRNo6vzvy+V
         Be1g==
X-Received: by 10.50.13.67 with SMTP id f3mr2550031igc.9.1400572819544;
        Tue, 20 May 2014 01:00:19 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id lr6sm27183364igb.15.2014.05.20.01.00.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 01:00:18 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 20 May 2014 01:00:14 -0700
X-Mailer: git-send-email 2.0.0.rc3.4.g6308767.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249648>

v5 of patch to add format-patch --signature-file <file> option.

This revision includes more suggestions from Jeff King and Junio C Hamano:

  - Use git_config_pathname instead of git_config_string for ~ expansion.

  - Eliminated head/tail --lines which is not POSIX compliant.
    Replaced with sed equivalents.

  - Used test_config instead of git config which also handles unsetting.

  - Use a DEFAULT_SIGNATURE variable to better describe its purpose
    instead of git_version_string which could be confusing.


Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 19 ++++++++++++++++++-
 t/t4014-format-patch.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
