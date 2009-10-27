From: Joe Perches <joe@perches.com>
Subject: git vs hg commit counts?
Date: Mon, 26 Oct 2009 17:08:47 -0700
Message-ID: <1256602127.29938.8.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, mercurial@selenic.com,
	Marti Raudsepp <marti@juffo.org>
To: LKML <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Zcd-000372-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZJ0AIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 20:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbZJ0AIn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:08:43 -0400
Received: from mail.perches.com ([173.55.12.10]:1074 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbZJ0AIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 20:08:43 -0400
Received: from [192.168.1.152] (new-host-2.home [192.168.1.152])
	by mail.perches.com (Postfix) with ESMTP id B152C24368;
	Mon, 26 Oct 2009 16:08:43 -0800 (PST)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131289>

I'm comparing linux-kernel git vs hg repositories.

While testing some changes to scripts/get_maintainer.pl,
I noticed that git and hg have different commit counts
for the same files.

For instance:

$ git log --since=1-year-ago -- MAINTAINERS | \
	grep -P "^commit [0-9a-f]{40,40}$"  | wc -l
514

$ hg log --template="commit {node}\n" --date -365 -- MAINTAINERS  | \
	grep -P "^commit [0-9a-f]{40,40}$" | wc -l
601

Anyone have any understanding why?
