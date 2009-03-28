From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I force git to forget about merging a binary file that is
  to stay deleted on the target branch?
Date: Sat, 28 Mar 2009 08:07:24 -0700
Message-ID: <7viqltvg7n.fsf@gitster.siamese.dyndns.org>
References: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
 <51419b2c0903280547y1bb5664dj70e4e6aa939bd015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brent Goodrick <bgoodr@gmail.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 16:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lna9h-0003pJ-IE
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 16:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbZC1PHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 11:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZC1PHd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 11:07:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbZC1PHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 11:07:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D4059ADFD;
	Sat, 28 Mar 2009 11:07:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E835FADFC; Sat,
 28 Mar 2009 11:07:25 -0400 (EDT)
In-Reply-To: <51419b2c0903280547y1bb5664dj70e4e6aa939bd015@mail.gmail.com>
 (Elijah Newren's message of "Sat, 28 Mar 2009 06:47:38 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28AE2C3E-1BAA-11DE-A0E0-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114960>

Elijah Newren <newren@gmail.com> writes:

> On Fri, Mar 27, 2009 at 11:26 PM, Brent Goodrick <bgoodr@gmail.com> w=
rote:
>> How do I commit a merge but force git to forget about merging one fi=
le
>> that I don't want on the target branch, when it is binary, and when =
it
>> was changed on the source branch, but was deleted on the target bran=
ch
>> (and should stay deleted on the target branch)?
>>
>> The details: I am merging a "work" branch into a "home" branch. =C2=A0=
There
>> is one file called "TimeSheets/Timesheet Exempt.XLS" that is binary.
>> I don't want that file on the "home" branch, but do want it on the
>> "work" branch. =C2=A0I had made an editing change to that file on th=
e
>> "work" branch, along with a bunch of other changes I do want to merg=
e
>> into the "home" branch. But no matter what I do, I can't force git t=
o
>> forget about that "TimeSheets/Timesheet Exempt.XLS" file.
>>
>> I've tried various flavors of git-checkout and git-reset to no
>> avail. This is what I see at the very last before I gave up:
>
> You can resolve this merge conflict by running
> $ git rm TimeSheets/Timesheet\ Exempt.XLS
>
> which will make git delete the file from your working copy and the
> index, at which point you can then make a commit that does not includ=
e
> this file.

But is this what you really want to do?  After doing such a "remove it"
merge resolution at Home, wouldn't merging it back to Work remove the
file?
