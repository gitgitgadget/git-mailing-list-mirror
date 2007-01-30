From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: t9200-git-cvsexportcommit #8 failure on OS X
Date: Tue, 30 Jan 2007 23:20:00 +0100
Organization: Dewire
Message-ID: <200701302320.02187.robin.rosenberg.lists@dewire.com>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 23:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC1Kz-0005no-Ei
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 23:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbXA3WT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbXA3WT2
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 17:19:28 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11077 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbXA3WT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 17:19:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 893E8803392;
	Tue, 30 Jan 2007 23:14:45 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05661-03; Tue, 30 Jan 2007 23:14:45 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3C46E80338F;
	Tue, 30 Jan 2007 23:14:43 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <20070130163219.GA14431@164.242.249.10.in-addr.arpa>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38209>

tisdag 30 januari 2007 17:32 skrev Brian Gernhardt:
[...]
> mkdir: ?: Invalid argument
>
> It looks like one of the odd characters that git's using for the test is
> an invalid character for HFS+, so the entire test fails.  Perhaps this
> should be made a "soft" failure like all of the SVN tests passing
> despite me not having SVN installed, or should a different character be
> used somewhere?  Git can't possibly be expected to work in a situation
> where the FS fails.

My fault. The problem is that the data is ISO-8859-1, which is invalid
when interpreted as UTF-8.  Another user reported the same problem in cygwin 
on a Korean Windows. The byte sequences are illegal there too.

A number of solution could be concieved, like converting to the local encoding 
first, but that cannot be done beacuase I couldn't find any non-ascii 
characters that would be convertible into any (major) locale. 

Another is to ignore the test if these files cannot be created.

-- robin
