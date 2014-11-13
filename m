From: Olaf Hering <olaf@aepfle.de>
Subject: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 12:14:44 +0100
Message-ID: <20141113111444.GA15503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 12:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosSM-0007nA-MP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbaKMLUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:20:50 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:17848 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbaKMLUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:20:48 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Nov 2014 06:20:47 EST
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415877646; l=1076;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=/hm2BcVd4b+1IzcnCHfbeQvEH38=;
	b=d9HaGxL+6bS9qeUAStd2h5kJ3Q/lCEId+2cCJfaBTJ6kMxegi1/tbmHxL6OGchIwWi8
	UdOKQNJiwXrE9Kg+HcynQToBdN+QesUZ7STlJJsH0y3HLNBhJBAe+n1f14IXYmF3YzMBY
	Chs6ZTieijLrFpqza9LxHORfpZn8MmwNhmI=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id D03ec2qADBEijxy
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Thu, 13 Nov 2014 12:14:44 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 6F25550172; Thu, 13 Nov 2014 12:14:44 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


How can I reduce the disk usage for multiple copies of the same repo?

Up to now I just made copies like this, but since .git alone is already
2GB it becomes expensive:

 # git clone git://host/repo.git repo-master
 # cp -a repo-master repo-branchA
 # cd repo-branchA
 # git checkout -b branchA origin/branchA
 # cd -
 # cp -a repo-master repo-branchB
 # cd repo-branchB
 # git checkout -b branchB origin/branchB
 # cd -
 # cp -a repo-master repo-branchB-feature
 # cd repo-branchB-feature
 # git checkout -b branchB-feature origin/branchB
 # cd -


Since each .git is almost identical I wonder if there is a reliable way
to "share" it. The "git clone" man page mentions --shared as a dangerous
way to do things. It does not give an advice how to manage such cloned
trees.

So how can I reduce the disk usage needed for the four .git dirs above?
I looked around in the docs that came with my git-2.1.3 package, but
found nothing that answers my question. Maybe we can workout something
and add it to one of the existing docs.

Thanks!

Olaf
