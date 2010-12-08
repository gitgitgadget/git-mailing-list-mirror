From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Wed, 08 Dec 2010 00:18:03 +0000
Message-ID: <4CFECEBB.7060703@ramsay1.demon.co.uk>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk> <201012042222.23384.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 08 01:30:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ7vn-0007Zf-IU
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab0LHAak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 19:30:40 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:54447 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754660Ab0LHAaj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 19:30:39 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PQ7va-00074A-YW; Wed, 08 Dec 2010 00:30:39 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012042222.23384.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163155>

Johannes Sixt wrote:
> On Samstag, 4. Dezember 2010, Ramsay Jones wrote:
>> diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
>> index 7e74ebe..708a6c9 100644
>> --- a/compat/win32/sys/poll.c
>> +++ b/compat/win32/sys/poll.c
>> @@ -34,6 +34,9 @@
>>
>>  #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
>>  # define WIN32_NATIVE
>> +# if defined (_MSC_VER)
>> +#  define _WIN32_WINNT 0x0502
>> +# endif
>>  # include <winsock2.h>
>>  # include <windows.h>
>>  # include <io.h>
> 
> Don't you have to do the same in git-compat-util.h?

No. compat/win32/sys/poll.c doesn't include git-compat-util.h (and I
don't think it should), so adding it there would not solve the immediate
problem. Also, I don't see any reason to restrict the API used by both
MinGW and msvc in other parts of git.

ATB,
Ramsay Jones
