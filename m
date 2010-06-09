From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Misterious warning about file system boundaries
Date: Wed, 09 Jun 2010 22:21:13 +0200
Message-ID: <4C0FF7B9.8040007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:21:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMRly-0003T8-3H
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0FIUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:21:07 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:43619 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753064Ab0FIUVG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 16:21:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 402B0F80DF;
	Wed,  9 Jun 2010 16:21:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 09 Jun 2010 16:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:content-type:content-transfer-encoding; s=smtpout; bh=1qw5RN6gWFigWGqDYeG8jVQbpJg=; b=dShZ0ALZtMSxJTKo67EH63wONqUMhg+V29d+WTfFJ2fuOfsGTH1rfoL1ngWincibZxsIrJVB192i9ri3npzQqmw5Fkgwkwr4vMYHAusUvxRWg0InZS16ih1LjhC/InBkRVR634gftedE5NB/hFHNpBOCTIBPGb2hljgSDYl0urE=
X-Sasl-enc: BGyOZATI5XuTXB29k9X1CdW9WGbwYMJcVCjbehHRzlVJ 1276114863
Received: from localhost.localdomain (p54859B40.dip0.t-ipconnect.de [84.133.155.64])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 31C9249B029;
	Wed,  9 Jun 2010 16:21:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148809>

Heya,

now what is going on here? After upgrading to current next I get

warning: working tree spans across filesystems but
GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.

in several repos, such as my local git.git repo. That is certainly on a
single file system only (ext4 over lvm over luks, all on one partition,
Fedora 13). I also get this for another repo, but not for every repo. It
goes away when I set the var and comes back when I don't set it, of course.

Although I haven't bisected this should be due to
52b98a7 (write-index: check and warn when worktree crosses a filesystem
boundary, 2010-04-04).

How does the code detect a file system boundary, and where could it go
wrong?

Michael
