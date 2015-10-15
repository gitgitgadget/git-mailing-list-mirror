From: Lars Schneider <larsxschneider@gmail.com>
Subject: [BUG] t7063-status-untracked-cache flaky?
Date: Thu, 15 Oct 2015 09:52:18 +0200
Message-ID: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: pclouds@gmail.com, dturner@twopensource.com
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdKs-0002z2-A5
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 09:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbbJOHwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 03:52:22 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36981 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbbJOHwW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Oct 2015 03:52:22 -0400
Received: by wijq8 with SMTP id q8so116595077wij.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=KtBxn+mWaUfI7ZDxOnyUJlAoBFdAUGPK9IqWBUo6EIg=;
        b=t4Il3j23YNyPQqqZEgdXpvRZqD0HuSBSka4M8DDr0jjB2RYJ2YulUjIo20Vj2/TJDb
         eN/VD9nXTwlpsGqS5hqo2yIPstISjmOxIayRpm2F2qw8buzwHOUGHo+jzShMoqhTH/sV
         5hwJP8SkMYalDQX5GDtlO93TAJq7kyOPyOwidWF6gjCI3OCFgwzGuCtEVtzWI6EEnqoN
         0qQJEck50tWAe6nAg0We5cQ3JnwcmrJ5ZNmZYlU7aFPZXPl4qpcZ46INa4F8TT39NQv2
         QhoJSXXGdEf55FZt4VwtSwr08SKh/9f6rlkFuStAt4DUV0ZiT68oNbBn5NJl5+votPcw
         HAjQ==
X-Received: by 10.180.108.44 with SMTP id hh12mr8774126wib.57.1444895540765;
        Thu, 15 Oct 2015 00:52:20 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5503.dip0.t-ipconnect.de. [93.219.85.3])
        by smtp.gmail.com with ESMTPSA id az6sm22473330wib.12.2015.10.15.00.52.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 00:52:20 -0700 (PDT)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279647>

Hi,

I noticed that "t7063-status-untracked-cache.sh" occasionally fails with "not ok 24 - test sparse status with untracked cache".

E.g. on OS X compiled with gcc:
https://travis-ci.org/larsxschneider/git/jobs/85432514

E.g. on Linux compiled with gcc:
https://travis-ci.org/larsxschneider/git/jobs/84986975

The test was added with commit 7687252. I have not really investigated the problem yet but the "avoid_racy" method caught my attention. Is this test known to be flaky? Would an increased sleep time in "avoid_racy" help?

Thanks,
Lars