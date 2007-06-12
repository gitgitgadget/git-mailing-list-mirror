From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Mail after commit
Date: Tue, 12 Jun 2007 17:32:14 +0200
Message-ID: <466EBC7E.8040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 17:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy8Nv-0006N3-Sd
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 17:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbXFLPeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbXFLPeS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 11:34:18 -0400
Received: from ms01.sssup.it ([193.205.80.99]:34858 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754067AbXFLPeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 11:34:17 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2007 11:34:08 EDT
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 31101118 for git@vger.kernel.org; Tue, 12 Jun 2007 17:24:27 +0200
Received: from [10.30.3.110] (chrome.retis [10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l5CETe8p016505
	for <git@vger.kernel.org>; Tue, 12 Jun 2007 16:29:40 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070306)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49967>

Hi all.

To have an email sent after every commit, I've put the following command in 
.git/hooks/post-commit:

rm -f /tmp/git-commit.patch ; git-format-patch --stdout -s `git log 
--pretty=oneline | awk '{print $1}' | sed -n '2p'` > /tmp/git-commit.patch ; 
git-send-email --no-signed-off-by-cc  --to XXX --from YYY /tmp/git-commit.patch 
; rm -f /tmp/git-commit.patch

and it works, indeed.

However, it's quite tricky.

Doesn't exist any way to make it simpler ?

Regards,

          Claudio
