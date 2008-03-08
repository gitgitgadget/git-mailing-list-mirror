From: Iustin Pop <iusty@k1024.org>
Subject: Improve git pull --quiet behaviour
Date: Sun,  9 Mar 2008 00:52:34 +0100
Message-ID: <1205020356-6682-1-git-send-email-iusty@k1024.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 00:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8qv-0005gC-8D
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbYCHXwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYCHXwm
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:52:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:13139 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYCHXwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:52:42 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1247747fga.17
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 15:52:40 -0800 (PST)
Received: by 10.82.138.6 with SMTP id l6mr7844871bud.35.1205020360131;
        Sat, 08 Mar 2008 15:52:40 -0800 (PST)
Received: from teal.hq.k1024.org ( [84.75.117.152])
        by mx.google.com with ESMTPS id y37sm8197106mug.19.2008.03.08.15.52.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 15:52:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by teal.hq.k1024.org (Postfix) with ESMTP id B924E40A112
	for <git@vger.kernel.org>; Sun,  9 Mar 2008 00:52:36 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76624>

While trying to cleanup some cron jobs that do "git pull", I found out
that "-q" doesn't behave as expected. The following two small patches
improve the handling of this option.

My tests show that now 'git pull -q' when there are no changes is silent
as expected and plain 'git pull' has the previous behaviour. I hope that
I followed the code style correctly while modifying the files.

Overall diff stats:
 Documentation/git-merge.txt     |    2 +-
 Documentation/merge-options.txt |    4 ++++
 git-merge.sh                    |   19 +++++++++++++------
 git-pull.sh                     |    8 +++++---
 4 files changed, 23 insertions(+), 10 deletions(-)

regards,
iustin
