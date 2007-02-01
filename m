From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [ANNOUNCE] GIT 1.5.0-rc3
Date: Thu, 1 Feb 2007 21:34:40 +0100
Organization: Dewire
Message-ID: <200702012134.40933.robin.rosenberg.lists@dewire.com>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCidB-0008NG-KX
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbXBAUeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbXBAUeA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:34:00 -0500
Received: from [83.140.172.130] ([83.140.172.130]:27643 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1422997AbXBAUeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:34:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E8985803392;
	Thu,  1 Feb 2007 21:29:17 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19445-03; Thu,  1 Feb 2007 21:29:17 +0100 (CET)
Received: from [10.9.0.10] (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 994B2802640;
	Thu,  1 Feb 2007 21:29:15 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38394>

torsdag 01 februari 2007 01:26 skrev Junio C Hamano:
> Junio C Hamano (43):
>   t9200: Re-code non-ascii path test in UTF-8

I sent a patch that converts to "visible" characters when looked
at with iso-8859-1/windows-1252 googles. It also tests the file system before 
executing the test. 

>   t9200: do not test -x bit if the filesystem does not support it.

The description is misleading. Git on cygwin chooses to ignore the executable 
flag by default, not because the filesystem won't handle it, but rather that 
enough many *other* applications sets it needlessly, that ignoring it becomes 
less problematic than honouring it.

Adding "git config core.filemode true" at the start of this test verifiies 
that it works on NTFS too. 

-- robin
