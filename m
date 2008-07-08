From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Test breakage [Re: [ANNOUNCE] GIT 1.5.6.2]
Date: Tue, 08 Jul 2008 11:47:45 +0200
Message-ID: <g4vd41$psa$1@ger.gmane.org>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org> <g4t342$9m8$1@ger.gmane.org> <20080708051622.GC2037@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 11:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG9oa-0000NV-9Q
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 11:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbYGHJrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 05:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYGHJrz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 05:47:55 -0400
Received: from main.gmane.org ([80.91.229.2]:55388 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615AbYGHJry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 05:47:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KG9nd-0006dQ-1a
	for git@vger.kernel.org; Tue, 08 Jul 2008 09:47:53 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 09:47:53 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 09:47:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080708051622.GC2037@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87732>

Jeff King venit, vidit, dixit 08.07.2008 07:16:
> On Mon, Jul 07, 2008 at 02:44:49PM +0200, Michael J Gruber wrote:
> 
>> On Kubuntu 7.10 (not my choice, this is at work...), "make test" gives:
>>
>> *** t9600-cvsimport.sh ***
>> [...]
>> * FAIL 6: update git module
>>                 cd module-git &&
>>                 git cvsimport -a -z 0 module &&
>>                 git merge origin &&
>>                 cd .. &&
>>                 test_cmp module-cvs/o_fortuna module-git/o_fortuna
>>
>> On the second (and subsequent) run, "make test" succeeds. I tried again  
>> with a fresh copy from the tarball, same effect: failure on 1, success on 
>> 2 and following.
> 
> I tried reproducing on my Debian box with various weaks of $LANG, but I
> couldn't. Can you please try running "./t9600-cvsimport.sh -v -i" and
> send us the output of a failing instance. It's not clear which step in
> failing test is causing the problem, or if cvsps is giving off any
> useful errors.
> 
>> This is with LANG=de_DE.UTF-8, whereas with LANG=C the tests succeed the  
>> first time already. Are tests supposed to be done in C locale only? Do  
>> they reuse data from a previous test run? I didn't notice this with 
>> 1.5.6.1.
> 
> They should be perfectly repeatable, but I have run into problems in the
> past with cruft in my ~/.cvsps directory. However, we should be setting
> $HOME properly in t9600 to avoid this, so I'm not sure what the culprit
> is.

Sure enough, I can't reproduce it today. I reproduced that effect 
several times yesterday, or else I would not have reported anything. 
Trying the very same steps today the tests succeed on the first run. 
Only differences between yesterday and today are be:

- I installed git 1.5.6.2 now (had 1.5.6.1 before) under $HOME, with 
PATH, PERL5LIB, LD_LIBRARY_PATH set accordingly; but tests should pick 
up git stuff from the local build dir, right?

- There may have been an automated update to kubuntu meanwhile, but I 
don't think so; cvsps is under $HOME anyways, and what else would 
matter? Perl version maybe?

So it's WORKSFORME now. Sorry for the noise. Next time I'll not only try 
to reproduce (as I did) but wait a day also!

Best
Michael
