From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 03 Mar 2009 12:48:02 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903031246420.3702@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
 <200903021530.01165.trast@student.ethz.ch>
 <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
 <37fcd2780903030147q7062ee47w7ce524c28a6aa347@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeT8x-0008BO-3x
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbZCCLtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZCCLtK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:49:10 -0500
Received: from smtp.getmail.no ([84.208.20.33]:46234 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbZCCLtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:49:09 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFX00201I5VKJ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:49:07 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX00MWSI42H600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:48:02 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX00KKLI42AOA0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:48:02 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 23EBD189B20; Tue,
 03 Mar 2009 12:48:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 20F8B1A97FE; Tue, 03 Mar 2009 12:48:02 +0100 (CET)
In-reply-to: <37fcd2780903030147q7062ee47w7ce524c28a6aa347@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112059>

Dmitry Potapov:

> The C Standard requires that the type wchar_t is capable of representing 
> any character in the current locale. If Windows uses UTF-16 as internal 
> encoding (so, it can work with symbols outside of the BMP), it means you 
> cannot have 16-bit wchar_t and be compliant with the C standard...

No, that's not quite correct. wchar_t is defined to be "an integer type whose 
range of values can represent distinct codes for all members of 
the largest extended character set specified among the supported locales". 
Since Windows defines all local character sets as Unicode-based, having 
wchar_t defined as Unicode means that it can represent everything.

-- 
\\// Peter - http://www.softwolves.pp.se/
