From: Michael Blume <blume.mike@gmail.com>
Subject: no-xmailer tests fail under Mac OS
Date: Fri, 5 Dec 2014 18:05:24 -0800
Message-ID: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 03:05:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx4kn-0002mF-07
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbaLFCFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:05:45 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:49538 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbaLFCFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:05:45 -0500
Received: by mail-oi0-f47.google.com with SMTP id v63so1298720oia.6
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=xFT+mR2QgCt3QsxG3zqUh3qVNTyRU08UEU+FdTLQzgo=;
        b=s+k8MwuDRtH0Nx9bKcC8/ynfRk4dRSXfRlpzlOouVP/SLZrgZthKlOyQ71B1RjBx4P
         wSADeFWvHxn7haKMBl8lYkhrghR+0v5NkmLONqchLtL4XU1RPc+HgTBs7M0znGuNHmVJ
         w+i/PedekVAhvoAIvO9M8w/IyuEUwobONkDI1unkVCQUvioigtkN0umT5LRBpbbcwlN9
         QkXi9dzApIQ7nnBlXzf/MZHNKYUFle3ULdQRhCQH6yBvXcdUtoYfdMh4eLX1LjIFGuvL
         Rl7T3YgYTypauKEbohdvdkhVepBfAIOE0GX1cnbd12F/0KAfI81rgNyk2ZhzO0DSsAl5
         AyXg==
X-Received: by 10.182.130.162 with SMTP id of2mr12684704obb.52.1417831544533;
 Fri, 05 Dec 2014 18:05:44 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Fri, 5 Dec 2014 18:05:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260924>

Failures start from

commit d2384abff7a6181fd7b9a51af7e780aa21e5cb8d (refs/bisect/bad)
Author: Luis Henriques <henrix@camandro.org>
Date:   Thu Dec 4 19:11:30 2014 +0000

    test/send-email: --[no-]xmailer tests

    Add tests for the --[no-]xmailer option.

    Signed-off-by: Luis Henriques <henrix@camandro.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

but continue with Junio's SQUASH??? commit at b728d078

Verbose output follows

expecting success:
do_xmailer_test 1 "--xmailer" &&
do_xmailer_test 0 "--no-xmailer"

0001-add-master.patch
not ok 109 - --[no-]xmailer without any configuration
#
# do_xmailer_test 1 "--xmailer" &&
# do_xmailer_test 0 "--no-xmailer"
#

expecting success:
test_config sendemail.xmailer true &&
do_xmailer_test 1 "" &&
do_xmailer_test 0 "--no-xmailer" &&
do_xmailer_test 1 "--xmailer"

0001-add-master.patch
not ok 110 - --[no-]xmailer with sendemail.xmailer=true
#
# test_config sendemail.xmailer true &&
# do_xmailer_test 1 "" &&
# do_xmailer_test 0 "--no-xmailer" &&
# do_xmailer_test 1 "--xmailer"
#

expecting success:
test_config sendemail.xmailer false &&
do_xmailer_test 0 "" &&
do_xmailer_test 0 "--no-xmailer" &&
do_xmailer_test 1 "--xmailer"

0001-add-master.patch
not ok 111 - --[no-]xmailer with sendemail.xmailer=false
#
# test_config sendemail.xmailer false &&
# do_xmailer_test 0 "" &&
# do_xmailer_test 0 "--no-xmailer" &&
# do_xmailer_test 1 "--xmailer"
#

# failed 3 among 111 test(s)
1..111
