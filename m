From: linux@horizon.com
Subject: git-fetch will leave a ref pointing to a tag
Date: 2 Jul 2007 15:44:37 -0400
Message-ID: <20070702194437.19202.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 21:44:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5RpB-0001CQ-SQ
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 21:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbXGBToj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 15:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbXGBToj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 15:44:39 -0400
Received: from science.horizon.com ([192.35.100.1]:17918 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753437AbXGBToj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 15:44:39 -0400
Received: (qmail 19203 invoked by uid 1000); 2 Jul 2007 15:44:37 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51396>

I did this while trying to force a fast-forward merge (I wanted an
error message if I had changes to merge), and got a somewhat obscure
error message:

$ git branch temp tags/v2.6.22-rc6
$ git fetch . tags/v2.6.22-rc7:temp
$ git checkout temp
$ (make minor change)
$ git commit -a
fatal: 087ea061253277de2b27e82d8572a386835a1b7e is not a valid 'commit' object

git-fetch does odd things when handed a tag rather than a commit.
Also, should "git checkout" have complained?
