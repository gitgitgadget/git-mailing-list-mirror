From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Tue, 03 Nov 2009 19:34:42 -0700
Message-ID: <4AF0E842.2010201@workspacewhiz.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257283802-29726-2-git-send-email-ahaczewski@gmail.com> <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 03:41:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5VoY-0005Zk-5C
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 03:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbZKDCl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 21:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZKDCl1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 21:41:27 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58435 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbZKDCl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 21:41:26 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2009 21:41:26 EST
Received: (qmail 32573 invoked by uid 399); 3 Nov 2009 19:34:48 -0700
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@24.10.200.9)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Nov 2009 19:34:48 -0700
X-Originating-IP: 24.10.200.9
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132025>

----- Original Message -----
From: Johannes Schindelin
Date: 11/3/2009 4:38 PM
>>   #ifdef THREADED_DELTA_SEARCH
>> -#include "thread-utils.h"
>> -#include<pthread.h>
>> +# include "thread-utils.h"
>> +# ifndef _WIN32
>> +#  include<pthread.h>
>> +# else
>> +#  include<winthread.h>
>> +# endif
>>   #endif
>>
>>      
> It is unlikely that an #ifdef "contamination" of this extent will go
> through easily, but I have a suggestion that may make your patch both
> easier to read and more likely to be accepted into git.git: Try to wrap
> the win32 calls into pthread-compatible function signatures.  Then you can
> add a compat/win32/pthread.h and not even touch core files of git.git at
> all.
>    
Pardon my ignorance, but is there a reason to not use Pthreads for 
Win32?  http://sourceware.org/pthreads-win32/

Josh
