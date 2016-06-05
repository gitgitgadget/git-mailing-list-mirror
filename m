From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 0/2] Introduce "log.showSignature" config variable
Date: Sun,  5 Jun 2016 21:09:31 +0530
Message-ID: <20160605153933.15231-1-mehul.jain2029@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 17:40:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9aA0-00089c-BW
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 17:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbcFEPkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 11:40:15 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34733 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcFEPkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 11:40:14 -0400
Received: by mail-pa0-f67.google.com with SMTP id x1so9906894pav.1
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Z/tJIhPKk9xVTFmrQGmkiQ3IE2AQakipcgT5sAtq97w=;
        b=fNozPnbsO8jMuGiWa/S9N2Zh/gfGLPC7WgpHTz8n5vNEbGWCSWW54Gk4rLl4cjNzxz
         oRL9bQGsPQm7/cl7L4cwt8Lz4PeNvsh/0EccsW7HrAPUBT++c3OLRweVA/jVK5Phyfhp
         5oNMuWT/+qyZlx+CH3xjNt5+aRQBfetNKlkyKZgfoXqb+hKw10ra/NxiduBoVzFC4svs
         Onw3fiqBIPsUxUOK4BypOCQrQ2RvddnGOFSS1u5t10t7xk8TggxyQ+nKMM2Hy9R/dDgP
         fMkD72nk+1Iq3Z6zIhkn67CvBM0Ri0u5+lk7dRTSL6usUtroEUmeoXuieV2wtPEc7sVJ
         zLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z/tJIhPKk9xVTFmrQGmkiQ3IE2AQakipcgT5sAtq97w=;
        b=TqbjRS3L417fHII9eDmU+6Fej1A6e+hwtnVp/udySgvPnX1m7Lo4N1APJvdQa9NbvF
         NTb9K+6IjlnxsLvjVd6ONdgdsbLLC/PeytLBOIA3xWJWQWdsRwWrD5U4pslrEM5zA9hk
         FgGVkFGbC+GG/pVobHnTjOqiQyb0DteoZWFjCbNpT9UQ2OMK6DTjgQtCHA6ld0bznJu2
         Da8aRDyrWF5BuLIHAvP0S6iH0ksE1Uw6lTTIOnvPmqRGBbhKlappy0i7FBhm9uwdKJni
         KvRhv84QSxgrN5MR+FxbHJy0WCF2EBMs1UR6WM9IsSauCpBP4tH8mtwhwqkozWsHlsVU
         OfAQ==
X-Gm-Message-State: ALyK8tJE2zZ16Xll3fUEibmr4GUxBRYqxaLouNw7Q6v6AWLk+kvUCzTNctATDEV3dHp9cg==
X-Received: by 10.66.157.193 with SMTP id wo1mr19052351pab.116.1465141213865;
        Sun, 05 Jun 2016 08:40:13 -0700 (PDT)
Received: from localhost.localdomain ([182.67.205.35])
        by smtp.gmail.com with ESMTPSA id p1sm21307814pfb.73.2016.06.05.08.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jun 2016 08:40:13 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296474>

Add a new configuratation variable "log.showSignature" for git-log and
related commands. This variable will enable user to see GPG signature
by default.

[Patch 1/2] 
	Introduce the config variable along with some tests.

[Patch 2/2] 
	Tackles the problem: what if user wants to disable the
	setting of "log.showSignature=true" using a command line
	switch.

* Thanks Junio, Jeff and Remi for helping in reference patch.

Previous reference patch: http://thread.gmane.org/gmane.comp.version-control.git/295649

Mehul Jain (2):
  log: add "log.showsignature" configuration variable
  log: "--no-show-signature" commmand-line option

 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 revision.c                |  2 ++
 t/t4202-log.sh            | 25 +++++++++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 5 files changed, 44 insertions(+)

-- 
2.9.0.rc0.dirty
