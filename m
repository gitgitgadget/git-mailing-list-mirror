From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: git log and --first-parent
Date: Tue, 24 Jul 2007 01:05:33 +0200
Message-ID: <200707240105.33729.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 01:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6x1-0006Ef-3a
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbXGWXEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXGWXEY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:04:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3404 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbXGWXEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:04:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9949F8026E0
	for <git@vger.kernel.org>; Tue, 24 Jul 2007 00:57:07 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20308-01 for <git@vger.kernel.org>; Tue, 24 Jul 2007 00:57:07 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 527B6802670
	for <git@vger.kernel.org>; Tue, 24 Jul 2007 00:57:07 +0200 (CEST)
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53499>


I'm puzzled over the behavior of --first-parent. The documentations seems to imply
that only the first parent is followed, but when a filter is applied it seems (just guessing)
that the "first" parent is selected *after* filtering, a behaviour that I feel does not match
the documentation.

Should the first-parent filter be applied first.

Example:

	git log --first-parent --pretty=format: --name-only v1.5.2|grep ^var.c|wc -l

counts four commits where var.c was changed, while

	git log --first-parent --pretty=format: --name-only v1.5.2 -- var.c |wc -l

gives me 23. 

-- robin
