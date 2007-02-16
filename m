From: SungHyun Nam <goweol@gmail.com>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Fri, 16 Feb 2007 09:04:14 +0900
Message-ID: <45D4F4FE.3010405@gmail.com>
References: <45B6C1FB.7060005@gmail.com> <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BD4AA9.5090400@gmail.com> <45D3AF9B.40205@gmail.com> <Pine.LNX.4.63.0702150236590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 01:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqaq-0002AR-46
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbXBPAEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbXBPAEd
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:04:33 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:60626 "EHLO
	relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbXBPAEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:04:32 -0500
Received: from [211.48.62.136] ([211.48.62.136]) 
          by relaygw1.kornet.net ([61.74.75.196]) 
          with ESMTP id 2007021609:04:23:370697.2057.13286320
          Fri, 16 Feb 2007 09:04:23 +0900 (KST) 
Received: from [61.83.195.103] ([61.83.195.103]) 
          by relay8.kornet.net ([211.48.62.136]) 
          with ESMTP id 2007021609:04:23:263775.25806.31472560
          Fri, 16 Feb 2007 09:04:16 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
In-Reply-To: <Pine.LNX.4.63.0702150236590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39864>

Hello,

Johannes Schindelin wrote:
> 
> On Thu, 15 Feb 2007, SungHyun Nam wrote:
> 
>>  check_result () {
>> +    [ -r current ] && rm -f current
>>      git-ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
>>      diff -u expected current
>>  }
> 
> Are you having a restrictive umask, or what are the permissions on that 
> file?

There's no problem with the umask.

$ umask
0022

I guess there is some race condition in CYGWIN or windows. And my system
triggers that condition.

Check the logic above. I cannot think there is any chance that 'rm -f
current && echo x >current' is success, but 'echo x >current' is fail?

Thanks,
namsh
