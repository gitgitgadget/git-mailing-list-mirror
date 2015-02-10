From: Sergey Organov <sorganov@gmail.com>
Subject: Re: 'git rebase' silently drops changes?
Date: Tue, 10 Feb 2015 14:46:52 +0300
Message-ID: <87pp9ivvir.fsf@osv.gnss.ru>
References: <87386ispb3.fsf@osv.gnss.ru> <54D68455.5070305@gmail.com>
	<54D7696B.3060407@kdbg.org> <87oap38cv1.fsf@osv.gnss.ru>
	<54D90473.2090208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:47:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL9HP-0005dZ-LK
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 12:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbbBJLq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 06:46:56 -0500
Received: from mail.javad.com ([54.86.164.124]:43704 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145AbbBJLqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 06:46:55 -0500
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 2CCB163680;
	Tue, 10 Feb 2015 11:46:54 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1YL9HI-0000gx-G8; Tue, 10 Feb 2015 14:46:52 +0300
In-Reply-To: <54D90473.2090208@kdbg.org> (Johannes Sixt's message of "Mon, 09
	Feb 2015 20:03:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263628>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.02.2015 um 13:53 schrieb Sergey Organov:

[...]

> If you want a version of --preserve-merges that does what *you* need,
> consider this commit:
>
>   git://repo.or.cz/git/mingw/j6t.git rebase-p-first-parent
>
> Use it like this:
>
>   git rebase -i -p --first-parent ...

Thanks a lot, this sounds promising! I've read the message for this
commit and it mentions no drawbacks. Are you aware of any?

> Beware, its implementation is incomplete: if the rebase is interrupted,
> then 'git rebase --continue' behaves as if --first-parent were not
> given.

Just never did get round to it, or something more fundamental?

To be useful for me, it also needs a support for 'git pull' to pass this
flag to 'git rebase', but that I think I can easily fix myself.

>>> it is impossible for git rebase to decide to which rebased
>>> commit the amendement applies. It doesn't even try to guess. It's the
>>> responsibility of the user to apply the amendment to the correct
>>> commit.
>> 
>> Yeah, this sounds reasonable, /except/ git even gives no warning when it
>> drops amendments. Shouldn't 'git rebase' rather consider merge amendment
>> a kind of conflict?
>
> There is work in progress where a merge is computed entirely in-memory
> (without relying on files in the worktree). It could be used to detect
> whether there are any changes beyond the automatic merge results, and
> they could be warned about.

Nice to hear there are chances to improve this in the future.

Thanks again!

-- Sergey.
