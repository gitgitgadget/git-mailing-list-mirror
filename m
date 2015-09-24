From: larsxschneider@gmail.com
Subject: [RFC/PATCH v1] Add Travis CI support
Date: Thu, 24 Sep 2015 23:43:23 +0200
Message-ID: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfEIg-00033L-0c
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbbIXVn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:43:29 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35324 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbbIXVn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:43:28 -0400
Received: by wicge5 with SMTP id ge5so2043341wic.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WH2QGCaKB0l5mm5s/2ovtH5q8tJePCWwCbpzHf5ac40=;
        b=BFQbj+00x+7mI7c/WhZ0oBpS0y+JhY55dU/WHU0C8ZthFFvAcRRs0DFkxXdfQCnlO/
         vcfcCiE6uakH8D9qk60tz7+CFSO9MNFK/OquXhF8TChKyjCwUqwDyaISToCrAE5G0tKw
         JCic7rCY02QRVP3PGZZ/6wC5bDiDfGP0d6WpfaA548Cy7fkdZnDMVr9rptnDQUfbeHXZ
         Z8fgZNWr0Zlb2UBfynRBC5+fCvDVms3uzp8j7Vi8ih28ad0d6Nn2QvB16Nx/FTqcAtG8
         igBNdQ0tqGc8Rm+9D8rp0WIQXDFeXkX2OoTY1yZQXJtYWcZlku844ex1Z/BnkbIGaedq
         H75g==
X-Received: by 10.195.11.40 with SMTP id ef8mr1966995wjd.103.1443131007296;
        Thu, 24 Sep 2015 14:43:27 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-094-223-081-222.094.223.pools.vodafone-ip.de. [94.223.81.222])
        by smtp.gmail.com with ESMTPSA id az6sm155603wib.12.2015.09.24.14.43.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Sep 2015 14:43:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278633>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

I recently broke a few tests...

In order to avoid that in the future I configured Travis CI for Git. With this
patch Travis can run all Git tests including the "git-p4" and "Git-LFS" tests.

The tests are executed on "Ubuntu 12.04 LTS Server Edition 64 bit" and on
"OS X Mavericks" using gcc and clang.

My idea is that the owner of "https://github.com/git/git" enables this account
for Travis (it's free!). Then we would automatically get the test state for all
official branches.

Every contributor can enable Travis for their respective GitHub accounts. Then
they would know if their patches pass all tests in advance, too.

You can see the state of my branches here:
https://travis-ci.org/larsxschneider/git/branches

It's pretty red. The reason is that maint, master, and next have a failure on
OS X (test "t9815-git-p4-submit-fail.sh" does not pass). Furthmore pu does not
pass on either Linux or OS X (which is propably OK since it is pu).

You can also inspect the build/test logs. Here for instance the log for the
next branch compiled on Linux with gcc:
https://travis-ci.org/larsxschneider/git/jobs/82032861

Cheers,
Lars

Lars Schneider (1):
  Add Travis CI support

 .travis.yml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 .travis.yml

--
2.5.1
