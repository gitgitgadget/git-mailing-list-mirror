From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in
 a non-bash shell
Date: Thu, 29 Jul 2010 22:29:36 +0100
Message-ID: <4C51F2C0.8090101@pileofstuff.org>
References: <4C50B005.1030004@pileofstuff.org> <7v4ofiuuf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	solsTiCe d'Hiver <solstice.dhiver@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 23:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oeag7-0001TP-99
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 23:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab0G2V37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 17:29:59 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:24974 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753391Ab0G2V37 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 17:29:59 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100729212947.TPVG3192.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Thu, 29 Jul 2010 22:29:47 +0100
Received: from [192.168.1.6] (really [80.6.134.127])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100729212947.WTFH1598.aamtaout03-winn.ispmail.ntl.com@[192.168.1.6]>;
          Thu, 29 Jul 2010 22:29:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <7v4ofiuuf7.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=3ENABmdyEd/Fm7fR7+mZIuMDn6+IErAeEhlfWBImZFk= c=1 sm=0 a=CVPIxC1EwrEA:10 a=8nJEP1OIZ-IA:10 a=jLEn85lTOr5PXNF6ARkA:9 a=99fgamdeKU6tsiZIKZoA:7 a=KBucLPJZgtlGXHMMdiCNlNTwWIgA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152200>

On 29/07/10 17:25, Junio C Hamano wrote:
> 
> I do agree that there need to be a way to find that information for the
> end users, especially for those who just use binary-packaged git given by
> their distros, but this codepath is _not_ the place to do it.
> 
> How about replacing these with something simple like:
> 
>     echo >&2 "You are not running full 'bash'; exiting." ; exit 127

I take your point that this is not the place to advertise the mailing
list, although I prefer to include instructions in error messages.
Would you be amenable in principle to creating something like `man
git-bug`?  A quick search doesn't turn up any documents specifically
about bug fixing/reporting, and a man page was the first place I thought
to look.  I'll happily withdraw this patch until I can have a crack at
such a page.

>> +	BASH_VERSION: {$BASH_VERSION}
>> +	BASHOPTS: {$BASHOPTS}
>> +	SHELLOPTS: {$SHELLOPTS}
>> +	POSIXLY_CORRECT: {$POSIXLY_CORRECT}
>> +EOF
>> +	echo -n "	command line: {"
>> +	tr '\0' ' ' < /proc/$$/cmdline
> 
> This looks like a Linux-ism to me.

Caught red-flippered :)  I'll use `ps` next time.

	- Andrew
