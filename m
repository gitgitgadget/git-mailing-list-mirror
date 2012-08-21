From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: read-cache-v5.c: compiler warnings
Date: Tue, 21 Aug 2012 20:04:41 +0100
Message-ID: <5033DBC9.7010707@ramsay1.demon.co.uk>
References: <50313AEC.1060700@ramsay1.demon.co.uk> <20120820082854.GA10909@tommy-fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:07:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3tnL-0002jx-3F
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471Ab2HUTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 15:07:15 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:46495 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab2HUTHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 15:07:11 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 170A3A640E3;
	Tue, 21 Aug 2012 20:07:11 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5D48AA640C9;	Tue, 21 Aug 2012 20:07:10 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Tue, 21 Aug 2012 20:07:09 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120820082854.GA10909@tommy-fedora>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203982>

Thomas Gummerer wrote:
> On 08/19, Ramsay Jones wrote:
>> Hi Thomas,
>>
>> Just an FYI; two out of the three gcc compilers I use (Linux, cygwin
>> but not MingW), issue the following warnings:
>>
>>         CC read-cache-v5.o
>>     read-cache-v5.c: In function `write_index_v5':
>>     read-cache-v5.c:1011: warning: 'dir' might be used uninitialized in this function
>>     read-cache-v5.c:1012: warning: 'search' might be used uninitialized in this function
>>     read-cache-v5.c:1012: warning: 'found' might be used uninitialized in this function
>>
>> [commit d2537158 ("Write index-v5", 16-08-2012)]
>>
>> Normally I would take a look and offer a patch, but I haven't found time
>> to do so in the last 10 days. So, I'm just giving you a heads up ... ;-P
> 
> Thanks for noticing.  This warnings only seem to be issued by older
> versions of gcc, which is probably why two compilers give the warnings
> while one doesn't.

You would hope that was true, but I would not bet on it! I've seen these types
of warnings (which rely heavily on analysis performed primarily for optimisation)
come and go several times in gcc.

> The variables can never be uninitialized, because they are guarded by
> ifs and older versions don't seem to recognize that.  I'll fix them
> in a re-roll though (or a separate patch if that's preferred), just
> waiting for some feedback for v4 of my series.

Thanks!

ATB,
Ramsay Jones
