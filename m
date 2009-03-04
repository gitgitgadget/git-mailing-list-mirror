From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Wed, 04 Mar 2009 11:51:15 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903041149250.8926@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
 <200903021530.01165.trast@student.ethz.ch>
 <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
 <37fcd2780903030147q7062ee47w7ce524c28a6aa347@mail.gmail.com>
 <alpine.DEB.2.00.0903031246420.3702@perkele.intern.softwolves.pp.se>
 <37fcd2780903030913q4ee0e5d0t45dc3b124285f748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:54:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Leojh-0003oS-8f
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbZCDKwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZCDKwd
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:52:33 -0500
Received: from smtp.getmail.no ([84.208.20.33]:56298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbZCDKwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:52:32 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFZ00817A7HC600@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 11:52:29 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFZ000XRA5JXPB0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 11:51:19 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFZ005AMA5IZ230@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 11:51:19 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 242DF189B20; Wed,
 04 Mar 2009 11:51:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 2026E1A97FE; Wed, 04 Mar 2009 11:51:15 +0100 (CET)
In-reply-to: <37fcd2780903030913q4ee0e5d0t45dc3b124285f748@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112203>

Dmitry Potapov:

> No, it does not, if you have wchar_t that is only 16-bit wide, because 
> characters outside of the BMP have integer values in Unicode greater than 
> 65535...

UTF-16 allows you to reference all of Unicode (i.e up to U+10FFFF) using 
surrogate pairs. That means that not all characters can be represented as a 
single wchar_t, that is true. The problem with changing wchar_t is that it 
was defined to use 16-bit values at a time where Unicode was defined to use 
16-bit code points (but they soon figured out that was not enough).

Anyway, this is getting off-topic. Please feel free reply in private.

-- 
\\// Peter - http://www.softwolves.pp.se/
