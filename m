From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Problem compiling git-1.6.4 on OpenServer 6.0
Date: Sat, 8 Aug 2009 10:14:32 -0600
Message-ID: <alpine.LNX.2.00.0908081013090.13290@suse104.zenez.com>
References: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com> <cY-iS6BS6knyjPKeVQI3ZIsIw3A3y5VK1oW-MNzUUztRn8CbeqRdew@cipher.nrlssc.navy.mil> <alpine.LNX.2.00.0908071523550.13290@suse104.zenez.com>
 <DHem56NUSFhg2VqQu1N0qVr3U86qJOp4OZZAEwV2Edz0-YuWJpDtgA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Aug 08 18:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZoZB-0006XZ-17
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 18:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZHHQOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZHHQOf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 12:14:35 -0400
Received: from suse104.zenez.com ([198.60.105.164]:44098 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbZHHQOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 12:14:34 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 1BDECAB8030; Sat,  8 Aug 2009 10:14:33 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 05BE293852B;
	Sat,  8 Aug 2009 10:14:32 -0600 (MDT)
In-Reply-To: <DHem56NUSFhg2VqQu1N0qVr3U86qJOp4OZZAEwV2Edz0-YuWJpDtgA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125285>

On Fri, 7 Aug 2009, Brandon Casey wrote:
> Boyd Lynn Gerber wrote:
>> On Fri, 7 Aug 2009, Brandon Casey wrote:
>>> Boyd Lynn Gerber wrote:
>>>> I just tried to compile the latest git and I get this error.
>>>>
>>>> CC builtin-pack-objects.o
>>>> UX:acomp: ERROR: "builtin-pack-objects.c", line 1602: integral constant
>>>> expression expected
>>>> gmake: *** [builtin-pack-objects.o] Error 1
>>>>
>>>> I will look into it when I have a bit more time, but this is a heads up.
>>>
>>> Did you set THREADED_DELTA_SEARCH=1 when you compiled?  That could be the
>>> problem.
>>>
>>> Line 1602 of builtin-pack-objects.c is wrapped in #ifdef
>>> THREADED_DELTA_SEARCH,
>>> so it is only compiled if THREADED_DELTA_SEARCH has been set.  Also,
>>> it's not
>>> a new line, it has been around since 2007.
>>
>> Removing it and the -pthread allows it to build.  I am now running the
>> tests.  The I need to find out why it is being set.
>
> Did you run configure?  which generates a config.mak.autogen file?
> There were some changes related to pthreads in configure.ac in March,
> and another back in Nov 2008.  Specifically commits 1973b0d7, and
> d937c374.

Yes, I am working through them and will submit a patch once I get it 
working properly without breaking someone elses configuration.

Thanks,

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
