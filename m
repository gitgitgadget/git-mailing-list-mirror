From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] clone tests: rename t57* => t56*
Date: Tue, 15 Mar 2016 14:25:50 -0700
Message-ID: <1458077150-15564-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 15 22:26:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwTn-0003PZ-0w
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbcCOV0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:26:10 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36243 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbcCOV0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:26:08 -0400
Received: by mail-pf0-f171.google.com with SMTP id u190so44505294pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AEb8MIubtn+95VRqpkbTv+/F7TxYZ5Umr9VnVogpY7U=;
        b=Ca0XummV/AzwIvBdegcthG7zs+01Zqja5lD3FE3SlwX6BtYt/BpFwy/uw9wg3Cpz9N
         Oavd+7crCYuafihPBzdkeCwegdpxQsyWjMuw/sB5bvTEYV15MTSJLg+y9Zjlsuf8TSHt
         Yyp5/Ybf1W3g+mZ5S7/gPXWM+w3NN33lwKj3L6AHoqGPBJs5wwR/bNFyalYGbAYlwXmQ
         jEIvS2zdDICTewQ11GgwFMQBovMXZOQbjYv/PDRVNXvf6ncnadvzHF73eqNvTMKuyRjO
         Hp65iRIYSJhdPuq7rtHBv4WE9p9Xze2/keW3lD7468Who5DTI1j4jWec1ktAYVTXd3em
         kWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AEb8MIubtn+95VRqpkbTv+/F7TxYZ5Umr9VnVogpY7U=;
        b=J0gC7GcATpzwYSXVhZu/j3JnoOQdstyalZNSz4BKu0OrO4awdJwEHRQwIrYDcyzlEQ
         dQUTOrySpnR1fVXsQtkMix+pAQlBF+Cc+D32PPEUw8+If2QJ7H9lQ96e+ZQoeDw2cWvQ
         UgPBuMK0umo2OSZuOTicD3Or+HmUbD7aVY/721YozclWQ9SiCKneXtqTZofcfhVns0H4
         tbExopIfHgQIMPlX8gtQxG5hfZnz/feEyqR+vLmTkIXBu70f8rMJow6+bJShwsQ0JN+k
         4yUGnjBQe1uZAYOf2CmNN1TRkGARE74qvsJVMcKJChPSL5pan557IGtzVbXGnys2iD/M
         6fng==
X-Gm-Message-State: AD7BkJJNIEK5VAHYnDNHknQUVgqYOdwJa51F0/MquYtNGw4uyIMFlC5Kq8kAK7cof64BuVtk
X-Received: by 10.66.102.104 with SMTP id fn8mr267717pab.129.1458077163622;
        Tue, 15 Mar 2016 14:26:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f8a9:c435:807a:de5e])
        by smtp.gmail.com with ESMTPSA id f66sm81983pff.8.2016.03.15.14.26.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 14:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.46.g8f16ed4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288916>

When trying to find a good spot for testing clone with submodules, I
got confused where to add a new test file. There are both tests in t560*
as well as t57* both testing the clone command. t/README claims the
second digit is to indicate the command, which is inconsistent to the
current naming structure.

Rename all t57* tests to be in t56* to follow the pattern of the digits
as laid out in t/README.

It would have been less work to rename t56* => t57* because there are less
files, but the tests in t56* look more basic and I assumed the higher the
last digits the more complicated niche details are tested, so with the patch
now it looks more in order to me.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

If there is a reason to have 2 separate spaces for clone testing,
and I missed it, we should document that why it is important to keep
them separate.

Thanks,
Stefan

 t/{t5700-clone-reference.sh => t5604-clone-reference.sh} | 0
 t/{t5701-clone-local.sh => t5605-clone-local.sh}         | 0
 t/{t5702-clone-options.sh => t5606-clone-options.sh}     | 0
 t/{t5704-bundle.sh => t5607-clone-bundle.sh}             | 0
 t/{t5705-clone-2gb.sh => t5608-clone-2gb.sh}             | 0
 t/{t5706-clone-branch.sh => t5609-clone-branch.sh}       | 0
 t/{t5707-clone-detached.sh => t5610-clone-detached.sh}   | 0
 t/{t5708-clone-config.sh => t5611-clone-config.sh}       | 0
 t/{t5709-clone-refspec.sh => t5612-clone-refspec.sh}     | 0
 t/{t5710-info-alternate.sh => t5613-info-alternate.sh}   | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t5700-clone-reference.sh => t5604-clone-reference.sh} (100%)
 rename t/{t5701-clone-local.sh => t5605-clone-local.sh} (100%)
 rename t/{t5702-clone-options.sh => t5606-clone-options.sh} (100%)
 rename t/{t5704-bundle.sh => t5607-clone-bundle.sh} (100%)
 rename t/{t5705-clone-2gb.sh => t5608-clone-2gb.sh} (100%)
 rename t/{t5706-clone-branch.sh => t5609-clone-branch.sh} (100%)
 rename t/{t5707-clone-detached.sh => t5610-clone-detached.sh} (100%)
 rename t/{t5708-clone-config.sh => t5611-clone-config.sh} (100%)
 rename t/{t5709-clone-refspec.sh => t5612-clone-refspec.sh} (100%)
 rename t/{t5710-info-alternate.sh => t5613-info-alternate.sh} (100%)

diff --git a/t/t5700-clone-reference.sh b/t/t5604-clone-reference.sh
similarity index 100%
rename from t/t5700-clone-reference.sh
rename to t/t5604-clone-reference.sh
diff --git a/t/t5701-clone-local.sh b/t/t5605-clone-local.sh
similarity index 100%
rename from t/t5701-clone-local.sh
rename to t/t5605-clone-local.sh
diff --git a/t/t5702-clone-options.sh b/t/t5606-clone-options.sh
similarity index 100%
rename from t/t5702-clone-options.sh
rename to t/t5606-clone-options.sh
diff --git a/t/t5704-bundle.sh b/t/t5607-clone-bundle.sh
similarity index 100%
rename from t/t5704-bundle.sh
rename to t/t5607-clone-bundle.sh
diff --git a/t/t5705-clone-2gb.sh b/t/t5608-clone-2gb.sh
similarity index 100%
rename from t/t5705-clone-2gb.sh
rename to t/t5608-clone-2gb.sh
diff --git a/t/t5706-clone-branch.sh b/t/t5609-clone-branch.sh
similarity index 100%
rename from t/t5706-clone-branch.sh
rename to t/t5609-clone-branch.sh
diff --git a/t/t5707-clone-detached.sh b/t/t5610-clone-detached.sh
similarity index 100%
rename from t/t5707-clone-detached.sh
rename to t/t5610-clone-detached.sh
diff --git a/t/t5708-clone-config.sh b/t/t5611-clone-config.sh
similarity index 100%
rename from t/t5708-clone-config.sh
rename to t/t5611-clone-config.sh
diff --git a/t/t5709-clone-refspec.sh b/t/t5612-clone-refspec.sh
similarity index 100%
rename from t/t5709-clone-refspec.sh
rename to t/t5612-clone-refspec.sh
diff --git a/t/t5710-info-alternate.sh b/t/t5613-info-alternate.sh
similarity index 100%
rename from t/t5710-info-alternate.sh
rename to t/t5613-info-alternate.sh
-- 
2.7.0.rc0.46.g8f16ed4.dirty
