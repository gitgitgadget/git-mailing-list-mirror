From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] completion: Handle '!f() { ... }; f' aliases
Date: Thu, 12 Jun 2014 20:41:54 +0200
Message-ID: <62610ABB-4ED5-4CF1-B5B2-B89C9DD22FBD@zib.de>
References: <CAPig+cQKtVoc7X2SBE8L1pSpnwQxkmFF6pL2PL-7RUoFq5h8gw@mail.gmail.com> <1402318493-29943-1-git-send-email-prohaska@zib.de> <xmqq1tuxcp13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9xW-00060e-9k
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaFLSmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:42:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:56046 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbaFLSml convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 14:42:41 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s5CIg1in008163;
	Thu, 12 Jun 2014 20:42:01 +0200 (CEST)
Received: from [192.168.1.200] (95-91-208-166-dynip.superkabel.de [95.91.208.166])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s5CIfxAT008157
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 12 Jun 2014 20:42:00 +0200 (CEST)
In-Reply-To: <xmqq1tuxcp13.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-Miltered: at mailer.zib.de with ID 5399F479.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5399F479.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 5399F479.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251475>


On Jun 10, 2014, at 7:27 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> I tend to prefer writing it like so instead:
> 
>    sh -c '...' -
> 
> so that I won't clobber "f" (or any other name).  I wonder if you
> can help users of this other pattern as well.

I'll send an updated patch that handles it.


>> +test_expect_success 'completion uses <cmd> completion for alias !f() { VAR=val git <cmd> ... }' '
>> +	test_config alias.co "!f() { VAR=val git checkout ... ; } f" &&
> 
> Is it only "f" that is completed, or can I spell it using another
> arbitrary token, e.g.
> 
> 	test_config alias.co "!co () { git checkout ... } co"

Any token that starts with ! already worked before. 

The updated patch will also handle spaces before the parens.

	Steffen