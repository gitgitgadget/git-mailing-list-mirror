From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/2] stash: test and fix git stash branch regression
Date: Tue, 28 Sep 2010 23:19:50 +1000
Message-ID: <1285679992-7638-1-git-send-email-jon.seymour@gmail.com>
References: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Cc: tla@land.ru, tom@dbservice.com, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 15:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0a3Y-0005ld-T0
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab0I1NRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 09:17:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:33456 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab0I1NRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 09:17:10 -0400
Received: by pxi10 with SMTP id 10so1677064pxi.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=207z1VOz0DdyMxP+0vUZzIyCGWoVOqOonOQ5BOyR+W8=;
        b=L2NRNNUEkUz+y+CJ+Srn79Ed6HoCF5eWJ7Bv9DvOGdiRO45pfI0hD4+x67k0loFh0W
         1jzpHzdPhjKexeXnWVCGZdgUk4jTopP2VyPDvFiWqqt1yPk0KNximDWU6ReLOLdKL7R5
         UC4DUyUExjxH5dmcK6T08LvTTeBCWVnkpxg9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jkqTTX+x9v5taXrCyztKGLivEUdP2wRSngprw7XUxH1PReCo+S4AfQKku5DfahehA4
         HKNMCnq+Cek4iIwUBwRLjQl9tXLhCj+6bAKiu83jcWn5ACHzBx3ozCj8+34mh4u/GwNw
         g+JbZ6DwQ7Q9QjyWsP+tE0CkbxK0vn6IFe5j4=
Received: by 10.142.48.17 with SMTP id v17mr7771463wfv.233.1285679830013;
        Tue, 28 Sep 2010 06:17:10 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-77.dyn.iinet.net.au [203.158.55.77])
        by mx.google.com with ESMTPS id o16sm8820470wfh.19.2010.09.28.06.16.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 06:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.5.g7cfb7
In-Reply-To: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157418>

This series fixes another (sorry!) regression I introduced with my detached-stash series.

I have included Tomas' test, so that my tweak to the test script applies cleanly.

Jon Seymour (1):
  stash: fix git stash branch regression when branch creation fails

Tomas Carnecky (1):
  stash drops the stash even if creating the branch fails because it
    already exists

 git-stash.sh     |    6 +++---
 t/t3903-stash.sh |   11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
1.7.3.4.g787b.dirty
