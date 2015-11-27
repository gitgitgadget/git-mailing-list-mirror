From: larsxschneider@gmail.com
Subject: [PATCH v1 0/2] test-must-fail-sigpipe
Date: Fri, 27 Nov 2015 10:15:12 +0100
Message-ID: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 10:15:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2F7p-0003Hh-S6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 10:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbbK0JPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 04:15:23 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38019 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbbK0JPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 04:15:19 -0500
Received: by wmec201 with SMTP id c201so50174151wme.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ymIpiCM82Gh6qd3+O+SI96qakCoY5pfwo/ZG7Et7Euo=;
        b=y7vP6mbdMS0GNz41nZ2K/Y+NEUHhyYJ53u26CW0e9vtIYE/1UWmGdXQsPnDMr9vuCe
         +U+RQqX6EqcGvOgDnYwpwmZKY6golyYa4CtSVrhCgmKDe+RS0lrMV9f9gZMDadMCWbmD
         zNxTs48lC9yS7w65N7K5iEnT8LaUIMCtPQWhnJdsVHHQeBT+w/LUvdvM/lUPqSfXnJch
         MSP0PGvfMOId2u3m8swFj07qgW6iTtQfOl7NMeSGdMggcvI5Dr7oq8e40+nmIkuBM+36
         k8OMvKpHMv+n50KJB7Zw/UPo1u08NDjGcqSzi1k3Zaf1L2oU32SFE3/gG3tUU12wNSha
         +f+Q==
X-Received: by 10.28.23.136 with SMTP id 130mr9745151wmx.94.1448615718617;
        Fri, 27 Nov 2015 01:15:18 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB75CD.dip0.t-ipconnect.de. [93.219.117.205])
        by smtp.gmail.com with ESMTPSA id lf10sm18438731wjb.23.2015.11.27.01.15.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 01:15:17 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281768>

From: Lars Schneider <larsxschneider@gmail.com>

As suggested by Peff I made "test-must-fail-sigpipe" a seperate topic.

diff to (former) Travis CI v7 topic:
* added helper function "list_contains" provided by Peff (thanks!)
* fix return value in "test_must_fail: command succeeded" (thanks Ramsay)
* use "-eq" instead of "=" (thanks Ramsay)
* accept SIGPIPE exit for t5504 "push with receive.fsckobjects"

Thanks,
Lars

Lars Schneider (2):
  implement test_might_fail using a refactored test_must_fail
  add "ok=sigpipe" to test_must_fail and use it to fix flaky tests

 t/t5504-fetch-receive-strict.sh |  5 ++---
 t/t5516-fetch-push.sh           |  6 ++---
 t/test-lib-functions.sh         | 50 +++++++++++++++++++++++++++++------------
 3 files changed, 41 insertions(+), 20 deletions(-)

--
2.5.1
