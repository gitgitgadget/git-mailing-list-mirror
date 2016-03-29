From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 0/5] modify tests for --[no-]autostash option
Date: Tue, 29 Mar 2016 18:59:55 +0530
Message-ID: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:30:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktjS-0004mf-3x
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487AbcC2Nav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:30:51 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33748 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbcC2Nat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:30:49 -0400
Received: by mail-pa0-f68.google.com with SMTP id q6so2151846pav.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/Q97gYi7K3EXB1cDxThAJafVQYy1tVfbH8DJy0kPCq4=;
        b=Ysc0LT49z+lCzLDxC/Fr0rSXsRZDAJObULbY/xFeYsKNpbdCF2Bq7NOD1ZB+CH9+uC
         A+DpVyTcQP67xyY298WAgguICQzN1DFQX6QR10/kaTD+XWtN1iiLfpkbJT5EJaA0tCWI
         juuFcBcoxD37uDxIr5+a99sZvQ6PM6x5aapTB8EIpFjIi0qn32rcxTBR+XHfMwnHedWP
         WaSFVVZXx1mMhkRAvP8tXe9zIzKuH+o8rIdZ0So/AAg1cSGxdtMk6PY4Xj/ccAyUeu3e
         i9BzcfR8eTyiizaOlEjtS/s7PMysR3LEwKff7X+P7NzCVnP+dWvzA6vRLZAHAfCm34Xc
         DiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Q97gYi7K3EXB1cDxThAJafVQYy1tVfbH8DJy0kPCq4=;
        b=KDaefcZWmrA7gX2M4S2cv5t+omvUyt6+TdRbbh4TuqtqAV0avPpT+J3pjcE9ews0xV
         nwcgNng9enh7Kr4xhWWGWN3vY/HJp6iJhmXjG4nCmM+LrRQayM+8ZuRX0STlf+Oj38K1
         pn5Jz+O7fESw+5xVTIBAvDWJVHQvTvzgf2ZVtSV2BFAazYrgG2HifOIz4M9eVW9hjAT+
         jN3NdPi/ulAgFVVUitmAo2dD3Csy06LDU0Dmp4q098Za1E0i++PZCDN9TAe6JgwummGp
         vqubyEMRdm9pU0rUfxDPnLVkSsAtkPr06c24qfMY45lu18B1RfLEaWPu4opDt11RNy4+
         qS1Q==
X-Gm-Message-State: AD7BkJIBBcxlYxl3ENPMG5EFlmdlthSCnOzAlQ2Jry/ujJtZuXgeFL0gM9C+OwWphJNydg==
X-Received: by 10.66.147.74 with SMTP id ti10mr3533891pab.128.1459258248355;
        Tue, 29 Mar 2016 06:30:48 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.29])
        by smtp.gmail.com with ESMTPSA id s66sm43430514pfi.3.2016.03.29.06.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 06:30:47 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290134>

The following patch series is applicable on mj/pull-rebase-autostash.

This series contain changes suggested by Eric and Matthieu on following
series

        http://thread.gmane.org/gmane.comp.version-control.git/289434

Changes made:
        * [Patch 4/5] reduces the code needed to test possible
          combinations of --autostash and rebase.autostash by introducing
          two functions.

          Also introduce a loop to tackle the repetitive code used to
          test the usage of --[no-]autostash without --rebase.

        * [Patch 5/5] introduces two new tests to check the cases when
          "git pull --[no-]autostash" is called with pull.rebase=true.


Mehul Jain (5):
  t/t5520: change rebase.autoStash to rebase.autostash
  t/t5520: explicitly unset rebase.autostash
  t/t5520: use test_i18ngrep instead of test_cmp
  t/t5520: modify tests to reduce common code
  t/t5520: test --[no-]autostash with pull.rebase=true

 t/t5520-pull.sh | 120 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

-- 
2.7.1.340.g69eb491.dirty
