From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 3 Sep 2008 21:58:08 -0600
Message-ID: <alpine.LNX.1.10.0809032157200.21167@suse104.zenez.com>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com> <7vljy88u0m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 05:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb604-0001Ew-Lv
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 05:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYIDD6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 23:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbYIDD6K
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 23:58:10 -0400
Received: from suse104.zenez.com ([198.60.105.164]:25120 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYIDD6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 23:58:09 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 967CBA7C939; Wed,  3 Sep 2008 21:58:08 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 870B9A7C931;
	Wed,  3 Sep 2008 21:58:08 -0600 (MDT)
In-Reply-To: <7vljy88u0m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94887>

On Wed, 3 Sep 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>> I just noticed that setlinebuf is coming back as undefined when trying
>> to build the lastest version.
>>
>> on UnixWare 7.1.4 I get
>>
>>     LINK git-var
>>     CC daemon.o
>> UX:acomp: WARNING: "daemon.c", line 485: end-of-loop code not reached
>>     LINK git-daemon
>> Undefined                       first referenced
>> symbol                              in file
>> setlinebuf                          daemon.o
>> UX:ld: ERROR: Symbol referencing errors. No output written to git-daemon
>> gmake: *** [git-daemon] Error 1
>
> Ah, ok.  I should have noticed that setlinebuf() was outside POSIX (it is
> not usable on older BSDs either).
>
> Let's see if we can replace it with setvbuf() which is POSIX.

This fixes the problem. on both OS's.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
