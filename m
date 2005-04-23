From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH] #!/bin/sh --> #!/usr/bin/env bash
Date: Fri, 22 Apr 2005 22:34:12 -0400
Message-ID: <4269B424.8010406@dwheeler.com>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com> <4267387A.6040602@timesys.com> <20050421102326.GA22541@xdt04.mpe-garching.mpg.de> <20050421143102.GA830@alc.bsd.st> <20050421194255.GA8479@alc.bsd.st> <4268A9C5.5090102@zytor.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alecs King <alecsk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 04:27:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPAMt-0003Hn-2T
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 04:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVDWCcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 22:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDWCcH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 22:32:07 -0400
Received: from cujo.runbox.com ([193.71.199.138]:28112 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261441AbVDWCcD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 22:32:03 -0400
Received: from [10.9.9.9] (helo=fetch.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DPAR6-0006fK-LB; Sat, 23 Apr 2005 04:32:00 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fetch.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DPAR6-0005LZ-DF; Sat, 23 Apr 2005 04:32:00 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4268A9C5.5090102@zytor.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> Alecs King wrote:
> 
>>
>> And as for bash, only gitdiff-do and gitlog.sh 'explicitly' use bash
>> instead of /bin/sh.  On most Linux distros, /bin/sh is just a symbolic
>> link to bash.  But not on some others.  I found gitlsobj.sh could not
>> work using a plain /bin/sh on fbsd.  To make life easier, i think it
>> might be better if we all explicitly use bash for all shell scripts.


H. Peter Anvin wrote:
> How about #!/bin/bash (build from .in files if you feel it necessary to 
> support systems which don't have bash in /bin) instead of doubling the 
> number of execs?

If # of execs is that critical, it probably should not be in
bash anyway.  OpenBSD (at least 3.1)'s bash appears to be in
/usr/local/bin/bash, NOT /bin/bash.
I'd go with the /bin/env solution for now;
it maximizes the "it just works" factor, and
when it comes time for .in files much of the cogito code (at least)
will probably be rewritten in Perl, and anything performance-sensitive
will be in C.

--- David A. Wheeler
