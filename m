From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Fri, 23 Dec 2011 18:41:47 +0900
Message-ID: <877h1nwrok.fsf@catnip.gol.com>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
	<m2liq6go7y.fsf@igel.home> <20111221145352.GB13097@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 23 10:55:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re1qX-0008BY-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 10:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab1LWJzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 04:55:21 -0500
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:37267 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1LWJzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 04:55:19 -0500
X-Greylist: delayed 806 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Dec 2011 04:55:19 EST
Received: from 218.231.96.216.eo.eaccess.ne.jp ([218.231.96.216] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1Re1dM-0003lP-8G; Fri, 23 Dec 2011 18:41:48 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 5B486DFA1; Fri, 23 Dec 2011 18:41:47 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20111221145352.GB13097@llunet.cs.wisc.edu> (Nathan Panike's
	message of "Wed, 21 Dec 2011 08:53:53 -0600")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187622>

Nathan Panike <nwp@cs.wisc.edu> writes:
>> > $ git log --pretty='%h %30s' d165204 -1
>> 
>> In C's formatted output this syntax denotes a minimum field width, not a
>> precision, so it will probably be surprising to many people.
>
> C semantics are already broken because (from git-log(1))
>
> "If you add a - (minus sign) after % of a placeholder, line-feeds that
> immediately precede the expansion are deleted if and only if the placeholder
> expands to an empty string."
>
> rather than indicating justification of the field.

There's no reason to make it _worse_ though...

For your desired feature, why not just use the C printf syntax for this
functionality, a leading dot before the max length?  E.g. "%.30s".

-miles

-- 
Youth, n. The Period of Possibility, when Archimedes finds a fulcrum,
Cassandra has a following and seven cities compete for the honor of endowing a
living Homer.
