From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 17:32:37 +0100
Organization: Dewire
Message-ID: <200702211732.38268.robin.rosenberg.lists@dewire.com>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 17:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJuNH-0000C8-Lb
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 17:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbXBUQbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 11:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbXBUQbU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 11:31:20 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20060 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1030360AbXBUQbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 11:31:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DBA2A802651;
	Wed, 21 Feb 2007 17:26:19 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20829-08; Wed, 21 Feb 2007 17:26:19 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 7E487802640;
	Wed, 21 Feb 2007 17:26:17 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40300>

onsdag 21 februari 2007 01:56 skrev Linus Torvalds:
> 
> On Wed, 21 Feb 2007, Johannes Schindelin wrote:
> >
> > Um, I don't want to spoil the party, but was not the original idea of this 
> > auto-CRLF thing some sort of "emulation" of the CVS text checkout 
> > behaviour?
> > 
> > In that case, .gitattributes (I mean a tracked one) would be wrong, wrong, 
> > wrong.
> > 
> > It's a local setup if you want auto-CRLF or not. So, why not just make it 
> > a local setting (if in config or $GIT_DIR/info/gitattributes, I don't 
> > care) which shell patterns are to be transformed on input and/or output?
> 
> That is a good point. We *could* just make it a ".git/config" issue, which 
> has the nice benefit that you can just set up some user-wide rules rather 
> than making it be per-repo.
> 
> Of course, the config language may not be wonderful for this. But we could 
> certainly have something like
> 
> 	[format "crlf"]
> 		enable = true
> 		text = *.[ch]
> 		binary = *.jpg

The decision whether to mangel at all shoule be local. Which files to mangle, if mangle is "on",
should be a per version (not like CVS' setting for all versions). Otherwise it won't
be propagated properly on push/pull, and people *will* get it wrong over and over. 

It it's .gitattributes or similar it can be merged as any other file and conflicts can be resolved like
any other file. For efficiency you can have one .gitattributes.

Hopefully it won't happen often because autodetection is soo good, but when it get's 
wrong it's important that it can be fixed and distributed properly.

-- robin
