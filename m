From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git binary size...
Date: Wed, 11 Jan 2006 11:39:16 -0800
Message-ID: <43C55EE4.9010103@zytor.com>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org> <43C558FB.3030102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewlos-0002qw-26
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWAKTjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWAKTjj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:39:39 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55773 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932460AbWAKTji
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:39:38 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0BJdLER003385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2006 11:39:21 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C558FB.3030102@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14503>

Andreas Ericsson wrote:
> 
> I'd suggest adding
> 
> strip:
>     strip $(PROGRAMS)
> 
> install: strip
> 
> to Makefile instead. That way people working on various git-tools won't 
> have to remember to override the CFLAGS when debugging new stuff.
> 

I disagree with both of these.  Most users will not install via "make 
install", but rather via a package manager.  Package managers have long 
since dealt with this problem; in the case of rpm, the debug information 
is stripped off into a separate package.  Having "make install" strip 
would break that -- although defining $(STRIP) makes it a bit easier to 
deal with (STRIP=: make install).

However, if the concern is "the average user" I really think there is no 
reason do bother with this at all -- the average user should to "yum 
install git" or whatever is the equivalent for their distribution.  This 
ain't 1990.

	-hpa
