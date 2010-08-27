From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Fix counting problem in `format-patch -<n>`
Date: Sat, 28 Aug 2010 01:58:14 +0530
Message-ID: <1282940896-18350-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 22:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op5ZD-0001vz-Ji
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 22:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0H0UaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 16:30:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58803 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0H0UaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 16:30:18 -0400
Received: by yxg6 with SMTP id 6so1264295yxg.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YuSHdBWTEXRaHGmXgMySu0Rcgr7lTZUScYOGTM9MkNA=;
        b=xf6umY922jauXOCX0MMCeg/oIo7/rlJ8Zdr0VI2Bh+YMzo801DbE/4q5AS3OcLWGd4
         zirR7L3coBKL7H4HRLUkO6xMC0ZBymIqX6cJTu4Rd2t+p8PA1Ii/8fWlxE384znmqdwf
         AS/DbeNbpGJpJAs8xJFUayPr47uY/7CXxPyGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kYovah9gGI7eLP5cMlLkMkVNup1TehNP7mfbOh0m12ft/CTYUOzajDl4Q/TXmBFlu5
         PODL0rjimNUNqkcmWsY6PP9/DtdjP9/0Zi0688NqSy8ADBSqpowKf6j0hbNnXp9e7e0p
         boz9OIEcpFyHAZZimeqZuXvXnNRUgJAFqXbCQ=
Received: by 10.100.190.11 with SMTP id n11mr1511294anf.160.1282941017086;
        Fri, 27 Aug 2010 13:30:17 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e18sm3996898ana.15.2010.08.27.13.30.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 13:30:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154616>

Hi,

Here's a patch avoid the 'git format-patch -3' confusion I complained
about earlier along with a test. 1/2 isn't strictly a prerequisite,
but results seem to be unpredictable without it.

Based on master.

Ramkumar Ramachandra (2):
  t4014-format-patch: Call test_tick before committing
  format-patch: Don't go over merge commits

 Documentation/git-format-patch.txt |    2 +-
 builtin/log.c                      |    7 +------
 t/t4014-format-patch.sh            |   21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
