From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: 'git rebase' silently drops changes?
Date: Tue, 10 Feb 2015 19:26:19 +0100
Message-ID: <54DA4D4B.5010902@kdbg.org>
References: <87386ispb3.fsf@osv.gnss.ru> <54D68455.5070305@gmail.com>	<54D7696B.3060407@kdbg.org> <87oap38cv1.fsf@osv.gnss.ru>	<54D90473.2090208@kdbg.org> <87pp9ivvir.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:26:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLFW3-00075o-Ks
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 19:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbbBJS00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 13:26:26 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:46965 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753349AbbBJS00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 13:26:26 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3khXcF6mRBz5tlN;
	Tue, 10 Feb 2015 19:26:21 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5480D19F938;
	Tue, 10 Feb 2015 19:26:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <87pp9ivvir.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263637>

Am 10.02.2015 um 12:46 schrieb Sergey Organov:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 09.02.2015 um 13:53 schrieb Sergey Organov:
> 
> [...]
> 
>> If you want a version of --preserve-merges that does what *you* need,
>> consider this commit:
>>
>>   git://repo.or.cz/git/mingw/j6t.git rebase-p-first-parent
>>
>> Use it like this:
>>
>>   git rebase -i -p --first-parent ...
> 
> Thanks a lot, this sounds promising! I've read the message for this
> commit and it mentions no drawbacks. Are you aware of any?

Except for this...

>> Beware, its implementation is incomplete: if the rebase is interrupted,
>> then 'git rebase --continue' behaves as if --first-parent were not
>> given.

... not anything that I would care about. Of course, you can't rebase
branchy history when this option is specified, but that's the whole point.

> Just never did get round to it, or something more fundamental?

Nothing fundamental. Just has to store the option in the rebase state
like all the other options.

-- Hannes
