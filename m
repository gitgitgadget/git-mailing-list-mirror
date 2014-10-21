From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reflog --date
Date: Tue, 21 Oct 2014 16:11:39 -0700
Message-ID: <xmqqk33thvbo.fsf@gitster.dls.corp.google.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
	<xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
	<CAHQ6N+rb6eNC0_uzCAdH-HNb_SmdG4-W9DgmVKjfNpRcKKxk=w@mail.gmail.com>
	<xmqq8uk91emg.fsf@gitster.dls.corp.google.com>
	<CAHQ6N+qkQbmhY-nueF28+iRhbVvH__gihXb6yyj3dRbgpbV18g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 01:11:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgial-00014b-4n
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 01:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbaJUXLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 19:11:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbaJUXLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 19:11:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 634E418431;
	Tue, 21 Oct 2014 19:11:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PC1IGrNKW1lArz2+VczU2Ir8acc=; b=VeNlAU
	Zt4ARa3jrdlEfqSknXQcC6MGu8z8U9tSP2rBMbLoy9tosFEeA58gxyuW6dI5lvhc
	F8RyP0Mxjz2aXmyHsuLm5cy7hB4iCtj4b+yLepM3P+0bkWmKTHl0ku7aw9ZBX0sj
	k6xP0SwbIujEahKNyvbA+BgRyFVtnpWbBjeqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aDyuhaFcLu/+/4Vhgkp2GR/vlLNeAfUb
	2wx55mzWovHUZ/AtpRS62jVQyRi4gdFiSyPjFi9nI4a8Z/LtDGXuKkZNqUcooPST
	wf7/py5Kglfs9GaveETWNauc568hhton9BXcNfGjSDUj4qjUcBXbDx1cT+zXa0r/
	EY/DSDUyK4c=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5902D1842F;
	Tue, 21 Oct 2014 19:11:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C77151842E;
	Tue, 21 Oct 2014 19:11:40 -0400 (EDT)
In-Reply-To: <CAHQ6N+qkQbmhY-nueF28+iRhbVvH__gihXb6yyj3dRbgpbV18g@mail.gmail.com>
	(John Tapsell's message of "Tue, 21 Oct 2014 19:12:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D9D1EA4-5977-11E4-AA4A-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Tapsell <johnflux@gmail.com> writes:

> On 21 October 2014 19:06, Junio C Hamano <gitster@pobox.com> wrote:
>> John Tapsell <johnflux@gmail.com> writes:
>>
>>> For me, writing "git reflog @{now}"  is a lot less intuitive than "git
>>> reflog --date"
>>>
>>> Currently the top google search for this question is here:
>>>
>>> http://stackoverflow.com/questions/17369254/is-there-a-way-to-cause-git-reflog-to-show-a-date-alongside-each-entry
>>>
>>> Which doesn't mention "@{now}"   at all.
>>
>> I would say that a site where cluelesses attempt to lead other
>> cluelesses is not the best source of information ;-), but that tells
>> us that either our docs are not read by people or they do not give
>> necessary information to them clearly enough.
>>
>>> My opinion:
>>>
>>> 1. Add --date   as an option to reflog.  Perhaps using the log.date
>>> format as the default.
>>> 2. Document --date in the man page for "git reflog"
>>> 3. Document @{now}  in the man page for "git reflog"
>>>
>>> Sound good?
>>
>> The order of changes is questionable, but other than that, I think
>> that would be a good way forward.
>
> Great - now I just need to persuade someone very nice nicely.. :-)

You should note that #1 is unworkable, as it would make:

    $ git log -g --date default

ambiguous.  Is it asking the timed reflog output using log.date
format on the "default" branch, or is it asking the timed reflog
output using the "default" time format on the HEAD?

You would need to disambiguate by

    $ git log -g --date -- default ;# on default branch
    $ git log -g --date default -- ;# using default time format

or something, which means --date can be the last dashed option on
the command line, and also you close the door for us to ever add
another dashed command line option that takes an optional argument.

So the best you could do is

    1. Add document commit@{timestamp} vs commit@{count} notation
       we have for "git log" also to "git reflog", perhaps?

    2. Document --date=<style> (but not --date alone) as a way to
       trigger timed output for reflog entries, and refer to that
       from "--walk-reflogs" option description as "see also".



 
