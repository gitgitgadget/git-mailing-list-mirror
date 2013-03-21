From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH jk/checkout-attribute-lookup] t2003: work around path
 mangling issue on Windows
Date: Thu, 21 Mar 2013 07:46:45 +0100
Message-ID: <514AACD5.3010106@viscovery.net>
References: <514977BD.6060604@viscovery.net> <7vli9if159.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 07:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIZHl-0005z5-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 07:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab3CUGqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 02:46:54 -0400
Received: from so.liwest.at ([212.33.55.24]:28938 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435Ab3CUGqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 02:46:53 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIZGy-0008UO-KI; Thu, 21 Mar 2013 07:46:50 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A4E8A1660F;
	Thu, 21 Mar 2013 07:46:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vli9if159.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218698>

Am 3/20/2013 18:10, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> MSYS bash considers the part "/g" in the sed expression "s/./=/g" as an
>> absolute path after an assignment, and mangles it to a C:/something
>> string. Do not attract bash's attention by avoiding the equals sign.
> 
> If this breakage is about path mangling, I suspect it may be cleaner
> to work it around by not using / as the pattern separator, e.g.
> 
> 	sed -e s!.!=!g

Half a year down the road you'd scratch your head why you were not using
'/' as separator. As the replacement character is irrelevant here, it's
better to exchange that. Therefore, I still prefer my version.

> Or perhaps use SHELL_PATH to point at a more reasonable
> implementation of shell that does not have such an idiocy?

Well, POSIX and DOS paths look inherently different, particularly absolute
paths. You can't write a reasonably portable shell script if the shell
doesn't help in some way.

Not to mention that the supply of POSIX shells on Windows is inherently
scarce.

-- Hannes
