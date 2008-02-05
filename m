From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [PATCH] git-cvsimport: Detect cvs without support for server
 mode
Date: Tue, 05 Feb 2008 14:03:51 +0100
Message-ID: <47A85EB7.2070105@gmx.ch>
References: <47A5DD98.6000606@gmx.ch>	<200802031908.28115.robin.rosenberg.lists@dewire.com>	<47A72EE5.2080904@gmx.ch> <7vsl07epo5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 14:04:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMNTP-0000tn-8l
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 14:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbYBENDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 08:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYBENDz
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 08:03:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:58095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbYBENDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 08:03:54 -0500
Received: (qmail invoked by alias); 05 Feb 2008 13:03:52 -0000
Received: from 192-47.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.47.192]
  by mail.gmx.net (mp031) with SMTP; 05 Feb 2008 14:03:52 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX192VsUd9z92NlazugMWvoqSjE8v21zjfQt5NWoz0s
	EkXewBCPXUxrSN
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <7vsl07epo5.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72652>

Junio C Hamano wrote:
> If we do not have cvs with server support, is there a fallback
> method we can still use to run cvsps?

I have no idea, I haven't looked at cvsps closely enough.

> Jean-Luc Herren <jlh@gmx.ch> writes:
>> diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
>> index 7706430..d8cbfd0 100755
>> --- a/t/t9600-cvsimport.sh
>> +++ b/t/t9600-cvsimport.sh
>> @@ -10,6 +10,13 @@ then
>>  	exit
>>  fi
>>  
>> +if echo -n | cvs server 2>&1 | grep 'Unknown command' > /dev/null
>> +then
>> +	say 'skipping cvsimport tests, cvs has support for server mode'
>> +	test_done
>> +	exit
>> +fi
> 
> Do you mean "has to support server" or "does not have support for"?

I meant to say "cvs has no support for server mode", but I think
"doesn't have support for" is better.

jlh
