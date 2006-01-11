From: Andreas Ericsson <ae@op5.se>
Subject: Re: git binary size...
Date: Wed, 11 Jan 2006 20:54:32 +0100
Message-ID: <43C56278.6090105@op5.se>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org> <43C558FB.3030102@op5.se> <43C55EE4.9010103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:55:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewm3J-0008Oe-Dq
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWAKTyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWAKTye
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:54:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:18080 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932242AbWAKTye
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:54:34 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 19AB16BD03; Wed, 11 Jan 2006 20:54:33 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43C55EE4.9010103@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14506>

H. Peter Anvin wrote:
> 
> I disagree with both of these.  Most users will not install via "make 
> install", but rather via a package manager.  Package managers have long 
> since dealt with this problem; in the case of rpm, the debug information 
> is stripped off into a separate package.  Having "make install" strip 
> would break that -- although defining $(STRIP) makes it a bit easier to 
> deal with (STRIP=: make install).
> 

Fair point. So how about a strip: target for just stripping the binaries 
in the directory? That way one can do "make strip install", but 
everything else will work as always. Better yet, make it

strip:
	strip $(STRIP_OPTS) $(PROGRAMS)

so Linus can set STRIP_OPTS=--strip-debug and everybody's happy.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
