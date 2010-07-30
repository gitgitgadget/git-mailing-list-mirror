From: Melton Low <softw.devl@gmail.com>
Subject: Re: Build error with 1.7.2 and 1.7.2.1 on PPC Mac OS X 10.4
Date: Thu, 29 Jul 2010 20:21:07 -0600
Message-ID: <BB59EA06-3B2E-4B61-8154-42D160125476@gmail.com>
References: <6E0EF82C-2938-4149-A277-D51BC046B4E2@gmail.com> <20100730014220.GC2182@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 04:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OefRT-0001HJ-W9
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 04:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421Ab0G3CfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 22:35:19 -0400
Received: from mail-gx0-f194.google.com ([209.85.161.194]:45531 "EHLO
	mail-gx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab0G3CfS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 22:35:18 -0400
X-Greylist: delayed 847 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2010 22:35:18 EDT
Received: by gxk23 with SMTP id 23so132305gxk.1
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 19:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=3IjWtCui+sp2YoDfRz6I8ZuLb77J/ha9524kvzpeFY0=;
        b=qR6HhaEkwQP/8LNS/5HI/ZLq1b/rHlqiILgDy2SNfrnrFAyZP4pz3fGf1OB2zRpM+8
         XL+LoH2hyqm+itbYpR+CRlyeLLUZEWeUUQat7UyA30SXT8YCtzJtJmcCSjBU2INV68nL
         3MRfEV2pBAph3jGNp5h+Ea5LMGjTqncxPIT4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=H79Y3a2Sx5obckQ3wZ595dxvb0P4xEQcGvgvuITnqKldC9KWvRwHl58r4Ghv5JQUmw
         l1JFMEa0prMKJ5UjTUf77ERNGvcnK9dw+T3pD8qt843OjeTaK0/TCOsEP5Fh6dXkGhhW
         J443Zn3X11DWrw3I1RqMOB0Y3Mb3npcWDOV44=
Received: by 10.101.28.26 with SMTP id f26mr1290696anj.149.1280456470763;
        Thu, 29 Jul 2010 19:21:10 -0700 (PDT)
Received: from [192.168.1.101] (S010690840de80d96.cg.shawcable.net [70.72.31.86])
        by mx.google.com with ESMTPS id a12sm2548705and.36.2010.07.29.19.21.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 19:21:10 -0700 (PDT)
In-Reply-To: <20100730014220.GC2182@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152217>



Hi Jonathan,

> Hi Mel,
> 
> Melton Low wrote:
> 
>> Error during build on 1.7.2.  I just tried building 1.7.2.1 with the
>> same error.  A partial output from my attempt to build 1.7.2.1:
>> 
>>    * new build flags or prefix
>>    CC fast-import.o
>> powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
>>    CC abspath.o
> [...]
> 
> Looks like it worked, though loudly.
> 
> What does
> 
> 	$ gcc -v
> 	$ echo '
> #		include <pthread.h>
> 
> 		int main(void)
> 		{
> 			pthread_mutex_t test_mutex;
> 			int retcode = 0;
> 			retcode |= pthread_mutex_init(&test_mutex,(void *)0);
> 			retcode |= pthread_mutex_lock(&test_mutex);
> 			retcode |= pthread_mutex_unlock(&test_mutex);
> 			return retcode;
> 		}
> 
> 	' >pthreadtest.c
> 	$ gcc -pthread pthreadtest.c
> 	$ echo $?
> 	$ ./a.out
> 	$ echo $?
> 
> say?
> 
> Regards,
> Jonathan

Here is the output:

BigMac:~/work melton$ gcc -v
Using built-in specs.
Target: powerpc-apple-darwin8
Configured with: /var/tmp/gcc/gcc-5370~2/src/configure --disable-checking -enable-werror --prefix=/usr --mandir=/share/man --enable-languages=c,objc,c++,obj-c++ --program-transform-name=/^[cg][^.-]*$/s/$/-4.0/ --with-gxx-include-dir=/include/c++/4.0.0 --with-slibdir=/usr/lib --build=powerpc-apple-darwin8 --host=powerpc-apple-darwin8 --target=powerpc-apple-darwin8
Thread model: posix
gcc version 4.0.1 (Apple Computer, Inc. build 5370)
BigMac:~/work melton$ echo '
> #               include <pthread.h>
> 
>                int main(void)
>                {
>                        pthread_mutex_t test_mutex;
>                        int retcode = 0;
>                        retcode |= pthread_mutex_init(&test_mutex,(void *)0);
>                        retcode |= pthread_mutex_lock(&test_mutex);
>                        retcode |= pthread_mutex_unlock(&test_mutex);
>                        return retcode;
>                }
> 
>        ' >pthreadtest.c
BigMac:~/work melton$ gcc -pthread pthreadtest.c
powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
BigMac:~/work melton$ echo $?
0
BigMac:~/work melton$ ./a.out
BigMac:~/work melton$ echo $?
0
BigMac:~/work melton$ 

Let me know anything else you would like me to try.

Mel