From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 0/4] Branch deletion testing and bug fixes
Date: Sat, 23 Aug 2008 08:45:43 +1000
Message-ID: <1219445147-6801-1-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 00:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfPN-0000Gz-5u
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYHVWp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbYHVWp5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:45:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:27720 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYHVWp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:45:56 -0400
Received: by wa-out-1112.google.com with SMTP id j37so232331waf.23
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:sender;
        bh=CYO6Yw9Cf/sL2bc0SAWfCVT2JG4zMgsR39NX1LRNSm8=;
        b=eIe6GdWA/jKGBzFJeLQ4+Z/f+x2HSoa7sZlHZ1tiXP1cenWb2GYnlcF9S25Y7HRFvu
         UNklMnDTlIhJf2WVXxTyNWTw/UoSlCbkZQejBKoBrxzA9y3OCf5zu8GgE6nuyM8seInn
         DE4HlaycbaOanBHPYG1e7rQZM+MV268tGb86Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:sender;
        b=IMIwI4ashInyNlBS+WQJjkfAeP+GyP8SRjHdwPUt5LEmN7HHnFNNwtJz80pIVSTFGn
         l5NeYUOI22CwYE/3pi1TyNJm3QDS1JTxgBBLpo3pgZv0VXzyjHzcQAsXlpG6MvgrdxCH
         x+OnND0uFEQX7l7XnOkl+KIVENEpzfMru4DGw=
Received: by 10.115.18.1 with SMTP id v1mr1634503wai.81.1219445156582;
        Fri, 22 Aug 2008 15:45:56 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id q18sm3549776pog.13.2008.08.22.15.45.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 15:45:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.49.gea35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93385>

Added a few tests for the RefUpdate delete method, which in turn
exposed two minor bugs. Previously you couldn't delete a ref
pointing to the current branch. Fixing that would also then allow
the current branch to be deleted too.

*** BLURB HERE ***

Charles O'Farrell (4):
  Ensured that RefUpdate cannot delete current branch
  Fixed bug where RefUpdate didn't delete identical HEAD branch
  Added test for RefUpdate branch deletion
  Added extra javadoc for delete to significant RefUpdate results

 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  106 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   30 ++++--
 2 files changed, 127 insertions(+), 9 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
