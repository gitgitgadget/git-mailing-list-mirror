From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: for-each-ref output order change in 2.7.0
Date: Sun, 10 Jan 2016 10:51:52 +0100
Message-ID: <569229B8.9000009@kdbg.org>
References: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
 <1674931730.811704.1452354002885.JavaMail.zimbra@imag.fr>
 <CAOLa=ZT7n8qCoS81iijf9vswWV+S8n7=4kmbKP0EAMnOenXwSg@mail.gmail.com>
 <56914AD2.9060303@kdbg.org>
 <CAOLa=ZTUcmAjpC4nf_o7ZAHC3Asj9iwfKOOrJr90_kAyMbd22A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 10:52:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aICfs-0002Rv-MA
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 10:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbcAJJv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 04:51:58 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:13098 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbcAJJv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 04:51:56 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pdYNT68Vtz5tl9;
	Sun, 10 Jan 2016 10:51:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E44975398;
	Sun, 10 Jan 2016 10:51:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAOLa=ZTUcmAjpC4nf_o7ZAHC3Asj9iwfKOOrJr90_kAyMbd22A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283615>

Am 09.01.2016 um 22:29 schrieb Karthik Nayak:
> On Sat, Jan 9, 2016 at 11:30 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 09.01.2016 um 18:21 schrieb Karthik Nayak:
>>>>>
>>>>> (Note: The alphabetical-ness of the branch names is reversed, which
>>>>> seems logical given my original sort was -committerdate. A
>>>>> --sort=refname looks like this.

After reading up on branch sorting, I notice that the single dash in 
front of committerdate is not a typo, but a request to sort in reverse. 
Therefore, the resulting sort order, which was

refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100

is totally correct.

>>>>>
>>>>> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
>>>>> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
>>>>> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
>>>>> refs/heads/@#$% - >Tue Jan 3 17:00:51 2012 +1100
>>>>> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
>>>>>
>>>>> That's probably more correct too.)

But I don't know what would be "more" correct here. It's simply correct.

>>> This is correct as per the patch, But I'm wondering if this is desired.
>>> I.E when sorting in reverse order should the fallback (alphabetical sort)
>>> also be in reverse order?
>>
>>
>> IMO, the fallback sorting should be in reverse order only when the user
>> explicitley asked for reverse order. Just because committer date implies
>> some "reverse" ordering should not imply that refs with the same committer
>> date should also be listed in reverse alphabetical order.

I was wrong here. Sorting by committerdate does not imply reverse-ness. 
I just did not know enough about the --sort options when I wrote this 
paragraph.

>
> I was thinking along the same lines. But do we want to expose the fallback to
> the user (i.e let them choose if its reversible or not)?

No, we do not want to expose the fallback to the user. And as far as I 
can see, no further change is required.

-- Hannes
