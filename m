From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 5/6] More accurately detect header lines in
 read_one_header_line
Date: Fri, 26 May 2006 02:16:24 -0600
Message-ID: <m1d5e1ciav.fsf@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
	<m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
	<m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r72kiksz.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzd8iklr.fsf_-_@ebiederm.dsl.xmission.com>
	<7vy7wpnt0t.fsf@assigned-by-dhcp.cox.net>
	<7vr72hns7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 10:17:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjXVY-0004rT-E9
	for gcvg-git@gmane.org; Fri, 26 May 2006 10:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWEZIRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 04:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWEZIRR
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 04:17:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29864 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750721AbWEZIRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 04:17:16 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4Q8GPDE017168;
	Fri, 26 May 2006 02:16:25 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4Q8GOsd017167;
	Fri, 26 May 2006 02:16:24 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr72hns7h.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 26 May 2006 00:46:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20801>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Was there a particular reason you needed this change?  That is,
>> did you have to parse mail-looking input that does not have a
>> blank line between runs of headers and the body of the message?

Yes.  I had patches that had a subject line followed by a blank line,
and the problem was that the old check thought the subject was a
header line, despite not even having a colon in it.

>> If so, I'd at least like to remove the || !isspace(colon[1])
>> from the test.  After all, I do not think RFC2822 requires a
>> whitespace after the colon there.
>
> In other words, something like this (tested):

Looks good to me, sorry for missing that one.

Eric
