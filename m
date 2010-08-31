From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/2] fix quotes in maint-reflog-beyond-horizon and detached-stash
Date: Wed,  1 Sep 2010 00:49:18 +1000
Message-ID: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 16:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqS98-0007VP-Rk
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476Ab0HaOtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 10:49:02 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49363 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431Ab0HaOtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 10:49:01 -0400
Received: by pvg2 with SMTP id 2so2473374pvg.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xTo+wyc7W1jFs2RE5dCHlJg6DUyZfH05JrmkKD9aQSc=;
        b=h2Hck/rSAOvOp7WNN86bXTlUHJaBAf+T8Rh8LMQdXYoIUzlQ71Q6S+3ZoTLFPt6N6Y
         ZfMYArgxwe7fz6pUePZL9aH3nQfCNCXLa8Z+0NPrhss4b+l3SRKXiOV6a5TnUojnREUA
         u6TtA7ZEIf//pV3rfxRFu/hCGqjjbtxNQyh2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FkAAOb5yZwkxAjSCc6TAAMQ5qydd5pQOkRw834ouGTW+z2aWKhQ7KqQuW66Xz63FsQ
         eE2XtKIB4ou1UUBg/y1wdXHI0g3fFNVRsld+LMGBQF9Q9rpgFwTkpd+b06rYHs0KL8aS
         mN0U0MZW4hoWJm+0Fvl5Zq+UHE/cPxYQtK5Do=
Received: by 10.114.73.20 with SMTP id v20mr7035193waa.148.1283266140774;
        Tue, 31 Aug 2010 07:49:00 -0700 (PDT)
Received: from localhost.localdomain (124-169-135-9.dyn.iinet.net.au [124.169.135.9])
        by mx.google.com with ESMTPS id d39sm16562703wam.16.2010.08.31.07.48.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 07:48:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.82.g9d57.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154904>

In two recent series, I introduced tests that use test_must_fail incorrectly.

In effect, I was calling:

   test_must_fail "foo bar"

but this was failing because "foo bar" is not comamnd and not because
the command "foo" fails with arguments "bar".

These two patches fix these problems.

If necessary, I can re-roll the original series. Otherwise, these patches
can be squashed with the test-oriented commits currently in next.

Jon Seymour (2):
  maint-reflog-beyond-horizon: fix broken test_must_fail calls
  detached-stash: fix broken test_must_fail calls

 t/t1503-rev-parse-verify.sh |    4 ++--
 t/t3903-stash.sh            |   36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
1.7.2.80.g22196.dirty
