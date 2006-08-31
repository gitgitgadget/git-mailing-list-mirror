From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 21:30:07 +0200
Organization: At home
Message-ID: <ed7dc6$7na$1@sea.gmane.org>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F6F478.1070708@users.sourceforge.net> <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F71557.1080404@users.sourceforge.net> <Pine.LNX.4.63.0608311904520.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F71B79.5070901@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 21:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIsFl-0006h6-55
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 21:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWHaTak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 15:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHaTak
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 15:30:40 -0400
Received: from main.gmane.org ([80.91.229.2]:28044 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932123AbWHaTaj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 15:30:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIsFD-0006aV-NB
	for git@vger.kernel.org; Thu, 31 Aug 2006 21:30:31 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 21:30:31 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 21:30:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26272>

Jorma Karvonen wrote:

> Johannes Schindelin wrote:
>
>> On Thu, 31 Aug 2006, Jorma Karvonen wrote:
>>   
>>> I tried
>>>
>>> make configure
>>>
>>> and got an error message:
>>>
>>> /bin/sh: curl-config: command not found
>>> make: **** No rule to make target `configure'. Stop.
     
The offending line seems to be
        curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
and it is turned off if you always run make with NO_CURL=1.
Or write NO_CURL=1 (or NO_CURL=YesPlease) in the config.mak file

>> Okay. I deem this a bug in our Makefile.
>>
>> Could you please try "autoconf" and _then_ "./configure"?
>>
> I tried autoconf and result was:
> 
> autoconf: no input file
 
"autoconf -o configure configure.ac" then

By the way, from what directory you try to run make from?
autoconf default input file is configure.ac, and AFAIK it is 
present in 'master' from quite some time, and perhaps in 'maint'
as well.

What is in GIT-VERSION-FILE aftre running GIT-VERSION-GEN?


Below my results of running make configure in git/ working directory:

1047:jnareb@roke:~/git> make configure
GIT_VERSION = 1.4.2.gf713
rm -f configure configure.ac+
sed -e 's/@@GIT_VERSION@@/1.4.2.gf713/g' \
    configure.ac > configure.ac+
autoconf -o configure configure.ac+
rm -f configure.ac+

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
