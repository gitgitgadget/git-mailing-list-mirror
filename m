From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v3] gitk: Teach gitk to respect log.showroot
Date: Mon, 19 Mar 2012 12:04:58 +0100
Message-ID: <4F6712DA.6090904@in.waw.pl>
References: <20111004200813.GA16596@kennedy.acc.umu.se> <20120318225327.GA26977@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marcus Karlsson <mk@acc.umu.se>, gitster@pobox.com,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 12:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9aOz-0006nb-5h
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 12:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031Ab2CSLFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 07:05:16 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55948 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047Ab2CSLFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 07:05:15 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S9aOi-0004r6-1r; Mon, 19 Mar 2012 12:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <20120318225327.GA26977@bloggs.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193424>

On 03/18/2012 11:53 PM, Paul Mackerras wrote:
> On Tue, Oct 04, 2011 at 10:08:13PM +0200, Marcus Karlsson wrote:
>
>> Teach gitk to respect log.showroot.
>
>> +set log_showroot true
>> +catch {
>> +    set log_showroot [exec git config --get log.showroot]
>> +}
>
> Since I mostly use gitk on the kernel, I'd prefer that log_showroot
> defaults to false if it isn't specified in the git config file.
> Defaulting to false would also be the smaller change in gitk
> behaviour.

I agree that in case of the kernel repo, log.showroot=false is more 
useful. But this somewhat special use case should not decide the policy. 
First of all, as an experienced git user you know how to set the config 
option, if you dislike the default. This new default targets new users. 
Secondly, this option only matters when you scroll all the way down and 
click on first commit. Probably doesn't happen too often, since the time 
required to read in the other ~300000 commit messages is pretty big too. 
If you want to look at the root commit, it's probably because your 
project started recently and your history is short. Thirdly, consistency 
between git-log and gitk is important.

Zbyszek
