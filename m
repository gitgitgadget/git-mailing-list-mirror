From: Kevin Ballard <kevin@sb.org>
Subject: [BUG] git fetch --prune --tags origin deletes all remote branches origin/*
Date: Wed, 25 Aug 2010 15:30:01 -0700
Message-ID: <84CF7907-4493-4110-A852-B949BAE0214C@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 00:30:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOTx-0006UU-K6
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab0HYWaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:30:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60532 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab0HYWaD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 18:30:03 -0400
Received: by pxi10 with SMTP id 10so386577pxi.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 15:30:03 -0700 (PDT)
Received: by 10.142.144.16 with SMTP id r16mr7519300wfd.113.1282775403230;
        Wed, 25 Aug 2010 15:30:03 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id t11sm2072597wfc.4.2010.08.25.15.30.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 15:30:02 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154489>

Running the simple command `git fetch --prune --tags origin` will delete every single remote branch refs/remotes/origin/*, with the sole exception of refs/remotes/origin/HEAD. This is wildly unexpected behavior. This was reproduced on the tip of the next branch, with version git version 1.7.2.2.440.g49ea7.

> git fetch --prune --tags origin
 x [deleted]         (none)     -> origin/ahaney/login_problem_debug
 x [deleted]         (none)     -> origin/ahaney/tocfixes
 x [deleted]         (none)     -> origin/develop
   (refs/remotes/origin/HEAD has become dangling)
 x [deleted]         (none)     -> origin/jon/contentupdates
 x [deleted]         (none)     -> origin/jon/ingest_safety
 x [deleted]         (none)     -> origin/jon/overview
 x [deleted]         (none)     -> origin/master
 x [deleted]         (none)     -> origin/v1_rejection/plan_a

> git fetch origin
From [redacted]
 * [new branch]      ahaney/login_problem_debug -> origin/ahaney/login_problem_debug
 * [new branch]      ahaney/tocfixes -> origin/ahaney/tocfixes
 * [new branch]      develop    -> origin/develop
 * [new branch]      jon/contentupdates -> origin/jon/contentupdates
 * [new branch]      jon/ingest_safety -> origin/jon/ingest_safety
 * [new branch]      jon/overview -> origin/jon/overview
 * [new branch]      master     -> origin/master
 * [new branch]      v1_rejection/plan_a -> origin/v1_rejection/plan_a

-Kevin Ballard