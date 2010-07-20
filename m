From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Convert "! git" to "test_must_fail" git.
Date: Tue, 20 Jul 2010 14:59:04 -0500
Message-ID: <7f2yYiHON5cy37krPeX7WXFeoN42YYjGc04eHV92atxS4vuERQ3MCA@cipher.nrlssc.navy.mil>
References: <20100720181431.GA12857@localhost.localdomain> <fe4308a0ab1c3d7296efa986d5cfe63c6ff4014a.1279652856.git.jaredhance@gmail.com> <_BUqzkdWhTIktk0rYFvr9jdvISwfrShKmEsXaqgCBwm0X5Urcv2osQ@cipher.nrlssc.navy.mil> <20100720194807.GA2259@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 21:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIyC-0006wl-6s
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658Ab0GTT7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:59:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44343 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab0GTT7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:59:10 -0400
Received: by mail.nrlssc.navy.mil id o6KJx4f5005642; Tue, 20 Jul 2010 14:59:04 -0500
In-Reply-To: <20100720194807.GA2259@burratino>
X-OriginalArrivalTime: 20 Jul 2010 19:59:04.0697 (UTC) FILETIME=[016D8E90:01CB2846]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151360>

On 07/20/2010 02:48 PM, Jonathan Nieder wrote:
> Brandon Casey wrote:
> 
>> I believe the '!' negates the
>> result of the entire statement, but test_must_fail only
>> operates on the arguments preceding the '|'.
> 
> Right.  For example:
> 
>> On 07/20/2010 02:09 PM, Jared Hance wrote:
> 
> [...]
>>> +++ b/t/t7810-grep.sh
>>> @@ -134,7 +134,7 @@ do
>>>  	'
>>>  
>>>  	test_expect_success "grep -c $L (no /dev/null)" '
>>> -		! git grep -c test $H | grep /dev/null
>>> +		test_must_fail git grep -c test $H | grep /dev/null
> 
> should be
> 
> 	git grep -c test $H | ! grep /dev/null

I seem to recall that that doesn't work either.

   $ /bin/bash -c 'echo foo | ! grep bar && echo success || echo failure'
   /bin/bash: -c: line 0: syntax error near unexpected token `!'
   /bin/bash: -c: line 0: `echo foo | ! grep bar && echo success || echo failure'

-brandon
