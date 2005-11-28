From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: lost again on syntax change - local repository?
Date: 28 Nov 2005 05:09:40 -0800
Message-ID: <86d5kk7wbv.fsf@blue.stonehenge.com>
References: <861x118r9t.fsf@blue.stonehenge.com>
	<20051128104831.GN22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:10:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgilS-0000Oo-6e
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVK1NJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVK1NJq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:09:46 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:22359 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932086AbVK1NJq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 08:09:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 88CA68F790;
	Mon, 28 Nov 2005 05:09:41 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 24061-03-97; Mon, 28 Nov 2005 05:09:41 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 24D4A8F799; Mon, 28 Nov 2005 05:09:41 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.15.0; tzolkin = 11 Ahau; haab = 18 Ceh
In-Reply-To: <20051128104831.GN22159@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12875>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> Dear diary, on Mon, Nov 28, 2005 at 03:01:18AM CET, I got a letter
Petr> where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
>> localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"

Petr> BTW, it should be fine to just say ../remote.git#master.

Maybe this is why yours worked.

Ahh, yes, it did.

So, cg-push treats '../..' differently from '/foo/bar/...'.

This is bad.  That's the bug.

cg-push treats "../" as a local filesystem, and "/..." as git-ssh.
This is a change from before.

Please make it recognize "/..." as a local file again.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
