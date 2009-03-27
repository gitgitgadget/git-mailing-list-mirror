From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: patch series starting with [JGIT PATCH 1/5] Remove dead/unused reset method from CountingOutputStream
Date: Fri, 27 Mar 2009 09:11:54 +0100
Message-ID: <200903270911.54571.robin.rosenberg.lists@dewire.com>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 27 09:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln7C8-0003mG-Em
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 09:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbZC0IMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 04:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZC0IMG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 04:12:06 -0400
Received: from mail.dewire.com ([83.140.172.130]:28177 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbZC0IMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 04:12:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AC8AE1488964;
	Fri, 27 Mar 2009 09:11:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKhTpR8xJqMN; Fri, 27 Mar 2009 09:11:55 +0100 (CET)
Received: from sleipner.localnet (sleipner.dewire.com [10.1.2.197])
	by dewire.com (Postfix) with ESMTP id 2B3961488963;
	Fri, 27 Mar 2009 09:11:55 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-14-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <1238030515-31768-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114871>


Seems fine. While verifying this I got this error.

jgit push sftp://me@calhost/home/me/tmp/cb/.git master:master

Counting objects:       20464
Compressing objects:    100% (20464/20464)
Writing objects:        100% (20464/20464)
fatal: Can't write /home/me/tmp/cb/.git/objects/../HEAD: Failure
fatal: sftp://me@localhost/home/me/tmp/cb/.git: cannot create HEAD

It seems the remote repo is OK and actually has handsome HEAD despite this.

More related, I also noted that the git:// ssh or file: clone calculates the CRC's separately
and wasn't subject to this bug.

-- robin
