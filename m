From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Problem compiling git-1.6.4 on OpenServer 6.0
Date: Fri, 7 Aug 2009 15:25:46 -0600
Message-ID: <alpine.LNX.2.00.0908071523550.13290@suse104.zenez.com>
References: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com> <cY-iS6BS6knyjPKeVQI3ZIsIw3A3y5VK1oW-MNzUUztRn8CbeqRdew@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZWwp-0000o3-JQ
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 23:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbZHGVZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZHGVZv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 17:25:51 -0400
Received: from suse104.zenez.com ([198.60.105.164]:50418 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbZHGVZu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 17:25:50 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 305E26C10EB; Fri,  7 Aug 2009 15:25:46 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 1C27F93852B;
	Fri,  7 Aug 2009 15:25:46 -0600 (MDT)
In-Reply-To: <cY-iS6BS6knyjPKeVQI3ZIsIw3A3y5VK1oW-MNzUUztRn8CbeqRdew@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125228>

On Fri, 7 Aug 2009, Brandon Casey wrote:
> Boyd Lynn Gerber wrote:
>> I just tried to compile the latest git and I get this error.
>>
>> CC builtin-pack-objects.o
>> UX:acomp: ERROR: "builtin-pack-objects.c", line 1602: integral constant
>> expression expected
>> gmake: *** [builtin-pack-objects.o] Error 1
>>
>> I will look into it when I have a bit more time, but this is a heads up.
>
> Did you set THREADED_DELTA_SEARCH=1 when you compiled?  That could be the
> problem.
>
> Line 1602 of builtin-pack-objects.c is wrapped in #ifdef THREADED_DELTA_SEARCH,
> so it is only compiled if THREADED_DELTA_SEARCH has been set.  Also, it's not
> a new line, it has been around since 2007.

Removing it and the -pthread allows it to build.  I am now running the 
tests.  The I need to find out why it is being set.

Thanks,


-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
