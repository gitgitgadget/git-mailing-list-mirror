From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Wire new date formats to --date=<format> parser.
Date: Fri, 13 Jul 2007 23:54:19 -0700
Message-ID: <7vbqeflbl0.fsf@assigned-by-dhcp.cox.net>
References: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net>
	<20070713225836.17922.32546.stgit@lathund.dewire.com>
	<7vodiflc3v.fsf_-_@assigned-by-dhcp.cox.net>
	<20070714064451.GH11809@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
X-From: git-owner@vger.kernel.org Sat Jul 14 08:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9bWK-00058V-Ip
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 08:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXGNGyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 02:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbXGNGyV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 02:54:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62629 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbXGNGyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 02:54:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714065421.ZNCH1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 02:54:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PJuK1X0091kojtg0000000; Sat, 14 Jul 2007 02:54:20 -0400
In-Reply-To: <20070714064451.GH11809@lug-owl.de> (Jan-Benedict Glaw's message
	of "Sat, 14 Jul 2007 08:44:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52449>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Fri, 2007-07-13 23:43:00 -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1133,6 +1133,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>>  			if (!strncmp(arg, "--date=", 7)) {
>>  				if (!strcmp(arg + 7, "relative"))
>>  					revs->date_mode = DATE_RELATIVE;
>> +				else if (!strcmp(arg + 7, "iso8601") ||
>> +					 !strcmp(arg + 7, "iso"))
>> +					revs->date_mode = DATE_ISO8601;
>> +				else if (!strcmp(arg + 7, "rfc2822") ||
>> +					 !strcmp(arg + 7, "rfc"))
>
> Maybe also add "rfc822"?

I've thought about it, but did not bother; I suspect people would
just say "rfc" anyway.
