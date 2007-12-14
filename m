From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/2] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 20:32:15 +0100
Message-ID: <20071214193216.13C795A873@dx.sixt.local>
References: <1197660157-24109-1-git-send-email-krh@redhat.com> <1197660157-24109-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Kristian =?ISO-8859-15?Q?H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 20:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GK1-0004vB-QC
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759605AbXLNTcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764886AbXLNTcU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:32:20 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:47334 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763425AbXLNTcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 14:32:18 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 486EC13A755;
	Fri, 14 Dec 2007 20:32:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 13C795A873;
	Fri, 14 Dec 2007 20:32:16 +0100 (CET)
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68331>

Kristian H=F8gsberg wrote:

> When we commit or roll back the lock file the fd is automatically clo=
sed,
> so don't do that again.  Also, just keep the lock on the stack.

IIRC, locks are accessed from atexit(), e.g. during a die(). So you mus=
t not
put one on the stack.

-- Hannes
