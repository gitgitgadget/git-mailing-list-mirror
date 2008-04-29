From: Richard Purdie <rpurdie@rpsys.net>
Subject: Tracability in git commits
Date: Tue, 29 Apr 2008 13:55:39 +0100
Message-ID: <1209473739.5642.31.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 15:31:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqpvg-0004Aa-Pm
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 15:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbYD2Nan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 09:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbYD2Nan
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 09:30:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:41791 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607AbYD2Nam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 09:30:42 -0400
X-Greylist: delayed 2094 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2008 09:30:42 EDT
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id m3TCtl87008739
	for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:55:47 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 08605-04 for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:55:42 +0100 (BST)
Received: from [192.168.1.3] (dax.rpnet.com [192.168.1.3])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id m3TCtdHQ008728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:55:39 +0100
X-Mailer: Evolution 2.12.1 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80683>

Hi,

I've been wondering about whether its possible to provide some degree of
traceability of commits to a shared git repository. The potential
nightmare scenario is one developer making a commit pretending to be
someone else.

Assuming a shared server using something like gitosis each set of
commits is made under a certain ssh ID and what I'd like is to be able
to validate that against the commits so we could tell that commits A-D
were made by ID Z.

I see a repository as a linear progression of commits and merges.

The simplest security check would check each commit/merge on this linear
progression and make sure it matches the ssh ID. The problem is where
someone merges in some external tree, someone else pulls it and pushes
it, only fast forward merges are made and the ssh 'ID' no longer matches
the ID of the merge which is in the linear path.

Someone mentioned some patches that are on the mailing list atm and the
idea of never allowing fast forward merges. Would the "never" policy of
fast forward merges solve this problem? Is there a simpler way to
address this or are there problems I'm not seeing?

Regards,

Richard
