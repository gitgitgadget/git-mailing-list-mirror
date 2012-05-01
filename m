From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] compat/mingw.h: Set S_ISUID to prevent a fast-import
 test failure
Date: Tue, 01 May 2012 21:44:15 +0200
Message-ID: <4FA03D0F.6080906@kdbg.org>
References: <4F8DAFA4.2050502@ramsay1.demon.co.uk> <4F8F2268.8020803@kdbg.org> <7vhaw0as8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:44:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPIzk-0000gO-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab2EAToQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 15:44:16 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55902 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab2EAToP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 15:44:15 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A7A6CA7EB3;
	Tue,  1 May 2012 21:45:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7vhaw0as8e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196733>

Am 01.05.2012 16:30, schrieb Junio C Hamano:
> Johannes Sixt<j6t@kdbg.org>  writes:
>
>>> ...
>>> -#define S_ISGID 0
>>> -#define S_ISVTX 0
>>> +
>>> +#define S_ISUID 0004000
>>> +#define S_ISGID 0002000
>>> +#define S_ISVTX 0001000
>>>
>>>   #define WIFEXITED(x) 1
>>>   #define WIFSIGNALED(x) 0
>>
>> I've submitted a similar patch, but it was suggested to solve the
>> inherent problem in a cleaner way, but no patch came forward.
>
> I think this patch should be fine, either as the final solution, or the
> first step for "solving the inherent problem in a cleaner way" (if msysgit
> folk care very deeply about it, that is).

My primary concern is to have the bug fixed on Windows. For this purpose, 
this patch is sufficiently clean.

-- Hannes
