From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 05 Dec 2007 14:22:59 -0800
Message-ID: <7vd4tkn5mk.fsf@gitster.siamese.dyndns.org>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
	<1196869526-2197-1-git-send-email-jnareb@gmail.com>
	<7vtzmxortn.fsf@gitster.siamese.dyndns.org>
	<200712052226.53543.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02eS-0001I0-LQ
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbXLEWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXLEWXK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:23:10 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40431 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXLEWXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:23:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 077312FB;
	Wed,  5 Dec 2007 17:23:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 674B69D511;
	Wed,  5 Dec 2007 17:23:23 -0500 (EST)
In-Reply-To: <200712052226.53543.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 5 Dec 2007 22:26:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67206>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> +AC_MSG_CHECKING([for old iconv()])
>>> +AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
>>> +	[AC_MSG_RESULT([no])],
>>> +	[AC_MSG_RESULT([yes])
>>> +	OLD_ICONV=YesPlease])
>>> +AC_SUBST(OLD_ICONV)
>>>  
>> 
>> Which result does COMPILE_IFELSE give for non error warnings?  Ok, or
>> Bad?
>
>  - Macro: AC_COMPILE_IFELSE (INPUT, [ACTION-IF-FOUND],
>           [ACTION-IF-NOT-FOUND])
>      Run the compiler and compilation flags of the current language
>      (*note Language Choice::) on the INPUT, run the shell commands
>      ACTION-IF-TRUE on success, ACTION-IF-FALSE otherwise.  The INPUT
>      can be made by `AC_LANG_PROGRAM' and friends.
>
> And if I have checked correctly code which causes only warnings
> returns Ok (in this case print 'no' after 'checking for old iconv()... '
> and do not set OLD_ICONV, which means it will be unset).

Which means the real-life compilation will get the warning on type
mismatch.  Wasn't OLD_ICONV about squelching that?
