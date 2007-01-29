From: SungHyun Nam <goweol@gmail.com>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Mon, 29 Jan 2007 10:15:21 +0900
Message-ID: <45BD4AA9.5090400@gmail.com>
References: <45B6C1FB.7060005@gmail.com> <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 29 02:15:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBL7T-00073K-Li
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 02:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbXA2BPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933035AbXA2BPg
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 20:15:36 -0500
Received: from relaygw2.kornet.net ([61.74.75.197]:59580 "EHLO
	relaygw2.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905AbXA2BPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 20:15:35 -0500
Received: from [211.48.62.137] ([211.48.62.137]) 
          by relaygw2.kornet.net ([61.74.75.197]) 
          with ESMTP id 2007012910:15:23:676316.11508.31054768
          Mon, 29 Jan 2007 10:15:23 +0900 (KST) 
Received: from [61.84.24.127] ([61.84.24.127]) 
          by relay9.kornet.net ([211.48.62.137]) 
          with ESMTP id 2007012910:15:22:913220.14000.31026096
          Mon, 29 Jan 2007 10:15:21 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
In-Reply-To: <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38060>

Hello,

Johannes Schindelin wrote:
> On Wed, 24 Jan 2007, SungHyun Nam wrote:
> 
>> First of all, this problem always existed to me. I was lazy to report. 
>> Please check the failure logs and my GIT build script below. [...] the 
>> first test failed at 't1000-read-tree-m-3way.sh' always. And in this 
>> case, 2nd test always succeeded.
>>
>> * FAIL 57: 5 - must match in !O && A && B && A==B case.
>>         rm -f .git/index LL &&
>>              cp .orig-A/LL LL &&
>>              git-update-index --add LL &&
>>              echo extra >>LL &&
>>              git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
>> 997bbc4a0a51e0574168a4f637739380edebe4d7
>> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>>              check_result
> 
> It is not directly apparent what is causing this error. Could you please 
> change your script to use "-i -v" on the tests? I.e. instead of:
> 	
>> 	    if ! make test
> 
> this:
> 
> 	    if ! (cd t; GIT_TEST_OPTS="-i -v" make)
> 
> It should give us a better idea what happened, since we also see the 
> error messages of the git commands.
> 
> If it is still not apparent what went wrong, there is unfortunately no way 
> around doing that particular test case manually, as to find out what went 
> wrong. Since you seem to be the only one who can reproduce this bug, it 
> boils down to you having to do the leg work.
> 

I'm not sure I can believe my system, Windows or CYGWIN.
It seems GIT has no problem.

Thanks,

2007-01-25
=========================================================================
* expecting success: rm -fr [NDMALTS][NDMALTSF] Z &&
     rm .git/index &&
     git-read-tree 997bbc4a0a51e0574168a4f637739380edebe4d7 &&
     git-checkout-index -f -u -a &&
     git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
     check_result
t1000-read-tree-m-3way.sh: line 133: current: Permission denied
* FAIL 46: 3-way merge with git-read-tree -m, match H
        rm -fr [NDMALTS][NDMALTSF] Z &&
             rm .git/index &&
             git-read-tree 997bbc4a0a51e0574168a4f637739380edebe4d7 &&
             git-checkout-index -f -u -a &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
make: *** [t1000-read-tree-m-3way.sh] Error 1


2007-01-29
=========================================================================
* expecting success: rm -f .git/index LL &&
     cp .orig-A/LL LL &&
     git-update-index --add LL &&
     echo extra >>LL &&
     git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
     check_result
t1000-read-tree-m-3way.sh: line 133: current: Permission denied
* FAIL 57: 5 - must match in !O && A && B && A==B case.
        rm -f .git/index LL &&
             cp .orig-A/LL LL &&
             git-update-index --add LL &&
             echo extra >>LL &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
make: *** [t1000-read-tree-m-3way.sh] Error 1
