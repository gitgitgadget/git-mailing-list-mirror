From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: update-cache ./test.c
Date: Sun, 1 May 2005 10:41:45 +0200
Message-ID: <20050501084145.GA30692@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 10:36:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS9vh-00066Q-9w
	for gcvg-git@gmane.org; Sun, 01 May 2005 10:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVEAIls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 04:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEAIls
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 04:41:48 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:13783 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261551AbVEAIlq
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 May 2005 04:41:46 -0400
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id D0F3C2B0EC; Sun,  1 May 2005 10:41:45 +0200 (MEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

update-cache seems to ignore paths containing path components
starting with a dot:

	pi% update-cache --add ./test.c
	Ignoring path ./test.c
	pi% update-cache --add test.c
	pi%

This is slightly annoying as 'find -type f | xargs update-cache --add'
doesn't work because of this.  ('find * -type f | ...` does.)  Instead
of ignoring the file, can we just strip off the leading "./" ?


--L
