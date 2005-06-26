From: Jeff Garzik <jgarzik@pobox.com>
Subject: 'dotest' script broken
Date: Sun, 26 Jun 2005 17:43:03 -0400
Message-ID: <42BF2167.9030404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 26 23:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmend-0003YU-TJ
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 23:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFZVnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 17:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVFZVnJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 17:43:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53964 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261600AbVFZVnG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 17:43:06 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dmeu9-0006xD-Fg; Sun, 26 Jun 2005 21:43:05 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


When I run 'dotest /g/tmp/mbox' I receive an error message

	[jgarzik@pretzel netdev-2.6]$ dotest /g/tmp/mbox
	mailinfo msg-file path-file filelist-file < email

and if you look at the dotest script, it only passes 2 args to mailinfo, 
not the 3 args that the above usage message appears to require:

for i in .dotest/*
do
         mailinfo .dotest/msg .dotest/patch < $i > .dotest/info || exit 1
	...
