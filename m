From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] merge, pull: stop advising 'commit -a' in case of conflict
Date: Thu, 28 Aug 2014 19:41:44 +0200
Message-ID: <vpq8um8v7dz.fsf@anie.imag.fr>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
	<1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa96obk1e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:43:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN3j5-0003m4-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaH1RnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:43:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37163 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbaH1Rm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 13:42:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7SHfgOP028999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2014 19:41:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7SHfict012314;
	Thu, 28 Aug 2014 19:41:44 +0200
In-Reply-To: <xmqqa96obk1e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Aug 2014 10:28:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 Aug 2014 19:41:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7SHfgOP028999
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1409852503.5789@57mO96OcIXmVGTqoUptOqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256107>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> 'git commit -a' is rarely a good way to mark conflicts as resolved: the
>> user anyway has to go manually through the list of conflicts to do the
>> actual resolution, and it is usually better to use "git add" on each
>> files after doing the resolution.
>>
>> On the other hand, using 'git commit -a' is potentially dangerous, as it
>> makes it very easy to mistakenly commit conflict markers without
>> noticing.
>>
>> While we're there, synchronize the 'git pull' and 'git merge' messages:
>> the first was ending with '...  and make a commit.', but not the later.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>>  - Hasty-and-careless new users will be incorrectly enticed to type
>>>    the command given by "or use 'git commit -a'" at the end of this
>>>    advice message without thinking.  Perhaps it is safer to stop the
>>>    sentence at "... and make a commit." and drop that last bit while
>>>    there are conflicts still in the working tree files.  We should
>>>    use the current end-of-message only when all the conflicts have
>>>    been resolved in the working tree.
>>
>> It was already on my todo-list, as a friend of mine semi-beginner with
>> Git complained about the mis-advice the other day, and I had to agree.
>
>
>
>> Eventually, git could detect that conflicts have been resolved, but
>> then that would be a different message, as not only "use git commit
>> -a" could be resurected, but "Fix them up in the work tree" should be
>> dropped when it is the case.
>
> This paragraph should be in the log message, shouldn't it, probably
> with s/could/should/?

I think the commit message explains well enough why the change is good.
The additional paragraph explains why I did not do it the way your
message suggests (which has to do with the current discussion, but does
not have to be recorded in history IHMO).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
