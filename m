From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 14:57:51 +0200
Message-ID: <200707241457.53414.robin.rosenberg.lists@dewire.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707241134.31950.robin.rosenberg.lists@dewire.com> <7v8x96glca.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:56:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDJwT-0008JN-GZ
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 14:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbXGXM4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 08:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbXGXM4m
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 08:56:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10086 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbXGXM4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 08:56:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 75D1D8026EE;
	Tue, 24 Jul 2007 14:49:25 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27134-10; Tue, 24 Jul 2007 14:49:25 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 21CD28026C7;
	Tue, 24 Jul 2007 14:49:25 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8x96glca.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53582>

tisdag 24 juli 2007 skrev Junio C Hamano:
> > Here CVS sleeps. The amount varies between invocations since it
> > only sleeps enough for the seconds to wrap.
> 
> Makes one wonder what it would do if you are on a filesystem
> with coarser-than-a-second timestamp resolution.

Like fat, but then the last test fails on FAT, which wasn't the case. Any other reasonable file
systems that comes to your mind?

Jason, could you provide us with some more information on OS, fs, cvs version etc.

Whether timestamp granularity is larger than a second or not can be checked with this line, I think:

	touch a && ls --full-time a && sleep 1 && touch a && ls --full-time a

Sample output where the timestamps are roughly one second apart.
-rw-r--r-- 1 me me 0 2007-07-24 14:15:47.330927250 +0200 a
-rw-r--r-- 1 me me 0 2007-07-24 14:15:48.338990250 +0200 a

-- robin
