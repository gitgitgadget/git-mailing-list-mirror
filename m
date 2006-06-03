From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: http-fetch troubles
Date: Fri, 2 Jun 2006 20:13:12 -0500
Message-ID: <1C422237-D48C-4A30-9BDD-5C165222873D@freescale.com>
References: <20060601232437.GD12261@reactrix.com> <7vhd34dptq.fsf@assigned-by-dhcp.cox.net> <7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sat Jun 03 03:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmKgC-0003FU-Ug
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 03:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWFCBLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 21:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWFCBLs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 21:11:48 -0400
Received: from [192.88.158.102] ([192.88.158.102]:39916 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932590AbWFCBLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 21:11:48 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k531VitA021510;
	Fri, 2 Jun 2006 18:31:44 -0700 (MST)
Received: from [192.168.1.100] (vpn-10-213-160-77.am.freescale.net [10.213.160.77])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k531B84H000911;
	Fri, 2 Jun 2006 20:11:13 -0500 (CDT)
In-Reply-To: <7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.750)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21181>


Woohoo!  The stuff you moved to master (which is what I was building  
from, not "next", as Nick pointed out) has fixed the git-http-fetch  
segfault problem I was seeing.

Thanks!
-Becky

On Jun 2, 2006, at 12:38 PM, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Nick Hengeveld <nickh@reactrix.com> writes:
>>
>>> - "git push" seems to pass --thin by default to http-push, which
>>>   subsequently barfs because that's not a valid http-push option.
>>>   Should it be?  Should it be silently ignored?  Should git-push not
>>>   default to --thin when pushing with HTTP transport?
>>
>> The way I understand http-push works is that it does not use
>> packed transfer, so I presume even if we give --thin as a hint
>> it cannot even take advantage of it.  Probably we should stop
>> passing --thin to http transport (git native one uses it as a
>> cue that it can generate baseless deltas in the resulting pack).
>>
>>> - when I clone, http-fetch outputs a whole bunch of
>>>   "error: Could not read ..." messages - is that expected?
>>
>> The clone over http seems to be severely broken in "next" right
>> now.  The one in "master" seems to be OK.  bisecting suggests
>> the breakage is coming from the tree parser rewrite.
>>
>> bisect points at 136f2e548a34f1f504b0f062f87ddf33e8d6e83b.
>
> I've pushed out Nick's http-fetch fixes in "master" to see if it
> fixes problems for people.  Right now the one in "next" branch
> seems to be having unrelated problems coming from another topic
> which I haven't started tracking down yet.
>
>
