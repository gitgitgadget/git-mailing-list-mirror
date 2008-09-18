From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/4] diff.c: convert builtin funcname patterns to extended
 regular expressions
Date: Thu, 18 Sep 2008 10:48:54 -0500
Message-ID: <ZteMrZlQ1K7uF4E4K_zDC1Gh4qMi2zZA1wWprVJjxcpiETKEn-YbiQ@cipher.nrlssc.navy.mil>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org> <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil> <57518fd10809180353q2564d873k98e5f6d9041d0a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:02:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLvr-0004v7-KS
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbYIRP72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbYIRP72
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:59:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58741 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbYIRP71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:59:27 -0400
Received: by mail.nrlssc.navy.mil id m8IFmtCo023399; Thu, 18 Sep 2008 10:48:55 -0500
In-Reply-To: <57518fd10809180353q2564d873k98e5f6d9041d0a7@mail.gmail.com>
X-OriginalArrivalTime: 18 Sep 2008 15:48:55.0379 (UTC) FILETIME=[0E68E230:01C919A6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96206>

Jonathan del Strother wrote:
> On Thu, Sep 18, 2008 at 1:21 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>>
>>
>> This is a blind conversion removing \\ before ( and { etc.
>> and adding \\ before naked ( and { etc.
>>
>> I hope the authors who last touched these patterns will help with testing:
> 
> 
> None of the patterns using \\s seem to work for me.  I had to replace
> them with [ \t] - is this a problem with the darwin regex
> compatibility library or something?  I applied the patches on master
> (97d7fee2cb), and am running OS X 10.5.5.

I was going to say possibly \s is a gnu extension, but if by "compatibility
library", you mean compat/regex/regex.[ch] in the git source which is used
by default now on OSX, then that _is_ the gnu library.

I just tried the ruby pattern on IRIX6.5 and Solaris7 and \\s does not work.
I am not using compat/regex/regex.[ch]. Same pattern works on linux.

Looks like '\\s' needs to be changed to ' '.

-brandon
